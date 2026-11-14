import { defineCollection, z } from 'astro:content';
import { glob } from 'astro/loaders';

const manuals = defineCollection({
  type: 'content',
  schema: z.object({
    title: z.string(),
    description: z.string().optional(),
  })
});

const qaPostSchema = z.object({
  title: z.string(),
  date: z.coerce.date(),
  author: z.string().default('Anonymous'),
  authorRole: z.string().optional(),
  authorAvatar: z.string().optional(),
  excerpt: z.string().optional(),
  image: z.string().nullable().optional(),
  tags: z.array(z.string()).default([]),
  content: z.string(),
});

const qa = defineCollection({
  loader: glob({ pattern: '**/*.json', base: './questions/json' }),
  schema: qaPostSchema,
});

export const collections = { manuals, qa };
