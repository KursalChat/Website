<script lang="ts">
  import { Check, Minus, X, Info } from "lucide-svelte";
  import { slide } from "svelte/transition";
  import DocPage from "$lib/components/DocPage.svelte";
  import Footprint from "$lib/components/Footprint.svelte";
  import { SITE_URL, SITE_OG } from "$lib/const";

  const pageUrl = `${SITE_URL}/compare`;

  type Mark = true | false | "partial";
  type Feature = { key: FeatureKey; label: string; note?: string };

  const core = [
    {
      key: "e2ee",
      label: "End-to-end encrypted",
      note: "WhatsApp uses Signal's protocol but is closed-source, so you trust Meta. Discord chats aren't end-to-end encrypted.",
    },
    { key: "openSource", label: "Open source" },
    {
      key: "noServers",
      label: "No central servers",
      note: "Matrix runs across many independently operated servers, but most people use one main homeserver.",
    },
    {
      key: "noAccount",
      label: "No phone or email needed",
      note: "Kursal uses rotating peer IDs: no phone, email, or account to sign up with.",
    },
    {
      key: "noMetadata",
      label: "No metadata harvested",
      note: "Kursal has no accounts, so there is nothing to tie metadata to, but relays still see IP addresses and rotating peer IDs. Signal minimizes metadata, but its central servers still exist; Matrix homeservers can see it.",
    },
    { key: "independent", label: "Not owned by Big Tech" },
  ] as const;

  const more = [
    { key: "selfHost", label: "Run your own relay" },
    {
      key: "postQuantum",
      label: "Post-quantum encryption",
      note: "Kursal and Signal use a post-quantum key exchange (PQXDH).",
    },
    {
      key: "offline",
      label: "Works while you're offline",
      note: "Kursal's offline message system has been implemented recently and needs testing.",
    },
    {
      key: "groupChats",
      label: "Group chats",
      note: "Planned! Group conversations are on the Kursal roadmap.",
    },
    {
      key: "calls",
      label: "Voice & video calls",
      note: "Only audio calls are supported. Video and screenshares are planned.",
    },
  ] as const;

  type FeatureKey = (typeof core)[number]["key"] | (typeof more)[number]["key"];
  type App = { name: string; highlight?: boolean } & Record<FeatureKey, Mark>;

  const apps: App[] = [
    {
      name: "Kursal",
      highlight: true,
      e2ee: true,
      openSource: true,
      noServers: true,
      noAccount: true,
      noMetadata: "partial",
      independent: true,
      selfHost: true,
      postQuantum: true,
      offline: "partial",
      groupChats: false,
      calls: "partial",
    },
    {
      name: "Signal",
      e2ee: true,
      openSource: true,
      noServers: false,
      noAccount: false,
      noMetadata: "partial",
      independent: true,
      selfHost: false,
      postQuantum: true,
      offline: true,
      groupChats: true,
      calls: true,
    },
    {
      name: "WhatsApp",
      e2ee: true,
      openSource: false,
      noServers: false,
      noAccount: false,
      noMetadata: false,
      independent: false,
      selfHost: false,
      postQuantum: false,
      offline: true,
      groupChats: true,
      calls: true,
    },
    {
      name: "Discord",
      e2ee: false,
      openSource: false,
      noServers: false,
      noAccount: false,
      noMetadata: false,
      independent: false,
      selfHost: false,
      postQuantum: false,
      offline: true,
      groupChats: true,
      calls: true,
    },
    {
      name: "Matrix",
      e2ee: true,
      openSource: true,
      noServers: true,
      noAccount: "partial",
      noMetadata: "partial",
      independent: true,
      selfHost: true,
      postQuantum: false,
      offline: true,
      groupChats: true,
      calls: true,
    },
    {
      name: "SMS",
      e2ee: false,
      openSource: false,
      noServers: false,
      noAccount: false,
      noMetadata: false,
      independent: false,
      selfHost: false,
      postQuantum: false,
      offline: true,
      groupChats: "partial",
      calls: "partial",
    },
  ];

  let activeNote = $state<FeatureKey | null>(null);

  function toggleNote(key: FeatureKey) {
    activeNote = activeNote === key ? null : key;
  }
</script>

<svelte:head>
  <title>Compare | Kursal</title>
  <meta
    name="description"
    content="How Kursal compares to Signal, WhatsApp, Discord and Matrix on encryption, decentralization and privacy."
  />
  <link rel="canonical" href={pageUrl} />

  <meta property="og:title" content="Compare | Kursal" />
  <meta
    property="og:description"
    content="How Kursal compares to Signal, WhatsApp, Discord and Matrix on encryption, decentralization and privacy."
  />
  <meta property="og:url" content={pageUrl} />
  <meta property="og:image" content={SITE_OG} />

  <meta name="twitter:card" content="summary_large_image" />
  <meta name="twitter:title" content="Compare | Kursal" />
  <meta
    name="twitter:description"
    content="How Kursal compares to Signal, WhatsApp, Discord and Matrix on encryption, decentralization and privacy."
  />
  <meta name="twitter:image" content={SITE_OG} />
