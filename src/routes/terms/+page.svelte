<script lang="ts">
  import { TriangleAlert } from "lucide-svelte";
  import DocPage from "$lib/components/DocPage.svelte";
  import DocSection from "$lib/components/DocSection.svelte";
  import PolicyUpdates from "$lib/components/PolicyUpdates.svelte";
  import { repository, email, SITE_URL, SITE_OG } from "$lib/const";

  const pageUrl = `${SITE_URL}/terms`;
  const lastUpdated = "21 July 2026";
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
  <meta property="og:image" content={SITE_OG} />

  <meta name="twitter:card" content="summary_large_image" />
  <meta name="twitter:title" content="Terms of Service | Kursal" />
  <meta
    name="twitter:description"
    content="Read the Kursal terms of service for usage responsibilities and more."
  />
  <meta name="twitter:image" content={SITE_OG} />
</svelte:head>

<DocPage
  file="terms.txt"
  title="Terms of Service"
  stamp="AGPL-3.0"
  subtitle="Open-source, decentralized, and peer-to-peer. Understand how Kursal works and your responsibilities."
>
  <p class="font-mono text-sm text-kursal-400">
    <span class="text-kursal-500">#&nbsp;</span>Last updated: {lastUpdated}
  </p>

  <DocSection n="01" title="About Kursal">
    <p>
      Kursal is an open-source, decentralized, peer-to-peer messaging
      application. No company or organization controls the Kursal network, and
      no central authority can moderate, intercept, or shut down what travels
      across it.
    </p>
    <p>
      Kursal is maintained by one independent developer, Kubik, who operates a
      small part of the surrounding infrastructure: this website, the download
      server, the newsletter and policy update lists, the crash report endpoint,
      and some of the public nodes. Others have contributed to the project, but
      Kubik alone is responsible for these services and is the person these
      terms bind. What those services can and cannot see is described in our
      <a
        href="/privacy"
        class="text-accent-400 underline underline-offset-2 hover:text-accent-300"
        >Privacy Policy</a
      >. Every other node on the network is run by the community.
    </p>
  </DocSection>

  <DocSection n="02" title="Scope and Acceptance">
    <p>
      These terms are an agreement between you and the maintainer of Kursal.
      They cover only the services we actually operate:
    </p>
    <ul class="mt-1 space-y-2 font-mono text-sm">
      <li class="flex gap-2.5">
        <span class="shrink-0 text-accent-500">▸</span>
        <span class="text-kursal-200">This website</span>
      </li>
      <li class="flex gap-2.5">
        <span class="shrink-0 text-accent-500">▸</span>
        <span class="text-kursal-200"
          >The download server and the installer scripts we host</span
        >
      </li>
      <li class="flex gap-2.5">
        <span class="shrink-0 text-accent-500">▸</span>
        <span class="text-kursal-200">The API documentation service</span>
      </li>
      <li class="flex gap-2.5">
        <span class="shrink-0 text-accent-500">▸</span>
        <span class="text-kursal-200"
          >The newsletter and policy update mailing lists</span
        >
      </li>
      <li class="flex gap-2.5">
        <span class="shrink-0 text-accent-500">▸</span>
        <span class="text-kursal-200">The crash report endpoint</span>
      </li>
      <li class="flex gap-2.5">
        <span class="shrink-0 text-accent-500">▸</span>
        <span class="text-kursal-200">The network nodes we run ourselves</span>
      </li>
    </ul>
    <p class="mt-3">You accept them by using any of those services.</p>
    <p>
      These terms do <strong class="text-kursal-50">not</strong> govern the Kursal
      software itself. The software is licensed to you under the GNU Affero General
      Public License, version 3 (AGPL-3.0), and nothing here adds conditions to that
      license, restricts the rights it grants you, or applies to copies of Kursal
      you build, modify, or run yourself. Where these terms and the AGPL-3.0 disagree
      about the software, the AGPL-3.0 wins.
    </p>
  </DocSection>

  <DocSection n="03" title="Decentralization">
    <p>
      By design, Kursal operates without central servers or control. This means:
    </p>
    <ul class="mt-1 space-y-2 font-mono text-sm">
      <li class="flex gap-2.5">
        <span class="shrink-0 text-party-400">✗</span>
        <span class="text-kursal-200"
          >We cannot moderate, filter, or censor messages</span
        >
      </li>
      <li class="flex gap-2.5">
        <span class="shrink-0 text-party-400">✗</span>
        <span class="text-kursal-200"
          >We cannot recover lost accounts or encryption keys</span
        >
      </li>
      <li class="flex gap-2.5">
        <span class="shrink-0 text-party-400">✗</span>
        <span class="text-kursal-200"
          >We cannot access or read your communications</span
        >
      </li>
      <li class="flex gap-2.5">
        <span class="shrink-0 text-party-400">✗</span>
        <span class="text-kursal-200">We cannot delete or modify your data</span
        >
      </li>
    </ul>
    <p class="font-mono text-sm text-kursal-400">
      You are solely responsible for your use of the software and for backing up
      your encryption keys.
    </p>
  </DocSection>

  <DocSection n="04" title="Who Can Use Kursal">
    <p>Two different rules apply, because they answer different questions.</p>
    <ul class="mt-1 space-y-2 font-mono text-sm">
      <li class="flex gap-2.5">
        <span class="shrink-0 text-accent-500">▸</span>
        <span class="text-kursal-200"
          >To hand us any data at all, meaning our mailing lists and crash
          reports, you must meet the age of digital consent where you live. That
          is 13 to 16 depending on the country, and 15 in France.</span
        >
      </li>
      <li class="flex gap-2.5">
        <span class="shrink-0 text-accent-500">▸</span>
        <span class="text-kursal-200"
          >To agree to these terms, you must be old enough to enter an agreement
          where you live, which is usually 18. If you are younger, a parent or
          legal guardian has to be involved.</span
        >
      </li>
    </ul>
    <p class="mt-3">
      We do not knowingly collect anything from anyone below the age of digital
      consent. The Kursal software itself is licensed under the AGPL-3.0 and is
      not subject to either rule.
    </p>
  </DocSection>

  <DocSection n="05" title="Your Responsibilities">
    <p>
      The Kursal software is yours to use freely under the AGPL-3.0. The
      commitments below apply to the services we operate, and to your own
      conduct under the law:
    </p>
    <ul class="mt-1 space-y-2 font-mono text-sm">
      <li class="flex gap-2.5">
        <span class="shrink-0 text-accent-500">▸</span>
        <span class="text-kursal-200"
          >Comply with all applicable laws in your jurisdiction</span
        >
      </li>
      <li class="flex gap-2.5">
        <span class="shrink-0 text-accent-500">▸</span>
        <span class="text-kursal-200"
          >Do not use our nodes to transmit or store content that is illegal
          where you or the recipient are</span
        >
      </li>
      <li class="flex gap-2.5">
        <span class="shrink-0 text-accent-500">▸</span>
        <span class="text-kursal-200"
          >Do not attack, overload, or attempt to compromise our services</span
        >
      </li>
      <li class="flex gap-2.5">
        <span class="shrink-0 text-accent-500">▸</span>
        <span class="text-kursal-200"
          >Do not use our services to send unsolicited bulk messages (spam)</span
        >
      </li>
      <li class="flex gap-2.5">
        <span class="shrink-0 text-accent-500">▸</span>
        <span class="text-kursal-200"
          >Safeguard your encryption keys and credentials</span
        >
      </li>
      <li class="flex gap-2.5">
        <span class="shrink-0 text-accent-500">▸</span>
        <span class="text-kursal-200"
          >Understand that lost keys cannot be recovered</span
        >
      </li>
    </ul>
    <p>
      We may stop serving a peer that is attacking or overloading our own nodes,
      and where we are actually able to identify one, we will stop serving
      anyone who repeatedly uses our services to infringe copyright. Both are
      limited to the services we run: we cannot remove anyone from the Kursal
      network itself, and we do not have that power by design.
    </p>
  </DocSection>

  <DocSection n="06" title="Our Role: Forwarding and Storage">
    <p>
      The nodes we run do two different things, and the law treats them
      differently, so it is worth separating them.
    </p>
    <p>
      <strong class="text-kursal-50">Forwarding.</strong> Most of what a node does
      is relay traffic between two people who are both online. In that role it is
      a mere conduit within the meaning of Article 4 of the Digital Services Act (Regulation
      (EU) 2022/2065). We do not initiate transmissions, do not select who receives
      them, and do not select or modify what they contain. Nothing is retained: the
      traffic is forwarded and gone.
    </p>
    <p>
      <strong class="text-kursal-50">Storage.</strong> Two things are stored, both
      encrypted, in the distributed hash table carried by volunteer nodes, which includes
      some of ours. Messages for a contact who is offline wait there until that contact
      collects them, and expire on their own after at most 3 weeks. First-contact
      rendezvous bundles wait there for 10 minutes. In that role a node is a hosting
      service under Article 6 of the same regulation.
    </p>
    <p>
      In both roles a node holds an opaque, random-looking key and a block of
      ciphertext. It cannot decrypt a record, tell whose it is, link two records
      to the same conversation, or work out who published one. That is a
      property of the design, not a policy we could change on request.
    </p>
  </DocSection>

  <DocSection n="07" title="Reporting Content">
    <p>
      If you believe a record stored by a node we run is illegal, write to
      <a
        href={"mailto:" + email}
        class="text-accent-400 underline underline-offset-2 hover:text-accent-300"
        >{email}</a
      >
      with everything you can give us: what the content is, why you believe it is
      illegal, where it is, and how to reach you. We accept notices in English and
      French, by email, from anyone. We confirm receipt, and we tell you what we decided
      and why.
    </p>
    <p>
      Be aware of what we can honestly promise. A stored record is ciphertext
      under a key derived from a secret only two people share. We cannot read
      it, search for it, or identify it as the one you are describing, so in
      almost every case the only true answer we can give you is that the record
      cannot be found or acted on, and that it expires by itself within 3 weeks.
      Where a notice does identify something we can act on, we act on it. This
      is the notice and action mechanism required by Article 16 of the Digital
      Services Act, and the same address is our point of contact for users and
      for authorities under Articles 11 and 12.
    </p>
  </DocSection>

  <DocSection n="08" title="Open Source License">
    <p>
      Kursal is released under the GNU Affero General Public License, version 3
      (AGPL-3.0-only). You are free to use, modify, and distribute the software
      according to the terms of that license. The full license text is available
      in our GitHub repository.
    </p>
    <p>
      The Kursal name, logo, and visual assets are not covered by that license
      and remain the property of their author. The AGPL expressly allows this in
      its section 7(e). See our
      <a
        href="/legal"
        class="text-accent-400 underline underline-offset-2 hover:text-accent-300"
        >Legal Notice</a
      > for what you may and may not do with them.
    </p>
  </DocSection>

  <DocSection n="09" title="No Warranty">
    <div
      class="flex items-start gap-3 rounded-sm border-l-2 border-party-500 bg-party-500/[0.07] p-4"
    >
      <TriangleAlert size={20} class="mt-0.5 shrink-0 text-party-400" />
      <p class="font-mono text-xs leading-relaxed text-kursal-300">
        THERE IS NO WARRANTY FOR THE PROGRAM, TO THE EXTENT PERMITTED BY
        APPLICABLE LAW. EXCEPT WHEN OTHERWISE STATED IN WRITING THE COPYRIGHT
        HOLDERS AND/OR OTHER PARTIES PROVIDE THE PROGRAM "AS IS" WITHOUT
        WARRANTY OF ANY KIND, EITHER EXPRESSED OR IMPLIED, INCLUDING, BUT NOT
        LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A
        PARTICULAR PURPOSE. THE ENTIRE RISK AS TO THE QUALITY AND PERFORMANCE OF
        THE PROGRAM IS WITH YOU. SHOULD THE PROGRAM PROVE DEFECTIVE, YOU ASSUME
        THE COST OF ALL NECESSARY SERVICING, REPAIR OR CORRECTION.
      </p>
    </div>
    <p class="font-mono text-sm text-kursal-400">
      Sections 15 and 16 of the GNU Affero General Public License, version 3.
    </p>
    <p>
      The services we operate are provided free of charge, without any guarantee
      of availability, and may change or shut down at any time.
    </p>
    <p class="font-mono text-sm text-kursal-400">
      This disclaimer applies only as far as the law allows.
    </p>
  </DocSection>

  <DocSection n="10" title="Limitation of Liability">
    <p>
      Because Kursal is decentralized and we have no control over the network or
      user activities, and to the fullest extent permitted by law, we are not
      liable for:
    </p>
    <ul class="mt-1 space-y-2 font-mono text-sm">
      <li class="flex gap-2.5">
        <span class="shrink-0 text-accent-500">▸</span>
        <span class="text-kursal-200"
          >Any content transmitted through the network</span
        >
      </li>
      <li class="flex gap-2.5">
        <span class="shrink-0 text-accent-500">▸</span>
        <span class="text-kursal-200">Loss of data or encryption keys</span>
      </li>
      <li class="flex gap-2.5">
        <span class="shrink-0 text-accent-500">▸</span>
        <span class="text-kursal-200"
          >Service interruptions or unavailability</span
        >
      </li>
      <li class="flex gap-2.5">
        <span class="shrink-0 text-accent-500">▸</span>
        <span class="text-kursal-200">Any actions taken by other users</span>
      </li>
    </ul>
    <p>
      Nothing in these terms limits our liability for wilful misconduct, gross
      negligence, death or personal injury, or for anything else that the law
      applying to you does not permit us to limit.
    </p>
  </DocSection>

  <DocSection n="11" title="Changes to These Terms">
    <p>
      We may update these terms when the software or the services we operate
      change, when the law changes, or to fix mistakes and make things clearer.
      The date at the top of this page always reflects the current version.
      Significant changes are announced here before they take effect, shown to
      you in the app, and emailed to anyone subscribed to policy updates.
      Continuing to use our services after a change means you accept the updated
      terms. If you do not, you can decline by staying on a previous version of
      the software, or you can stop using our services entirely. The software
      itself remains yours under the AGPL-3.0 regardless.
    </p>
    <PolicyUpdates />
  </DocSection>

  <DocSection n="12" title="Governing Law">
    <p>
      These terms are governed by French law. If you are a consumer, this choice
      does not deprive you of the protection of the mandatory rules of the
      country where you live, and you keep the right to bring proceedings before
      the courts of that country.
    </p>
    <p>
      Before going to court, we would much rather talk. Email us at
      <a
        href={"mailto:" + email}
        class="text-accent-400 underline underline-offset-2 hover:text-accent-300"
        >{email}</a
      >
      and we will do our best to sort it out.
    </p>
  </DocSection>

  <DocSection n="13" title="Severability">
    <p>
      If any provision of these terms is held invalid or unenforceable, it is
      limited or removed to the minimum extent necessary, and the remaining
      provisions stay in full force.
    </p>
  </DocSection>

  <p
    class="mt-9 border-t border-kursal-700 pt-6 font-mono text-sm text-kursal-400"
  >
    <span class="text-kursal-500">#&nbsp;</span>For questions about these terms,
    please open an issue on our
    <a
      href={repository}
      target="_blank"
      rel="noopener noreferrer"
      class="text-accent-400 underline underline-offset-2 hover:text-accent-300"
      >repository</a
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
