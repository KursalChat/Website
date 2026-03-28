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
  class="min-h-screen w-full flex flex-col items-center justify-center gap-8 px-6"
>
  <div class="text-center">
    <h1 class="text-4xl font-bold text-kursal-50 mb-2">404</h1>
    <p class="text-kursal-300">Page vaporized. It has never existed.</p>
  </div>
</main>
