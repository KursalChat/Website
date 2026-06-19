<script lang="ts">
  import { onMount } from "svelte";
  import {
    Server,
    Smartphone,
    Laptop,
    Monitor,
    Wifi,
    WifiOff,
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
        if (scrollProgress < 0.25) {
          result.push({ ...node, status: "active" });
        } else if (scrollProgress < 0.4) {
          result.push({ ...node, status: "failing" });
        } else {
          result.push({ ...node, status: "dead" });
        }
      } else {
        result.push({ ...node, status: "active" });
      }
    }

    if (scrollProgress > 0.55) {
      result.push({
        ...newNode,
        status: scrollProgress > 0.7 ? "active" : "joining",
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
        if (scrollProgress < 0.25) {
          result.push({ from, to, opacity: 1 });
        } else if (scrollProgress < 0.4) {
          const fadeProgress = (scrollProgress - 0.25) / 0.15;
          result.push({ from, to, opacity: 1 - fadeProgress });
        }
      } else {
        result.push({ from, to, opacity: 1 });
      }
    }

    if (scrollProgress > 0.6) {
      const fadeProgress = Math.min(1, (scrollProgress - 0.6) / 0.2);
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
    if (scrollProgress < 0.25) return "healthy";
    if (scrollProgress < 0.55) return "failure";
    if (scrollProgress < 0.75) return "recovery";
    return "restored";
  });

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
  class="relative h-[240vh]"
>
  <div
    class="sticky top-0 h-screen flex items-center justify-center overflow-hidden transition-colors duration-700 pt-16 bg-kursal-900"
  >
    <!-- CRT lines -->
    <div
      class="pointer-events-none absolute inset-0 opacity-[0.035]"
      style="background-image: repeating-linear-gradient(to bottom, var(--color-kursal-50) 0px, var(--color-kursal-50) 1px, transparent 1px, transparent 3px);"
    ></div>

    <div class="max-w-6xl w-full px-4 md:px-6 relative z-10">
      <div class="text-center mb-2 md:mb-4" use:reveal>
        <div
          class="inline-flex items-center gap-2 font-mono text-sm mb-4 transition-colors duration-500 {phase ===
          'failure'
            ? 'text-party-400'
            : 'text-accent-400'}"
        >
          {#if phase === "failure"}
            <WifiOff size={18} />
            <span>Node Offline</span>
          {:else}
            <Wifi size={18} />
            <span>Network Active</span>
          {/if}
        </div>

        <h2
          class="font-mono text-2xl md:text-4xl font-bold text-kursal-50 mb-3"
        >
          {#if phase === "healthy"}
            Decentralized Network
          {:else if phase === "failure"}
            Node Went Offline
          {:else if phase === "recovery"}
            <span class="text-accent-400">New Node Joining...</span>
          {:else}
            <span class="text-accent-400">Network Still Up</span>
          {/if}
        </h2>
        <p class="text-kursal-300 text-sm md:text-lg max-w-xl mx-auto">
          {#if phase === "healthy"}
            Data flows encrypted through a resilient mesh
          {:else if phase === "failure"}
            A node went down, but the network keeps running
          {:else if phase === "recovery"}
            New nodes join automatically to maintain resilience
          {:else}
            That's the power of decentralization
          {/if}
        </p>
      </div>

      <div class="relative w-full aspect-[16/10] max-w-3xl mx-auto">
        <svg
          class="absolute inset-0 w-full h-full"
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
            class="absolute transform -translate-x-1/2 -translate-y-1/2 transition-all duration-700"
            style="left: {node.x}%; top: {node.y}%; opacity: {node.status ===
            'dead'
              ? 0.5
              : node.status === 'joining'
                ? 0.7
                : 1}; scale: {node.status === 'joining' ? 0.8 : 1}"
          >
            <div
              class="relative w-10 h-10 sm:w-12 sm:h-12 lg:w-16 lg:h-16 rounded-sm flex items-center justify-center transition-all duration-500 {node.status ===
              'failing'
                ? 'bg-party-500/20 border-2 border-party-500 animate-pulse'
                : node.status === 'dead'
                  ? 'bg-kursal-800 border-2 border-party-600/40'
                  : node.status === 'joining'
                    ? 'bg-accent-500/20 border-2 border-accent-500'
                    : 'bg-kursal-800 border-2 border-accent-500/50'}"
            >
              {#if node.icon === "server"}
                <Server
                  class="w-5 h-5 sm:w-6 sm:h-6 lg:w-8 lg:h-8 {node.status ===
                  'dead'
                    ? 'text-kursal-500'
                    : node.status === 'failing'
                      ? 'text-party-400'
                      : 'text-accent-400'}"
                />
              {:else if node.icon === "phone"}
                <Smartphone
                  class="w-5 h-5 sm:w-6 sm:h-6 lg:w-8 lg:h-8 {node.status ===
                  'dead'
                    ? 'text-kursal-500'
                    : node.status === 'joining'
                      ? 'text-accent-400'
                      : 'text-accent-400'}"
                />
              {:else if node.icon === "laptop"}
                <Laptop
                  class="w-5 h-5 sm:w-6 sm:h-6 lg:w-8 lg:h-8 {node.status ===
                  'dead'
                    ? 'text-kursal-500'
                    : 'text-accent-400'}"
                />
              {:else if node.icon === "monitor"}
                <Monitor
                  class="w-5 h-5 sm:w-6 sm:h-6 lg:w-8 lg:h-8 {node.status ===
                  'dead'
                    ? 'text-kursal-500'
                    : 'text-accent-400'}"
                />
              {/if}

              {#if node.status === "dead"}
                <div class="absolute inset-0 flex items-center justify-center">
                  <div
                    class="w-full h-0.5 bg-party-500 rotate-45 absolute"
                  ></div>
                  <div
                    class="w-full h-0.5 bg-party-500 -rotate-45 absolute"
                  ></div>
                </div>
                <span
                  class="stamp text-party-500 text-[0.5rem] absolute -bottom-5 left-1/2 -translate-x-1/2 -rotate-6 whitespace-nowrap"
                  >Offline</span
                >
              {/if}
            </div>
          </div>
        {/each}
      </div>

      <div class="flex justify-center mt-8">
        <div class="w-48 h-1 bg-kursal-700 overflow-hidden">
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
