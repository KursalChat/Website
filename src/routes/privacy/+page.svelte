<script lang="ts">
  import { SiGithub } from "@icons-pack/svelte-simple-icons";
  import DocPage from "$lib/components/DocPage.svelte";
  import DocSection from "$lib/components/DocSection.svelte";
  import { repository, SITE_OG, SITE_URL } from "$lib/const";

  const pageUrl = `${SITE_URL}/privacy`;
</script>

<svelte:head>
  <title>Privacy Policy | Kursal</title>
  <meta
    name="description"
    content="Kursal is built for privacy by design. Learn what data we do (not) collect."
  />
  <link rel="canonical" href={pageUrl} />

  <meta property="og:title" content="Privacy Policy | Kursal" />
  <meta
    property="og:description"
    content="Kursal is built for privacy by design. Learn what data we do (not) collect."
  />
  <meta property="og:url" content={pageUrl} />
  <meta property="og:image" content={SITE_OG} />

  <meta name="twitter:card" content="summary_large_image" />
  <meta name="twitter:title" content="Privacy Policy | Kursal" />
  <meta
    name="twitter:description"
    content="Kursal is built for privacy by design. Learn what data we do (not) collect."
  />
  <meta name="twitter:image" content={SITE_OG} />
</svelte:head>

<DocPage
  file="privacy.policy"
  title="Privacy Policy"
  stamp="No Logs"
  subtitle="Your conversations belong to you. We've designed Kursal so literally no one can access your messages."
>
  <DocSection n="01" title="Our Commitment">
    <p>
      Kursal is built with privacy as its foundation. We believe your
      conversations belong to you, and we've designed our system to ensure we
      literally cannot access your messages.
    </p>
  </DocSection>

  <DocSection n="02" title="Data We Don't Collect">
    <p>
      Because the Kursal app is peer-to-peer and fully decentralized and we do
      not want to invade your privacy:
    </p>
    <ul class="font-mono text-sm space-y-2 mt-1">
      <li class="flex gap-2.5">
        <span class="text-party-400 shrink-0">✗</span>
        <span class="text-kursal-200">No access to encryption keys</span>
      </li>
      <li class="flex gap-2.5">
        <span class="text-party-400 shrink-0">✗</span>
        <span class="text-kursal-200">No analytics or usage tracking</span>
      </li>
      <li class="flex gap-2.5">
        <span class="text-party-400 shrink-0">✗</span>
        <span class="text-kursal-200">No conversation metadata</span>
      </li>
    </ul>
  </DocSection>

  <DocSection n="03" title="Data We Collect">
    <p>
      The Kursal app itself collects nothing. The only data we ever hold is what
      you explicitly hand us:
    </p>
    <ul class="font-mono text-sm space-y-2 mt-1">
      <li class="flex gap-2.5">
        <span class="text-accent-500 shrink-0">+</span>
        <span class="text-kursal-200"
          >Email addresses, only if you subscribe to our newsletter on this
          website</span
        >
      </li>
      <li class="flex gap-2.5">
        <span class="text-accent-500 shrink-0">+</span>
        <span class="text-kursal-200"
          >Crash reports, only if you send one from the pop-up after a crash</span
        >
      </li>
    </ul>
    <p class="mt-3">
      Both are self-hosted on our own servers in Germany. We never share, sell,
      or otherwise hand off this data to anyone. You can unsubscribe from the
      newsletter at any time via the confirmation email, or reach us by email if
      you need help.
    </p>
  </DocSection>

  <DocSection n="04" title="Data Peers Could Collect">
    <p>
      Your encrypted messages go through public relays. Those relays can track
      some limited informations about you:
    </p>
    <ul class="font-mono text-sm space-y-2 mt-1">
      <li class="flex gap-2.5">
        <span class="text-accent-500 shrink-0">▸</span>
        <span class="text-kursal-200"
          >Your IP address (can be changed with a VPN)</span
        >
      </li>
      <li class="flex gap-2.5">
        <span class="text-accent-500 shrink-0">▸</span>
        <span class="text-kursal-200">When you send messages</span>
      </li>
      <li class="flex gap-2.5">
        <span class="text-accent-500 shrink-0">▸</span>
        <span class="text-kursal-200"
          >Your Peer ID and the destination Peer ID (which periodically rotates
          and makes the 'when' harder to track)</span
        >
      </li>
    </ul>
  </DocSection>

  <DocSection n="05" title="How Kursal Works">
    <p>
      All encryption happens locally on your device. Messages are transmitted
      directly between peers using end-to-end encryption. There is no central
      server that processes or stores your communications. Even if your messages
      transit through public relays, no one but the receiver can decrypt them.
    </p>
  </DocSection>

  <DocSection n="06" title="Website Data">
    <p>
      This website does not use cookies but tracks the number of visitors using
      <a
        href="https://plausible.io/"
        target="_blank"
        class="text-accent-400 underline underline-offset-2 hover:text-accent-300"
        >Plausible</a
      >, a privacy-friendly tracking platform, which is self-hosted in our case.
    </p>
  </DocSection>

  <DocSection n="07" title="Open Source">
    <p>
      Kursal is fully open source. You can audit our code at any time to verify
      our privacy claims. We encourage security researchers to review our
      implementation.
    </p>
    <a
      href={repository}
      target="_blank"
      rel="noopener noreferrer"
      class="inline-flex items-center gap-2 font-mono text-sm border border-accent-500/70 text-accent-400 hover:bg-accent-500 hover:text-kursal-950 px-4 py-2 rounded-sm transition-colors"
    >
      <SiGithub size={16} />
      view source on GitHub
    </a>
  </DocSection>

  <p
    class="mt-9 pt-6 border-t border-kursal-700 font-mono text-sm text-kursal-400"
  >
    <span class="text-kursal-500">#&nbsp;</span>This privacy policy is
    intentionally simple because our approach to privacy is simple: we don't
    collect your data because we can't. That's how Kursal is designed.
  </p>
</DocPage>
