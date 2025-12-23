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
  class="relative h-[300vh]"
>
  <div
    class="sticky top-0 h-screen flex items-center justify-center overflow-hidden transition-colors duration-700 pt-16"
    style="background: {phase === 'failure'
      ? 'radial-gradient(ellipse at center, rgba(239, 68, 68, 0.12) 0%, rgba(10, 13, 20, 1) 70%)'
      : 'radial-gradient(ellipse at center, rgba(91, 141, 239, 0.12) 0%, rgba(10, 13, 20, 1) 70%)'}"
  >
    <div class="max-w-6xl w-full px-4 md:px-6 relative z-10">
      <div class="text-center mb-2 md:mb-4">
        <div
          class="inline-flex items-center gap-2 px-4 py-2 rounded-full mb-4 transition-all duration-500 {phase ===
          'failure'
            ? 'bg-red-500/20 text-red-400'
            : 'bg-accent-500/20 text-accent-400'}"
        >
          {#if phase === "failure"}
            <WifiOff size={20} />
            <span class="font-medium">Node Offline</span>
          {:else}
            <Wifi size={20} />
            <span class="font-medium">Network Active</span>
          {/if}
        </div>

        <h2 class="text-2xl md:text-4xl font-bold text-kursal-50 mb-3">
          {#if phase === "healthy"}
            Decentralized Network
          {:else if phase === "failure"}
            Node Went Offline
          {:else if phase === "recovery"}
            <span class="text-accent-400">New Node Joining...</span>
          {:else}
            <span class="text-green-400">Network Still Up</span>
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
                stroke="rgba(91, 141, 239, {conn.opacity * 0.6})"
                stroke-width="0.3"
                class="transition-all duration-500"
              />
              {#if conn.opacity > 0.5}
                <circle r="0.8" fill="rgba(91, 141, 239, {conn.opacity})">
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
              ? 0.3
              : node.status === 'joining'
                ? 0.7
                : 1}; scale: {node.status === 'joining' ? 0.8 : 1}"
          >
            <div
              class="absolute -inset-3 rounded-full blur-xl transition-all duration-500 {node.status ===
              'failing'
                ? 'bg-red-500/50'
                : node.status === 'dead'
                  ? 'bg-kursal-600/30'
                  : node.status === 'joining'
                    ? 'bg-green-500/40'
                    : 'bg-accent-500/30'}"
            ></div>

            <div
              class="relative w-10 h-10 sm:w-12 sm:h-12 lg:w-16 lg:h-16 rounded-full flex items-center justify-center transition-all duration-500 {node.status ===
              'failing'
                ? 'bg-red-500 shadow-lg shadow-red-500/50 animate-pulse'
                : node.status === 'dead'
                  ? 'bg-kursal-600'
                  : node.status === 'joining'
                    ? 'bg-green-500 shadow-lg shadow-green-500/50'
                    : 'bg-kursal-700 border-2 border-accent-500/50 shadow-lg shadow-accent-500/20'}"
            >
              {#if node.icon === "server"}
                <Server
                  class="w-5 h-5 sm:w-6 sm:h-6 lg:w-8 lg:h-8 {node.status ===
                  'dead'
                    ? 'text-kursal-400'
                    : 'text-white'}"
                />
              {:else if node.icon === "phone"}
                <Smartphone
                  class="w-5 h-5 sm:w-6 sm:h-6 lg:w-8 lg:h-8 {node.status ===
                  'dead'
                    ? 'text-kursal-400'
                    : 'text-white'}"
                />
              {:else if node.icon === "laptop"}
                <Laptop
                  class="w-5 h-5 sm:w-6 sm:h-6 lg:w-8 lg:h-8 {node.status ===
                  'dead'
                    ? 'text-kursal-400'
                    : 'text-white'}"
                />
              {:else if node.icon === "monitor"}
                <Monitor
                  class="w-5 h-5 sm:w-6 sm:h-6 lg:w-8 lg:h-8 {node.status ===
                  'dead'
                    ? 'text-kursal-400'
                    : 'text-white'}"
                />
              {/if}

              {#if node.status === "dead"}
                <div class="absolute inset-0 flex items-center justify-center">
                  <div class="w-full h-0.5 bg-red-500 rotate-45 absolute"></div>
                  <div
                    class="w-full h-0.5 bg-red-500 -rotate-45 absolute"
                  ></div>
                </div>
              {/if}
            </div>
          </div>
        {/each}
      </div>

      <div class="flex justify-center mt-8">
        <div class="w-48 h-1.5 bg-kursal-700 rounded-full overflow-hidden">
          <div
            class="h-full rounded-full {phase === 'failure'
              ? 'bg-red-500'
              : phase === 'restored'
                ? 'bg-green-500'
                : 'bg-accent-500'}"
            style="width: {scrollProgress *
              100}%; transition: width 0.05s linear, background-color 0.3s ease"
          ></div>
        </div>
      </div>
    </div>
  </div>
</section>
