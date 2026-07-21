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
    csp: {
      mode: "hash",
      directives: {
        "default-src": ["self"],
        "script-src": ["self", "https://stats.openvoxel.studio"],
        "style-src": ["self", "unsafe-inline"],
        "img-src": ["self", "data:"],
        "font-src": ["self"],
        "connect-src": [
          "self",
          "https://stats.openvoxel.studio",
          "https://mail.kursal.chat",
          "https://api.github.com",
        ],
        "frame-ancestors": ["none"],
        "base-uri": ["self"],
        "form-action": ["self"],
        "object-src": ["none"],
      },
    },
    prerender: {
      handleHttpError: ({ path, referrer, message }) => {
        if (
          path === "/issues" ||
          path === "/vulnerability" ||
          path === "/trademark"
        ) {
          return;
        }
        throw new Error(message);
      },
    },
  },
};
