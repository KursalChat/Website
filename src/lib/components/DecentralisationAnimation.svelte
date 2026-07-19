<script lang="ts">
  import { onMount } from "svelte";
  import {
    Server,
    Smartphone,
    Laptop,
    Monitor,
    Wifi,
    WifiOff,
    Lock,
    Check,
  } from "lucide-svelte";
  import { reveal } from "$lib/reveal";

  let scrollProgress = $state(0);
  let containerElement: HTMLElement;

  type Node = {
    id: string;
    x: number;
    y: number;
    icon: "server" | "phone" | "laptop" | "monitor";
    status: "active" | "failing" | "dead" | "joining";
  };

  const initialNodes: Node[] = [
    { id: "a", x: 20, y: 30, icon: "laptop", status: "active" },
    { id: "b", x: 50, y: 20, icon: "server", status: "active" },
    { id: "c", x: 80, y: 35, icon: "phone", status: "active" },
    { id: "d", x: 35, y: 60, icon: "monitor", status: "active" },
    { id: "e", x: 65, y: 65, icon: "laptop", status: "active" },
    { id: "f", x: 50, y: 85, icon: "phone", status: "active" },
  ];

  const initialConnections = [
    ["a", "b"],
    ["b", "c"],
    ["a", "d"],
    ["b", "d"],
    ["b", "e"],
    ["c", "e"],
    ["d", "e"],
    ["d", "f"],
    ["e", "f"],
  ];

  const failingNodeId = "b";
  const newNode: Node = {
    id: "g",
    x: 15,
    y: 75,
    icon: "phone",
    status: "joining",
  };
  const newConnections = [
    ["g", "a"],
    ["g", "d"],
    ["g", "f"],
  ];

  let nodes = $derived.by(() => {
    const result: Node[] = [];

    for (const node of initialNodes) {
      if (node.id === failingNodeId) {
        if (scrollProgress < 0.3) {
          result.push({ ...node, status: "active" });
        } else if (scrollProgress < 0.5) {
          result.push({ ...node, status: "failing" });
        } else {
          result.push({ ...node, status: "dead" });
        }
      } else {
        result.push({ ...node, status: "active" });
      }
    }

    if (scrollProgress > 0.62) {
      result.push({
        ...newNode,
        status: scrollProgress > 0.75 ? "active" : "joining",
      });
    }

    return result;
  });

  let connections = $derived.by(() => {
    const result: { from: string; to: string; opacity: number }[] = [];

    for (const [from, to] of initialConnections) {
      const involvesFailingNode =
        from === failingNodeId || to === failingNodeId;

      if (involvesFailingNode) {
        if (scrollProgress < 0.3) {
          result.push({ from, to, opacity: 1 });
        } else if (scrollProgress < 0.5) {
          const fadeProgress = (scrollProgress - 0.3) / 0.2;
          result.push({ from, to, opacity: 1 - fadeProgress });
        }
      } else {
        result.push({ from, to, opacity: 1 });
      }
    }

    if (scrollProgress > 0.66) {
      const fadeProgress = Math.min(1, (scrollProgress - 0.66) / 0.2);
      for (const [from, to] of newConnections) {
        result.push({ from, to, opacity: fadeProgress });
      }
    }

    return result;
  });

  function getNodePos(id: string): { x: number; y: number } | null {
    const node = nodes.find((n) => n.id === id);
    return node ? { x: node.x, y: node.y } : null;
  }

  let phase = $derived.by(() => {
    if (scrollProgress < 0.3) return "healthy";
    if (scrollProgress < 0.62) return "failure";
    if (scrollProgress < 0.8) return "recovery";
    return "restored";
  });

  const smooth = (x: number) => {
    const c = Math.max(0, Math.min(1, x));
    return c * c * (3 - 2 * c);
  };

  const packetPath = [
    {
      from: { x: 20, y: 30 },
      to: { x: 39.5, y: 23.5 },
      start: 0.05,
      end: 0.3,
    },
    {
      from: { x: 39.5, y: 23.5 },
      to: { x: 20, y: 30 },
      start: 0.3,
      end: 0.5,
    },
    { from: { x: 20, y: 30 }, to: { x: 35, y: 60 }, start: 0.5, end: 0.62 },
    { from: { x: 35, y: 60 }, to: { x: 65, y: 65 }, start: 0.62, end: 0.74 },
    { from: { x: 65, y: 65 }, to: { x: 80, y: 35 }, start: 0.74, end: 0.88 },
  ];

  let packet = $derived.by(() => {
    for (const seg of packetPath) {
      if (scrollProgress <= seg.end) {
        const t = smooth((scrollProgress - seg.start) / (seg.end - seg.start));
        return {
          x: seg.from.x + (seg.to.x - seg.from.x) * t,
          y: seg.from.y + (seg.to.y - seg.from.y) * t,
        };
      }
    }
    return { x: 80, y: 35 };
  });

  let rerouting = $derived(scrollProgress >= 0.3 && scrollProgress < 0.5);
  let delivered = $derived(scrollProgress > 0.88);

  onMount(() => {
    const handleScroll = () => {
      if (!containerElement) return;
      const rect = containerElement.getBoundingClientRect();
      const scrollableDistance = rect.height - window.innerHeight;
      const scrolled = -rect.top;
      scrollProgress = Math.max(0, Math.min(1, scrolled / scrollableDistance));
    };

    window.addEventListener("scroll", handleScroll, { passive: true });
    handleScroll();
    return () => window.removeEventListener("scroll", handleScroll);
  });
