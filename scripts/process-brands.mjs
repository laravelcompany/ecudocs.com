import * as fs from 'node:fs';
import * as path from 'node:path';
import { fileURLToPath } from 'node:url';

const __dirname = path.dirname(fileURLToPath(import.meta.url));
const ROOT_DIR = path.join(__dirname, '..');
const BRANDS_FILE = path.join(ROOT_DIR, 'src/data/brands.json');
const DATA_DIR = path.join(ROOT_DIR, 'src/data');
const IMAGES_DIR = path.join(ROOT_DIR, 'public/images/brands');

// Ensure directories exist
if (!fs.existsSync(IMAGES_DIR)) {
  fs.mkdirSync(IMAGES_DIR, { recursive: true });
}

function slugify(text) {
  return text
    .toString()
    .toLowerCase()
    .trim()
    .replace(/\s+/g, '-')     // Replace spaces with -
    .replace(/[^\w-]+/g, '')   // Remove all non-word chars
    .replace(/--+/g, '-');    // Replace multiple - with single -
}

async function downloadImage(url, filepath) {
  if (fs.existsSync(filepath)) {
    console.log(`Image already exists: ${filepath}`);
    return;
  }
  
  try {
    const response = await fetch(url);
    if (!response.ok) throw new Error(`HTTP error! status: ${response.status}`);
    const buffer = await response.arrayBuffer();
    fs.writeFileSync(filepath, Buffer.from(buffer));
    console.log(`Downloaded image: ${filepath}`);
  } catch (err) {
    console.error(`Failed to download ${url}: ${err.message}`);
  }
}

async function main() {
  const brands = JSON.parse(fs.readFileSync(BRANDS_FILE, 'utf-8'));
  
  for (const brand of brands) {
    const [id, uuid, url, name, imageUrl, desc, createdAt, updatedAt] = brand;
    const slug = slugify(name);
    
    if (!slug) {
        console.warn(`Empty slug for brand: ${name}`);
        continue;
    }

    const brandFolder = path.join(DATA_DIR, slug);
    const modelsFile = path.join(brandFolder, 'models.json');
    const imagePath = path.join(IMAGES_DIR, `${slug}.jpg`);

    // Create brand folder
    if (!fs.existsSync(brandFolder)) {
      fs.mkdirSync(brandFolder, { recursive: true });
      console.log(`Created folder: ${brandFolder}`);
    }

    // Create initial models.json if it doesn't exist
    if (!fs.existsSync(modelsFile)) {
      fs.writeFileSync(modelsFile, JSON.stringify([], null, 2));
      console.log(`Created models.json stub: ${modelsFile}`);
    }

    // Process image
    if (imageUrl && imageUrl.startsWith('http')) {
      await downloadImage(imageUrl, imagePath);
    }
  }
  
  console.log('Finished processing all brands.');
}

main().catch(console.error);
