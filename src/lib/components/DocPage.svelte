<script lang="ts">
  import Navbar from "$lib/components/Navbar.svelte";
  import Footer from "$lib/components/Footer.svelte";
  import { ArrowLeft } from "lucide-svelte";

  let {
    file,
    title,
    subtitle = "",
    stamp = "",
    children,
  }: {
    file: string;
    title: string;
    subtitle?: string;
    stamp?: string;
    children?: import("svelte").Snippet;
  } = $props();
</script>

<Navbar />

<main class="min-h-screen pt-24 pb-16 bg-kursal-900">
  <div class="max-w-4xl mx-auto px-6">
    <a
      href="/"
      onclick={() => window.scrollTo(0, 0)}
      class="inline-flex items-center gap-2 font-mono text-sm text-kursal-400 hover:text-accent-400 transition-colors mb-6"
    >
      <ArrowLeft size={16} />
      cd ~
    </a>

    <article
      class="border border-kursal-700 rounded-sm bg-kursal-800/30 overflow-hidden"
    >
      <!-- File header bar -->
      <div
        class="flex items-center justify-between gap-3 px-4 py-2.5 border-b border-kursal-700 bg-kursal-800 font-mono text-xs text-kursal-400"
      >
        <span class="flex items-center gap-2 min-w-0">
          <span class="text-accent-500 shrink-0">$</span>
          <span class="truncate">cat ~/{file}</span>
        </span>
        {#if stamp}
          <span
            class="stamp text-[0.6rem] -rotate-2 text-accent-400/80 shrink-0"
            >{stamp}</span
          >
        {/if}
      </div>

      <div class="p-6 md:p-10">
        <header class="mb-9 pb-8 border-b border-kursal-700">
          <h1
            class="font-mono text-3xl md:text-4xl font-bold text-kursal-50 mb-3"
          >
            {title}
          </h1>
          {#if subtitle}
            <p class="text-kursal-300 text-lg leading-relaxed max-w-2xl">
              {subtitle}
            </p>
          {/if}
        </header>

        {@render children?.()}
      </div>
    </article>
  </div>
</main>

<Footer />
