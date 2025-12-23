<script lang="ts">
  import {
    CircleCheckBig,
    BookOpen,
    MessageSquare,
    ArrowLeft,
  } from "lucide-svelte";
  import { onMount } from "svelte";
  import Navbar from "$lib/components/Navbar.svelte";
  import Footer from "$lib/components/Footer.svelte";
  import { repository, PAPER_URL } from "$lib/const";

  interface PlatformInfo {
    name: string;
    downloadUrl: string | null;
  }

  const platforms: Record<string, PlatformInfo> = {
    mac: { name: "macOS", downloadUrl: null },
    windows: { name: "Windows", downloadUrl: null },
    linux: { name: "Linux", downloadUrl: null },
  };

  function getPlatformFromUrl(): PlatformInfo | null {
    if (typeof window === "undefined") return null;

    const params = new URLSearchParams(window.location.search);
    const platformKey = params.get("platform")?.toLowerCase();

    if (!platformKey || !(platformKey in platforms)) return null;

    return platforms[platformKey];
  }

  function triggerDownload(url: string) {
    const link = document.createElement("a");
    link.href = url;
    link.download = "";
    document.body.appendChild(link);
    link.click();
    document.body.removeChild(link);
  }

  const platform = getPlatformFromUrl();

  onMount(() => {
    if (platform?.downloadUrl) {
      triggerDownload(platform.downloadUrl);
    }
  });
</script>

<Navbar />

<main class="min-h-screen pt-24 pb-16 bg-kursal-900 flex items-center">
  <div class="max-w-2xl mx-auto px-6 text-center">
    <div
      class="w-20 h-20 bg-green-900/30 rounded-full flex items-center justify-center mx-auto mb-8"
    >
      <CircleCheckBig size={48} class="text-green-400" />
    </div>

    <h1 class="text-4xl md:text-5xl font-bold text-white mb-4">
      {#if platform}
        Thanks for downloading!
      {:else}
        Thank you!
      {/if}
    </h1>

    <p class="text-lg text-kursal-50 mb-4">
      {#if platform}
        Your download for <span class="text-white font-medium"
          >{platform.name}</span
        >
        {#if platform.downloadUrl}
          should start automatically.
        {:else}
          is not yet available.
        {/if}
      {:else}
        Kursal is coming soon. Stay tuned for updates!
      {/if}
    </p>

    <p class="text-kursal-100 mb-8">
      {#if platform?.downloadUrl}
        If the download doesn't start, <a
          href={platform.downloadUrl}
          class="text-accent-400 hover:underline"
          >click here to download manually</a
        >.
      {:else}
        <a href="/download" class="text-accent-400 hover:underline"
          >View all available downloads</a
        >.
      {/if}
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
            <h3 class="text-white font-medium">Create your account</h3>
            <p class="text-kursal-200 text-sm">
              Your encryption keys are generated locally on your device.
            </p>
          </div>
        </div>

        <div class="flex gap-4">
          <div
            class="w-8 h-8 bg-accent-500/20 rounded-full flex items-center justify-center flex-shrink-0"
          >
            <span class="text-accent-400 font-semibold">3</span>
          </div>
          <div>
            <h3 class="text-white font-medium">Start chatting privately</h3>
            <p class="text-kursal-200 text-sm">
              Share friend codes and enjoy end-to-end encrypted messaging.
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
        <MessageSquare size={18} />
        Join the Community
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
