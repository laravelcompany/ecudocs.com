import feed from './data/deals/products.json' with { type: 'json' };
export function staleOfferResponse(request, now = Date.now()) {
  const path = new URL(request.url).pathname;
  const offerRoute = path === '/deals' || path.startsWith('/deals/');
  if (!offerRoute || now - Date.parse(feed.exported_at) < 28 * 60 * 60 * 1000) return null;
  return new Response('<!doctype html><html lang="en"><meta name="viewport" content="width=device-width,initial-scale=1"><title>Listings are being refreshed</title><main style="max-width:640px;margin:15vh auto;padding:24px;font:18px/1.6 system-ui"><h1>Listings are being refreshed</h1><p>We have paused these offers because our last eBay check is over a day old. Please try again later.</p><a href="/">Return home</a></main></html>', {status:503,headers:{'content-type':'text/html; charset=utf-8','cache-control':'no-store','retry-after':'3600'}});
}
