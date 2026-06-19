<script lang="ts">
  import { onMount } from "svelte";
  import { fade, fly } from "svelte/transition";
  import {
    Lock,
    Eye,
    KeyRound,
    Laptop,
    Smartphone,
    ShieldCheck,
  } from "lucide-svelte";
  import { reveal } from "$lib/reveal";

  const convo = [
    { from: "you", text: "movie friday?" },
    { from: "them", text: "i'm in 🍿" },
    { from: "you", text: "8pm my place" },
  ];
  const HEX = "0123456789abcdef";
  const N = convo.length;
  const UNIT = 4200;
  const HOLD = 0.5;

  let clock = $state(0);
  let stage: HTMLElement;

  const smooth = (x: number) => {
    const c = Math.max(0, Math.min(1, x));
    return c * c * (3 - 2 * c);
  };

  let T = $derived(clock / UNIT);
  let i = $derived(Math.min(Math.floor(T), N - 1));
  let f = $derived(T - i);
  let msg = $derived(convo[i]);
  let fromYou = $derived(msg.from === "you");
  let seed = $derived(Math.floor(clock / 90));

  let typedText = $derived(
    msg.text.slice(
      0,
      Math.ceil(Math.max(0, Math.min(1, (f - 0.06) / 0.16)) * msg.text.length),
    ),
  );
  let typing = $derived(f >= 0.06 && f < 0.24 && T < N);

  let senderShown = $derived(f >= 0.06 && f < 0.92 && T < N);
  let receiverShown = $derived(f >= 0.76 && f < 0.92 && T < N);
  let packetShown = $derived(f >= 0.26 && f <= 0.8 && T < N);

  let tt = $derived(smooth((f - 0.26) / 0.52));
  let pos = $derived(fromYou ? 24 + tt * 52 : 76 - tt * 52);

  let cipher = $derived.by(() => {
    let o = "";
    for (let k = 0; k < 8; k++) {
      if (k > 0 && k % 4 === 0) o += " ";
      o += HEX[(k * 7 + i * 13 + seed) % 16];
    }
    return o;
  });

  onMount(() => {
    if (window.matchMedia("(prefers-reduced-motion: reduce)").matches) {
      clock = (N - 1 + 0.82) * UNIT;
      return;
    }
    let raf = 0;
    let last: number | null = null;
    let running = false;
    const tick = (now: number) => {
      if (last == null) last = now;
      const dt = now - last;
      last = now;
      let c = clock + dt;
      if (c >= (N + HOLD) * UNIT) c = 0;
      clock = c;
      raf = requestAnimationFrame(tick);
    };
    const io = new IntersectionObserver(
      ([e]) => {
        if (e.isIntersecting && !running) {
          running = true;
          last = null;
          raf = requestAnimationFrame(tick);
        } else if (!e.isIntersecting && running) {
          running = false;
          cancelAnimationFrame(raf);
        }
      },
      { threshold: 0.25 },
    );
    io.observe(stage);
    return () => {
      cancelAnimationFrame(raf);
      io.disconnect();
    };
  });
</script>

