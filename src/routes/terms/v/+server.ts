import { TERMS_LAST_UPDATED } from "$lib/const";

export const prerender = true;

export function GET() {
  return new Response(TERMS_LAST_UPDATED, {
    headers: {
      "Content-Type": "text/plain; charset=utf-8",
      "Cache-Control": "max-age=3600",
    },
  });
}
