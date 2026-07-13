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
    <div class="grid md:grid-cols-2 gap-6 mt-1">
      <div class="border border-kursal-700 rounded-sm p-5 bg-kursal-800/40">
        <h3
          class="font-mono text-base font-semibold text-kursal-50 mb-2 flex items-center gap-2"
        >
          <Key size={18} class="text-accent-400 shrink-0" />
          PQXDH Key Agreement
          <a
            href="https://signal.org/docs/specifications/pqxdh/"
            target="_blank"
            rel="noopener noreferrer"
            class="text-kursal-400 hover:text-accent-400 transition-colors"
          >
            <ExternalLink size={15} />
          </a>
        </h3>
        <p class="text-kursal-300 text-sm leading-relaxed">
          Kursal uses the Post-Quantum Extended Diffie-Hellman (PQXDH) protocol
          to establish shared secrets when initiating conversations.
        </p>
      </div>
      <div class="border border-kursal-700 rounded-sm p-5 bg-kursal-800/40">
        <h3
          class="font-mono text-base font-semibold text-kursal-50 mb-2 flex items-center gap-2 flex-wrap"
        >
          <RefreshCw size={18} class="text-accent-400 shrink-0" />
          Double Ratchet
          <a
            href="https://signal.org/docs/specifications/doubleratchet/"
            target="_blank"
            rel="noopener noreferrer"
            class="text-kursal-400 hover:text-accent-400 transition-colors"
          >
            <ExternalLink size={15} />
          </a>
          <span class="text-kursal-400">+ ML-KEM Braid</span>
          <a
            href="https://signal.org/docs/specifications/mlkembraid/"
            target="_blank"
            rel="noopener noreferrer"
            class="text-kursal-400 hover:text-accent-400 transition-colors"
          >
            <ExternalLink size={15} />
          </a>
        </h3>
        <p class="text-kursal-300 text-sm leading-relaxed">
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
        class="font-mono text-base font-semibold text-kursal-50 mb-3 flex items-center gap-2"
      >
        <SiGithub size={18} />
        General Issues
      </h3>
      <p class="text-kursal-300 mb-4 text-sm leading-relaxed">
        For bugs, feature requests, and non-security issues, please open an
        issue on GitHub:
      </p>
      <a
        href="/issues"
        target="_blank"
        rel="noopener noreferrer"
        class="inline-flex items-center gap-2 font-mono text-sm border border-kursal-600 hover:border-accent-500 bg-kursal-800 hover:bg-kursal-700 text-kursal-100 px-4 py-2 rounded-sm transition-colors"
      >
        <SiGithub size={16} />
        Open GitHub Issue
      </a>
    </div>

    <div class="mt-6">
      <h3
        class="font-mono text-base font-semibold text-kursal-50 mb-3 flex items-center gap-2"
      >
        <Bug size={18} class="text-party-400" />
        Found a Vulnerability?
      </h3>
      <p class="text-kursal-300 mb-4 text-sm leading-relaxed">
        If you've discovered a security issue that might impact user privacy or
        safety, we'd greatly appreciate your help in reporting it.
      </p>
      <a
        href="/vulnerability"
        target="_blank"
        rel="noopener noreferrer"
        class="inline-flex items-center gap-2 font-mono text-sm bg-party-500/10 hover:bg-party-500/20 text-party-400 border border-party-500/40 px-4 py-2 rounded-sm transition-colors"
      >
        <Bug size={16} />
        Submit Vulnerability Report
      </a>
      <ul class="font-mono text-sm space-y-2 mt-5 text-kursal-300">
        <li class="flex gap-2.5">
          <span class="text-accent-500 shrink-0">▸</span>
          <span
            >Please provide detailed steps so we can reproduce and verify the
            issue.</span
          >
        </li>
        <li class="flex gap-2.5">
          <span class="text-accent-500 shrink-0">▸</span>
          <span
            >We kindly ask for 90 days to release a fix before public
            disclosure.</span
          >
        </li>
        <li class="flex gap-2.5">
          <span class="text-accent-500 shrink-0">▸</span>
          <span
            >We're a small team, but we'll try our best to acknowledge your
            report within 48 hours.</span
          >
        </li>
      </ul>
    </div>

    <div class="mt-6">
      <h3 class="font-mono text-base font-semibold text-kursal-50 mb-3">
        Our Commitment
      </h3>
      <ul class="font-mono text-sm space-y-2 text-kursal-300">
        <li class="flex gap-2.5">
          <span class="text-accent-500 shrink-0">▸</span>
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
          <span class="text-accent-500 shrink-0">▸</span>
          <span>Regular updates on our progress addressing the issue</span>
        </li>
        <li class="flex gap-2.5">
          <span class="text-accent-500 shrink-0">▸</span>
          <span>Transparent communication throughout the process</span>
        </li>
      </ul>
    </div>
  </DocSection>

  <DocSection n="03" title="Security Practices">
    <div class="grid md:grid-cols-2 gap-6 mt-1">
      <div>
        <h3 class="font-mono text-base font-semibold text-kursal-50 mb-3">
          Code Security
        </h3>
        <ul class="font-mono text-sm space-y-2 text-kursal-300">
          <li class="flex gap-2.5">
            <span class="text-accent-500 shrink-0">▸</span>
            <span>All code is open source and publicly auditable</span>
          </li>
          <li class="flex gap-2.5">
            <span class="text-accent-500 shrink-0">▸</span>
            <span>Continuous dependency vulnerability monitoring</span>
          </li>
        </ul>
      </div>
      <div>
        <h3 class="font-mono text-base font-semibold text-kursal-50 mb-3">
          Infrastructure
        </h3>
        <ul class="font-mono text-sm space-y-2 text-kursal-300">
          <li class="flex gap-2.5">
            <span class="text-accent-500 shrink-0">▸</span>
            <span>All communications are end-to-end encrypted</span>
          </li>
          <li class="flex gap-2.5">
            <span class="text-accent-500 shrink-0">▸</span>
            <span>Resistant decentralized network</span>
          </li>
        </ul>
      </div>
    </div>
  </DocSection>

  <p
    class="mt-9 pt-6 border-t border-kursal-700 font-mono text-sm text-kursal-400"
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
