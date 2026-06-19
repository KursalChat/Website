<script lang="ts">
  import { CircleCheckBig, ArrowLeft, BookOpen } from "lucide-svelte";
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
    if (!plat || !fileKey) return;
    platform = plat.name;

    const file = plat.links.find((l) => l.id === fileKey);
    if (!file) return;
    fileURL = file?.url;

    window.plausible?.("File Download", {
      props: {
        platform: plat.name,
        file: fileKey,
      },
    });

    setTimeout(() => {
      if (fileURL) {
        window.location.href = fileURL;
      }
    }, 150);
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
      class="w-16 h-16 bg-accent-500/15 border border-accent-500/40 rounded-sm flex items-center justify-center mx-auto mb-8"
    >
      <CircleCheckBig size={36} class="text-accent-400" />
    </div>

    <p class="font-mono text-sm text-accent-400 mb-3">~/thanks</p>
    <h1 class="font-mono text-4xl md:text-5xl font-bold text-kursal-50 mb-4">
      Thanks for downloading Kursal
    </h1>

    <p class="text-lg text-kursal-200 mb-4 leading-relaxed">
      {#if platform}
        Your <span class="font-mono text-accent-400">{platform}</span>
        download should have started.

        <a
          href={fileURL}
          class="text-accent-400 underline underline-offset-2 hover:text-accent-300"
          >If not, click here</a
        >.
      {:else}
        Hmm.. Seems you landed on this page with invalid parameters. Go check
        the download page out and click from there!
      {/if}
    </p>

    <p class="text-kursal-300 mb-8">
      <a
        href="/download"
        class="text-accent-400 underline underline-offset-2 hover:text-accent-300"
        >Wrong download? View all available downloads</a
      >.
    </p>

    <div
      class="bg-kursal-800 rounded-sm border border-kursal-700 p-7 text-left mb-8"
    >
      <h2 class="font-mono text-sm text-accent-400 mb-6">
        <span class="text-kursal-500">#</span> Getting Started
      </h2>

      <div class="space-y-5">
        <div class="flex gap-4">
          <span class="font-mono text-accent-400 font-semibold shrink-0 pt-0.5"
            >01</span
          >
          <div>
            <h3 class="font-mono text-kursal-50 font-medium">
              Install the application
            </h3>
            <p class="text-kursal-300 text-sm mt-1">
              Open the downloaded file and follow the installation instructions.
            </p>
          </div>
        </div>

        <div class="flex gap-4">
          <span class="font-mono text-accent-400 font-semibold shrink-0 pt-0.5"
            >02</span
          >
          <div>
            <h3 class="font-mono text-kursal-50 font-medium">
              Start chatting privately
            </h3>
            <p class="text-kursal-300 text-sm mt-1">
              Enjoy end-to-end encrypted messaging. As simple as that!
            </p>
          </div>
        </div>
      </div>
    </div>

    <div class="flex flex-col sm:flex-row gap-3 justify-center font-mono">
      <a
        href={PAPER_URL}
        target="_blank"
        class="inline-flex items-center justify-center gap-2 border border-kursal-600 hover:border-accent-500 bg-kursal-800 hover:bg-kursal-700 text-kursal-100 px-6 py-3 rounded-sm font-medium transition-colors"
      >
        <BookOpen size={18} />
        Read the Whitepaper
      </a>

      <a
        href={repository}
        target="_blank"
        rel="noopener noreferrer"
        class="inline-flex items-center justify-center gap-2 border border-kursal-600 hover:border-accent-500 bg-kursal-800 hover:bg-kursal-700 text-kursal-100 px-6 py-3 rounded-sm font-medium transition-colors"
      >
        <SiGithub size={18} />
        Star us on GitHub
      </a>
    </div>

    <div class="mt-12">
      <a
        href="/"
        class="inline-flex items-center gap-2 font-mono text-sm text-kursal-400 hover:text-accent-400 transition-colors"
      >
        <ArrowLeft size={18} />
        Back to home
      </a>
    </div>
  </div>
</main>

<Footer />
