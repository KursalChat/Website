<script lang="ts">
  import DocPage from "$lib/components/DocPage.svelte";
  import DocSection from "$lib/components/DocSection.svelte";
  import { email, SITE_OG, SITE_URL } from "$lib/const";

  const pageUrl = `${SITE_URL}/legal`;
  const lastUpdated = "21 July 2026";
</script>

<svelte:head>
  <title>Legal Notice | Kursal</title>
  <meta name="description" content="Legal notice for the Kursal website." />
  <link rel="canonical" href={pageUrl} />

  <meta property="og:title" content="Legal Notice | Kursal" />
  <meta
    property="og:description"
    content="Legal notice for the Kursal website."
  />
  <meta property="og:url" content={pageUrl} />
  <meta property="og:image" content={SITE_OG} />

  <meta name="twitter:card" content="summary_large_image" />
  <meta name="twitter:title" content="Legal Notice | Kursal" />
  <meta
    name="twitter:description"
    content="Legal notice for the Kursal website."
  />
  <meta name="twitter:image" content={SITE_OG} />
</svelte:head>

<DocPage
  file="boring.txt"
  title="Legal Notice"
  subtitle="Who publishes this site, who hosts it, and how to reach us about any of it."
>
  <p class="font-mono text-sm text-kursal-400">
    <span class="text-kursal-500">#&nbsp;</span>Last updated: {lastUpdated}
  </p>

  <DocSection n="01" title="Publisher">
    <p>
      This website is published by one private individual, on a non-professional
      basis, as a personal open source project. Kursal is not a business and
      sells nothing. It accepts voluntary donations, which go towards hosting.
    </p>
    <p>
      The publisher exercises the right of a non-professional individual under
      article 6 III-2 of the French LCEN to remain anonymous on the site itself.
      This is a deliberate choice, not an omission: our identity and contact
      details are held by our host, named in section 02, who is required to
      disclose them to a judicial authority on request.
    </p>
    <p>
      For anything at all, write to
      <a
        href={"mailto:" + email}
        class="text-accent-400 underline underline-offset-2 hover:text-accent-300"
        >{email}</a
      >. We answer.
    </p>
  </DocSection>

  <DocSection n="02" title="Host">
    <p>This website is hosted on Cloudflare Pages by:</p>
    <ul class="mt-1 space-y-2 font-mono text-sm">
      <li class="flex gap-2.5">
        <span class="shrink-0 text-accent-500">▸</span>
        <span class="text-kursal-200">Cloudflare, Inc.</span>
      </li>
      <li class="flex gap-2.5">
        <span class="shrink-0 text-accent-500">▸</span>
        <span class="text-kursal-200"
          >101 Townsend St., San Francisco, California 94107, United States</span
        >
      </li>
      <li class="flex gap-2.5">
        <span class="shrink-0 text-accent-500">▸</span>
        <span class="text-kursal-200">+1 888 993 5273</span>
      </li>
      <li class="flex gap-2.5">
        <span class="shrink-0 text-accent-500">▸</span>
        <span class="text-kursal-200">
          <a
            href="https://www.cloudflare.com/"
            target="_blank"
            rel="noopener noreferrer"
            class="text-accent-400 underline underline-offset-2 hover:text-accent-300"
            >cloudflare.com</a
          >
        </span>
      </li>
    </ul>
  </DocSection>

  <DocSection n="03" title="Everything Else">
    <p>
      The mailing lists, the analytics, and the crash report endpoint do not run
      on Cloudflare. They run in Germany on hardware we own and administer
      ourselves, not rented, not colocated, with no hosting provider or
      datacenter operator in between.
    </p>
    <p>
      The nodes that carry Kursal traffic are operated partly by us and partly
      by the community. They forward encrypted traffic they cannot decrypt, and
      they also hold encrypted messages for contacts who are offline until those
      contacts collect them. All of this is set out in the
      <a
        href="/privacy"
        class="text-accent-400 underline underline-offset-2 hover:text-accent-300"
        >Privacy Policy</a
      >.
    </p>
  </DocSection>

  <DocSection n="04" title="Notices and Reports">
    <p>
      To report illegal content carried or stored by a node we operate, or to
      send a notice as an authority, write to
      <a
        href={"mailto:" + email}
        class="text-accent-400 underline underline-offset-2 hover:text-accent-300"
        >{email}</a
      >. We accept notices in English and French. This is our point of contact
      under Articles 11 and 12 of the Digital Services Act.
    </p>
    <p>
      When a node forwards traffic it is a mere conduit; when it holds an
      encrypted message for someone who is offline it is a hosting service.
      Neither role gives us any technical ability to read, select, or modify
      what passes through. What a notice can and cannot achieve, and what we do
      when we receive one, is set out in section 07 of our
      <a
        href="/terms"
        class="text-accent-400 underline underline-offset-2 hover:text-accent-300"
        >Terms of Service</a
      >.
    </p>
  </DocSection>

  <DocSection n="05" title="Intellectual Property">
    <p>
      The Kursal software is released under the GNU Affero General Public
      License, version 3 (AGPL-3.0-only), and you are free to use, modify, and
      redistribute it under those terms.
    </p>
    <p>
      The Kursal name, logo, and visual assets are not covered by that license
      and remain the property of their author, as section 7(e) of the AGPL
      expressly permits. You may say that your project is based on or compatible
      with Kursal. You may not use the name, logo, or assets as your own, or in
      any way that suggests we endorse or maintain your version. The details are
      in
      <a
        href="/trademark"
        target="_blank"
        rel="noopener noreferrer"
        class="text-accent-400 underline underline-offset-2 hover:text-accent-300"
        >TRADEMARK.md</a
      > in the main repository.
    </p>
  </DocSection>

  <p
    class="mt-9 border-t border-kursal-700 pt-6 font-mono text-sm text-kursal-400"
  >
    <span class="text-kursal-500">#&nbsp;</span>See also our
    <a
      href="/privacy"
      class="text-accent-400 underline underline-offset-2 hover:text-accent-300"
      >Privacy Policy</a
    >
    and
    <a
      href="/terms"
      class="text-accent-400 underline underline-offset-2 hover:text-accent-300"
      >Terms of Service</a
    >.
  </p>
</DocPage>