</script>

<section
  id="decentralisation"
  bind:this={containerElement}
  class="relative h-[300vh]"
>
  <div
    class="sticky top-0 flex h-screen items-center justify-center overflow-hidden bg-kursal-900 pt-16 transition-colors duration-700"
  >
    <!-- CRT lines -->
    <div
      class="pointer-events-none absolute inset-0 opacity-[0.035]"
      style="background-image: repeating-linear-gradient(to bottom, var(--color-kursal-50) 0px, var(--color-kursal-50) 1px, transparent 1px, transparent 3px);"
    ></div>

    <div class="relative z-10 w-full max-w-6xl px-4 md:px-6">
      <div class="mb-2 text-center md:mb-4" use:reveal>
        <div
          class="mb-4 inline-flex items-center gap-2 font-mono text-sm transition-colors duration-500 {phase ===
          'failure'
            ? 'text-party-400'
            : 'text-accent-400'}"
        >
          {#if phase === "failure"}
            <WifiOff size={18} />
            <span>Relay Seized</span>
          {:else}
            <Wifi size={18} />
            <span>Network Active</span>
          {/if}
        </div>

        <h2
          class="mb-3 font-mono text-2xl font-bold text-kursal-50 md:text-4xl"
        >
          {#if phase === "healthy"}
            Decentralized Network
          {:else if phase === "failure"}
            A Relay Got Seized
          {:else if phase === "recovery"}
            <span class="text-accent-400">New Node Joining...</span>
          {:else}
            <span class="text-accent-400">Network Still Up</span>
          {/if}
        </h2>
        <p class="mx-auto max-w-xl text-sm text-kursal-300 md:text-lg">
          {#if phase === "healthy"}
            Data flows encrypted through a resilient mesh
          {:else if phase === "failure"}
            A relay was taken down, but your packet just reroutes
          {:else if phase === "recovery"}
            New nodes join automatically to maintain resilience
          {:else}
            That's the power of decentralization
          {/if}
        </p>
      </div>

      <div class="relative mx-auto aspect-[16/10] w-full max-w-3xl">
        <svg
          class="absolute inset-0 h-full w-full"
          viewBox="0 0 100 100"
          preserveAspectRatio="none"
        >
          {#each connections as conn (conn.from + "-" + conn.to)}
            {@const fromPos = getNodePos(conn.from)}
            {@const toPos = getNodePos(conn.to)}
            {#if fromPos && toPos}
              <line
                x1={fromPos.x}
                y1={fromPos.y}
                x2={toPos.x}
                y2={toPos.y}
                stroke="rgba(77, 141, 255, {conn.opacity * 0.55})"
                stroke-width="0.3"
                class="transition-all duration-500"
              />
              {#if conn.opacity > 0.5}
                <circle r="0.8" fill="rgba(77, 141, 255, {conn.opacity})">
                  <animateMotion
                    dur="2s"
                    repeatCount="indefinite"
                    path="M{fromPos.x},{fromPos.y} L{toPos.x},{toPos.y}"
                  />
                </circle>
              {/if}
            {/if}
          {/each}
        </svg>

        {#each nodes as node (node.id)}
          <div
            class="absolute -translate-x-1/2 -translate-y-1/2 transform transition-all duration-700"
            style="left: {node.x}%; top: {node.y}%; opacity: {node.status ===
            'dead'
              ? 0.5
              : node.status === 'joining'
                ? 0.7
                : 1}; scale: {node.status === 'joining' ? 0.8 : 1}"
          >
            <div
              class="relative flex h-10 w-10 items-center justify-center rounded-sm transition-all duration-500 sm:h-12 sm:w-12 lg:h-16 lg:w-16 {node.status ===
              'failing'
                ? 'animate-pulse border-2 border-party-500 bg-party-500/20'
                : node.status === 'dead'
                  ? 'border-2 border-party-600/40 bg-kursal-800'
                  : node.status === 'joining'
                    ? 'border-2 border-accent-500 bg-accent-500/20'
                    : 'border-2 border-accent-500/50 bg-kursal-800'}"
            >
              {#if node.icon === "server"}
                <Server
                  class="h-5 w-5 sm:h-6 sm:w-6 lg:h-8 lg:w-8 {node.status ===
                  'dead'
                    ? 'text-kursal-500'
                    : node.status === 'failing'
                      ? 'text-party-400'
                      : 'text-accent-400'}"
                />
              {:else if node.icon === "phone"}
                <Smartphone
                  class="h-5 w-5 sm:h-6 sm:w-6 lg:h-8 lg:w-8 {node.status ===
                  'dead'
                    ? 'text-kursal-500'
                    : node.status === 'joining'
                      ? 'text-accent-400'
                      : 'text-accent-400'}"
                />
              {:else if node.icon === "laptop"}
                <Laptop
                  class="h-5 w-5 sm:h-6 sm:w-6 lg:h-8 lg:w-8 {node.status ===
                  'dead'
                    ? 'text-kursal-500'
                    : 'text-accent-400'}"
                />
              {:else if node.icon === "monitor"}
                <Monitor
                  class="h-5 w-5 sm:h-6 sm:w-6 lg:h-8 lg:w-8 {node.status ===
                  'dead'
                    ? 'text-kursal-500'
                    : 'text-accent-400'}"
                />
              {/if}

              {#if node.status === "dead"}
                <div class="absolute inset-0 flex items-center justify-center">
                  <div
                    class="absolute h-0.5 w-full rotate-45 bg-party-500"
                  ></div>
                  <div
                    class="absolute h-0.5 w-full -rotate-45 bg-party-500"
                  ></div>
                </div>
                <span
                  class="stamp absolute -bottom-5 left-1/2 -translate-x-1/2 -rotate-6 text-[0.5rem] whitespace-nowrap text-party-500"
                  >Seized</span
                >
              {/if}
            </div>
          </div>
        {/each}

        <div
          class="absolute z-10 -translate-x-1/2 transition-transform duration-300 {delivered
            ? '-translate-y-[170%]'
            : '-translate-y-1/2'}"
          style="left: {packet.x}%; top: {packet.y}%"
        >
          <div
            class="flex items-center gap-1.5 rounded-md border bg-kursal-950 px-2 py-1 font-mono text-[0.65rem] whitespace-nowrap sm:text-xs {delivered
              ? 'border-accent-500 text-accent-400'
              : rerouting
                ? 'border-party-500/70 text-party-400 shadow-[0_0_18px_-4px] shadow-party-500/50'
                : 'border-accent-500/60 text-accent-400 shadow-[0_0_18px_-4px] shadow-accent-500/50'}"
          >
            {#if delivered}
              <Check size={12} />
              delivered
            {:else}
              <Lock size={12} />
              8f3a c21d
            {/if}
          </div>
        </div>
      </div>

      <div class="mt-8 flex justify-center">
        <div class="h-1 w-48 overflow-hidden bg-kursal-700">
          <div
            class="h-full transition-colors duration-300 {phase === 'failure'
              ? 'bg-party-500'
              : 'bg-accent-500'}"
            style="width: {scrollProgress *
              100}%; transition: width 0.05s linear, background-color 0.3s ease"
          ></div>
        </div>
      </div>
    </div>
  </div>
</section>
