// Run after a build: `npm run build && npm run test:blog`.
// The blog is live: /blog routes build, post pages build, nav and footer link to it.
import { test } from 'node:test';
import assert from 'node:assert/strict';
import { readFileSync, readdirSync, existsSync } from 'node:fs';
import { join } from 'node:path';

const root = new URL('../', import.meta.url).pathname;
const out = join(root, 'dist');

const walk = (d) =>
  readdirSync(d, { withFileTypes: true }).flatMap((e) =>
    e.isDirectory() ? walk(join(d, e.name)) : [join(d, e.name)]
  );

test('blog index page 1 exists and lists posts', () => {
  const indexPath = join(out, 'blog', 'index.html');
  assert.ok(existsSync(indexPath), 'dist/blog/index.html missing');
  const html = readFileSync(indexPath, 'utf8');
  assert.match(html, /Blog/, 'index has no Blog heading');
  assert.match(html, /href="\/blog\/\d+-/, 'index links no post pages');
});

test('blog pagination page 2 exists', () => {
  assert.ok(existsSync(join(out, 'blog', '2', 'index.html')), 'dist/blog/2/index.html missing');
});

test('post pages were generated', () => {
  const files = walk(join(out, 'blog'));
  const postPages = files.filter((f) => /\/blog\/\d+-[^/]+\/index\.html$/.test(f));
  assert.ok(postPages.length > 9000, `expected >9000 post pages, got ${postPages.length}`);
  const html = readFileSync(postPages[0], 'utf8');
  assert.match(html, /<article/, 'post page missing <article>');
});

test('nav and footer link to the blog on the homepage', () => {
  const home = readFileSync(join(out, 'index.html'), 'utf8');
  const links = home.match(/href="\/blog"/g) ?? [];
  assert.ok(links.length >= 2, `expected nav+footer /blog links, got ${links.length}`);
});
