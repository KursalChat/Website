<script lang="ts">
  import Navbar from "$lib/components/Navbar.svelte";
  import { repository, SITE_ICON, SITE_OG, SITE_URL } from "$lib/const";

  import Hero from "$lib/components/Hero.svelte";
  import EncryptionAnimation from "$lib/components/EncryptionAnimation.svelte";
  import MailingList from "$lib/components/MailingList.svelte";
  import DecentralisationAnimation from "$lib/components/DecentralisationAnimation.svelte";
  import Features from "$lib/components/Features.svelte";
  import FAQ from "$lib/components/FAQ.svelte";
  import NotesFromTheDevs from "$lib/components/NotesFromTheDevs.svelte";

  import Footer from "$lib/components/Footer.svelte";

  const organizationSchema = {
    "@context": "https://schema.org",
    "@type": "Organization",
    name: "Kursal",
    url: SITE_URL,
    logo: SITE_ICON,
    sameAs: [repository],
  };

  const websiteSchema = {
    "@context": "https://schema.org",
    "@type": "WebSite",
    name: "Kursal",
    url: SITE_URL,
    description:
      "Peer-to-peer, end-to-end encrypted messaging with no central servers and no tracking.",
  };
</script>

<svelte:head>
  <title>Kursal | Private Peer-to-Peer Messaging</title>
  <meta
    name="description"
    content="Kursal is a peer-to-peer, end-to-end encrypted messaging platform with no central servers and no tracking."
  />
  <link rel="canonical" href={SITE_URL} />

  <meta property="og:title" content="Kursal | Private Peer-to-Peer Messaging" />
  <meta
    property="og:description"
    content="Peer-to-peer, end-to-end encrypted messaging with no central servers and no tracking."
  />
  <meta property="og:url" content={SITE_URL} />
  <meta property="og:image" content={SITE_OG} />
  <meta
    property="og:image:alt"
    content="Kursal — Big Brother was watching you."
  />

  <meta name="twitter:card" content="summary_large_image" />
  <meta
    name="twitter:title"
    content="Kursal | Private Peer-to-Peer Messaging"
  />
  <meta
    name="twitter:description"
    content="Peer-to-peer, end-to-end encrypted messaging with no central servers and no tracking."
  />
  <meta name="twitter:image" content={SITE_OG} />

  {@html `<script type="application/ld+json">${JSON.stringify(organizationSchema)}</script>`}
  {@html `<script type="application/ld+json">${JSON.stringify(websiteSchema)}</script>`}
</svelte:head>

<Navbar />

<main>
  <Hero />

  <EncryptionAnimation />

  <DecentralisationAnimation />

  <Features />

  <MailingList />

  <FAQ />

  <!-- Hi! Thanks for reading the source code :) -->
  <!-- It's funny how I write these comments to whoever is gonna read them... -->
  <!-- Hope you're doing well I guess! -->
  <NotesFromTheDevs />
</main>

<Footer />
