<script lang="ts">
  import { Tween } from "svelte/motion";
  import { flip } from "svelte/animate";
  import { cubicOut } from "svelte/easing";
  import { reveal, growBar, prefersReducedMotion } from "$lib/reveal";
  import {
    apps,
    metrics,
    mb,
    lighterFactor,
    MEASURED_ON,
    type MetricKey,
  } from "$lib/footprint";

  let active = $state<MetricKey>("disk");

  const reduce = prefersReducedMotion();

  const values = new Map(
    apps.map((app) => [
      app.name,
      new Tween(app.disk, { duration: reduce ? 0 : 650, easing: cubicOut }),
    ]),
  );

  $effect(() => {
    for (const app of apps) values.get(app.name)!.target = app[active];
  });

  let metric = $derived(metrics.find((m) => m.key === active)!);
  let rows = $derived([...apps].sort((a, b) => a[active] - b[active]));
  let max = $derived(Math.max(...apps.map((app) => app[active])));
  let factor = $derived(lighterFactor(active));

  function width(app: (typeof apps)[number]) {
    return Math.max((app[active] / max) * 100, 2.5);
  }
</script>

<section
  use:reveal
  class="mt-14 overflow-hidden rounded-sm border border-kursal-700 bg-kursal-800/30"
>
  <div
    class="flex flex-wrap items-center justify-between gap-x-4 gap-y-2 border-b border-kursal-700 bg-kursal-800 px-4 py-2.5 font-mono text-xs"
  >
    <span class="flex min-w-0 items-center gap-2 text-kursal-400">
      <span class="shrink-0 text-accent-500">$</span>
      <span class="truncate">compare</span>
    </span>
    <div class="flex shrink-0 gap-1.5">
      {#each metrics as m}
        <button
          type="button"
          onclick={() => (active = m.key)}
          aria-pressed={active === m.key}
          class="rounded-sm border px-2 py-0.5 transition-colors {active ===
          m.key
            ? 'border-accent-500/40 bg-accent-500/15 text-accent-400'
            : 'border-kursal-700 text-kursal-500 hover:border-kursal-600 hover:text-kursal-300'}"
        >
          {m.flag}
        </button>
      {/each}
    </div>
  </div>

  <div class="p-6 md:p-8">
    <p class="mb-3 font-mono text-xs text-accent-400">~/benchmarks</p>
    <h2 class="font-mono text-xl font-bold text-kursal-50 md:text-2xl">
      {metric.title}
    </h2>
    <p class="mt-1.5 mb-7 text-sm text-kursal-300">{metric.caption}</p>

    <div class="flex flex-col gap-3">
      {#each rows as app, i (app.name)}
        <div
          animate:flip={{ duration: reduce ? 0 : 450, easing: cubicOut }}
          class="flex items-center gap-3 sm:gap-4"
        >
          <span
            class="w-[4.5rem] shrink-0 truncate font-mono text-xs sm:w-24 sm:text-sm {app.highlight
              ? 'font-semibold text-kursal-50'
              : 'text-kursal-300'}"
          >
            {app.name}
          </span>

          <div
            class="h-7 flex-1 rounded-sm border border-kursal-700 bg-kursal-900/60 p-[3px] sm:h-8"
          >
            <div
              use:growBar={{ delay: i * 90 }}
              class="h-full rounded-[2px] transition-[width] duration-700 ease-out {app.highlight
                ? 'bg-accent-500'
                : 'bg-kursal-600'}"
              style="width: {width(app)}%"
            ></div>
          </div>

          <span
            class="w-[4.5rem] shrink-0 text-right font-mono text-xs tabular-nums sm:w-20 sm:text-sm {app.highlight
              ? 'text-kursal-50'
              : 'text-kursal-300'}"
          >
            {mb(values.get(app.name)!.current)} MB
          </span>
        </div>
      {/each}
    </div>

    <div
      class="mt-7 flex items-start gap-2 border-t border-kursal-700 pt-4 font-mono text-xs text-kursal-400"
    >
      <span class="text-accent-500/80 select-none">↳</span>
      <span>
        Kursal uses
        <span class="text-accent-400">{factor}× less {metric.noun}</span>
        than the other three, on average. Measured on macOS, {MEASURED_ON}.
      </span>
    </div>
  </div>
</section>
