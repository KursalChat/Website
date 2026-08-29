<script lang="ts">
  import { Bug, ShieldCheck } from "lucide-svelte";
  import DocPage from "$lib/components/DocPage.svelte";
  import DocSection from "$lib/components/DocSection.svelte";
  import CreditsBox from "$lib/components/CreditsBox.svelte";
  import CreditRow from "$lib/components/CreditRow.svelte";
  import { SITE_URL, SITE_OG, OPEN_COLLECTIVE_URL } from "$lib/const";
  import {
    contributorOverrides,
    researchers,
    supporters,
    translators,
    type CreditEntry,
    type TranslatorEntry,
  } from "$lib/credits";

  const pageUrl = `${SITE_URL}/credits`;
  const description =
    "A thank-you to everyone who helped build Kursal: code contributors, security researchers, financial supporters, and translators.";

  let contributors = $state<CreditEntry[]>(contributorOverrides);

  const translatorsByLanguage = translators.reduce<
    Record<string, TranslatorEntry[]>
  >((acc, t) => {
    (acc[t.language] ??= []).push(t);
    return acc;
  }, {});

  function contributionLabel(count?: number) {
    if (!count) return undefined;
    return `${count} contribution${count === 1 ? "" : "s"}`;
  }

  async function fetchContributors() {
    const res = await fetch(
      "https://api.github.com/repos/KursalChat/Kursal/contributors?per_page=100",
    );
    if (!res.ok) return;

    const users = (
      (await res.json()) as {
        login: string;
        contributions: number;
        type: string;
      }[]
    )
      .filter((u) => u.type === "User")
      .sort((a, b) => b.contributions - a.contributions);

    const countByLogin = new Map(
      users.map((u) => [u.login.toLowerCase(), u.contributions]),
    );
    const overridden = new Set(
      contributorOverrides.map((c) => c.github?.toLowerCase()),
    );

    contributors = [
      ...contributorOverrides.map((c) => ({
        ...c,
        meta:
          c.meta ??
          contributionLabel(
            c.github ? countByLogin.get(c.github.toLowerCase()) : undefined,
          ),
      })),
      ...users
        .filter((u) => !overridden.has(u.login.toLowerCase()))
        .map((u) => ({
          name: u.login,
          github: u.login,
          meta: contributionLabel(u.contributions),
        })),
    ];
  }

  $effect(() => {
    fetchContributors();
  });
</script>

<svelte:head>
  <title>Acknowledgments | Kursal</title>
  <meta name="description" content={description} />
  <link rel="canonical" href={pageUrl} />

  <meta property="og:title" content="Acknowledgments | Kursal" />
  <meta property="og:description" content={description} />
  <meta property="og:url" content={pageUrl} />
  <meta property="og:image" content={SITE_OG} />

  <meta name="twitter:card" content="summary_large_image" />
  <meta name="twitter:title" content="Acknowledgments | Kursal" />
  <meta name="twitter:description" content={description} />
  <meta name="twitter:image" content={SITE_OG} />
</svelte:head>

<DocPage
  file="credits"
  title="Acknowledgments"
  stamp="With Thanks"
  subtitle="The people who built, secured, supported, and translated Kursal. Credited here with thanks."
>
  <DocSection n="01" title="Code Contributors">
    <p>Features & fixes. Thank you for making Kursal better.</p>

    <CreditsBox
      path="contributors"
      count={contributors.length}
      empty="0 contributors. Be the first!"
    >
      <ul class="space-y-3.5">
        {#each contributors as c}
          <CreditRow entry={c} />
        {/each}
      </ul>
    </CreditsBox>
  </DocSection>

  <DocSection n="02" title="Credited Researchers">
    <p>
      Every one of these reports came in privately, with time to ship a fix
      before going public. We're grateful for that.
    </p>

    <CreditsBox
      path="researchers"
      count={researchers.length}
      empty="0 reports. The list is empty"
    >
      <ul class="space-y-3.5">
        {#each researchers as r}
          <CreditRow entry={r} />
        {/each}
      </ul>
    </CreditsBox>
  </DocSection>

  <DocSection n="03" title="How to Get Listed">
    <p>
      If you've found a security issue that could impact user privacy or safety,
      report it to us privately. With your consent, we'll add your name once a
      fix has shipped.
    </p>
    <ul class="mt-1 space-y-2 font-mono text-sm text-kursal-300">
      <li class="flex gap-2.5">
        <span class="shrink-0 text-accent-500">▸</span>
        <span>Disclose privately and give us 90 days before going public.</span>
      </li>
      <li class="flex gap-2.5">
        <span class="shrink-0 text-accent-500">▸</span>
        <span
          >Include clear steps so we can reproduce and verify the issue.</span
        >
      </li>
      <li class="flex gap-2.5">
        <span class="shrink-0 text-accent-500">▸</span>
        <span>Tell us how you'd like to be credited (or stay anonymous).</span>
      </li>
    </ul>

    <div class="mt-5 flex flex-wrap gap-3">
      <a
        href="/vulnerability"
        target="_blank"
        rel="noopener noreferrer"
        class="inline-flex items-center gap-2 rounded-sm border border-party-500/40 bg-party-500/10 px-4 py-2 font-mono text-sm text-party-400 transition-colors hover:bg-party-500/20"
      >
        <Bug size={16} />
        Submit Vulnerability Report
      </a>
      <a
        href="/security"
        class="inline-flex items-center gap-2 rounded-sm border border-kursal-600 bg-kursal-800 px-4 py-2 font-mono text-sm text-kursal-100 transition-colors hover:border-accent-500 hover:bg-kursal-700"
      >
        <ShieldCheck size={16} />
        Read our Security policy
      </a>
    </div>
  </DocSection>

  <DocSection n="04" title="Financial Supporters">
    <p>
      Kursal runs on their backing. Join them on our
      <a
        href={OPEN_COLLECTIVE_URL}
        target="_blank"
        rel="noopener noreferrer"
        class="text-accent-400 hover:text-accent-300">OpenCollective page</a
      >.
    </p>

    <CreditsBox
      path="supporters"
      count={supporters.length}
      empty="0 supporters. The list is empty"
    >
      <ul class="space-y-3.5">
        {#each supporters as s}
          <CreditRow entry={s} />
        {/each}
      </ul>
    </CreditsBox>
  </DocSection>

  <DocSection n="05" title="Translators">
    <p>Kursal speaks these languages because volunteers translated it.</p>

    <CreditsBox
      path="translators"
      count={translators.length}
      empty="0 translators. Be the first!"
    >
      <div class="space-y-4">
        {#each Object.entries(translatorsByLanguage) as [language, people]}
          <div>
            <p
              class="mb-2 font-mono text-sm font-semibold tracking-wide text-kursal-300 uppercase"
            >
              {language}
            </p>
            <ul class="space-y-2">
              {#each people as t}
                <CreditRow entry={t} />
              {/each}
            </ul>
          </div>
        {/each}
      </div>
    </CreditsBox>
  </DocSection>

  <p
    class="mt-9 border-t border-kursal-700 pt-6 font-mono text-sm text-kursal-400"
  >
    <span class="text-kursal-500">#&nbsp;</span>We try keeping Kursal as secure
    as possible. If you find a vulnerability, please reach out!
  </p>
</DocPage>
