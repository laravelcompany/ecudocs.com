import json, sys, tempfile, unittest
from pathlib import Path
sys.path.insert(0, str(Path(__file__).resolve().parent.parent))
import generate as g

ITEM = {"itemId": "v1|123|0", "title": "Thing", "price": {"value": "9.99", "currency": "GBP"},
        "itemAffiliateWebUrl": "https://www.ebay.co.uk/itm/123?mkcid=1&campid=555&customid=ref", "itemWebUrl": "https://www.ebay.co.uk/itm/123"}

class T(unittest.TestCase):
    def test_slug(self): self.assertEqual(g.slugify("OBD2 Scanner!"), "obd2-scanner")
    def test_row_ok(self): self.assertEqual(g.to_row(ITEM, "c", "r", "now")["affiliate_url"], ITEM["itemAffiliateWebUrl"])
    def test_drops_without_affiliate_and_never_substitutes(self):
        i = dict(ITEM); del i["itemAffiliateWebUrl"]
        self.assertIsNone(g.to_row(i, "c", "r", "now"))
    def test_dedupe_keeps_first_seen(self):
        db = g.init_db(":memory:")
        a = g.to_row(ITEM, "c", "r", "t1"); b = g.to_row(ITEM, "c", "r", "t2")
        g.persist(db, [a]); g.persist(db, [b])
        self.assertEqual(db.execute("select count(*), first_seen, last_seen from products").fetchone(), (1, "t1", "t2"))
    def test_feed_atomic_and_filtered(self):
        with tempfile.TemporaryDirectory() as d:
            p = Path(d) / "f.json"
            r = g.to_row(ITEM, "c", "r", "t"); bad = dict(r, item_id="x", affiliate_url="")
            self.assertEqual(g.write_feed(p, [r, r, bad], "t"), 1)
            self.assertEqual(len(json.loads(p.read_text())["products"]), 1)
    def test_failure_keeps_feed(self):
        with tempfile.TemporaryDirectory() as d:
            p = Path(d) / "f.json"; p.write_text("OLD")
            import os; os.environ.pop("EBAY_CLIENT_ID", None)
            self.assertEqual(g.main(["--feed", str(p), "--db", d + "/x.db"]), 2)
            self.assertEqual(p.read_text(), "OLD")

if __name__ == "__main__": unittest.main()
