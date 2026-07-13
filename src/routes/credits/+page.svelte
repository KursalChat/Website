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
      class="mt-2 border border-kursal-700 rounded-sm bg-kursal-900/60 overflow-hidden font-mono text-sm"
    >
      <div
        class="flex items-center gap-2 px-4 py-2.5 border-b border-kursal-700 bg-kursal-800/60 text-kursal-400"
      >
        <span class="text-accent-500 shrink-0">$</span>
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
                  class="flex items-baseline justify-between gap-3 flex-wrap"
                >
                  <span
                    class="font-semibold text-kursal-50 flex items-baseline gap-2.5 min-w-0"
                  >
                    <span class="text-accent-500 shrink-0">▸</span>
                    {#if r.url}
                      <a
                        href={r.url}
                        target="_blank"
                        rel="noopener noreferrer"
                        class="text-accent-400 hover:text-accent-300 truncate"
                        >{r.name}</a
                      >
                    {:else}
                      <span class="truncate">{r.name}</span>
                    {/if}
                  </span>
                  {#if r.date}
                    <span class="text-xs text-kursal-500 shrink-0"
                      >{r.date}</span
                    >
                  {/if}
                </div>
                {#if r.finding}
                  <p
                    class="text-kursal-300 leading-relaxed mt-1.5 pl-[1.375rem]"
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
    <ul class="font-mono text-sm space-y-2 mt-1 text-kursal-300">
      <li class="flex gap-2.5">
        <span class="text-accent-500 shrink-0">▸</span>
        <span>Disclose privately and give us 90 days before going public.</span>
      </li>
      <li class="flex gap-2.5">
        <span class="text-accent-500 shrink-0">▸</span>
        <span
          >Include clear steps so we can reproduce and verify the issue.</span
        >
      </li>
      <li class="flex gap-2.5">
        <span class="text-accent-500 shrink-0">▸</span>
        <span>Tell us how you'd like to be credited (or stay anonymous).</span>
      </li>
    </ul>

    <div class="flex flex-wrap gap-3 mt-5">
      <a
        href="/vulnerability"
        target="_blank"
        rel="noopener noreferrer"
        class="inline-flex items-center gap-2 font-mono text-sm bg-party-500/10 hover:bg-party-500/20 text-party-400 border border-party-500/40 px-4 py-2 rounded-sm transition-colors"
      >
        <Bug size={16} />
        Submit Vulnerability Report
      </a>
      <a
        href="/security"
        class="inline-flex items-center gap-2 font-mono text-sm border border-kursal-600 hover:border-accent-500 bg-kursal-800 hover:bg-kursal-700 text-kursal-100 px-4 py-2 rounded-sm transition-colors"
      >
        <ShieldCheck size={16} />
        Read our Security policy
      </a>
    </div>
  </DocSection>

  <p
    class="mt-9 pt-6 border-t border-kursal-700 font-mono text-sm text-kursal-400"
  >
    <span class="text-kursal-500">#&nbsp;</span>We try keeping Kursal as secure
    as possible. If you find a vulnerability, please reach out!
  </p>
</DocPage>
