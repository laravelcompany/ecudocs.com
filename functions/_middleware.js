// Thin wrapper so the pages.dev deployment honours the same legacy 301s as
// the production worker (src/worker.js); the map lives in
// src/legacy-redirects.js.
import { legacyRedirectResponse } from '../src/legacy-redirects.js';

export async function onRequest(context) {
  return legacyRedirectResponse(context.request) || context.next();
}
