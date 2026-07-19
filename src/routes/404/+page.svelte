<script lang="ts">
  import { SITE_URL } from "$lib/const";

  const pageUrl = `${SITE_URL}/404`;
</script>

<svelte:head>
  <title>Page Not Found | Kursal</title>
  <meta
    name="description"
    content="The page you requested could not be found on Kursal."
  />
  <meta name="robots" content="noindex, follow" />
  <link rel="canonical" href={pageUrl} />
</svelte:head>

<main
  class="flex min-h-screen w-full flex-col items-center justify-center bg-kursal-900 px-6"
>
  <div
    class="w-full max-w-lg overflow-hidden rounded-sm border border-kursal-700 bg-kursal-800 font-mono"
  >
    <div
      class="flex items-center justify-between border-b border-kursal-700 px-4 py-2.5 text-xs text-kursal-400"
    >
      <span class="flex items-center gap-2"
        ><span class="text-accent-500">kursal:~$</span> locate page</span
      >
      <span class="stamp -rotate-3 text-[0.6rem] text-party-500">Not Found</span
      >
    </div>

    <div class="bg-kursal-900 p-6 sm:p-8">
      <h1 class="mb-3 text-5xl font-bold text-kursal-50">404</h1>
      <p class="mb-1 text-sm text-party-400">
        error: no such page in this directory
      </p>
      <p class="mb-8 text-kursal-300">Page vaporized. It has never existed.</p>

      <a
        href="/"
        class="group inline-flex items-center gap-2 rounded-sm border border-accent-500/70 px-4 py-2 font-medium text-accent-400 transition-colors hover:bg-accent-500 hover:text-kursal-950"
      >
        <span
          class="text-kursal-500 transition group-hover:-translate-x-0.5 group-hover:text-kursal-950/60"
          >[</span
        >
        cd ~
        <span
          class="text-kursal-500 transition group-hover:translate-x-0.5 group-hover:text-kursal-950/60"
          >]</span
        >
      </a>
    </div>
  </div>
</main>
