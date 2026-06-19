<script lang="ts">
  let {
    n,
    title,
    children,
  }: {
    n: string;
    title: string;
    children?: import("svelte").Snippet;
  } = $props();
</script>

<section class="py-7 border-t border-kursal-700/60 first:border-t-0 first:pt-1">
  <div class="flex gap-4 md:gap-6">
    <span
      class="font-mono text-accent-500 text-sm pt-1.5 select-none shrink-0 w-7 text-right"
      aria-hidden="true">{n}</span
    >
    <div class="min-w-0 flex-1">
      <h2
        class="font-mono text-xl md:text-2xl font-semibold text-kursal-50 mb-4"
      >
        {title}
      </h2>
      <div class="space-y-4 text-kursal-200 leading-relaxed">
        {@render children?.()}
      </div>
    </div>
  </div>
</section>
