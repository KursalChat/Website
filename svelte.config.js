import adapter from "@sveltejs/adapter-static";
import { vitePreprocess } from "@sveltejs/vite-plugin-svelte";

/** @type {import("@sveltejs/vite-plugin-svelte").SvelteConfig} */
export default {
  preprocess: vitePreprocess(),
  kit: {
    adapter: adapter({
      pages: "build",
      assets: "build",
      fallback: undefined,
    }),
    prerender: {
      handleHttpError: ({ path, referrer, message }) => {
        if (path === "/issues" || path === "/vulnerability") {
          return;
        }
        throw new Error(message);
      },
    },
  },
};
