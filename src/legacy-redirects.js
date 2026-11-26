// Legacy sitemap 404s (GSC Page indexing, 2026-11-26).
// Production traffic is served by src/worker.js (run_worker_first), which
// intercepts /blog/<slug> before any _redirects or static fallthrough can
// fire, so these 301s live in one shared module used by both the worker and
// the Pages Functions middleware (pages.dev).
const REDIRECTS = new Map([
  ['/blog/maintaining-luxury-car', '/blog/'],
  ['/blog/discover-the-elegance-of-luxury-cars', '/blog/'],
  ['/blog/benefits-electric-luxury-cars', '/blog/'],
  ['/search', '/'],
  // Literal template string Googlebot scraped from the /ecu/ page source
  ['/ecu/${ecu.slug}', '/ecu/'],
  ['/ecu/$%7Becu.slug%7D', '/ecu/'],
  ['/ecu/%24%7Becu.slug%7D', '/ecu/'],
]);

export function legacyRedirectResponse(request) {
  const url = new URL(request.url);
  const trimmed = url.pathname.replace(/\/+$/, '') || '/';
  const dest = REDIRECTS.get(trimmed) || REDIRECTS.get(url.pathname);
  if (!dest) return null;
  return Response.redirect(new URL(dest, url).href, 301);
}
