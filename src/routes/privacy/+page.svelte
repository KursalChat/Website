<script lang="ts">
  import { SiGithub } from "@icons-pack/svelte-simple-icons";
  import DocPage from "$lib/components/DocPage.svelte";
  import DocSection from "$lib/components/DocSection.svelte";
  import { repository, email, SITE_OG, SITE_URL } from "$lib/const";

  const pageUrl = `${SITE_URL}/privacy`;
  const lastUpdated = "27 July 2026";
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
  <p class="font-mono text-sm text-kursal-400">
    <span class="text-kursal-500">#&nbsp;</span>Last updated: {lastUpdated}
  </p>

  <DocSection n="01" title="Our Commitment">
    <p>
      Kursal is built with privacy as its foundation. We believe your
      conversations belong to you, and we've designed our system so that we
      literally cannot read your messages. What we cannot hide is described just
      as plainly further down: relays see some metadata, and the network stores
      encrypted messages for contacts who are offline.
    </p>
  </DocSection>

  <DocSection n="02" title="Who Is Responsible">
    <p>
      The data controller for everything described here is Erik L.P., also known
      as Kubik (a pseudonym), reachable at
      <a
        href="mailto:kubik@kursal.chat"
        class="text-accent-400 underline underline-offset-2 hover:text-accent-300"
        >kubik@kursal.chat</a
      >. Kursal is a personal open source project, not a company.
    </p>
    <p>
      You can reach us about anything in this policy, including any of the
      rights in section 11, at
      <a
        href={"mailto:" + email}
        class="text-accent-400 underline underline-offset-2 hover:text-accent-300"
        >{email}</a
      >.
    </p>
  </DocSection>

  <DocSection n="03" title="Data We Don't Collect">
    <p>
      Because the Kursal app is peer-to-peer and fully decentralized and we do
      not want to invade your privacy, the app never sends us:
    </p>
    <ul class="mt-1 space-y-2 font-mono text-sm">
      <li class="flex gap-2.5">
        <span class="shrink-0 text-party-400">✗</span>
        <span class="text-kursal-200">No access to encryption keys</span>
      </li>
      <li class="flex gap-2.5">
        <span class="shrink-0 text-party-400">✗</span>
        <span class="text-kursal-200"
          >No in-app analytics or usage tracking</span
        >
      </li>
      <li class="flex gap-2.5">
        <span class="shrink-0 text-party-400">✗</span>
        <span class="text-kursal-200">No message content, ever</span>
      </li>
      <li class="flex gap-2.5">
        <span class="shrink-0 text-party-400">✗</span>
        <span class="text-kursal-200"
          >No account, phone number, or email to sign up</span
        >
      </li>
    </ul>
    <p class="mt-3">
      The network itself is the exception, and it is covered in sections 05 and
      06 below.
    </p>
  </DocSection>

  <DocSection n="04" title="Data We Collect">
    <p>
      The Kursal app never collects anything in the background. The only data we
      ever hold is what you explicitly hand us, and in all three cases the legal
      basis is your consent under Article 6(1)(a) GDPR, which you can withdraw
      at any time:
    </p>
    <ul class="mt-1 space-y-2 font-mono text-sm">
      <li class="flex gap-2.5">
        <span class="shrink-0 text-accent-500">+</span>
        <span class="text-kursal-200"
          >Your email address, only if you subscribe to our newsletter on this
          website</span
        >
      </li>
      <li class="flex gap-2.5">
        <span class="shrink-0 text-accent-500">+</span>
        <span class="text-kursal-200"
          >Your email address, only if you subscribe to policy update
          announcements on our Terms of Service page</span
        >
      </li>
      <li class="flex gap-2.5">
        <span class="shrink-0 text-accent-500">+</span>
        <span class="text-kursal-200"
          >Crash reports, only if you send one from the pop-up after a crash</span
        >
      </li>
    </ul>
    <p class="mt-3">
      A crash report tells us what went wrong, not who you are. It contains the
      error and the technical state of the app when it failed, the Kursal
      version, and your operating system and its version. It never contains
      messages, contacts, or encryption keys. The crash pop-up shows you the
      exact report before anything is sent, so you never have to take that on
      trust: read it, and send it only if you are happy with what is in it.
    </p>
    <p>
      We never share, sell, or otherwise hand off any of this to anyone. Both
      mailing lists are separate from each other, and you can leave either at
      any time using the link in every email we send, or by writing to us.
    </p>
    <p>
      One technical note for completeness: whenever you hand us any of this,
      subscribing or sending a crash report, the request itself carries your IP
      address to our server in Germany, as every request on the web does. We use
      it only to receive and answer that request, and do not log or keep it. The
      legal basis is our legitimate interest under Article 6(1)(f) GDPR in
      operating the endpoint securely.
    </p>
  </DocSection>

  <DocSection n="05" title="What Relays Can See">
    <p>
      Your encrypted messages travel through public relays. Some of these relays
      are operated by us, the rest are run by the community and by users who
      host their own. A relay only forwards traffic: it cannot decrypt anything
      it carries, and it stores none of it. But any relay can see some limited
      information about you while it is forwarding:
    </p>
    <ul class="mt-1 space-y-2 font-mono text-sm">
      <li class="flex gap-2.5">
        <span class="shrink-0 text-accent-500">▸</span>
        <span class="text-kursal-200"
          >Your IP address (can be changed with a VPN or Tor)</span
        >
      </li>
      <li class="flex gap-2.5">
        <span class="shrink-0 text-accent-500">▸</span>
        <span class="text-kursal-200">When you send messages</span>
      </li>
      <li class="flex gap-2.5">
        <span class="shrink-0 text-accent-500">▸</span>
        <span class="text-kursal-200"
          >Your Peer ID and the destination Peer ID (which periodically rotates
          and makes the 'when' harder to track)</span
        >
      </li>
    </ul>
    <p class="mt-3">
      This applies to every relay on the network, including our own. The relays
      we operate keep no logs at all: they forward traffic and retain nothing
      about who connected, or when. We have no control over what community-run
      relays log, which is why Kursal rotates Peer IDs and why we recommend a
      VPN or Tor if your IP address matters to you. Be aware that a relay
      actively carrying your traffic still sees a stable connection, so rotation
      alone does not hide you from it.
    </p>
    <p>
      Handling this metadata is unavoidable if a message is to reach anyone at
      all, so the legal basis for it is our legitimate interest under Article
      6(1)(f) GDPR in routing traffic and keeping the network running. The
      balance is deliberately tipped towards you: nothing is retained, nothing
      is decryptable, Peer IDs rotate on their own, and you can route around us
      entirely by picking different relays or running your own.
    </p>
  </DocSection>

  <DocSection n="06" title="What the Network Stores">
    <p>
      Two things do get stored, both encrypted, and neither on a server we
      control. They live in the distributed hash table carried by volunteer
      nodes, which includes some of ours:
    </p>
    <ul class="mt-1 space-y-2 font-mono text-sm">
      <li class="flex gap-2.5">
        <span class="shrink-0 text-accent-500">▸</span>
        <span class="text-kursal-200"
          >Messages for a contact who is offline, held until they come back and
          collect them, and discarded automatically after at most 3 weeks</span
        >
      </li>
      <li class="flex gap-2.5">
        <span class="shrink-0 text-accent-500">▸</span>
        <span class="text-kursal-200"
          >First-contact rendezvous bundles, published when you add someone with
          a one-time password, and discarded automatically after 10 minutes</span
        >
      </li>
    </ul>
    <p class="mt-3">
      A node holding one of these records sees an opaque, random-looking key and
      a block of ciphertext. It cannot decrypt the record, tell whose it is,
      tell that two records belong to the same conversation, or work out who
      published it. Offline bundles carry no signature and no sender key of any
      kind. Nothing needs to be deleted by hand, because every record expires by
      itself.
    </p>
    <p>
      This storage exists so that two people are not required to be online at
      the same moment, and its legal basis is our legitimate interest under
      Article 6(1)(f) GDPR in delivering messages you asked us to deliver. As
      with relays, most nodes are not ours, and we cannot make promises on
      behalf of the people who run them. What we can promise is that the design
      leaves them nothing worth having.
    </p>
  </DocSection>

  <DocSection n="07" title="How Kursal Works">
    <p>
      All encryption happens locally on your device. Messages are transmitted
      directly between peers using end-to-end encryption. There is no central
      server that processes or stores your communications. Even when your
      messages transit through public relays or wait in the distributed hash
      table, no one but the receiver can decrypt them.
    </p>
  </DocSection>

  <DocSection n="08" title="This Website">
    <p>
      This website sets no tracking or advertising cookies. The only cookies
      that may be set are the strictly necessary security cookies Cloudflare
      uses to tell humans apart from bots, which need no consent. We count
      visitors using
      <a
        href="https://plausible.io/"
        target="_blank"
        rel="noopener noreferrer"
        class="text-accent-400 underline underline-offset-2 hover:text-accent-300"
        >Plausible</a
      >, a privacy-friendly analytics platform which we self-host. Plausible
      stores no cookies and no IP addresses: it derives a daily rotating hash to
      count unique visits and discards the address itself. What we see is
      aggregate, and cannot be traced back to you.
    </p>
    <p>
      If you support us through
      <a
        href="https://ko-fi.com/kursal"
        target="_blank"
        rel="noopener noreferrer"
        class="text-accent-400 underline underline-offset-2 hover:text-accent-300"
        >Ko-Fi</a
      >, that donation is handled entirely by Ko-Fi as its own data controller,
      under their own privacy policy, and processed in the United States outside
      the EU under the safeguards Ko-Fi puts in place. We never see your payment
      details, only the name and message you choose to leave.
    </p>
  </DocSection>

  <DocSection n="09" title="Where Your Data Lives">
    <p>
      The newsletter service, the analytics, and the crash reports all run on
      hardware we own, keep, and administer ourselves, in Germany. It is not
      rented, not colocated, and not managed by anyone else. No hosting provider
      or datacenter operator sits between us and those machines, and nobody
      other than the maintainer holds credentials for them.
    </p>
    <p>
      This website and our inbound email are served through Cloudflare, which
      acts as a processor for delivery, spam filtering, and protection against
      attacks. Cloudflare is based in the United States and may process this
      traffic outside the EU, covered by the EU-US Data Privacy Framework and
      the European Commission's standard contractual clauses. Nothing else
      leaves the EU.
    </p>
  </DocSection>

  <DocSection n="10" title="How Long We Keep Things">
    <ul class="mt-1 space-y-2 font-mono text-sm">
      <li class="flex gap-2.5">
        <span class="shrink-0 text-accent-500">▸</span>
        <span class="text-kursal-200"
          >Newsletter emails: until you unsubscribe, or until the stable release
          announcement is sent, whichever comes first. That list is then
          deleted.</span
        >
      </li>
      <li class="flex gap-2.5">
        <span class="shrink-0 text-accent-500">▸</span>
        <span class="text-kursal-200"
          >Policy update emails: until you unsubscribe, or until we stop running
          the list.</span
        >
      </li>
      <li class="flex gap-2.5">
        <span class="shrink-0 text-accent-500">▸</span>
        <span class="text-kursal-200"
          >Crash reports: until the bug is fixed, and never longer than 6
          months.</span
        >
      </li>
      <li class="flex gap-2.5">
        <span class="shrink-0 text-accent-500">▸</span>
        <span class="text-kursal-200"
          >Analytics: aggregate counts only, with nothing tied to a person to
          retain.</span
        >
      </li>
      <li class="flex gap-2.5">
        <span class="shrink-0 text-accent-500">▸</span>
        <span class="text-kursal-200"
          >Relay traffic: forwarded and not stored, so there is nothing to keep.</span
        >
      </li>
      <li class="flex gap-2.5">
        <span class="shrink-0 text-accent-500">▸</span>
        <span class="text-kursal-200"
          >Offline messages in the distributed hash table: at most 3 weeks, then
          discarded automatically.</span
        >
      </li>
      <li class="flex gap-2.5">
        <span class="shrink-0 text-accent-500">▸</span>
        <span class="text-kursal-200"
          >First-contact rendezvous bundles: 10 minutes, then discarded
          automatically.</span
        >
      </li>
    </ul>
  </DocSection>

  <DocSection n="11" title="Your Rights">
    <p>
      Under the GDPR you have the right to access your data, correct it, have it
      deleted, restrict or object to how we use it, receive it in a portable
      form, and withdraw your consent at any time. For most of this there is
      simply nothing to hand over, because we hold nothing about you. Where we
      do hold something, the mailing lists and crash reports, write to
      <a
        href={"mailto:" + email}
        class="text-accent-400 underline underline-offset-2 hover:text-accent-300"
        >{email}</a
      >.
    </p>
    <p>
      We answer within one month, free of charge. If a request turns out to be
      genuinely complex we may take up to two months more, and in that case we
      will tell you inside the first month why. In practice this is one student
      and two small mailing lists, so it will almost always be far quicker than
      that.
    </p>
    <p>
      If you think we have handled your data badly, you can complain to the
      French data protection authority, the
      <a
        href="https://www.cnil.fr/"
        target="_blank"
        rel="noopener noreferrer"
        class="text-accent-400 underline underline-offset-2 hover:text-accent-300"
        >CNIL</a
      >, or to the supervisory authority of the country where you live or work.
      You do not need to talk to us first, though we would rather you did, and
      we will help either way.
    </p>
  </DocSection>

  <DocSection n="12" title="Security and Breaches">
    <p>
      Messages are end-to-end encrypted on your device and we never hold the
      keys. Everything else travels over TLS, our machines are accessible only
      to the maintainer, and we keep the amount of data we hold as close to zero
      as we can, which is the most effective security measure available to us.
    </p>
    <p>
      If a breach ever affects personal data we hold, we will notify the CNIL
      within 72 hours as required by Article 33 GDPR, and tell you directly if
      it puts you at real risk. Given that our entire holdings amount to two
      lists of email addresses and some crash logs, the blast radius is small by
      design.
    </p>
  </DocSection>

  <DocSection n="13" title="Children">
    <p>
      Kursal is not directed at children. You must meet the age of digital
      consent in your country to subscribe to either of our mailing lists or
      send us a crash report. We do not knowingly collect anything from anyone
      younger, and if you believe we have, tell us and we will delete it.
    </p>
  </DocSection>

  <DocSection n="14" title="Changes to This Policy">
    <p>
      If this policy changes, the date at the top of this page changes with it.
      Anything significant, and in particular any new purpose we would ever use
      your data for, is announced here before it takes effect, shown to you in
      the app, and emailed to anyone subscribed to policy updates, which you can
      sign up for on our
      <a
        href="/terms"
        class="text-accent-400 underline underline-offset-2 hover:text-accent-300"
        >Terms of Service</a
      >
      page. Since the whole history of this file is public, you can always see exactly
      what changed and when.
    </p>
  </DocSection>

  <DocSection n="15" title="Open Source">
    <p>
      Kursal is fully open source. You can audit our code at any time to verify
      our privacy claims. We encourage security researchers to review our
      implementation.
    </p>
    <a
      href={repository}
      target="_blank"
      rel="noopener noreferrer"
      class="inline-flex items-center gap-2 rounded-sm border border-accent-500/70 px-4 py-2 font-mono text-sm text-accent-400 transition-colors hover:bg-accent-500 hover:text-kursal-950"
    >
      <SiGithub size={16} />
      view source on GitHub
    </a>
  </DocSection>

  <p
    class="mt-9 border-t border-kursal-700 pt-6 font-mono text-sm text-kursal-400"
  >
    <span class="text-kursal-500">#&nbsp;</span>we don't collect your data
    because we can't. That's how Kursal is designed.
  </p>
</DocPage>
