import { readFileSync } from 'fs';
let lines = readFileSync('node_modules/@astrojs/mdx/dist/vite-plugin-mdx.js', 'utf8').split('\n');
let newLines = lines.map(line => {
   if (line.includes('const err = e;')) {
      return '          console.log("FAILED ON FILE: " + id);\n' + line;
   }
   return line;
});
import { writeFileSync } from 'fs';
writeFileSync('node_modules/@astrojs/mdx/dist/vite-plugin-mdx.js', newLines.join('\n'));
