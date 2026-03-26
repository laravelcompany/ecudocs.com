import fs from 'node:fs';
import path from 'node:path';

const DATA_DIR = path.join(process.cwd(), 'src', 'data');
const AI_API_URL = 'https://ai.izdrail.com';

function slugify(text) {
  return text.toString().toLowerCase()
    .replace(/\s+/g, '-')
    .replace(/[^\w\-]+/g, '')
    .replace(/\-\-+/g, '-')
    .replace(/^-+/, '')
    .replace(/-+$/, '');
}

function sleep(ms) {
  return new Promise(resolve => setTimeout(resolve, ms));
}

function cleanJSON(text) {
  text = text.replace(/```json\n?/g, '').replace(/```\n?/g, '').trim();
  text = text.replace(/[\x00-\x1F\x7F]/g, '');
  return text;
}

async function generateWithAI(prompt, retries = 3) {
  for (let i = 0; i < retries; i++) {
    try {
      const response = await fetch(`${AI_API_URL}/api/generate`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          model: 'mistral:7b',
          prompt,
          stream: false,
          options: {
            temperature: 0.7,
            num_predict: 3000
          }
        })
      });

      if (!response.ok) {
        throw new Error(`AI API error: ${response.status}`);
      }

      const data = await response.json();
      let text = data.response || '';
      text = cleanJSON(text);
      return JSON.parse(text);
    } catch (err) {
      if (i === retries - 1) {
        console.error(`  [!] AI error: ${err.message}`);
        return null;
      }
      await sleep(1000);
    }
  }
  return null;
}

async function processBrand(brandName, logo = '') {
  brandName = brandName.trim();
  const brandSlug = slugify(brandName);
  
  console.log(`Processing ${brandName}...`);
  
  const prompt = `Provide detailed information about ${brandName} car manufacturer. Return ONLY valid JSON with this exact structure, no markdown:

{
  "name": "${brandName}",
  "description": "2-3 paragraph comprehensive history including founding, key milestones, notable achievements, and current status",
  "productionModels": number of currently produced models,
  "discontinuedModels": number of discontinued models,
  "models": [
    {
      "name": "model name",
      "description": "brief 1-2 sentence description",
      "year_started": year first produced as number,
      "year_ended": year production ended as number or null if still produced
    }
  ]
}

Include 5-15 major models spanning the brand's history. Be accurate with years. Return ONLY the JSON.`;

  const result = await generateWithAI(prompt);
  
  if (!result) {
    console.log(`  Failed for ${brandName}`);
    return false;
  }

  const brandDir = path.join(DATA_DIR, brandSlug);
  if (!fs.existsSync(brandDir)) {
    fs.mkdirSync(brandDir, { recursive: true });
  }

  const brandData = {
    name: result.name || brandName,
    description: result.description || '',
    logo: logo,
    productionModels: result.productionModels || 0,
    discontinuedModels: result.discontinuedModels || 0
  };

  let finalModels = [];
  if (result.models && Array.isArray(result.models)) {
    finalModels = result.models.map(m => ({
      id: slugify(m.name),
      name: m.name,
      description: m.description || '',
      year_started: m.year_started || null,
      year_ended: m.year_ended || null
    }));
  }

  fs.writeFileSync(path.join(brandDir, 'brand.json'), JSON.stringify(brandData, null, 2));
  fs.writeFileSync(path.join(brandDir, 'models.json'), JSON.stringify(finalModels, null, 2));
  
  console.log(`  Saved ${finalModels.length} models`);
  return true;
}

async function run() {
  const brandsPath = path.join(DATA_DIR, 'brands.json');
  const brandsData = JSON.parse(fs.readFileSync(brandsPath, 'utf-8'));
  
  console.log(`Generating data for ${brandsData.length} brands...\n`);
  
  let processed = 0;
  let failed = 0;
  const delay = parseInt(process.argv[2]) || 2000;
  
  for (const brand of brandsData) {
    const name = brand[3];
    const logo = brand[4] || '';
    
    const success = await processBrand(name, logo);
    if (success) {
      processed++;
    } else {
      failed++;
    }
    
    if (processed + failed < brandsData.length) {
      await sleep(delay);
    }
  }
  
  console.log(`\n=== Summary ===`);
  console.log(`Processed: ${processed}/${brandsData.length}`);
  console.log(`Failed: ${failed}`);
}

run();
