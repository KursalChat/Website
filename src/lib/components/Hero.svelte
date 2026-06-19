<script lang="ts">
  import { onMount } from "svelte";
  import { Bell, FileText, ArrowDown } from "lucide-svelte";
  import { scrollTo } from "$lib/util";
  import { PAPER_URL, EXPECTEDTIME } from "$lib/const";

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
  class="relative min-h-screen flex flex-col pt-20 pb-12 overflow-hidden bg-kursal-900"
>
  <div class="flex-1 flex items-center justify-center relative z-10">
    <div class="max-w-3xl mx-auto px-6 text-center">
      <div
        class="inline-flex items-center gap-2 font-mono text-sm text-kursal-300 mb-10"
      >
        <span class="relative flex h-2 w-2">
          <span
            class="absolute inline-flex h-full w-full rounded-full bg-accent-500/70 animate-ping"
          ></span>
          <span class="relative inline-flex h-2 w-2 rounded-full bg-accent-500"
          ></span>
        </span>
        {EXPECTEDTIME}
      </div>

      <div class="flex items-center justify-center gap-3 md:gap-4 mb-8">
        <img src="/icon.png" alt="Kursal" class="w-12 h-12 md:w-16 md:h-16" />
        <h1
          class="font-mono text-4xl md:text-6xl font-bold text-kursal-50 tracking-tight"
        >
          kursal
        </h1>
      </div>

      <p
        class="font-mono text-2xl md:text-4xl lg:text-5xl font-semibold text-kursal-50 mb-6 tracking-tight"
        aria-label="Big Brother was watching you."
      >
        <span class="text-kursal-400">&gt;</span> Big Brother
        <span aria-hidden="true"
          ><span class="text-accent-400">{wasPart}</span>{restPart}.</span
        ><span class="caret" aria-hidden="true"></span>
      </p>

      <p
        class="text-base md:text-lg text-kursal-300 max-w-xl mx-auto mb-12 leading-relaxed"
      >
        Peer-to-peer, end-to-end encrypted messaging that puts you in control.
        No servers. No tracking. Just your private conversations.
      </p>

      <div
        class="flex flex-col sm:flex-row gap-4 justify-center mb-16 font-mono"
      >
        <button
          onclick={() => scrollTo("notify")}
          class="group inline-flex items-center justify-center gap-2.5 bg-accent-500 hover:bg-accent-400 text-kursal-950 px-7 py-3.5 rounded-sm font-semibold text-base transition-colors"
        >
          <span class="text-kursal-950/50">[</span>
          <Bell size={18} class="group-hover:animate-wiggle" />
          Get Notified at Launch
          <span class="text-kursal-950/50">]</span>
        </button>

        <a
          href={PAPER_URL}
          target="_blank"
          class="inline-flex items-center justify-center gap-2.5 border border-kursal-600 hover:border-accent-500 bg-kursal-800/60 hover:bg-kursal-800 text-kursal-100 px-7 py-3.5 rounded-sm font-semibold text-base transition-colors"
        >
          <span class="text-accent-500">[</span>
          <FileText size={18} />
          Read the Paper
          <span class="text-accent-500">]</span>
        </a>
      </div>

      <div class="mt-16">
        <button
          onclick={() => scrollTo("animation")}
          class="inline-flex flex-col items-center gap-2 font-mono text-sm text-kursal-400 hover:text-accent-400 transition-colors cursor-pointer animate-bounce"
        >
          <span>learn more</span>
          <ArrowDown size={18} />
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
</style>
