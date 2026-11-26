// Legacy sitemap 404s (GSC Page indexing, 2026-11-26).
// public/_redirects carries the same rules, but static 404 fallthrough was
// winning for /blog/* paths, so the rules also live here where matching is
// deterministic: Functions run before asset serving.
const REDIRECTS = new Map([
  ['/blog/maintaining-luxury-car', '/blog/'],
  ['/blog/discover-the-elegance-of-luxury-cars', '/blog/'],
  ['/blog/benefits-electric-luxury-cars', '/blog/'],
  ['/search', '/'],
  ['/ecu/${ecu.slug}', '/ecu/'],
  ['/ecu/$%7Becu.slug%7D', '/ecu/'],
  ['/ecu/%24%7Becu.slug%7D', '/ecu/'],
]);

export async function onRequest(context) {
  const url = new URL(context.request.url);
  const path = url.pathname.replace(/\/+$/, '') || '/';
  const dest = REDIRECTS.get(path) || REDIRECTS.get(url.pathname);
  if (dest) {
    return Response.redirect(new URL(dest, url).href, 301);
  }
  return context.next();
}
