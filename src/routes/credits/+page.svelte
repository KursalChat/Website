<script lang="ts">
  import { Bug, ShieldCheck } from "lucide-svelte";
  import DocPage from "$lib/components/DocPage.svelte";
  import DocSection from "$lib/components/DocSection.svelte";
  import { SITE_URL, SITE_OG } from "$lib/const";

  const pageUrl = `${SITE_URL}/credits`;

  type Researcher = {
    name: string;
    url?: string;
    date?: string;
    finding?: string;
  };

  const researchers: Researcher[] = [];
</script>

<svelte:head>
  <title>Security Acknowledgments | Kursal</title>
  <meta
    name="description"
    content="A thank-you to the security researchers who responsibly disclosed vulnerabilities and helped keep Kursal safe."
  />
  <link rel="canonical" href={pageUrl} />

  <meta property="og:title" content="Security Acknowledgments | Kursal" />
  <meta
    property="og:description"
    content="A thank-you to the security researchers who responsibly disclosed vulnerabilities and helped keep Kursal safe."
  />
  <meta property="og:url" content={pageUrl} />
  <meta property="og:image" content={SITE_OG} />

  <meta name="twitter:card" content="summary_large_image" />
  <meta name="twitter:title" content="Security Acknowledgments | Kursal" />
  <meta
    name="twitter:description"
    content="A thank-you to the security researchers who responsibly disclosed vulnerabilities and helped keep Kursal safe."
  />
  <meta name="twitter:image" content={SITE_OG} />
</svelte:head>

<DocPage
  file="credits"
  title="Acknowledgments"
  stamp="With Thanks"
  subtitle="The people who found security flaws in Kursal and reported them to us privately, so we could fix them before anyone could exploit them."
>
  <DocSection n="01" title="Credited Researchers">
    <p>
      Everyone listed here reported a vulnerability privately and gave us time
      to ship a fix before disclosing it. We're grateful for their work.
    </p>

    <div
      class="mt-2 overflow-hidden rounded-sm border border-kursal-700 bg-kursal-900/60 font-mono text-sm"
    >
      <div
        class="flex items-center gap-2 border-b border-kursal-700 bg-kursal-800/60 px-4 py-2.5 text-kursal-400"
      >
        <span class="shrink-0 text-accent-500">$</span>
        <span class="truncate">ls ~/credits</span>
      </div>

      <div class="p-4">
        {#if researchers.length === 0}
          <p class="text-kursal-500">0 reports. The list is empty</p>
        {:else}
          <ul class="space-y-3.5">
            {#each researchers as r}
              <li>
                <div
                  class="flex flex-wrap items-baseline justify-between gap-3"
                >
                  <span
                    class="flex min-w-0 items-baseline gap-2.5 font-semibold text-kursal-50"
                  >
                    <span class="shrink-0 text-accent-500">▸</span>
                    {#if r.url}
                      <a
                        href={r.url}
                        target="_blank"
                        rel="noopener noreferrer"
                        class="truncate text-accent-400 hover:text-accent-300"
                        >{r.name}</a
                      >
                    {:else}
                      <span class="truncate">{r.name}</span>
                    {/if}
                  </span>
                  {#if r.date}
                    <span class="shrink-0 text-xs text-kursal-500"
                      >{r.date}</span
                    >
                  {/if}
                </div>
                {#if r.finding}
                  <p
                    class="mt-1.5 pl-[1.375rem] leading-relaxed text-kursal-300"
                  >
                    {r.finding}
                  </p>
                {/if}
              </li>
            {/each}
          </ul>
        {/if}
      </div>
    </div>
  </DocSection>

  <DocSection n="02" title="How to Get Listed">
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

  <p
    class="mt-9 border-t border-kursal-700 pt-6 font-mono text-sm text-kursal-400"
  >
    <span class="text-kursal-500">#&nbsp;</span>We try keeping Kursal as secure
    as possible. If you find a vulnerability, please reach out!
  </p>
</DocPage>
