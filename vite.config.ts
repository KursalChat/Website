import { defineConfig, type Plugin } from "vite";
import { sveltekit } from "@sveltejs/kit/vite";
import tailwindcss from "@tailwindcss/vite";
import { readFile, writeFile } from "node:fs/promises";

function securityTxtExpires(): Plugin {
  const source = "static/.well-known/security.txt";
  const output = "build/.well-known/security.txt";
  const field = /^Expires:.*$/m;

  async function stamp(path: string, expires: string, required: boolean) {
    let contents: string;
    try {
      contents = await readFile(path, "utf8");
    } catch (cause) {
      if (!required) return;
      throw new Error(`security.txt: cannot read ${path}`, { cause });
    }

    if (!field.test(contents)) {
      throw new Error(`security.txt: no Expires field in ${path}`);
    }

    await writeFile(path, contents.replace(field, `Expires: ${expires}`));
  }

  return {
    name: "security-txt-expires",
    apply: "build",
    enforce: "post",
    closeBundle: {
      sequential: true,
      order: "post",
      async handler() {
        const expires = new Date();
        expires.setUTCFullYear(expires.getUTCFullYear() + 1);
        expires.setUTCDate(expires.getUTCDate() - 1);
        expires.setUTCHours(0, 0, 0, 0);

        await stamp(source, expires.toISOString(), true);
        await stamp(output, expires.toISOString(), false);
      },
    },
  };
}

// https://vite.dev/config/
export default defineConfig({
  plugins: [sveltekit(), tailwindcss(), securityTxtExpires()],
  server: {
    allowedHosts: true,
  },
});
