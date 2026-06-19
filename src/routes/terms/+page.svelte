<script lang="ts">
  import { TriangleAlert } from "lucide-svelte";
  import DocPage from "$lib/components/DocPage.svelte";
  import DocSection from "$lib/components/DocSection.svelte";
  import { repository, email, SITE_URL, SITE_ICON } from "$lib/const";

  const pageUrl = `${SITE_URL}/terms`;
</script>

<svelte:head>
  <title>Terms of Service | Kursal</title>
  <meta
    name="description"
    content="Read the Kursal terms of service for usage responsibilities and more."
  />
  <link rel="canonical" href={pageUrl} />

  <meta property="og:title" content="Terms of Service | Kursal" />
  <meta
    property="og:description"
    content="Read the Kursal terms of service for usage responsibilities and more."
  />
  <meta property="og:url" content={pageUrl} />
  <meta property="og:image" content={SITE_ICON} />

  <meta name="twitter:card" content="summary" />
  <meta name="twitter:title" content="Terms of Service | Kursal" />
  <meta
    name="twitter:description"
    content="Read the Kursal terms of service for usage responsibilities and more."
  />
  <meta name="twitter:image" content={SITE_ICON} />
</svelte:head>

<DocPage
  file="terms.txt"
  title="Terms of Service"
  stamp="AGPL-3.0"
  subtitle="Open-source, decentralized, and peer-to-peer. Understand how Kursal works and your responsibilities."
>
  <DocSection n="01" title="About Kursal">
    <p>
      Kursal is an open-source, decentralized, peer-to-peer messaging
      application. There is no central authority, company, or organization that
      controls the Kursal network. The software is provided as-is under an open
      source license (AGPL-3).
    </p>
  </DocSection>

  <DocSection n="02" title="Decentralization">
    <p>
      By design, Kursal operates without central servers or control. This means:
    </p>
    <ul class="font-mono text-sm space-y-2 mt-1">
      <li class="flex gap-2.5">
        <span class="text-party-400 shrink-0">✗</span>
        <span class="text-kursal-200"
          >We cannot moderate, filter, or censor messages</span
        >
      </li>
      <li class="flex gap-2.5">
        <span class="text-party-400 shrink-0">✗</span>
        <span class="text-kursal-200"
          >We cannot recover lost accounts or encryption keys</span
        >
      </li>
      <li class="flex gap-2.5">
        <span class="text-party-400 shrink-0">✗</span>
        <span class="text-kursal-200"
          >We cannot access or read your communications</span
        >
      </li>
      <li class="flex gap-2.5">
        <span class="text-party-400 shrink-0">✗</span>
        <span class="text-kursal-200">We cannot delete or modify your data</span
        >
      </li>
    </ul>
    <p class="font-mono text-sm text-kursal-400">
      You are solely responsible for your use of the software and for backing up
      your encryption keys.
    </p>
  </DocSection>

  <DocSection n="03" title="Your Responsibilities">
    <p>When using Kursal, you agree to:</p>
    <ul class="font-mono text-sm space-y-2 mt-1">
      <li class="flex gap-2.5">
        <span class="text-accent-500 shrink-0">▸</span>
        <span class="text-kursal-200"
          >Comply with all applicable laws in your jurisdiction</span
        >
      </li>
      <li class="flex gap-2.5">
        <span class="text-accent-500 shrink-0">▸</span>
        <span class="text-kursal-200"
          >Not use the software for illegal activities</span
        >
      </li>
      <li class="flex gap-2.5">
        <span class="text-accent-500 shrink-0">▸</span>
        <span class="text-kursal-200"
          >Safeguard your encryption keys and credentials</span
        >
      </li>
      <li class="flex gap-2.5">
        <span class="text-accent-500 shrink-0">▸</span>
        <span class="text-kursal-200"
          >Understand that lost keys cannot be recovered</span
        >
      </li>
    </ul>
  </DocSection>

  <DocSection n="04" title="Open Source License">
    <p>
      Kursal is released under the AGPL-3.0 License. You are free to use,
      modify, and distribute the software according to the terms of this
      license. The full license text is available in our GitHub repository.
    </p>
  </DocSection>

  <DocSection n="05" title="No Warranty">
    <div
      class="bg-party-500/[0.07] border-l-2 border-party-500 rounded-sm p-4 flex gap-3 items-start"
    >
      <TriangleAlert size={20} class="text-party-400 shrink-0 mt-0.5" />
      <p class="font-mono text-xs text-kursal-300 leading-relaxed">
        THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
        OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
        MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
        IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
        CLAIM, DAMAGES OR OTHER LIABILITY.
      </p>
    </div>
  </DocSection>

  <DocSection n="06" title="Limitation of Liability">
    <p>
      Because Kursal is decentralized and we have no control over the network or
      user activities, we cannot be held liable for:
    </p>
    <ul class="font-mono text-sm space-y-2 mt-1">
      <li class="flex gap-2.5">
        <span class="text-accent-500 shrink-0">▸</span>
        <span class="text-kursal-200"
          >Any content transmitted through the network</span
        >
      </li>
      <li class="flex gap-2.5">
        <span class="text-accent-500 shrink-0">▸</span>
        <span class="text-kursal-200">Loss of data or encryption keys</span>
      </li>
      <li class="flex gap-2.5">
        <span class="text-accent-500 shrink-0">▸</span>
        <span class="text-kursal-200"
          >Service interruptions or unavailability</span
        >
      </li>
      <li class="flex gap-2.5">
        <span class="text-accent-500 shrink-0">▸</span>
        <span class="text-kursal-200">Any actions taken by other users</span>
      </li>
    </ul>
  </DocSection>

  <p
    class="mt-9 pt-6 border-t border-kursal-700 font-mono text-sm text-kursal-400"
  >
    <span class="text-kursal-500">#&nbsp;</span>For questions about these terms,
    please open an issue on our
    <a
      href={repository}
      target="_blank"
      rel="noopener noreferrer"
      class="text-accent-400 underline underline-offset-2 hover:text-accent-300"
      >GitHub repository</a
    >
    or email us at
    <a
      href={"mailto:" + email}
      target="_blank"
      rel="noopener noreferrer"
      class="text-accent-400 underline underline-offset-2 hover:text-accent-300"
      >{email}</a
    >.
  </p>
</DocPage>
