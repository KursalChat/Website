<script lang="ts">
  import { Shield, Server, Eye, Code, ArrowUpRight } from "lucide-svelte";
  import { reveal } from "$lib/reveal";
  import { repository, PAPER_URL } from "$lib/const";

  const features = [
    {
      icon: Shield,
      flag: "--encrypted",
      title: "End-to-End Encrypted",
      description:
        "Messages are encrypted on your device and can only be read by the recipient. No one else can see them, not even us.",
      link: "/security",
      external: false,
    },
    {
      icon: Server,
      flag: "--decentralized",
      title: "Decentralized",
      description:
        "There exist no central Kursal server: no single point of failure or control. The network belongs to everyone.",
      link: PAPER_URL,
      external: true,
    },
    {
      icon: Eye,
      flag: "--no-tracking",
      title: "No Tracking",
      description:
        "We don't collect analytics, metadata, or any information about your conversations or your usage.",
      link: "/privacy",
      external: false,
    },
    {
      icon: Code,
      flag: "--open-source",
      title: "Open Source",
      description:
        "Fully transparent codebase. Audit the code yourself or contribute to the project. Even ideas are welcome!",
      link: repository,
      external: true,
    },
  ];
</script>

<section id="features" class="py-24 bg-kursal-900">
  <div class="max-w-6xl mx-auto px-6">
    <div class="text-center mb-12" use:reveal>
      <p class="font-mono text-sm text-accent-400 mb-4">~/features</p>
      <h2 class="font-mono text-3xl md:text-4xl font-bold text-kursal-50 mb-4">
        Privacy by Design
      </h2>
      <p class="text-kursal-300 text-lg max-w-2xl mx-auto">
        Kursal is built from the ground up with privacy and security as the core
        principles. No compromises.
      </p>
    </div>

    <div class="mb-10 overflow-x-auto" use:reveal={{ delay: 80 }}>
      <code
        class="font-mono text-xs sm:text-sm text-kursal-400 flex flex-wrap justify-center gap-x-3 gap-y-1 px-4"
      >
        <span><span class="text-kursal-500">$</span> kursal</span>
        {#each features as feature}
          <span class="text-accent-400">{feature.flag}</span>
        {/each}
      </code>
    </div>

    <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
      {#each features as feature, i}
        <a
          href={feature.link}
          target={feature.external ? "_blank" : undefined}
          rel={feature.external ? "noopener noreferrer" : undefined}
          use:reveal={{ delay: i * 70 }}
          class="group flex flex-col p-6 bg-kursal-800 rounded-sm border border-kursal-700 hover:border-accent-500/50 hover:-translate-y-0.5 transition-all duration-200"
        >
          <div class="flex items-center justify-between mb-4">
            <div
              class="w-10 h-10 bg-kursal-700 group-hover:bg-accent-500/15 rounded-sm flex items-center justify-center transition-colors"
            >
              <feature.icon size={20} class="text-accent-400" />
            </div>
            <span class="font-mono text-sm text-accent-400/80"
              >{feature.flag}</span
            >
          </div>
          <h3 class="font-mono text-xl font-semibold text-kursal-50 mb-2">
            {feature.title}
          </h3>
          <p class="text-kursal-300 leading-relaxed flex-1">
            {feature.description}
          </p>
          <span
            class="mt-4 inline-flex items-center gap-1 font-mono text-xs text-kursal-400 group-hover:text-accent-400 transition-colors"
          >
            learn more <ArrowUpRight
              size={13}
              class="group-hover:translate-x-0.5 group-hover:-translate-y-0.5 transition-transform"
            />
          </span>
        </a>
      {/each}
    </div>
  </div>
</section>
