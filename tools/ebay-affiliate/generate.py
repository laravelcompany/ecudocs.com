#!/usr/bin/env python3
"""eBay affiliate product generator for ecudocs.com /deals.

Queries the eBay Browse API (EBAY_GB), takes affiliate URLs from the API itself
(itemAffiliateWebUrl, built from the EPN campaign id), dedupes in SQLite, writes a
per-run CSV and the site feed src/data/deals/products.json.

Rules kept from the brief:
- A product with no affiliate URL is dropped. A plain eBay URL is never substituted.
- On any failure the existing products.json is left untouched.

Env: EBAY_CLIENT_ID, EBAY_CLIENT_SECRET, EPN_CAMPAIGN_ID (required)
     EBAY_ENV=production|sandbox (default production), EBAY_MARKETPLACE (default EBAY_GB)
Stdlib only. Usage: python generate.py [--keywords keywords.json] [--limit 50] [--dry-run]
"""
import argparse, base64, csv, json, os, re, sqlite3, sys, time
import urllib.error, urllib.parse, urllib.request
from datetime import datetime, timezone
from pathlib import Path

HERE = Path(__file__).resolve().parent
REPO = HERE.parent.parent
HOSTS = {"production": "https://api.ebay.com", "sandbox": "https://api.sandbox.ebay.com"}
FIELDS = ["item_id", "category", "reference_id", "title", "price", "currency", "condition",
          "seller", "affiliate_url", "item_url", "image_url", "location", "first_seen", "last_seen"]


def slugify(text):
    return re.sub(r"[^a-z0-9]+", "-", text.lower()).strip("-")


def http_json(req, retries=3):
    for attempt in range(retries):
        try:
            with urllib.request.urlopen(req, timeout=30) as r:
                return json.load(r)
        except urllib.error.HTTPError as e:
            if e.code in (429, 500, 502, 503, 504) and attempt < retries - 1:
                time.sleep(2 ** attempt * 2)
                continue
            raise RuntimeError(f"eBay API HTTP {e.code}: {e.read()[:300]!r}")
        except urllib.error.URLError as e:
            if attempt < retries - 1:
                time.sleep(2 ** attempt * 2)
                continue
            raise RuntimeError(f"eBay API network error: {e}")


def get_token(host, cid, secret):
    auth = base64.b64encode(f"{cid}:{secret}".encode()).decode()
    data = urllib.parse.urlencode({"grant_type": "client_credentials",
                                   "scope": "https://api.ebay.com/oauth/api_scope"}).encode()
    req = urllib.request.Request(f"{host}/identity/v1/oauth2/token", data=data, headers={
        "Authorization": f"Basic {auth}", "Content-Type": "application/x-www-form-urlencoded"})
    return http_json(req)["access_token"]


def search(host, token, marketplace, campaign, reference_id, keyword, limit):
    q = urllib.parse.urlencode({"q": keyword, "limit": limit, "filter": "buyingOptions:{FIXED_PRICE}"})
    req = urllib.request.Request(f"{host}/buy/browse/v1/item_summary/search?{q}", headers={
        "Authorization": f"Bearer {token}",
        "X-EBAY-C-MARKETPLACE-ID": marketplace,
        # EPN: campaign id + sub-id make the API return tracked itemAffiliateWebUrl
        "X-EBAY-C-ENDUSERCTX": f"affiliateCampaignId={campaign},affiliateReferenceId={reference_id}"})
    return http_json(req).get("itemSummaries", [])


def to_row(item, category, reference_id, now):
    """Return a product dict or None. None when the affiliate URL is missing."""
    affiliate = (item.get("itemAffiliateWebUrl") or "").strip()
    if not affiliate or not item.get("itemId"):
        return None
    price = item.get("price") or {}
    return {
        "item_id": item["itemId"], "category": category, "reference_id": reference_id,
        "title": item.get("title", ""), "price": price.get("value", ""),
        "currency": price.get("currency", ""), "condition": item.get("condition", ""),
        "seller": (item.get("seller") or {}).get("username", ""),
        "affiliate_url": affiliate, "item_url": item.get("itemWebUrl", ""),
        "image_url": (item.get("image") or {}).get("imageUrl", ""),
        "location": (item.get("itemLocation") or {}).get("country", ""),
        "first_seen": now, "last_seen": now}


