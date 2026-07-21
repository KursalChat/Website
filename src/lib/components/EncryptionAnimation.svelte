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

<section id="animation" class="bg-kursal-900 py-20 md:py-28">
  <div class="mx-auto max-w-3xl px-6">
    <div class="mb-12 text-center" use:reveal>
      <div
        class="mb-4 inline-flex items-center gap-2 font-mono text-sm text-accent-400"
      >
        <ShieldCheck size={18} />
        <span>Quantum-Resistant</span>
      </div>
      <h2 class="mb-3 font-mono text-2xl font-bold text-kursal-50 md:text-4xl">
        End-to-End Encrypted
      </h2>
      <p class="mx-auto max-w-lg text-sm text-kursal-300 md:text-lg">
        Readable on your device and theirs. Everything in between only ever sees
        ciphertext.
      </p>
    </div>

    <div
      bind:this={stage}
      class="relative h-72 overflow-hidden rounded-sm border border-kursal-700 bg-kursal-950/40 sm:h-64"
    >
      <div
        class="channel pointer-events-none absolute top-1/2 right-[22%] left-[22%] h-px -translate-y-1/2"
      ></div>

      <div
        class="absolute top-3 left-1/2 z-20 flex -translate-x-1/2 flex-col items-center gap-1.5"
      >
        <div
          class="flex items-center gap-2 rounded-sm border border-kursal-700 bg-kursal-800 px-2.5 py-1.5 font-mono text-[0.65rem] whitespace-nowrap text-kursal-400"
        >
          <Eye size={13} class="text-kursal-500" /> relay sees
          <span class="flex items-center gap-1 text-kursal-300">
            <Lock size={11} /> sealed
          </span>
        </div>
        <div class="h-5 w-px bg-kursal-700"></div>
      </div>

      {#each [{ side: "left", name: "you", icon: Laptop, own: fromYou, shown: fromYou ? senderShown : receiverShown, text: fromYou ? typedText : msg.text, caret: fromYou && typing }, { side: "right", name: "recipient", icon: Smartphone, own: !fromYou, shown: fromYou ? receiverShown : senderShown, text: fromYou ? msg.text : typedText, caret: !fromYou && typing }] as d}
        <div
          class="absolute top-1/2 w-24 -translate-y-1/2 sm:w-32 {d.side ===
          'left'
            ? 'left-2 sm:left-4'
            : 'right-2 sm:right-4'}"
        >
          <div
            class="overflow-hidden rounded-lg border border-kursal-700 bg-kursal-800"
          >
            <div
              class="flex items-center gap-1.5 border-b border-kursal-700 px-2.5 py-1.5"
            >
              <d.icon size={12} class="text-accent-400" />
              <span class="font-mono text-[0.6rem] text-kursal-300"
                >{d.name}</span
              >
              <KeyRound size={10} class="ml-auto text-accent-400/70" />
            </div>
            <div class="flex h-20 flex-col justify-end p-2">
              {#if d.shown}
                <div
                  in:fly={{ y: 8, duration: 220 }}
                  out:fade={{ duration: 180 }}
                  class="flex {d.own ? 'justify-end' : 'justify-start'}"
                >
                  <span
                    class="max-w-[92%] rounded-md px-2 py-1 font-mono text-[0.7rem] leading-snug {d.own
                      ? 'border border-accent-500/30 bg-accent-500/20 text-kursal-50'
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
          class="pkt-glow pointer-events-none absolute top-1/2 z-0 h-24 w-24 -translate-x-1/2 -translate-y-1/2"
          style="left: {pos}%"
        ></div>
        <div
          in:fade={{ duration: 160 }}
          out:fade={{ duration: 160 }}
          class="absolute top-1/2 z-10 -translate-x-1/2 -translate-y-1/2"
          style="left: {pos}%"
        >
          <div
            class="flex items-center gap-1.5 rounded-md border border-accent-500/60 bg-kursal-950 px-2.5 py-1.5 font-mono text-xs text-accent-400 shadow-[0_0_22px_-4px] shadow-accent-500/50"
          >
            <Lock size={12} />
            {cipher}
          </div>
        </div>
      {/if}
    </div>

    <p class="mt-5 text-center font-mono text-xs text-kursal-500">
      // keys live only on these two devices: relays just carry a sealed packet
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
