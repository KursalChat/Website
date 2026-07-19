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

<main class="flex min-h-screen items-center bg-kursal-900 pt-24 pb-16">
  <div class="mx-auto max-w-2xl px-6 text-center">
    <div
      class="mx-auto mb-8 flex h-16 w-16 items-center justify-center rounded-sm border border-accent-500/40 bg-accent-500/15"
    >
      <CircleCheckBig size={36} class="text-accent-400" />
    </div>

    <p class="mb-3 font-mono text-sm text-accent-400">~/thanks</p>
    <h1 class="mb-4 font-mono text-4xl font-bold text-kursal-50 md:text-5xl">
      Thanks for downloading Kursal
    </h1>

    <p class="mb-4 text-lg leading-relaxed text-kursal-200">
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

    <p class="mb-8 text-kursal-300">
      <a
        href="/download"
        class="text-accent-400 underline underline-offset-2 hover:text-accent-300"
        >Wrong download? View all available downloads</a
      >.
    </p>

    <div
      class="mb-8 rounded-sm border border-kursal-700 bg-kursal-800 p-7 text-left"
    >
      <h2 class="mb-6 font-mono text-sm text-accent-400">
        <span class="text-kursal-500">#</span> Getting Started
      </h2>

      <div class="space-y-5">
        <div class="flex gap-4">
          <span class="shrink-0 pt-0.5 font-mono font-semibold text-accent-400"
            >01</span
          >
          <div>
            <h3 class="font-mono font-medium text-kursal-50">
              Install the application
            </h3>
            <p class="mt-1 text-sm text-kursal-300">
              Open the downloaded file and follow the installation instructions.
            </p>
          </div>
        </div>

        <div class="flex gap-4">
          <span class="shrink-0 pt-0.5 font-mono font-semibold text-accent-400"
            >02</span
          >
          <div>
            <h3 class="font-mono font-medium text-kursal-50">
              Start chatting privately
            </h3>
            <p class="mt-1 text-sm text-kursal-300">
              Enjoy end-to-end encrypted messaging. As simple as that!
            </p>
          </div>
        </div>
      </div>
    </div>

    <div class="flex flex-col justify-center gap-3 font-mono sm:flex-row">
      <a
        href={PAPER_URL}
        target="_blank"
        class="inline-flex items-center justify-center gap-2 rounded-sm border border-kursal-600 bg-kursal-800 px-6 py-3 font-medium text-kursal-100 transition-colors hover:border-accent-500 hover:bg-kursal-700"
      >
        <BookOpen size={18} />
        Read the Whitepaper
      </a>

      <a
        href={repository}
        target="_blank"
        rel="noopener noreferrer"
        class="inline-flex items-center justify-center gap-2 rounded-sm border border-kursal-600 bg-kursal-800 px-6 py-3 font-medium text-kursal-100 transition-colors hover:border-accent-500 hover:bg-kursal-700"
      >
        <SiGithub size={18} />
        Star us on GitHub
      </a>
    </div>

    <div class="mt-12">
      <a
        href="/"
        class="inline-flex items-center gap-2 font-mono text-sm text-kursal-400 transition-colors hover:text-accent-400"
      >
        <ArrowLeft size={18} />
        Back to home
      </a>
    </div>
  </div>
</main>

<Footer />
