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
  class="min-h-screen w-full flex flex-col items-center justify-center px-6 bg-kursal-900"
>
  <div
    class="w-full max-w-lg font-mono rounded-sm border border-kursal-700 bg-kursal-800 overflow-hidden"
  >
    <div
      class="flex items-center justify-between px-4 py-2.5 border-b border-kursal-700 text-xs text-kursal-400"
    >
      <span class="flex items-center gap-2"
        ><span class="text-accent-500">kursal:~$</span> locate page</span
      >
      <span class="stamp text-party-500 text-[0.6rem] -rotate-3">Not Found</span
      >
    </div>

    <div class="p-6 sm:p-8 bg-kursal-900">
      <h1 class="text-5xl font-bold text-kursal-50 mb-3">404</h1>
      <p class="text-party-400 text-sm mb-1">
        error: no such page in this directory
      </p>
      <p class="text-kursal-300 mb-8">Page vaporized. It has never existed.</p>

      <a
        href="/"
        class="group inline-flex items-center gap-2 border border-accent-500/70 text-accent-400 hover:bg-accent-500 hover:text-kursal-950 px-4 py-2 rounded-sm font-medium transition-colors"
      >
        <span
          class="text-kursal-500 transition group-hover:text-kursal-950/60 group-hover:-translate-x-0.5"
          >[</span
        >
        cd ~
        <span
          class="text-kursal-500 transition group-hover:text-kursal-950/60 group-hover:translate-x-0.5"
          >]</span
        >
      </a>
    </div>
  </div>
</main>
