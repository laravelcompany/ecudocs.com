import fs from 'node:fs';
import path from 'node:path';

const DATA_DIR = path.join(process.cwd(), 'src', 'data');
const BRANDS_FILE = path.join(DATA_DIR, 'brands.json');

const rawBrandsData = JSON.parse(fs.readFileSync(BRANDS_FILE, 'utf-8'));

function slugify(text) {
  return text.toString().toLowerCase()
    .replace(/\s+/g, '-')           // Replace spaces with -
    .replace(/[^\w\-]+/g, '')       // Remove all non-word chars
    .replace(/\-\-+/g, '-')         // Replace multiple - with single -
    .replace(/^-+/, '')             // Trim - from start of text
    .replace(/-+$/, '');            // Trim - from end of text
}

async function fetchWikipediaCategory(categoryName) {
  const url = `https://en.wikipedia.org/w/api.php?action=query&list=categorymembers&cmtitle=Category:${encodeURIComponent(categoryName)}&cmlimit=100&cmnamespace=0&format=json`;
  
  try {
    const res = await fetch(url, { headers: { 'User-Agent': 'ECUDocsBot/1.0 (https://ecudocs.com/)' } });
    if (!res.ok) return [];
    
    const data = await res.json();
    return data.query?.categorymembers || [];
  } catch (err) {
    console.error(`  [!] Error fetching ${categoryName}:`, err.message);
    return [];
  }
}

async function getBrandModels(brandName) {
  const exactBrandName = brandName.replace(/ /g, '_');
  
  const patterns = [
    `${exactBrandName}_vehicles`,
    `${exactBrandName}_cars`
  ];

  let members = [];
  for (const pattern of patterns) {
    members = await fetchWikipediaCategory(pattern);
    if (members.length > 0) break;
  }

  if (members.length === 0) {
    return [
      {
        id: "placeholder-model",
        name: "Generic Model",
        description: `Model data for ${brandName} is currently being researched.`,
        year_started: null,
      }
    ];
  }

  return members.map(member => {
    let title = member.title;
    
    // Attempt to remove the brand name from the model string
    const brandRegex = new RegExp(`^${brandName}\\s+`, 'i');
    let modelName = title.replace(brandRegex, '').trim();
    
    // Remove disambiguations like "(car)"
    modelName = modelName.replace(/\s*\([^)]*\)$/, '').trim();

    return {
      id: slugify(modelName),
      name: modelName,
      description: `${title} is a vehicle produced by ${brandName}. Select this model to see matching ECU hardware configurations.`,
      year_started: null
    };
  });
}

async function run() {
  console.log(`Starting Wikipedia Sync for ${rawBrandsData.length} brands...`);
  
  let successCount = 0;

  for (const group of rawBrandsData) {
    const brandName = group[3];
    const brandSlug = slugify(brandName);
    const brandDir = path.join(DATA_DIR, brandSlug);
    const modelsFile = path.join(brandDir, 'models.json');

    console.log(`=> Processing [${brandName}]...`);

    if (!fs.existsSync(brandDir)) {
      fs.mkdirSync(brandDir, { recursive: true });
    }

    const models = await getBrandModels(brandName);

    // Filter potential duplicates
    const uniqueModelsMap = new Map();
    for (const model of models) {
       uniqueModelsMap.set(model.id, model);
    }
    const uniqueModels = Array.from(uniqueModelsMap.values());

    fs.writeFileSync(modelsFile, JSON.stringify(uniqueModels, null, 2));
    
    if (uniqueModels[0]?.id !== "placeholder-model") {
        successCount++;
        console.log(`   Found ${uniqueModels.length} models from Wikipedia`);
    } else {
        console.log(`   Warning: No Wikipedia category found, using placeholder.`);
    }
    
    // Polite delay for Wikipedia API rate limits
    await new Promise(r => setTimeout(r, 200));
  }
  
  console.log(`\n✅ Parsing complete! Succeeded finding models for ${successCount}/${rawBrandsData.length} brands.`);
}

run();
