<script lang="ts">
  import {
    CircleCheckBig,
    ArrowLeft,
    BookOpen,
    HandMetal,
  } from "lucide-svelte";
  import { onMount } from "svelte";
  import Navbar from "$lib/components/Navbar.svelte";
  import Footer from "$lib/components/Footer.svelte";
  import { PAPER_URL, repository, SITE_URL } from "$lib/const";
  import { SiGithub } from "@icons-pack/svelte-simple-icons";
  import { platforms } from "$lib/download";

  const pageUrl = `${SITE_URL}/thanks`;

  let platform = $state<string | null>(null);
  let fileURL = $state<string | null>(null);

  onMount(() => {
    const params = new URLSearchParams(window.location.search);
    const platformKey = params.get("platform")?.toLowerCase();
    const fileKey = params.get("id")?.toLowerCase();

    const plat = platforms.find((p) => p.id === platformKey);
    if (!plat) return;
    platform = plat.name;

    const file = plat.links.find((l) => l.id === fileKey);
    if (!file) return;
    fileURL = file.url;

    window.plausible?.("File Download", {
      props: {
        platform: plat.name,
        file: fileKey,
      },
    });

    window.location.href = fileURL;
  });
</script>

<svelte:head>
  <title>Thanks | Kursal</title>
  <meta name="description" content="Thanks for your interest in Kursal!" />
  <meta name="robots" content="noindex, follow" />
  <link rel="canonical" href={pageUrl} />
</svelte:head>

<Navbar />

<main class="min-h-screen pt-24 pb-16 bg-kursal-900 flex items-center">
  <div class="max-w-2xl mx-auto px-6 text-center">
    <div
      class="w-20 h-20 bg-green-900/30 rounded-full flex items-center justify-center mx-auto mb-8"
    >
      <CircleCheckBig size={48} class="text-green-400" />
    </div>

    <h1 class="text-4xl md:text-5xl font-bold text-white mb-4">
      Thanks for downloading Kursal
    </h1>

    <p class="text-lg text-kursal-50 mb-4">
      {#if platform}
        Your <span class="text-white font-medium">{platform}</span>
        download should have started.

        <a href={fileURL} class="text-accent-400 hover:underline"
          >If not, click here</a
        >.
      {:else}
        Hmm.. Seems you landed on this page with invalid parameters. Go check
        the download page out and click from there!
      {/if}
    </p>

    <p class="text-kursal-100 mb-8">
      <a href="/download" class="text-accent-400 hover:underline"
        >Wrong download? View all available downloads</a
      >.
    </p>

    <div
      class="bg-kursal-800 rounded-2xl border border-kursal-700 p-8 text-left mb-8"
    >
      <h2 class="text-xl font-semibold text-white mb-6">Getting Started</h2>

      <div class="space-y-4">
        <div class="flex gap-4">
          <div
            class="w-8 h-8 bg-accent-500/20 rounded-full flex items-center justify-center flex-shrink-0"
          >
            <span class="text-accent-400 font-semibold">1</span>
          </div>
          <div>
            <h3 class="text-white font-medium">Install the application</h3>
            <p class="text-kursal-200 text-sm">
              Open the downloaded file and follow the installation instructions.
            </p>
          </div>
        </div>

        <div class="flex gap-4">
          <div
            class="w-8 h-8 bg-accent-500/20 rounded-full flex items-center justify-center flex-shrink-0"
          >
            <span class="text-accent-400 font-semibold">2</span>
          </div>
          <div>
            <h3 class="text-white font-medium">Start chatting privately</h3>
            <p class="text-kursal-200 text-sm">
              Enjoy end-to-end encrypted messaging. As simple as that!
            </p>
          </div>
        </div>
      </div>
    </div>

    <div class="flex flex-col sm:flex-row gap-4 justify-center">
      <a
        href={PAPER_URL}
        target="_blank"
        class="inline-flex items-center justify-center gap-2 bg-kursal-700 hover:bg-kursal-600 text-white px-6 py-3 rounded-xl font-medium transition-colors"
      >
        <BookOpen size={18} />
        Read the Whitepaper
      </a>

      <a
        href={repository}
        target="_blank"
        rel="noopener noreferrer"
        class="inline-flex items-center justify-center gap-2 bg-kursal-700 hover:bg-kursal-600 text-white px-6 py-3 rounded-xl font-medium transition-colors"
      >
        <SiGithub size={18} />
        Star us on GitHub
      </a>
    </div>

    <div class="mt-12">
      <a
        href="/"
        class="inline-flex items-center gap-2 text-kursal-400 hover:text-kursal-300 transition-colors"
      >
        <ArrowLeft size={18} />
        Back to home
      </a>
    </div>
  </div>
</main>

<Footer />
