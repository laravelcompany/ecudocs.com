import fs from 'fs';
import path from 'path';

const SRC_FILE = path.join(process.cwd(), 'src', 'content', 'manuals.json');
const DEST_DIR = path.join(process.cwd(), 'src', 'content', 'manuals');

const rawData = fs.readFileSync(SRC_FILE, 'utf-8');
const data = JSON.parse(rawData);

function slugify(text) {
  return text.toString().toLowerCase()
    .replace(/[^\w\s-]/g, '') // remove non-word characters
    .replace(/[\s_-]+/g, '-') // convert spaces and underscores to hyphens
    .replace(/^-+|-+$/g, ''); // trim hyphens
}

if (!fs.existsSync(DEST_DIR)) {
  fs.mkdirSync(DEST_DIR, { recursive: true });
}

let count = 0;
data.forEach(manual => {
    const slug = slugify(manual.name);
    const filePath = path.join(DEST_DIR, `${slug}.mdx`);
    
    // Formatting the frontmatter properly, escaping quotes if necessary
    const title = manual.name.replace(/"/g, '\\"');
    const desc = manual.description.replace(/"/g, '\\"');
    
    const mdContent = `---
title: "${title}"
description: "${desc}"
---

# ${manual.name}

${manual.description}
`;

    fs.writeFileSync(filePath, mdContent);
    count++;
});

console.log(`✅ Successfully generated ${count} markdown manuals in src/content/manuals/`);
