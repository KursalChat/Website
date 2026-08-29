<script lang="ts">
  let {
    path,
    count,
    empty,
    children,
  }: {
    path: string;
    count: number;
    empty: string;
    children?: import("svelte").Snippet;
  } = $props();
</script>

<div
  class="mt-2 overflow-hidden rounded-sm border border-kursal-700 bg-kursal-900/60 font-mono text-sm"
>
  <div
    class="flex items-center gap-2 border-b border-kursal-700 bg-kursal-800/60 px-4 py-2.5 text-kursal-400"
  >
    <span class="shrink-0 text-accent-500">$</span>
    <span class="truncate">ls ~/{path} ({count})</span>
  </div>

  <div class="p-4">
    {#if count === 0}
      <p class="text-kursal-500">{empty}</p>
    {:else}
      {@render children?.()}
    {/if}
  </div>
</div>
