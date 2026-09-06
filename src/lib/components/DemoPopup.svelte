<script lang="ts">
  import { Play, X } from "lucide-svelte";

  interface Props {
    src: string;
    label: string;
    command: string;
    title: string;
    stack: number;
  }

  let { src, label, command, title, stack }: Props = $props();

  let open = $state(false);
  let dismissed = $state(false);
  let video = $state<HTMLVideoElement | null>(null);
  let closeButton = $state<HTMLButtonElement | null>(null);

  function close() {
    video?.pause();
    open = false;
  }

  $effect(() => {
    if (!open) return;

    closeButton?.focus();
    const previous = document.body.style.overflow;
    document.body.style.overflow = "hidden";

    return () => {
      document.body.style.overflow = previous;
    };
  });
</script>

<svelte:window
  onkeydown={(event) => event.key === "Escape" && open && close()}
/>

{#if open}
  <div
    role="dialog"
    aria-modal="true"
    aria-label={title}
    class="fixed inset-0 z-50 flex items-center justify-center p-4 sm:p-8"
  >
    <button
      aria-label="Close {title}"
      tabindex="-1"
      onclick={close}
      class="absolute inset-0 cursor-default bg-kursal-950/85 backdrop-blur-sm"
    ></button>

    <div
      class="relative flex max-h-full w-full max-w-5xl flex-col overflow-hidden rounded-sm border border-kursal-600 bg-kursal-800 shadow-2xl shadow-kursal-950/80"
    >
      <div
        class="flex shrink-0 items-center justify-between gap-2 border-b border-kursal-700 bg-kursal-950 px-4 py-2.5"
      >
        <span class="font-mono text-xs tracking-wide text-kursal-300">
          <span class="text-accent-500">$</span>
          {command}
        </span>
        <button
          bind:this={closeButton}
          onclick={close}
          aria-label="Close {title}"
          class="rounded-sm p-1 text-kursal-400 transition-colors hover:bg-kursal-800 hover:text-kursal-50"
        >
          <X size={16} />
        </button>
      </div>
      <!-- svelte-ignore a11y_media_has_caption -->
      <video
        bind:this={video}
        src="{src}#t=0.1"
        controls
        autoplay
        playsinline
        preload="metadata"
        class="max-h-[75vh] w-full bg-kursal-950"
      ></video>
    </div>
  </div>
{:else if !dismissed}
  <div
    class="pill fixed right-4 z-40 flex items-center gap-1 rounded-sm border border-kursal-600 bg-kursal-800 pr-1 shadow-lg shadow-kursal-950/50 sm:right-6"
    style="--stack: {stack}"
  >
    <button
      onclick={() => (open = true)}
      class="inline-flex items-center gap-2 py-2.5 pl-4 font-mono text-sm font-medium text-kursal-50 transition-colors hover:text-accent-400"
    >
      <Play size={14} class="shrink-0 fill-accent-400 text-accent-400" />
      {label}
    </button>
    <button
      onclick={() => (dismissed = true)}
      aria-label="Dismiss {title}"
      class="rounded-sm p-1.5 text-kursal-500 transition-colors hover:bg-kursal-700 hover:text-kursal-50"
    >
      <X size={14} />
    </button>
  </div>
{/if}

<style>
  .pill {
    bottom: calc(1rem + var(--stack) * 3.375rem);
  }

  @media (min-width: 640px) {
    .pill {
      bottom: calc(1.5rem + var(--stack) * 3.375rem);
    }
  }
</style>
