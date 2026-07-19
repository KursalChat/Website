<script lang="ts">
  import { Key, Bug, RefreshCw, ExternalLink } from "lucide-svelte";
  import { SiGithub } from "@icons-pack/svelte-simple-icons";
  import DocPage from "$lib/components/DocPage.svelte";
  import DocSection from "$lib/components/DocSection.svelte";
  import { repository, PAPER_URL, SITE_URL, SITE_OG } from "$lib/const";

  const pageUrl = `${SITE_URL}/security`;
</script>

<svelte:head>
  <title>Security | Kursal</title>
  <meta
    name="description"
    content="See the cryptographic protocols and security practices that power private messaging on Kursal."
  />
  <link rel="canonical" href={pageUrl} />

  <meta property="og:title" content="Security | Kursal" />
  <meta
    property="og:description"
    content="See the cryptographic protocols and security practices that power private messaging on Kursal."
  />
  <meta property="og:url" content={pageUrl} />
  <meta property="og:image" content={SITE_OG} />

  <meta name="twitter:card" content="summary_large_image" />
  <meta name="twitter:title" content="Security | Kursal" />
  <meta
    name="twitter:description"
    content="See the cryptographic protocols and security practices that power private messaging on Kursal."
  />
  <meta name="twitter:image" content={SITE_OG} />
</svelte:head>

<DocPage
  file="security.md"
  title="Security"
  stamp="Open-Source"
  subtitle="Our mission is to protect your privacy through proven cryptographic protocols and transparent security practices."
