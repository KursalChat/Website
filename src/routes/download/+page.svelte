<script lang="ts">
  import {
    Clock,
    Bell,
    TriangleAlert,
    Download,
    ChevronDown,
    ExternalLink,
  } from "lucide-svelte";
  import Navbar from "$lib/components/Navbar.svelte";
  import Footer from "$lib/components/Footer.svelte";
  import { EXPECTEDTIME, SITE_ICON, SITE_URL } from "$lib/const";
  import { platforms, type OSId } from "$lib/download";

  let openDropdown = $state<string | null>(null);

  function toggleDropdown(id: string, event: MouseEvent) {
    event.stopPropagation();
    if (openDropdown === id) {
      openDropdown = null;
    } else {
      openDropdown = id;
    }
  }

  function handleOutsideClick(event: MouseEvent) {
    const target = event.target as HTMLElement;
    if (!target.closest(".linux-dropdown-container")) {
      openDropdown = null;
    }
  }

  function handleDownloadClick(
    platformId: OSId,
    linkId: string,
    event: MouseEvent,
  ) {
    event.preventDefault();

    const params = new URLSearchParams({
      platform: platformId,
      id: linkId,
    });
    window.location.href = `/thanks?${params.toString()}`;
  }

  const pageUrl = `${SITE_URL}/download`;
</script>

<svelte:window onclick={handleOutsideClick} />

<svelte:head>
  <title>Download Kursal | Private Messaging App</title>
  <meta
    name="description"
    content="Download Kursal for macOS, Windows, and Linux. Get notified as soon as releases are available."
  />
  <link rel="canonical" href={pageUrl} />

  <meta property="og:title" content="Download Kursal | Private Messaging App" />
  <meta
    property="og:description"
    content="Download Kursal for macOS, Windows, and Linux. Get notified as soon as releases are available."
  />
  <meta property="og:url" content={pageUrl} />
  <meta property="og:image" content={SITE_ICON} />

  <meta name="twitter:card" content="summary" />
  <meta
    name="twitter:title"
    content="Download Kursal | Private Messaging App"
  />
  <meta
    name="twitter:description"
    content="Download Kursal for macOS, Windows, and Linux. Get notified as soon as releases are available."
  />
  <meta name="twitter:image" content={SITE_ICON} />
</svelte:head>

<Navbar />