</svelte:head>

{#snippet mark(v: Mark, strong: boolean)}
  {#if v === true}
    <Check
      size={18}
      class={strong ? "text-accent-400" : "text-accent-400/80"}
    />
    <span class="sr-only">yes</span>
  {:else if v === "partial"}
    <Minus size={18} class="text-kursal-400" />
    <span class="sr-only">partial</span>
  {:else}
    <X size={18} class="text-kursal-600" />
    <span class="sr-only">no</span>
  {/if}
{/snippet}

{#snippet row(feature: Feature, isLast: boolean)}
  <tr>
    <td
      class="sticky left-0 z-10 border-b border-kursal-700/70 bg-kursal-850 py-3 pr-3 text-left text-kursal-200"
    >
      {#if feature.note}
        <button
          type="button"
          onclick={() => toggleNote(feature.key)}
          aria-expanded={activeNote === feature.key}
          class="inline-flex items-center gap-1.5 text-left transition-colors hover:text-accent-400 {activeNote ===
          feature.key
            ? 'text-accent-400'
            : ''}"
        >
          <span
            class="underline decoration-dotted underline-offset-4 {activeNote ===
            feature.key
              ? 'decoration-accent-400/60'
              : 'decoration-kursal-600'}">{feature.label}</span
          >
          <Info
            size={13}
            class="shrink-0 {activeNote === feature.key
              ? 'text-accent-400'
              : 'text-kursal-500'}"
          />
        </button>
      {:else}
        <span class="inline-flex items-center gap-1.5">{feature.label}</span>
      {/if}
    </td>
    {#each apps as app}
      <td
        class="border-b border-kursal-700/70 px-2 py-3 {app.highlight
          ? `border-x border-x-accent-500/40 bg-accent-500/[0.08] ${isLast ? 'rounded-b-md border-b-accent-500/40' : ''}`
          : ''}"
      >
        <span class="inline-flex justify-center">
          {@render mark(app[feature.key], !!app.highlight)}
        </span>
      </td>
    {/each}
  </tr>

  {#if feature.note && activeNote === feature.key}
    <tr>
      <td colspan={apps.length + 1} class="border-b border-kursal-700/70 p-0">
        <div
          transition:slide={{ duration: 140 }}
          class="flex items-start gap-2 bg-kursal-800/40 px-3 py-2.5 text-left font-mono text-xs text-kursal-400"
        >
          <span class="text-accent-500/80 select-none">↳</span>
          <span>{feature.note}</span>
        </div>
      </td>
    </tr>
  {/if}
{/snippet}

<DocPage
  file="compare.md"
  title="How Kursal compares"
  subtitle="Same goal as the best private messengers. Without the servers, accounts, or trust in a company."
>
  <div class="overflow-x-auto">
    <table
      class="w-full min-w-[640px] border-separate border-spacing-0 text-center font-mono text-sm"
    >
      <thead>
        <tr>
          <th class="sticky left-0 z-20 w-[34%] bg-kursal-850"></th>
          {#each apps as app}
            <th
              class="border-b border-kursal-700 px-2 py-3 font-semibold {app.highlight
                ? 'rounded-t-md border-x border-t border-x-accent-500/40 border-t-accent-500/40 bg-accent-500/[0.08] text-accent-400'
                : 'text-kursal-300'}"
            >
              {app.name}
            </th>
          {/each}
        </tr>
      </thead>
      <tbody>
        {#each core as feature}
          {@render row(feature, false)}
        {/each}

        <tr>
          <td
            class="sticky left-0 z-10 bg-kursal-850 pt-8 pr-3 pb-3 text-left align-middle"
          >
            <span
              class="font-mono text-xs tracking-widest text-kursal-500 uppercase"
            >
              also worth knowing
            </span>
          </td>
          <td
            class="border-x border-x-accent-500/40 bg-accent-500/[0.08] pt-8 pb-3"
          ></td>
          <td colspan={apps.length - 1} class="pt-8 pb-3 align-middle">
            <div class="h-px bg-kursal-700"></div>
          </td>
        </tr>

        {#each more as feature, i}
          {@render row(feature, i === more.length - 1)}
        {/each}
      </tbody>
    </table>
  </div>

  <div
    class="mt-6 flex items-center justify-center gap-5 font-mono text-xs text-kursal-400"
  >
    <span class="flex items-center gap-1.5"
      >{@render mark(true, false)} yes</span
    >
    <span class="flex items-center gap-1.5"
      >{@render mark("partial", false)} partial</span
    >
    <span class="flex items-center gap-1.5"
      >{@render mark(false, false)} no</span
    >
  </div>

  <Footprint />
</DocPage>
