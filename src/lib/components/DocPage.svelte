<script lang="ts">
  import Navbar from "$lib/components/Navbar.svelte";
  import Footer from "$lib/components/Footer.svelte";
  import { ArrowLeft } from "lucide-svelte";

  let {
    file,
    title,
    subtitle = "",
    stamp = "",
    command = "cat",
    children,
  }: {
    file: string;
    title: string;
    subtitle?: string;
    stamp?: string;
    command?: string;
    children?: import("svelte").Snippet;
  } = $props();
</script>

<Navbar />

<main class="min-h-screen bg-kursal-900 pt-24 pb-16">
  <div class="mx-auto max-w-4xl px-6">
    <a
      href="/"
      onclick={() => window.scrollTo(0, 0)}
      class="group mb-6 inline-flex items-center gap-2 font-mono text-sm text-kursal-400 transition-colors hover:text-accent-400"
    >
      <ArrowLeft
        size={16}
        class="transition-transform group-hover:-translate-x-0.5"
      />
      cd ~
    </a>

    <article
      class="overflow-hidden rounded-sm border border-kursal-700 bg-kursal-800/30"
    >
      <!-- File header bar -->
      <div
        class="flex items-center justify-between gap-3 border-b border-kursal-700 bg-kursal-800 px-4 py-2.5 font-mono text-xs text-kursal-400"
      >
        <span class="flex min-w-0 items-center gap-2">
          <span class="shrink-0 text-accent-500">$</span>
          <span class="truncate">{command} ~/{file}</span>
        </span>
        {#if stamp}
          <span
            class="stamp shrink-0 -rotate-2 text-[0.6rem] text-accent-400/80"
            >{stamp}</span
          >
        {/if}
      </div>

      <div class="p-6 md:p-10">
        <header class="mb-9 border-b border-kursal-700 pb-8">
          <h1
            class="mb-3 font-mono text-3xl font-bold text-kursal-50 md:text-4xl"
          >
            {title}
          </h1>
          {#if subtitle}
            <p class="max-w-2xl text-lg leading-relaxed text-kursal-300">
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