<main class="min-h-screen pt-24 pb-16 bg-kursal-900">
  <div class="max-w-4xl mx-auto px-6">
    <div class="text-center mb-12">
      <div
        class="inline-flex items-center gap-2 bg-accent-500/20 text-accent-400 px-4 py-2 rounded-full mb-6 text-sm font-medium"
      >
        <Clock size={16} />
        {EXPECTEDTIME}
      </div>

      <h1 class="text-4xl md:text-5xl font-bold text-white mb-4">
        Download Kursal
      </h1>
      <p class="text-lg text-kursal-50 max-w-xl mx-auto">
        Kursal is currently in a <strong>very early prototype stage</strong>.
        Expect bugs, missing features, and instability! Download below or sign
        up for a future stable release.
      </p>
    </div>

    <div
      class="mb-12 p-8 bg-kursal-800 rounded-2xl border border-accent-500/30 text-center"
    >
      <h3 class="text-xl font-semibold text-white mb-2">
        Get notified when beta launches
      </h3>
      <p class="text-kursal-50 mb-6">
        Be the first to download Kursal when it's ready.
      </p>
      <a
        href="/#notify"
        class="inline-flex items-center gap-2 bg-accent-500 hover:bg-accent-400 text-white px-6 py-3 rounded-xl font-medium transition-colors"
      >
        <Bell size={18} />
        Sign up for updates
      </a>
    </div>

    <div
      class="mb-6 bg-red-500/10 border border-red-500/30 rounded-xl p-4 flex gap-3 items-start md:items-center"
    >
      <TriangleAlert class="text-red-400 shrink-0 mt-0.5 md:mt-0" size={20} />
      <p class="text-red-200 text-sm leading-relaxed">
        <strong>Early Prototype:</strong> This release is highly experimental
        and meant for testing purposes. You will encounter bugs, missing
        features, and potential data loss. Please report any issues on the
        <a
          href="https://github.com/KursalChat/Kursal-Prototype/issues"
          target="_blank"
          rel="noopener noreferrer"
          class="inline-flex items-center gap-1 underline hover:text-red-100 font-medium transition-colors"
          >prototype GitHub <ExternalLink size={12} class="opacity-80" /></a
        >.
      </p>
    </div>

    <div class="grid gap-6">
      {#each platforms as platform}
        <div
          class="flex flex-col md:flex-row md:items-center gap-6 p-6 bg-kursal-800 rounded-2xl border border-kursal-700 hover:border-accent-500/50 transition-colors"
        >
          <div class="flex items-center gap-6 flex-1">
            <div
              class="w-16 h-16 bg-kursal-700 rounded-xl flex items-center justify-center shrink-0"
            >
              <platform.icon size={32} class="text-kursal-400" />
            </div>

            <div>
              <h2 class="text-xl font-semibold text-white">
                {platform.name}
              </h2>
              <p class="text-kursal-100 text-sm mt-1">{platform.description}</p>
            </div>
          </div>

          <div class="w-full md:w-auto relative">
            {#if platform.id === "linux"}
              <div class="flex flex-col gap-3 items-stretch md:items-end">
                <div class="relative w-full md:w-auto linux-dropdown-container">
                  <button
                    onclick={(e) => toggleDropdown("linux-x64", e)}
                    class="relative w-full md:w-[220px] inline-flex items-center justify-center gap-2 px-4 py-2 pr-10 bg-kursal-700 hover:bg-kursal-600 border border-kursal-600 rounded-lg text-sm text-kursal-50 font-medium transition-colors"
                  >
                    <Download
                      size={14}
                      class="text-accent-400 text-opacity-80 shrink-0"
                    />
                    <span>x64 / AMD64</span>
                    <ChevronDown
                      size={14}
                      class="text-kursal-400 transition-transform {openDropdown ===
                      'linux-x64'
                        ? 'rotate-180'
                        : ''} absolute right-4"
                    />
                  </button>
                  {#if openDropdown === "linux-x64"}
                    <div
                      class="absolute right-0 mt-2 w-full md:w-[220px] bg-kursal-800 border border-kursal-600 rounded-lg shadow-xl overflow-hidden z-10"
                    >
                      {#each platform.links.slice(0, 3) as link}
                        <a
                          href={link.url}
                          onclick={(e) =>
                            handleDownloadClick(platform.id, link.id, e)}
                          class="inline-flex items-center justify-center gap-2 px-4 py-3 hover:bg-kursal-700 text-sm text-kursal-50 transition-colors"
                        >
                          <Download
                            size={14}
                            class="text-accent-400 text-opacity-80 shrink-0"
                          />
                          {link.label}
                        </a>
                      {/each}
                    </div>
                  {/if}
                </div>

                <div class="relative w-full md:w-auto linux-dropdown-container">
                  <button
                    onclick={(e) => toggleDropdown("linux-arm64", e)}
                    class="relative w-full md:w-[220px] inline-flex items-center justify-center gap-2 px-4 py-2 pr-10 bg-kursal-700 hover:bg-kursal-600 border border-kursal-600 rounded-lg text-sm text-kursal-50 font-medium transition-colors"
                  >
                    <Download
                      size={14}
                      class="text-accent-400 text-opacity-80 shrink-0"
                    />
                    <span>arm64</span>
                    <ChevronDown
                      size={14}
                      class="text-kursal-400 transition-transform {openDropdown ===
                      'linux-arm64'
                        ? 'rotate-180'
                        : ''} absolute right-4"
                    />
                  </button>
                  {#if openDropdown === "linux-arm64"}
                    <div
                      class="absolute right-0 mt-2 w-full md:w-[220px] bg-kursal-800 border border-kursal-600 rounded-lg shadow-xl overflow-hidden z-10"
                    >
                      {#each platform.links.slice(3, 6) as link}
                        <a
                          href={link.url}
                          onclick={(e) =>
                            handleDownloadClick(platform.id, link.id, e)}
                          class="inline-flex items-center justify-center gap-2 px-4 py-3 hover:bg-kursal-700 text-sm text-kursal-50 transition-colors"
                        >
                          <Download
                            size={14}
                            class="text-accent-400 text-opacity-80 shrink-0"
                          />
                          {link.label}
                        </a>
                      {/each}
                    </div>
                  {/if}
                </div>
              </div>
            {:else}
              <div class="flex flex-col gap-3 items-stretch md:items-end">
                {#each platform.links as link}
                  <a
                    href={link.url}
                    onclick={(e) =>
                      handleDownloadClick(platform.id, link.id, e)}
                    class="inline-flex items-center justify-center gap-2 px-4 py-2 bg-kursal-700 hover:bg-kursal-600 border border-kursal-600 rounded-lg text-sm text-kursal-50 font-medium transition-colors w-full md:w-[220px]"
                  >
                    <Download
                      size={14}
                      class="text-accent-400 text-opacity-80"
                    />
                    {link.label}
                  </a>
                {/each}
              </div>
            {/if}
          </div>
        </div>
      {/each}
    </div>
  </div>
</main>

<Footer />
