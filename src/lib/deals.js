import feed from '../data/deals/products.json';

export const exportedAt = feed.exported_at;
// Drop anything without an affiliate URL. Never fall back to the plain eBay URL.
export const products = (feed.products || []).filter((p) => p.affiliate_url && p.item_id);

export const itemSlug = (id) => String(id).split('|')[1] || String(id).replace(/[^A-Za-z0-9]/g, '');
export const truncate = (s, n = 80) => (s.length > n ? s.slice(0, n - 1).trimEnd() + '…' : s);
export const titleCase = (slug) => slug.replace(/-/g, ' ').replace(/\b\w/g, (c) => c.toUpperCase());
export const money = (p) => `${p.currency === 'GBP' ? '£' : p.currency + ' '}${Number(p.price).toFixed(2)}`;
export const dateOnly = (iso) => (iso ? iso.slice(0, 10) : 'unknown');

export function categories() {
  const map = new Map();
  for (const p of products) map.set(p.category, [...(map.get(p.category) || []), p]);
  return [...map.entries()].map(([slug, items]) => ({ slug, name: titleCase(slug), items }));
}
export const detailPath = (p) => `/deals/${p.category}/${itemSlug(p.item_id)}`;
export const AFFILIATE_REL = 'sponsored nofollow noopener';
