import { plugin } from "bun";
import { compile } from "svelte/compiler";
import { render } from "svelte/server";
import { mkdir, readdir } from "node:fs/promises";

plugin({
  name: "svelte",
  setup(build) {
    build.onLoad({ filter: /\.svelte$/ }, async ({ path }) => {
      const source = await Bun.file(path).text();
      const { js } = compile(source, {
        filename: path,
        generate: "server",
        css: "injected",
      });

      return { contents: js.code, loader: "js" };
    });
  },
});

const CHROME = "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome";
const WIDTH = 1200;
const HEIGHT = 630;

const here = new URL(".", import.meta.url).pathname;
const out = new URL("../../static/og/", import.meta.url).pathname;

function page(head: string, body: string) {
  return `<!doctype html>
<html>
  <head>
    <meta charset="utf-8" />
    <style>
      @font-face {
        font-family: "IBM Plex Mono";
        font-weight: 400;
        src: url("../../static/fonts/ibm-plex-mono-400.woff2") format("woff2");
      }
      @font-face {
        font-family: "IBM Plex Mono";
        font-weight: 500;
        src: url("../../static/fonts/ibm-plex-mono-500.woff2") format("woff2");
      }
      @font-face {
        font-family: "IBM Plex Mono";
        font-weight: 600;
        src: url("../../static/fonts/ibm-plex-mono-600.woff2") format("woff2");
      }
      @font-face {
        font-family: "IBM Plex Mono";
        font-weight: 700;
        src: url("../../static/fonts/ibm-plex-mono-700.woff2") format("woff2");
      }

      * {
        margin: 0;
        box-sizing: border-box;
      }

      html,
      body {
        width: ${WIDTH}px;
        height: ${HEIGHT}px;
      }

      body {
        background: transparent;
        font-family: "IBM Plex Mono", monospace;
      }
    </style>
${head}
  </head>
  <body>
${body}
  </body>
</html>
`;
}

await mkdir(out, { recursive: true });

const cards = (await readdir(here)).filter((file) => file.endsWith(".svelte"));

for (const card of cards) {
  const name = card.replace(/\.svelte$/, "");
  const { default: component } = await import(`${here}${card}`);
  const { head, body } = render(component);
  const html = `${here}.${name}.render.html`;

  await Bun.write(html, page(head, body));

  const chrome = Bun.spawn(
    [
      CHROME,
      "--headless=new",
      "--disable-gpu",
      "--hide-scrollbars",
      "--default-background-color=00000000",
      `--window-size=${WIDTH},${HEIGHT}`,
      `--screenshot=${out}${name}.png`,
      html,
    ],
    { stdout: "ignore", stderr: "ignore" },
  );

  if ((await chrome.exited) !== 0) throw new Error(`failed to shoot ${name}`);

  console.log(`  static/og/${name}.png`);
}

console.log("Generated OG images!");