>
  <DocSection n="01" title="Cryptographic Protocols">
    <div class="mt-1 grid gap-6 md:grid-cols-2">
      <div class="rounded-sm border border-kursal-700 bg-kursal-800/40 p-5">
        <h3
          class="mb-2 flex items-center gap-2 font-mono text-base font-semibold text-kursal-50"
        >
          <Key size={18} class="shrink-0 text-accent-400" />
          PQXDH Key Agreement
          <a
            href="https://signal.org/docs/specifications/pqxdh/"
            target="_blank"
            rel="noopener noreferrer"
            class="text-kursal-400 transition-colors hover:text-accent-400"
          >
            <ExternalLink size={15} />
          </a>
        </h3>
        <p class="text-sm leading-relaxed text-kursal-300">
          Kursal uses the Post-Quantum Extended Diffie-Hellman (PQXDH) protocol
          to establish shared secrets when initiating conversations.
        </p>
      </div>
      <div class="rounded-sm border border-kursal-700 bg-kursal-800/40 p-5">
        <h3
          class="mb-2 flex flex-wrap items-center gap-2 font-mono text-base font-semibold text-kursal-50"
        >
          <RefreshCw size={18} class="shrink-0 text-accent-400" />
          Double Ratchet
          <a
            href="https://signal.org/docs/specifications/doubleratchet/"
            target="_blank"
            rel="noopener noreferrer"
            class="text-kursal-400 transition-colors hover:text-accent-400"
          >
            <ExternalLink size={15} />
          </a>
          <span class="text-kursal-400">+ ML-KEM Braid</span>
          <a
            href="https://signal.org/docs/specifications/mlkembraid/"
            target="_blank"
            rel="noopener noreferrer"
            class="text-kursal-400 transition-colors hover:text-accent-400"
          >
            <ExternalLink size={15} />
          </a>
        </h3>
        <p class="text-sm leading-relaxed text-kursal-300">
          All message exchanges use the Double Ratchet algorithm, providing both
          forward secrecy and post-compromise security.
        </p>
      </div>
    </div>
  </DocSection>

  <DocSection n="02" title="Vulnerability Disclosure">
    <p>
      Security is at the core of Kursal. We encourage responsible disclosure of
      any vulnerabilities and are committed to addressing issues promptly.
    </p>

    <div class="mt-2">
      <h3
        class="mb-3 flex items-center gap-2 font-mono text-base font-semibold text-kursal-50"
      >
        <SiGithub size={18} />
        General Issues
      </h3>
      <p class="mb-4 text-sm leading-relaxed text-kursal-300">
        For bugs, feature requests, and non-security issues, please open an
        issue on GitHub:
      </p>
      <a
        href="/issues"
        target="_blank"
        rel="noopener noreferrer"
        class="inline-flex items-center gap-2 rounded-sm border border-kursal-600 bg-kursal-800 px-4 py-2 font-mono text-sm text-kursal-100 transition-colors hover:border-accent-500 hover:bg-kursal-700"
      >
        <SiGithub size={16} />
        Open GitHub Issue
      </a>
    </div>

    <div class="mt-6">
      <h3
        class="mb-3 flex items-center gap-2 font-mono text-base font-semibold text-kursal-50"
      >
        <Bug size={18} class="text-party-400" />
        Found a Vulnerability?
      </h3>
      <p class="mb-4 text-sm leading-relaxed text-kursal-300">
        If you've discovered a security issue that might impact user privacy or
        safety, we'd greatly appreciate your help in reporting it.
      </p>
      <a
        href="/vulnerability"
        target="_blank"
        rel="noopener noreferrer"
        class="inline-flex items-center gap-2 rounded-sm border border-party-500/40 bg-party-500/10 px-4 py-2 font-mono text-sm text-party-400 transition-colors hover:bg-party-500/20"
      >
        <Bug size={16} />
        Submit Vulnerability Report
      </a>
      <ul class="mt-5 space-y-2 font-mono text-sm text-kursal-300">
        <li class="flex gap-2.5">
          <span class="shrink-0 text-accent-500">▸</span>
          <span
            >Please provide detailed steps so we can reproduce and verify the
            issue.</span
          >
        </li>
        <li class="flex gap-2.5">
          <span class="shrink-0 text-accent-500">▸</span>
          <span
            >We kindly ask for 90 days to release a fix before public
            disclosure.</span
          >
        </li>
        <li class="flex gap-2.5">
          <span class="shrink-0 text-accent-500">▸</span>
          <span
            >We're a small team, but we'll try our best to acknowledge your
            report within 48 hours.</span
          >
        </li>
      </ul>
    </div>

    <div class="mt-6">
      <h3 class="mb-3 font-mono text-base font-semibold text-kursal-50">
        Our Commitment
      </h3>
      <ul class="space-y-2 font-mono text-sm text-kursal-300">
        <li class="flex gap-2.5">
          <span class="shrink-0 text-accent-500">▸</span>
          <span
            >Credit in our
            <a
              href="/credits"
              class="text-accent-400 underline underline-offset-2 hover:text-accent-300"
              >security acknowledgments</a
            > (if desired)</span
          >
        </li>
        <li class="flex gap-2.5">
          <span class="shrink-0 text-accent-500">▸</span>
          <span>Regular updates on our progress addressing the issue</span>
        </li>
        <li class="flex gap-2.5">
          <span class="shrink-0 text-accent-500">▸</span>
          <span>Transparent communication throughout the process</span>
        </li>
      </ul>
    </div>
  </DocSection>

  <DocSection n="03" title="Security Practices">
    <div class="mt-1 grid gap-6 md:grid-cols-2">
      <div>
        <h3 class="mb-3 font-mono text-base font-semibold text-kursal-50">
          Code Security
        </h3>
        <ul class="space-y-2 font-mono text-sm text-kursal-300">
          <li class="flex gap-2.5">
            <span class="shrink-0 text-accent-500">▸</span>
            <span>All code is open source and publicly auditable</span>
          </li>
          <li class="flex gap-2.5">
            <span class="shrink-0 text-accent-500">▸</span>
            <span>Continuous dependency vulnerability monitoring</span>
          </li>
        </ul>
      </div>
      <div>
        <h3 class="mb-3 font-mono text-base font-semibold text-kursal-50">
          Infrastructure
        </h3>
        <ul class="space-y-2 font-mono text-sm text-kursal-300">
          <li class="flex gap-2.5">
            <span class="shrink-0 text-accent-500">▸</span>
            <span>All communications are end-to-end encrypted</span>
          </li>
          <li class="flex gap-2.5">
            <span class="shrink-0 text-accent-500">▸</span>
            <span>Resistant decentralized network</span>
          </li>
        </ul>
      </div>
    </div>
  </DocSection>

  <p
    class="mt-9 border-t border-kursal-700 pt-6 font-mono text-sm text-kursal-400"
  >
    <span class="text-kursal-500">#&nbsp;</span>For more details on our
    cryptographic implementation, read our
    <a
      href={PAPER_URL}
      target="_blank"
      class="text-accent-400 underline underline-offset-2 hover:text-accent-300"
      >technical paper</a
    >
    or review the
    <a
      href={repository}
      target="_blank"
      rel="noopener noreferrer"
      class="text-accent-400 underline underline-offset-2 hover:text-accent-300"
      >source code</a
    >.
  </p>
</DocPage>
