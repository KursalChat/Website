<script lang="ts">
  import { onMount } from "svelte";
  import { Download, FileText, ArrowDown } from "lucide-svelte";
  import { scrollTo } from "$lib/util";
  import { PAPER_URL, RELEASE_STATUS } from "$lib/const";

  const SCRAMBLE_CHARS = "#$%&@/<>=+0123456789ABCDEFabcdef";
  const TARGET = "was watching you";

  let revealed = $state(TARGET);

  onMount(() => {
    if (window.matchMedia("(prefers-reduced-motion: reduce)").matches) return;

    const duration = 950;
    const settleAt = TARGET.split("").map(
      (_, i) => 150 + (i / TARGET.length) * (duration * 0.75),
    );
    const start = performance.now();
    let raf = 0;

    const tick = (now: number) => {
      const t = now - start;
      let out = "";
      let done = true;
      for (let i = 0; i < TARGET.length; i++) {
        const ch = TARGET[i];
        if (ch === " ") {
          out += " ";
        } else if (t >= settleAt[i]) {
          out += ch;
        } else {
          out +=
            SCRAMBLE_CHARS[Math.floor(Math.random() * SCRAMBLE_CHARS.length)];
          done = false;
        }
      }
      revealed = out;
      if (done) {
        revealed = TARGET;
      } else {
        raf = requestAnimationFrame(tick);
      }
    };

    revealed = "";
    raf = requestAnimationFrame(tick);
    return () => cancelAnimationFrame(raf);
  });

  let wasPart = $derived(revealed.slice(0, 3));
  let restPart = $derived(revealed.slice(3));
</script>

<section
  class="relative flex min-h-screen flex-col overflow-hidden bg-kursal-900 pt-20 pb-12"
>
  <div class="relative z-10 flex flex-1 items-center justify-center">
    <div class="mx-auto max-w-3xl px-6 text-center">
      <div
        class="mb-10 inline-flex items-center gap-2 font-mono text-sm text-kursal-300"
      >
        <span class="relative flex h-2 w-2">
          <span
            class="absolute inline-flex h-full w-full animate-ping rounded-full bg-accent-500/70"
          ></span>
          <span class="relative inline-flex h-2 w-2 rounded-full bg-accent-500"
          ></span>
        </span>
        {RELEASE_STATUS}
      </div>

      <div class="mb-8 flex items-center justify-center gap-3 md:gap-4">
        <img src="/icon.png" alt="Kursal" class="h-12 w-12 md:h-16 md:w-16" />
        <h1
          class="font-mono text-4xl font-bold tracking-tight text-kursal-50 md:text-6xl"
        >
          kursal
        </h1>
      </div>

      <p
        class="mb-6 font-mono text-2xl font-semibold tracking-tight text-kursal-50 md:text-4xl lg:text-5xl"
        aria-label="Big Brother was watching you."
      >
        <span class="text-kursal-400">&gt;</span> Big Brother
        <span aria-hidden="true"
          ><span class="text-accent-400">{wasPart}</span>{restPart}.</span
        ><span class="caret" aria-hidden="true"></span>
      </p>

      <p
        class="mx-auto mb-12 max-w-xl text-base leading-relaxed text-kursal-300 md:text-lg"
      >
        Peer-to-peer, end-to-end encrypted messaging that puts you in control.
        No servers. No tracking. Just your private conversations.
      </p>

      <div
        class="mb-16 flex flex-col justify-center gap-4 font-mono sm:flex-row"
      >
        <a
          href="/download"
          class="group inline-flex items-center justify-center gap-2.5 rounded-sm bg-accent-500 px-7 py-3.5 text-base font-semibold text-kursal-950 transition-colors hover:bg-accent-400"
        >
          <span
            class="text-kursal-950/50 transition-transform group-hover:-translate-x-0.5"
            >[</span
          >
          <Download size={18} class="group-hover:animate-wiggle" />
          Download the Beta
          <span
            class="text-kursal-950/50 transition-transform group-hover:translate-x-0.5"
            >]</span
          >
        </a>

        <a
          href={PAPER_URL}
          target="_blank"
          class="group inline-flex items-center justify-center gap-2.5 rounded-sm border border-kursal-600 bg-kursal-800/60 px-7 py-3.5 text-base font-semibold text-kursal-100 transition-colors hover:border-accent-500 hover:bg-kursal-800"
        >
          <span
            class="text-accent-500 transition-transform group-hover:-translate-x-0.5"
            >[</span
          >
          <FileText size={18} />
          Read the Paper
          <span
            class="text-accent-500 transition-transform group-hover:translate-x-0.5"
            >]</span
          >
        </a>
      </div>

      <div class="mt-16">
        <button
          onclick={() => scrollTo("animation")}
          class="inline-flex cursor-pointer flex-col items-center gap-2 font-mono text-sm text-kursal-400 transition-colors hover:text-accent-400"
        >
          <span>learn more</span>
          <span class="tick"><ArrowDown size={18} /></span>
        </button>
      </div>
    </div>
  </div>
</section>

<style>
  @keyframes wiggle {
    0%,
    100% {
      transform: rotate(0deg);
    }
    25% {
      transform: rotate(-10deg);
    }
    75% {
      transform: rotate(10deg);
    }
  }

  :global(.group:hover .group-hover\:animate-wiggle) {
    animation: wiggle 0.5s ease-in-out;
  }

  .tick {
    animation: tick 1.4s steps(1) infinite;
  }

  @keyframes tick {
    0%,
    100% {
      transform: translateY(0);
    }
    50% {
      transform: translateY(5px);
    }
  }
</style>
