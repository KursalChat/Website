<script lang="ts">
  import {
    Rocket,
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
  import { RELEASE_STATUS, SITE_OG, SITE_URL } from "$lib/const";
  import { platforms, type OSId } from "$lib/download";

  let openDropdown = $state<string | null>(null);
  let downloadCount = $state<string | null>(null);
  let latestVersion = $state<string | null>(null);
  let copiedState = $state<Record<string, boolean>>({});

  const terminalTabs = [
    { id: "mac-linux", label: "Mac / Linux" },
    { id: "windows", label: "Windows" },
    { id: "homebrew", label: "Homebrew" },
  ] as const;
  type TerminalTabId = (typeof terminalTabs)[number]["id"];

  let activeTerminalTab = $state<TerminalTabId>("mac-linux");

  let activeTerminalCmds = $derived(
    activeTerminalTab === "mac-linux"
      ? ["curl -fsSL https://kursal.chat | bash"]
      : activeTerminalTab === "homebrew"
        ? ["brew trust KursalChat/tap", "brew install KursalChat/tap/kursal"]
        : ['powershell -c "irm kursal.chat | iex"'],
  );
  let activeTerminalPrompt = $derived(
    activeTerminalTab === "windows" ? ">" : "$",
  );

  let detectedOS = $state<OSId | null>(null);

  let sortedPlatforms = $derived(
    detectedOS
      ? [...platforms].sort((a, b) =>
          a.id === detectedOS ? -1 : b.id === detectedOS ? 1 : 0,
        )
      : platforms,
  );

  $effect(() => {
    const ua = window.navigator.userAgent.toLowerCase();
    // TODO: enable back when IOS available
    // if (/iphone|ipad|ipod/.test(ua)) detectedOS = "ios";
    if (ua.includes("android")) detectedOS = "android";
    else if (ua.includes("win")) detectedOS = "windows";
    else if (ua.includes("mac")) detectedOS = "mac";
    else if (ua.includes("linux")) detectedOS = "linux";

    activeTerminalTab = detectedOS === "windows" ? "windows" : "mac-linux";

    fetchRepo();
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

  function handleKeydown(event: KeyboardEvent) {
    if (event.key === "Escape" && openDropdown) {
      const trigger = document.getElementById(`${openDropdown}-trigger`);
      openDropdown = null;
      trigger?.focus();
    }
  }

  function handleTabKeydown(event: KeyboardEvent, index: number) {
    if (event.key !== "ArrowRight" && event.key !== "ArrowLeft") return;
    event.preventDefault();

    const offset = event.key === "ArrowRight" ? 1 : -1;
    const next = (index + offset + terminalTabs.length) % terminalTabs.length;

    activeTerminalTab = terminalTabs[next].id;
    document.getElementById(`tab-${terminalTabs[next].id}`)?.focus();
  }

  function handleDownloadClick(
    platformId: OSId,
    linkId: string,
    event: MouseEvent,
  ) {
    if (
      event.button !== 0 ||
      event.metaKey ||
      event.ctrlKey ||
      event.shiftKey ||
      event.altKey
    ) {
      return;
    }

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

  async function fetchRepo() {
    const res = await fetch(
      "https://api.github.com/repos/KursalChat/Kursal/releases",
    );

    if (!res.ok) return;
    const release = (await res.json()) as {
      assets: { name: string; download_count: number }[];
      prerelease: boolean;
      draft: boolean;
      name: string;
    }[];

    // find latest tag
    latestVersion =
      release.find((r) => r.prerelease == false && r.draft == false)?.name ||
      null;

    // count downloads
    let tempDownloads = 0;
    for (let r of release) {
      for (let asset of r.assets) {
        if (asset.name.toLowerCase().startsWith("kursal")) {
          tempDownloads += asset.download_count;
        }
      }
    }

    downloadCount =
      tempDownloads >= 1000
        ? (tempDownloads / 1000).toFixed(1).replace(/\.0$/, "") + "k"
        : String(tempDownloads);
  }
</script>

<svelte:window onclick={handleOutsideClick} onkeydown={handleKeydown} />

<svelte:head>
  <title>Download Kursal | Private Messaging App</title>
  <meta
    name="description"
    content="Download the Kursal beta for macOS, Windows, Linux and Android. Free, open source, and end-to-end encrypted."
  />
  <link rel="canonical" href={pageUrl} />

  <meta property="og:title" content="Download Kursal | Private Messaging App" />
  <meta
    property="og:description"
    content="Download the Kursal beta for macOS, Windows, Linux and Android. Free, open source, and end-to-end encrypted."
  />
  <meta property="og:url" content={pageUrl} />
  <meta property="og:image" content={SITE_OG} />

  <meta name="twitter:card" content="summary_large_image" />
  <meta
    name="twitter:title"
    content="Download Kursal | Private Messaging App"
  />
  <meta
    name="twitter:description"
    content="Download the Kursal beta for macOS, Windows, Linux and Android. Free, open source, and end-to-end encrypted."
  />
  <meta name="twitter:image" content={SITE_OG} />
</svelte:head>

{#snippet archDropdown(
  id: string,
  archLabel: string,
  links: { id: string; label: string; url: string }[],
)}
  <div class="linux-dropdown-container relative w-full md:w-auto">
    <button
      id="{id}-trigger"
      aria-haspopup="true"
      aria-expanded={openDropdown === id}
      aria-controls="{id}-menu"
      onclick={(e) => toggleDropdown(id, e)}
      class="relative inline-flex w-full items-center justify-center gap-2 rounded-sm border border-kursal-600 bg-kursal-700 px-4 py-2 pr-10 font-mono text-sm font-medium text-kursal-50 transition-colors hover:bg-kursal-600 md:w-[220px]"
    >
      <Download size={14} class="text-opacity-80 shrink-0 text-accent-400" />
      <span>{archLabel}</span>
      <ChevronDown
        size={14}
        class="text-kursal-400 transition-transform {openDropdown === id
          ? 'rotate-180'
          : ''} absolute right-4"
      />
    </button>
    {#if openDropdown === id}
      <div
        id="{id}-menu"
        aria-labelledby="{id}-trigger"
        class="absolute right-0 z-10 mt-2 w-full overflow-hidden rounded-sm border border-kursal-600 bg-kursal-800 md:w-[220px]"
      >
        {#each links as link (link.id)}
          <a
            href={link.url}
            aria-label="Download Linux {archLabel} {link.label}"
            onclick={(e) => handleDownloadClick("linux", link.id, e)}
            class="flex w-full items-center justify-center gap-2 px-4 py-3 font-mono text-sm text-kursal-50 transition-colors hover:bg-kursal-700"
          >
            <Download
              size={14}
              class="text-opacity-80 shrink-0 text-accent-400"
            />
            {link.label}
          </a>
        {/each}
      </div>
    {/if}
  </div>
{/snippet}

<Navbar />

<main class="min-h-screen bg-kursal-900 pt-24 pb-16">
  <div class="mx-auto max-w-4xl px-6">
    <div class="mb-12 text-center">
      <div
        class="mb-6 inline-flex items-center gap-2 font-mono text-sm text-kursal-300"
      >
        <Rocket size={15} class="text-accent-400" />
        {RELEASE_STATUS}
      </div>

      <h1 class="mb-4 font-mono text-4xl font-bold text-kursal-50 md:text-5xl">
        Download Kursal
      </h1>

      {#if latestVersion || downloadCount}
        <div
          class="mb-6 flex flex-wrap items-center justify-center gap-x-3 gap-y-2 font-mono tracking-wide"
        >
          {#if latestVersion}
            <span
              class="inline-flex items-center rounded-sm border border-accent-500/30 px-2 py-1 text-xs font-bold whitespace-nowrap text-accent-400"
              >{latestVersion}</span
            >
          {/if}
          {#if latestVersion && downloadCount}
            <span class="text-kursal-500 select-none">/</span>
          {/if}
          {#if downloadCount}
            <span
              class="inline-flex items-baseline gap-1.5 text-sm whitespace-nowrap text-kursal-300"
            >
              <Download
                size={14}
                class="translate-y-0.5 self-center text-accent-400"
              />
              <span class="text-base font-bold text-kursal-50"
                >{downloadCount}</span
              >
              downloads
            </span>
          {/if}
        </div>
      {/if}

      <p class="mx-auto max-w-xl text-lg leading-relaxed text-kursal-200">
        Kursal is currently in <strong class="text-kursal-50"
          >public beta</strong
        >. Expect bugs, missing features, and some instability! Download below
        or sign up to hear about the stable release.
      </p>
    </div>

    <div
      class="mb-6 flex items-start gap-3 rounded-sm border-l-2 border-party-500 bg-party-500/[0.08] p-4 md:items-center"
    >
      <TriangleAlert class="mt-0.5 shrink-0 text-party-400 md:mt-0" size={20} />
      <p class="text-sm leading-relaxed text-kursal-200">
        <strong class="font-mono text-party-400">Beta Release:</strong> This
        release is still experimental. You may encounter bugs, missing features,
        and potential data loss. Please report any issues on the
        <a
          href="https://github.com/KursalChat/Kursal/issues"
          target="_blank"
          rel="noopener noreferrer"
          class="inline-flex items-center gap-1 font-medium underline underline-offset-2 transition-colors hover:text-kursal-50"
          >GitHub <ExternalLink size={12} class="opacity-80" /></a
        >.
      </p>
    </div>

    <div class="mb-12">
      <h2 class="mb-4 font-mono text-2xl font-bold text-kursal-50">
        <span class="text-accent-500">$</span> Install via Terminal
        <span class="text-base font-normal text-kursal-400">(Recommended)</span>
      </h2>

      <div
        class="overflow-hidden rounded-sm border border-kursal-700 bg-kursal-800"
      >
        <div
          role="tablist"
          aria-label="Install method"
          class="flex border-b border-kursal-700 bg-kursal-950 font-mono"
        >
          {#each terminalTabs as tab, index (tab.id)}
            <button
              id="tab-{tab.id}"
              role="tab"
              aria-selected={activeTerminalTab === tab.id}
              aria-controls="tabpanel-{tab.id}"
              tabindex={activeTerminalTab === tab.id ? 0 : -1}
              onclick={() => (activeTerminalTab = tab.id)}
              onkeydown={(e) => handleTabKeydown(e, index)}
              class="relative px-6 py-3.5 text-sm font-medium transition-all {activeTerminalTab ===
              tab.id
                ? 'bg-kursal-800 text-kursal-50'
                : 'text-kursal-400 hover:bg-kursal-800/50 hover:text-kursal-200'}"
            >
              {tab.label}
              {#if activeTerminalTab === tab.id}
                <div
                  class="absolute right-0 bottom-0 left-0 h-0.5 bg-accent-500"
                ></div>
              {/if}
            </button>
          {/each}
        </div>

        <div
          id="tabpanel-{activeTerminalTab}"
          role="tabpanel"
          aria-labelledby="tab-{activeTerminalTab}"
          tabindex="0"
          class="p-5"
        >
          <div
            class="flex items-center gap-3 rounded-sm border border-kursal-700 bg-kursal-950 p-3"
          >
            <code
              class="flex-1 overflow-x-auto font-mono text-sm whitespace-nowrap text-kursal-50"
            >
              {#each activeTerminalCmds as cmd}
                <div>
                  <span class="mr-2 text-accent-500 select-none"
                    >{activeTerminalPrompt}</span
                  >{cmd}
                </div>
              {/each}
            </code>
            <button
              onclick={() =>
                handleCopy(activeTerminalCmds.join("\n"), activeTerminalTab)}
              class="shrink-0 rounded-sm p-2 text-kursal-300 transition-colors hover:bg-kursal-700 hover:text-kursal-50"
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

    <div class="mb-12 grid gap-6">
      {#each sortedPlatforms as platform (platform.id)}
        {@const detected = platform.id === detectedOS}
        <div
          class="flex flex-col gap-6 rounded-sm border bg-kursal-800 p-6 transition-colors md:flex-row md:items-center {detected
            ? 'border-accent-500/60'
            : 'border-kursal-700 hover:border-accent-500/50'}"
        >
          <div class="flex flex-1 items-center gap-6">
            <div
              class="flex h-16 w-16 shrink-0 items-center justify-center rounded-sm bg-kursal-700"
            >
              <platform.icon size={32} class="text-accent-400" />
            </div>

            <div>
              <h2
                class="flex items-center gap-2.5 font-mono text-lg font-semibold text-kursal-50"
              >
                {platform.name}
                {#if detected}
                  <span
                    class="rounded-sm border border-accent-500/40 px-1.5 py-0.5 font-mono text-[0.65rem] font-medium tracking-wide text-accent-400"
                    >detected</span
                  >
                {/if}
              </h2>
              <p class="mt-1 text-sm text-kursal-300">{platform.description}</p>
            </div>
          </div>

          <div class="relative w-full md:w-auto">
            {#if platform.id === "linux"}
              <div class="flex flex-col items-stretch gap-3 md:items-end">
                {@render archDropdown(
                  "linux-x64",
                  "x64 / AMD64",
                  platform.links.slice(0, 3),
                )}
                {@render archDropdown(
                  "linux-arm64",
                  "arm64",
                  platform.links.slice(3, 6),
                )}
              </div>
            {:else}
              <div class="flex flex-col items-stretch gap-3 md:items-end">
                {#each platform.links as link}
                  <a
                    href={link.url}
                    onclick={(e) =>
                      handleDownloadClick(platform.id, link.id, e)}
                    class="inline-flex w-full items-center justify-center gap-2 rounded-sm border border-kursal-600 bg-kursal-700 px-4 py-2 font-mono text-sm font-medium text-kursal-50 transition-colors hover:bg-kursal-600 md:w-[220px]"
                  >
                    <Download
                      size={14}
                      class="text-opacity-80 text-accent-400"
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

    <div
      class="rounded-sm border border-accent-500/30 bg-kursal-800 p-7 text-center"
    >
      <h3 class="mb-2 font-mono text-lg font-semibold text-kursal-50">
        Prefer to wait for stable?
      </h3>
      <p class="mb-6 text-kursal-300">
        Get one email when the first stable release ships. Nothing else.
      </p>
      <a
        href="/#notify"
        class="inline-flex items-center gap-2 rounded-sm bg-accent-500 px-6 py-3 font-mono font-semibold text-kursal-950 transition-colors hover:bg-accent-400"
      >
        <Bell size={18} />
        Sign up for updates
      </a>
    </div>
  </div>
</main>

<Footer />
