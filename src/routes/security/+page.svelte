<script lang="ts">
  import {
    Key,
    Bug,
    RefreshCw,
    ExternalLink,
    ShieldCheck,
    TriangleAlert,
  } from "lucide-svelte";
  import { SiGithub } from "@icons-pack/svelte-simple-icons";
  import DocPage from "$lib/components/DocPage.svelte";
  import DocSection from "$lib/components/DocSection.svelte";
  import { repository, PAPER_URL, SITE_URL, SITE_OG } from "$lib/const";

  const pageUrl = `${SITE_URL}/security`;
  const lastUpdated = "27 July 2026";
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
  <p class="font-mono text-sm text-kursal-400">
    <span class="text-kursal-500">#&nbsp;</span>Last updated: {lastUpdated}
  </p>

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
    <p class="mt-2">
      We did not invent any of this. Kursal builds on Signal's specifications
      through libsignal, and on libp2p for the networking.
    </p>
  </DocSection>

  <DocSection n="02" title="Current Limitations">
    <div
      class="flex items-start gap-3 rounded-sm border-l-2 border-party-500 bg-party-500/[0.07] p-4"
    >
      <TriangleAlert size={20} class="mt-0.5 shrink-0 text-party-400" />
      <p class="text-sm leading-relaxed text-kursal-200">
        Kursal has <strong class="text-kursal-50"
          >not been audited by an independent third party</strong
        >, and it is public beta software. Use it accordingly. If your safety
        depends on a messenger today, use one that has been audited.
      </p>
    </div>
    <p>
      Some weaknesses are inherent to the design rather than bugs waiting to be
      fixed, so it is only fair to name them here rather than leave them in the
      paper:
    </p>
    <ul class="mt-1 space-y-2 font-mono text-sm text-kursal-300">
      <li class="flex gap-2.5">
        <span class="shrink-0 text-party-400">▸</span>
        <span
          >Contacts added with a Long-Term Code have weaker forward secrecy for
          the first few messages of a conversation, until the Double Ratchet
          takes its first step. Contacts added with a one-time password or
          Nearby Share do not have this trade-off.</span
        >
      </li>
      <li class="flex gap-2.5">
        <span class="shrink-0 text-party-400">▸</span>
        <span
          >Peer ID rotation hides you from passive observers, not from a relay
          that is actively carrying your traffic. That relay sees a stable IP
          address, and the address update you send after rotating links your old
          and new IDs. Use Tor or a VPN if that matters to you.</span
        >
      </li>
      <li class="flex gap-2.5">
        <span class="shrink-0 text-party-400">▸</span>
        <span
          >Encryption protects content, not the fact that you are using Kursal
          at all. Nothing in the design hides that from your network.</span
        >
      </li>
    </ul>
    <p>
      All three are documented in more detail, with the reasoning behind them,
      in our
      <a
        href={PAPER_URL}
        target="_blank"
        rel="noopener noreferrer"
        class="text-accent-400 underline underline-offset-2 hover:text-accent-300"
        >technical paper</a
      >.
    </p>
  </DocSection>

  <DocSection n="03" title="Vulnerability Disclosure">
    <p>
      Security is at the core of Kursal. We encourage responsible disclosure of
      any vulnerabilities and are committed to addressing issues promptly.
    </p>

    <div class="mt-2">
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
            >We'll try our best to acknowledge your report within 48 hours.</span
          >
        </li>
      </ul>
    </div>

    <div class="mt-6">
      <h3
        class="mb-3 flex items-center gap-2 font-mono text-base font-semibold text-kursal-50"
      >
        <ShieldCheck size={18} class="text-accent-400" />
        Safe Harbour
      </h3>
      <div
        class="rounded-sm border-l-2 border-accent-500 bg-accent-500/[0.07] p-4"
      >
        <p class="text-sm leading-relaxed text-kursal-200">
          If you research Kursal in good faith and stay within the scope below,
          we consider your testing authorised. We will not start or support any
          legal action against you for it, and if a third party comes after you
          over research we authorised, we will say so publicly and in writing.
          Accidents happen while testing: if you break something or reach data
          you did not expect to reach, stop, tell us, and we will treat that as
          part of the report rather than as a problem.
        </p>
      </div>
      <p class="mt-4 text-sm leading-relaxed text-kursal-300">
        This is our promise, not a court's. It cannot bind a prosecutor or a
        third party whose systems you touch, which is exactly why the boundaries
        below matter.
      </p>
    </div>

    <div class="mt-6 grid gap-6 md:grid-cols-2">
      <div>
        <h3 class="mb-3 font-mono text-base font-semibold text-kursal-50">
          In Scope
        </h3>
        <ul class="space-y-2 font-mono text-sm text-kursal-300">
          <li class="flex gap-2.5">
            <span class="shrink-0 text-accent-500">▸</span>
            <span>kursal.chat and its subdomains</span>
          </li>
          <li class="flex gap-2.5">
            <span class="shrink-0 text-accent-500">▸</span>
            <span>The Kursal client, on any platform</span>
          </li>
          <li class="flex gap-2.5">
            <span class="shrink-0 text-accent-500">▸</span>
            <span>The protocol, the cryptography, and the paper</span>
          </li>
          <li class="flex gap-2.5">
            <span class="shrink-0 text-accent-500">▸</span>
            <span>Nodes and relays we operate ourselves</span>
          </li>
          <li class="flex gap-2.5">
            <span class="shrink-0 text-accent-500">▸</span>
            <span>Anything you run yourself, against yourself</span>
          </li>
        </ul>
      </div>
      <div>
        <h3 class="mb-3 font-mono text-base font-semibold text-kursal-50">
          Out of Scope
        </h3>
        <ul class="space-y-2 font-mono text-sm text-kursal-300">
          <li class="flex gap-2.5">
            <span class="shrink-0 text-party-400">✗</span>
            <span>Denial of service, load testing, or traffic flooding</span>
          </li>
          <li class="flex gap-2.5">
            <span class="shrink-0 text-party-400">✗</span>
            <span>Nodes and relays run by the community, not by us</span>
          </li>
          <li class="flex gap-2.5">
            <span class="shrink-0 text-party-400">✗</span>
            <span
              >Anything belonging to another user: messages, mailboxes,
              accounts, devices</span
            >
          </li>
          <li class="flex gap-2.5">
            <span class="shrink-0 text-party-400">✗</span>
            <span>Social engineering, phishing, or physical access</span>
          </li>
          <li class="flex gap-2.5">
            <span class="shrink-0 text-party-400">✗</span>
            <span>Automated scanner output with no demonstrated impact</span>
          </li>
        </ul>
      </div>
    </div>

    <div class="mt-6">
      <h3 class="mb-3 font-mono text-base font-semibold text-kursal-50">
        No Bug Bounty
      </h3>
      <p class="text-sm leading-relaxed text-kursal-300">
        We do not pay for reports. Kursal is a student project with no revenue,
        and the money simply is not there. Saying so up front seems better than
        letting you find out after the work. What we can offer is a real answer
        from the person who wrote the code, a fix, and credit in our
        <a
          href="/credits"
          class="text-accent-400 underline underline-offset-2 hover:text-accent-300"
          >security acknowledgments</a
        > if you want it.
      </p>
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

    <div class="mt-6">
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
  </DocSection>

  <DocSection n="04" title="Security Practices">
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
      rel="noopener noreferrer"
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
