<script lang="ts">
  import { slugify } from "$lib/util";

  let {
    n,
    title,
    id,
    children,
  }: {
    n: string;
    title: string;
    id?: string;
    children?: import("svelte").Snippet;
  } = $props();

  const anchor = $derived(id ?? slugify(title));
</script>

<section
  id={anchor}
  class="scroll-mt-24 border-t border-kursal-700/60 py-7 [header+&]:border-t-0 [header+&]:pt-1"
>
  <div class="flex gap-4 md:gap-6">
    <span
      class="w-7 shrink-0 pt-1.5 text-right font-mono text-sm text-accent-500 select-none"
      aria-hidden="true">{n}</span
    >
    <div class="min-w-0 flex-1">
      <h2
        class="mb-4 font-mono text-xl font-semibold text-kursal-50 md:text-2xl"
      >
        <a
          href="#{anchor}"
          class="group inline-flex items-baseline gap-2 transition-colors hover:text-accent-300"
        >
          {title}
          <span
            aria-hidden="true"
            class="font-normal text-accent-500 opacity-0 transition-opacity group-hover:opacity-100 group-focus-visible:opacity-100"
            >#</span
          >
        </a>
      </h2>
      <div class="space-y-4 leading-relaxed text-kursal-200">
        {@render children?.()}
      </div>
    </div>
  </div>
</section>