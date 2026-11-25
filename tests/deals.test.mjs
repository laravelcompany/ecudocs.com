// After build: `npm run build && npm run test:deals`. Checks dist/deals against the feed.
import { test } from 'node:test';
import assert from 'node:assert/strict';
import { readFileSync, existsSync } from 'node:fs';
import { join } from 'node:path';
const itemSlug = (id) => String(id).split('|')[1] || String(id).replace(/[^A-Za-z0-9]/g, '');

const root = new URL('../', import.meta.url).pathname;
const dist = join(root, 'dist');
const read = (p) => readFileSync(join(dist, p), 'utf8');
const feed = JSON.parse(readFileSync(join(root, 'src/data/deals/products.json'), 'utf8'));
const products = feed.products.filter((p) => p.affiliate_url && p.item_id);

test('rows with empty affiliate_url never get a page', () => {
  for (const p of feed.products.filter((p) => !p.affiliate_url)) {
    assert.ok(!existsSync(join(dist, `deals/${p.category}/${itemSlug(p.item_id)}/index.html`)), 'page for product without affiliate url');
  }
});
test('item slug strips pipes', () => assert.equal(itemSlug('v1|1234|0'), '1234'));
test('/deals landing exists with disclosure and canonical', () => {
  const html = read('deals/index.html');
  assert.match(html, /earns a commission from qualifying purchases/);
  assert.match(html, /<link rel="canonical" href="https:\/\/ecudocs\.com\/deals"/);
});
for (const p of products) {
  const path = `deals/${p.category}/${itemSlug(p.item_id)}/index.html`;
  test(`detail ${p.item_id}`, () => {
    assert.ok(existsSync(join(dist, path)), `${path} missing`);
    const html = read(path);
    assert.ok(html.includes(`href="https://ecudocs.com/deals/${p.category}/${itemSlug(p.item_id)}"`), 'canonical');
    assert.match(html, /rel="sponsored nofollow noopener"/);
    assert.ok(html.includes(p.affiliate_url.replace(/&/g, '&#38;')) || html.includes(p.affiliate_url) , 'affiliate url preserved');
    assert.match(html, /earns a commission/);
  });
}
test('category pages have ItemList JSON-LD', () => {
  for (const c of new Set(products.map((p) => p.category))) {
    assert.match(read(`deals/${c}/index.html`), /"@type":"ItemList"/);
  }
});
test('unknown item has no page (404)', () => {
  assert.ok(!existsSync(join(dist, 'deals/nope/000/index.html')));
});


test('deal pages keep shared UX, breadcrumbs and accessible filters', () => {
  const landing = read('deals/index.html');
  assert.match(landing, /class="deals-page"/);
  assert.match(landing, /aria-label="Breadcrumb"/);
  assert.match(landing, /class="deals-category-card"/);
  assert.match(landing, /id="cat-no-results"/);
  for (const c of new Set(products.map((p) => p.category))) {
    const html = read(`deals/${c}/index.html`);
    for (const id of ['deal-q','deal-min','deal-max','deal-reset','deal-results','deal-no-results']) {
      assert.ok(html.includes(`id="${id}"`), `missing ${id}`);
    }
    assert.match(html, /aria-label="Breadcrumb"/);
    assert.match(html, /aria-current="page"/);
    assert.match(html, /aria-live="polite"/);
    assert.match(html, /class="deals-product-grid"/);
  }
});
