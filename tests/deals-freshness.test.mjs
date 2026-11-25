import {test} from 'node:test';
import assert from 'node:assert/strict';
import fs from 'node:fs';
const source=fs.readFileSync(new URL('../src/deals-freshness.js',import.meta.url),'utf8').replace("import feed from './data/deals/products.json';","const feed={exported_at:'2026-11-25T00:00:00Z'};");
const {staleOfferResponse}=await import('data:text/javascript,'+encodeURIComponent(source));
test('old offers fail closed, unrelated pages stay available',()=>{assert.equal(staleOfferResponse(new Request('https://example.com/deals/x'),Date.parse('2099-01-01')).status,503);assert.equal(staleOfferResponse(new Request('https://example.com/contact'),Date.parse('2099-01-01')),null);assert.equal(staleOfferResponse(new Request('https://example.com/deals/x'),0),null)});