def init_db(path):
    db = sqlite3.connect(path)
    db.execute("""CREATE TABLE IF NOT EXISTS products (
        item_id TEXT PRIMARY KEY, category TEXT, reference_id TEXT, title TEXT, price TEXT,
        currency TEXT, condition TEXT, seller TEXT, affiliate_url TEXT NOT NULL, item_url TEXT,
        image_url TEXT, location TEXT, first_seen TEXT, last_seen TEXT)""")
    return db


def persist(db, rows):
    """Upsert rows; keep first_seen of existing items. Dedupes globally by item_id."""
    for r in rows:
        db.execute("""INSERT INTO products VALUES (:item_id,:category,:reference_id,:title,:price,
            :currency,:condition,:seller,:affiliate_url,:item_url,:image_url,:location,:first_seen,:last_seen)
            ON CONFLICT(item_id) DO UPDATE SET title=excluded.title, price=excluded.price,
            currency=excluded.currency, condition=excluded.condition, affiliate_url=excluded.affiliate_url,
            item_url=excluded.item_url, image_url=excluded.image_url, last_seen=excluded.last_seen""", r)
    db.commit()


def write_csv(path, rows):
    path.parent.mkdir(parents=True, exist_ok=True)
    with open(path, "w", newline="", encoding="utf-8") as f:
        w = csv.DictWriter(f, FIELDS)
        w.writeheader()
        w.writerows(rows)


def write_feed(path, rows, exported_at):
    """Atomic write of the site feed. Rows keep export order; duplicates across categories removed."""
    seen, out = set(), []
    for r in rows:
        if r["item_id"] in seen or not r["affiliate_url"]:
            continue
        seen.add(r["item_id"])
        out.append(r)
    path.parent.mkdir(parents=True, exist_ok=True)
    tmp = path.with_suffix(".tmp")
    tmp.write_text(json.dumps({"exported_at": exported_at, "products": out}, indent=1), encoding="utf-8")
    os.replace(tmp, path)
    return len(out)


def main(argv=None):
    ap = argparse.ArgumentParser()
    ap.add_argument("--keywords", default=str(HERE / "keywords.json"))
    ap.add_argument("--limit", type=int, default=50)
    ap.add_argument("--db", default=str(HERE / "products.sqlite"))
    ap.add_argument("--out-dir", default=str(HERE / "output"))
    ap.add_argument("--feed", default=str(REPO / "src/data/deals/products.json"))
    ap.add_argument("--dry-run", action="store_true", help="validate config only, no API calls")
    a = ap.parse_args(argv)

    cid, secret, campaign = (os.environ.get(k, "") for k in ("EBAY_CLIENT_ID", "EBAY_CLIENT_SECRET", "EPN_CAMPAIGN_ID"))
    keywords = json.loads(Path(a.keywords).read_text())
    if a.dry_run:
        print(f"{len(keywords)} keywords; credentials present: {bool(cid and secret and campaign)}")
        return 0
    if not (cid and secret and campaign):
        print("ERROR: set EBAY_CLIENT_ID, EBAY_CLIENT_SECRET, EPN_CAMPAIGN_ID", file=sys.stderr)
        return 2
    host = HOSTS[os.environ.get("EBAY_ENV", "production")]
    marketplace = os.environ.get("EBAY_MARKETPLACE", "EBAY_GB")
    now = datetime.now(timezone.utc).strftime("%Y-%m-%dT%H:%M:%SZ")
    try:
        token = get_token(host, cid, secret)
        rows, dropped = [], 0
        for kw in keywords:
            slug = slugify(kw)
            ref = f"ecudocs-{slug}"[:40]
            items = search(host, token, marketplace, campaign, ref, kw, a.limit)
            for it in items:
                row = to_row(it, slug, ref, now)
                if row:
                    rows.append(row)
                else:
                    dropped += 1
            print(f"{kw}: {len(items)} results")
            time.sleep(0.3)
        if not rows:
            raise RuntimeError("zero usable products; refusing to overwrite the feed")
    except Exception as e:  # previous feed stays live
        print(f"ERROR: {e}", file=sys.stderr)
        return 1
    db = init_db(a.db)
    persist(db, rows)
    stamp = datetime.now(timezone.utc).strftime("%Y%m%d_%H%M%S")
    write_csv(Path(a.out_dir) / f"ebay_affiliate_products_{stamp}.csv", rows)
    n = write_feed(Path(a.feed), rows, now)
    print(f"OK: {n} products in feed, {dropped} dropped (no affiliate URL)")
    return 0


if __name__ == "__main__":
    sys.exit(main())