<section id="animation" class="py-20 md:py-28 bg-kursal-900">
  <div class="max-w-3xl mx-auto px-6">
    <div class="text-center mb-12" use:reveal>
      <div
        class="inline-flex items-center gap-2 font-mono text-sm text-accent-400 mb-4"
      >
        <ShieldCheck size={18} />
        <span>End-to-End Encrypted</span>
      </div>
      <h2 class="font-mono text-2xl md:text-4xl font-bold text-kursal-50 mb-3">
        Locked end to end
      </h2>
      <p class="text-kursal-300 text-sm md:text-lg max-w-lg mx-auto">
        Readable on your device and theirs. Everything in between only ever
        carries a sealed packet.
      </p>
    </div>

    <div
      bind:this={stage}
      class="relative h-72 sm:h-64 rounded-sm border border-kursal-700 bg-kursal-950/40 overflow-hidden"
    >
      <div
        class="channel pointer-events-none absolute left-[22%] right-[22%] top-1/2 -translate-y-1/2 h-px"
      ></div>

      <div
        class="absolute left-1/2 -translate-x-1/2 top-3 z-20 flex flex-col items-center gap-1.5"
      >
        <div
          class="flex items-center gap-2 font-mono text-[0.65rem] text-kursal-400 border border-kursal-700 bg-kursal-800 rounded-sm px-2.5 py-1.5 whitespace-nowrap"
        >
          <Eye size={13} class="text-kursal-500" /> relay sees
          <span class="flex items-center gap-1 text-kursal-300">
            <Lock size={11} /> sealed
          </span>
        </div>
        <div class="w-px h-5 bg-kursal-700"></div>
      </div>

      {#each [{ side: "left", name: "you", icon: Laptop, own: fromYou, shown: fromYou ? senderShown : receiverShown, text: fromYou ? typedText : msg.text, caret: fromYou && typing }, { side: "right", name: "recipient", icon: Smartphone, own: !fromYou, shown: fromYou ? receiverShown : senderShown, text: fromYou ? msg.text : typedText, caret: !fromYou && typing }] as d}
        <div
          class="absolute top-1/2 -translate-y-1/2 w-24 sm:w-32 {d.side ===
          'left'
            ? 'left-2 sm:left-4'
            : 'right-2 sm:right-4'}"
        >
          <div
            class="rounded-lg border border-kursal-700 bg-kursal-800 overflow-hidden"
          >
            <div
              class="flex items-center gap-1.5 px-2.5 py-1.5 border-b border-kursal-700"
            >
              <d.icon size={12} class="text-accent-400" />
              <span class="font-mono text-[0.6rem] text-kursal-300"
                >{d.name}</span
              >
              <KeyRound size={10} class="text-accent-400/70 ml-auto" />
            </div>
            <div class="h-20 p-2 flex flex-col justify-end">
              {#if d.shown}
                <div
                  in:fly={{ y: 8, duration: 220 }}
                  out:fade={{ duration: 180 }}
                  class="flex {d.own ? 'justify-end' : 'justify-start'}"
                >
                  <span
                    class="max-w-[92%] rounded-md px-2 py-1 font-mono text-[0.7rem] leading-snug {d.own
                      ? 'bg-accent-500/20 text-kursal-50 border border-accent-500/30'
                      : 'bg-kursal-700 text-kursal-100'}"
                  >
                    {d.text}{#if d.caret}<span class="tcaret"></span>{/if}
                  </span>
                </div>
              {/if}
            </div>
          </div>
        </div>
      {/each}

      {#if packetShown}
        <div
          class="pkt-glow pointer-events-none absolute top-1/2 -translate-y-1/2 -translate-x-1/2 w-24 h-24 z-0"
          style="left: {pos}%"
        ></div>
        <div
          in:fade={{ duration: 160 }}
          out:fade={{ duration: 160 }}
          class="absolute top-1/2 -translate-y-1/2 -translate-x-1/2 z-10"
          style="left: {pos}%"
        >
          <div
            class="flex items-center gap-1.5 rounded-md px-2.5 py-1.5 font-mono text-xs bg-kursal-950 border border-accent-500/60 text-accent-400 shadow-[0_0_22px_-4px] shadow-accent-500/50"
          >
            <Lock size={12} />
            {cipher}
          </div>
        </div>
      {/if}
    </div>

    <p class="font-mono text-xs text-kursal-500 text-center mt-5">
      // keys live only on these two devices — relays just carry the sealed
      packet
    </p>
  </div>
</section>

<style>
  .channel {
    background-image: repeating-linear-gradient(
      to right,
      var(--color-kursal-600) 0 6px,
      transparent 6px 14px
    );
    background-size: 14px 100%;
    animation: flow 0.7s linear infinite;
  }
  @keyframes flow {
    to {
      background-position: 14px 0;
    }
  }
  .pkt-glow {
    background: radial-gradient(
      circle,
      rgba(77, 141, 255, 0.3),
      transparent 70%
    );
    filter: blur(6px);
  }
  .tcaret {
    display: inline-block;
    width: 0.5em;
    height: 1em;
    margin-left: 1px;
    vertical-align: -0.12em;
    background: var(--color-accent-400);
    animation: tblink 1s steps(1) infinite;
  }
  @keyframes tblink {
    0%,
    50% {
      opacity: 1;
    }
    50.01%,
    100% {
      opacity: 0;
    }
  }
</style>
