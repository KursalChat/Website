import { SITE_URL } from "$lib/const";

export const prerender = true;

const pages = [
  { path: "/", changefreq: "weekly", priority: 1.0 },
  { path: "/download", changefreq: "weekly", priority: 0.9 },
  { path: "/progress", changefreq: "weekly", priority: 0.9 },
  { path: "/privacy", changefreq: "monthly", priority: 0.7 },
  { path: "/security", changefreq: "monthly", priority: 0.7 },
  { path: "/terms", changefreq: "monthly", priority: 0.6 },
];

const today = new Date().toISOString().split("T")[0];

export async function GET() {
  const urls = pages
    .map(
      ({ path, changefreq, priority }) => `
  <url>
    <loc>${SITE_URL}${path}</loc>
    <lastmod>${today}</lastmod>
    <changefreq>${changefreq}</changefreq>
    <priority>${priority}</priority>
  </url>`,
    )
    .join("");

  const xml = `<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">${urls}
</urlset>`;

  return new Response(xml, {
    headers: {
      "Content-Type": "application/xml",
      "Cache-Control": "max-age=3600",
    },
  });
}
