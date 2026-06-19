<script lang="ts">
  import {
    Clock,
    Bell,
    TriangleAlert,
    Download,
    ChevronDown,
    ExternalLink,
    Copy,
    Check,
  } from "lucide-svelte";
  import Navbar from "$lib/components/Navbar.svelte";
  import Footer from "$lib/components/Footer.svelte";
  import { EXPECTEDTIME, SITE_ICON, SITE_URL } from "$lib/const";
  import { platforms, type OSId } from "$lib/download";

  let openDropdown = $state<string | null>(null);
  let latestVersion = $state<string | null>(null);
  let copiedState = $state<Record<string, boolean>>({});
  let activeTerminalTab = $state<"mac-linux" | "windows">("mac-linux");

  let activeTerminalCmd = $derived(
    activeTerminalTab === "mac-linux"
      ? "curl -fsSL https://kursal.chat | bash"
      : 'powershell -c "irm kursal.chat | iex"',
  );
  let activeTerminalPrompt = $derived(
    activeTerminalTab === "mac-linux" ? "$" : ">",
  );

  $effect(() => {
    const ua = window.navigator.userAgent.toLowerCase();
    if (ua.includes("win")) {
      activeTerminalTab = "windows";
    } else {
      activeTerminalTab = "mac-linux";
    }

    fetchVersion();
  });

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

  function handleCopy(text: string, id: string) {
    navigator.clipboard.writeText(text);
    copiedState[id] = true;
    setTimeout(() => {
      copiedState[id] = false;
    }, 2000);
  }

  const pageUrl = `${SITE_URL}/download`;

  async function fetchVersion() {
    const res = await fetch(
      "https://api.github.com/repos/KursalChat/Kursal-Prototype/releases/latest",
    );

    const release = await res.json();
    latestVersion = release.tag_name;
  }
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
        class="inline-flex items-center gap-2 font-mono text-sm text-kursal-300 mb-6"
      >
        <Clock size={15} class="text-accent-400" />
        {EXPECTEDTIME}
      </div>

      <h1 class="font-mono text-4xl md:text-5xl font-bold text-kursal-50 mb-4">
        Download Kursal
        {#if latestVersion}
          <span
            class="inline-flex items-center font-mono text-xs font-bold tracking-wide text-accent-400 border border-accent-500/30 px-2.5 py-0.5 rounded-sm align-middle ml-2 -mt-2"
            >{latestVersion}</span
          >
        {/if}
      </h1>
      <p class="text-lg text-kursal-200 max-w-xl mx-auto leading-relaxed">
        Kursal is currently in a <strong class="text-kursal-50"
          >very early prototype stage</strong
        >. Expect bugs, missing features, and instability! Download below or
        sign up for a future stable release.
      </p>
    </div>

    <div
      class="mb-12 p-7 bg-kursal-800 rounded-sm border border-accent-500/30 text-center"
    >
      <h3 class="font-mono text-lg font-semibold text-kursal-50 mb-2">
        Get notified when beta launches
      </h3>
      <p class="text-kursal-300 mb-6">
        Be the first to download Kursal when it's ready.
      </p>
      <a
        href="/#notify"
        class="inline-flex items-center gap-2 font-mono bg-accent-500 hover:bg-accent-400 text-kursal-950 px-6 py-3 rounded-sm font-semibold transition-colors"
      >
        <Bell size={18} />
        Sign up for updates
      </a>
    </div>

    <div
      class="mb-6 bg-party-500/[0.08] border-l-2 border-party-500 rounded-sm p-4 flex gap-3 items-start md:items-center"
    >
      <TriangleAlert class="text-party-400 shrink-0 mt-0.5 md:mt-0" size={20} />
      <p class="text-kursal-200 text-sm leading-relaxed">
        <strong class="font-mono text-party-400">Early Prototype:</strong> This
        release is highly experimental and meant for testing purposes. You will
        encounter bugs, missing features, and potential data loss. Please report
        any issues on the
        <a
          href="https://github.com/KursalChat/Kursal-Prototype/issues"
          target="_blank"
          rel="noopener noreferrer"
          class="inline-flex items-center gap-1 underline underline-offset-2 hover:text-kursal-50 font-medium transition-colors"
          >prototype GitHub <ExternalLink size={12} class="opacity-80" /></a
        >.
      </p>
    </div>

    <div class="mb-12">
      <h2 class="font-mono text-2xl font-bold text-kursal-50 mb-4">
        <span class="text-accent-500">$</span> Install via Terminal
        <span class="text-kursal-400 text-base font-normal">(Recommended)</span>
      </h2>

      <div
        class="bg-kursal-800 rounded-sm border border-kursal-700 overflow-hidden"
      >
        <div class="flex bg-kursal-950 border-b border-kursal-700 font-mono">
          <button
            onclick={() => (activeTerminalTab = "mac-linux")}
            class="px-6 py-3.5 text-sm font-medium transition-all relative {activeTerminalTab ===
            'mac-linux'
              ? 'text-kursal-50 bg-kursal-800'
              : 'text-kursal-400 hover:text-kursal-200 hover:bg-kursal-800/50'}"
          >
            Mac / Linux
            {#if activeTerminalTab === "mac-linux"}
              <div
                class="absolute bottom-0 left-0 right-0 h-0.5 bg-accent-500"
              ></div>
            {/if}
          </button>
          <button
            onclick={() => (activeTerminalTab = "windows")}
            class="px-6 py-3.5 text-sm font-medium transition-all relative {activeTerminalTab ===
            'windows'
              ? 'text-kursal-50 bg-kursal-800'
              : 'text-kursal-400 hover:text-kursal-200 hover:bg-kursal-800/50'}"
          >
            Windows
            {#if activeTerminalTab === "windows"}
              <div
                class="absolute bottom-0 left-0 right-0 h-0.5 bg-accent-500"
              ></div>
            {/if}
          </button>
        </div>

        <div class="p-5">
          <div
            class="flex items-center gap-3 bg-kursal-950 border border-kursal-700 rounded-sm p-3"
          >
            <code
              class="text-kursal-50 text-sm flex-1 font-mono overflow-x-auto whitespace-nowrap"
            >
              <span class="text-accent-500 select-none mr-2"
                >{activeTerminalPrompt}</span
              >{activeTerminalCmd}
            </code>
            <button
              onclick={() => handleCopy(activeTerminalCmd, activeTerminalTab)}
              class="p-2 text-kursal-300 hover:bg-kursal-700 hover:text-kursal-50 rounded-sm transition-colors shrink-0"
              title="Copy command"
            >
              {#if copiedState[activeTerminalTab]}
                <Check size={16} class="text-accent-400" />
              {:else}
                <Copy size={16} />
              {/if}
            </button>
          </div>
        </div>
      </div>
    </div>

    <div class="mb-6 flex flex-col gap-3">
      <h2 class="font-mono text-2xl font-bold text-kursal-50">
        <span class="text-accent-500">$</span> Manual Downloads
      </h2>
      <p class="text-kursal-200">
        Because Kursal is not signed with a paid certificate, you will most
        likely have to bypass your system protections to open Kursal.
      </p>
    </div>

    <div class="grid gap-6 mb-12">
      {#each platforms as platform}
        <div
          class="flex flex-col md:flex-row md:items-center gap-6 p-6 bg-kursal-800 rounded-sm border border-kursal-700 hover:border-accent-500/50 transition-colors"
        >
          <div class="flex items-center gap-6 flex-1">
            <div
              class="w-16 h-16 bg-kursal-700 rounded-sm flex items-center justify-center shrink-0"
            >
              <platform.icon size={32} class="text-accent-400" />
            </div>

            <div>
              <h2 class="font-mono text-lg font-semibold text-kursal-50">
                {platform.name}
              </h2>
              <p class="text-kursal-300 text-sm mt-1">{platform.description}</p>
            </div>
          </div>

          <div class="w-full md:w-auto relative">
            {#if platform.id === "linux"}
              <div class="flex flex-col gap-3 items-stretch md:items-end">
                <div class="relative w-full md:w-auto linux-dropdown-container">
                  <button
                    onclick={(e) => toggleDropdown("linux-x64", e)}
                    class="relative w-full md:w-[220px] inline-flex items-center justify-center gap-2 px-4 py-2 pr-10 bg-kursal-700 hover:bg-kursal-600 border border-kursal-600 rounded-sm font-mono text-sm text-kursal-50 font-medium transition-colors"
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
                      class="absolute right-0 mt-2 w-full md:w-[220px] bg-kursal-800 border border-kursal-600 rounded-sm overflow-hidden z-10"
                    >
                      {#each platform.links.slice(0, 3) as link}
                        <a
                          href={link.url}
                          onclick={(e) =>
                            handleDownloadClick(platform.id, link.id, e)}
                          class="flex w-full items-center justify-center gap-2 px-4 py-3 hover:bg-kursal-700 font-mono text-sm text-kursal-50 transition-colors"
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
                    class="relative w-full md:w-[220px] inline-flex items-center justify-center gap-2 px-4 py-2 pr-10 bg-kursal-700 hover:bg-kursal-600 border border-kursal-600 rounded-sm font-mono text-sm text-kursal-50 font-medium transition-colors"
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
                      class="absolute right-0 mt-2 w-full md:w-[220px] bg-kursal-800 border border-kursal-600 rounded-sm overflow-hidden z-10"
                    >
                      {#each platform.links.slice(3, 6) as link}
                        <a
                          href={link.url}
                          onclick={(e) =>
                            handleDownloadClick(platform.id, link.id, e)}
                          class="flex w-full items-center justify-center gap-2 px-4 py-3 hover:bg-kursal-700 font-mono text-sm text-kursal-50 transition-colors"
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
                    class="inline-flex items-center justify-center gap-2 px-4 py-2 bg-kursal-700 hover:bg-kursal-600 border border-kursal-600 rounded-sm font-mono text-sm text-kursal-50 font-medium transition-colors w-full md:w-[220px]"
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
