# eBay affiliate generator (ecudocs /deals)

Offline batch job. Queries the eBay Browse API (EBAY_GB), uses the affiliate URL returned by the API
(`itemAffiliateWebUrl`, tracked with your EPN campaign id and a per-category sub-id), dedupes in SQLite,
writes `output/ebay_affiliate_products_*.csv` and the site feed `src/data/deals/products.json`.

Products with no affiliate URL are dropped. A plain eBay URL is never used instead.
If a run fails, the existing feed is untouched.

    export EBAY_CLIENT_ID=... EBAY_CLIENT_SECRET=... EPN_CAMPAIGN_ID=...
    python3 tools/ebay-affiliate/generate.py            # edit keywords.json for categories
    python3 tools/ebay-affiliate/generate.py --dry-run  # config check
    python3 -m unittest discover tools/ebay-affiliate/tests

Schedule: `.github/workflows/deals-refresh.yml` (every four hours at minute 17 UTC, edit the cron line to change it; also runnable by hand via workflow_dispatch).
Repo secrets needed: EBAY_CLIENT_ID, EBAY_CLIENT_SECRET, EPN_CAMPAIGN_ID.
The refresh commits the new feed to main, then explicitly dispatches deploy.yml.
GitHub token-authored pushes do not trigger another push workflow.
Prices are shown as "at time of export". Rebuilt daily, so they are at most ~1 day old.
