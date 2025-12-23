<script lang="ts">
  import Navbar from "$lib/components/Navbar.svelte";

  import Hero from "$lib/components/Hero.svelte";
  import EncryptionAnimation from "$lib/components/EncryptionAnimation.svelte";
  import MailingList from "$lib/components/MailingList.svelte";
  import DecentralisationAnimation from "$lib/components/DecentralisationAnimation.svelte";
  import Features from "$lib/components/Features.svelte";
  import FAQ from "$lib/components/FAQ.svelte";
  import NotesFromTheDevs from "$lib/components/NotesFromTheDevs.svelte";

  import Footer from "$lib/components/Footer.svelte";
</script>

<Navbar />

<main>
  <Hero />

  <EncryptionAnimation />

  <MailingList />

  <DecentralisationAnimation />

  <Features />

  <FAQ />

  <!-- Hi! Thanks for reading the source code :) -->
  <!-- It's funny how I write these comments to whoever is gonna read them... -->
  <!-- Hope you're doing well I guess! -->
  <NotesFromTheDevs />
</main>

<Footer />
