<script lang="ts">
  import type { CreditEntry } from "$lib/credits";

  let { entry }: { entry: CreditEntry } = $props();

  const href = $derived(
    entry.url ??
      (entry.github ? `https://github.com/${entry.github}` : undefined),
  );
</script>

<li>
  <div class="flex flex-wrap items-center justify-between gap-3">
    <span
      class="flex min-w-0 items-center gap-2.5 font-semibold text-kursal-50"
    >
      {#if entry.github}
        <img
          src={`https://github.com/${entry.github}.png?size=64`}
          alt=""
          width="24"
          height="24"
          loading="lazy"
          class="h-6 w-6 shrink-0 rounded-full"
        />
      {:else}
        <span class="w-6 shrink-0 text-center text-accent-500">▸</span>
      {/if}
      {#if href}
        <a
          {href}
          target="_blank"
          rel="noopener noreferrer"
          class="truncate text-accent-400 hover:text-accent-300">{entry.name}</a
        >
      {:else}
        <span class="truncate">{entry.name}</span>
      {/if}
    </span>
    {#if entry.meta}
      <span class="shrink-0 text-xs text-kursal-500">{entry.meta}</span>
    {/if}
  </div>
  {#if entry.detail}
    <p class="mt-1.5 pl-[2.125rem] leading-relaxed text-kursal-300">
      {entry.detail}
    </p>
  {/if}
</li>
