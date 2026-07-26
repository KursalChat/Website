<script lang="ts">
  import {
    Shield,
    Server,
    Eye,
    Code,
    Feather,
    ArrowUpRight,
  } from "lucide-svelte";
  import { reveal } from "$lib/reveal";
  import { repository, PAPER_URL } from "$lib/const";
  import { kursal, mb } from "$lib/footprint";

  type Feature = {
    icon: typeof Shield;
    flag: string;
    title: string;
    description: string;
    link: string;
    external: boolean;
    wide?: boolean;
    stats?: { value: string; label: string }[];
  };

  const features: Feature[] = [
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
    {
      icon: Feather,
      flag: "--lightweight",
      title: "Lightweight",
      description:
        "A fraction of what other chat apps reserve just to sit in your dock, measured against the ones you already have installed.",
      link: "/compare",
      external: false,
      wide: true,
      stats: [
        { value: `${mb(kursal.disk)} MB`, label: "installed" },
        { value: `${mb(kursal.ram)} MB`, label: "idle RAM" },
      ],
    },
  ];
</script>

<section id="features" class="bg-kursal-900 py-24">
  <div class="mx-auto max-w-6xl px-6">
    <div class="mb-12 text-center" use:reveal>
      <p class="mb-4 font-mono text-sm text-accent-400">~/features</p>
      <h2 class="mb-4 font-mono text-3xl font-bold text-kursal-50 md:text-4xl">
        Privacy by Design
      </h2>
      <p class="mx-auto max-w-2xl text-lg text-kursal-300">
        Kursal is built from the ground up with privacy and security as the core
        principles. No compromises.
      </p>
    </div>

    <div class="mb-10 overflow-x-auto" use:reveal={{ delay: 80 }}>
      <code
        class="flex flex-wrap justify-center gap-x-3 gap-y-1 px-4 font-mono text-xs text-kursal-400 sm:text-sm"
      >
        <span><span class="text-kursal-500">$</span> kursal</span>
        {#each features as feature}
          <span class="text-accent-400">{feature.flag}</span>
        {/each}
      </code>
    </div>

    <div class="grid grid-cols-1 gap-4 md:grid-cols-2">
      {#each features as feature, i}
        <a
          href={feature.link}
          target={feature.external ? "_blank" : undefined}
          rel={feature.external ? "noopener noreferrer" : undefined}
          use:reveal={{ delay: i * 70 }}
          class="group flex flex-col rounded-sm border border-kursal-700 bg-kursal-800 p-6 transition-all duration-200 hover:-translate-y-0.5 hover:border-accent-500/50 {feature.wide
            ? 'md:col-span-2'
            : ''}"
        >
          <div class="mb-4 flex items-center justify-between">
            <div
              class="flex h-10 w-10 items-center justify-center rounded-sm bg-kursal-700 transition-colors group-hover:bg-accent-500/15"
            >
              <feature.icon size={20} class="text-accent-400" />
            </div>
            <span class="font-mono text-sm text-accent-400/80"
              >{feature.flag}</span
            >
          </div>
          <h3 class="mb-2 font-mono text-xl font-semibold text-kursal-50">
            {feature.title}
          </h3>
          <p class="flex-1 leading-relaxed text-kursal-300">
            {feature.description}
          </p>
          {#if feature.stats}
            <div class="mt-5 flex gap-8 border-t border-kursal-700 pt-5">
              {#each feature.stats as stat}
                <div>
                  <div
                    class="font-mono text-2xl font-bold text-accent-400 tabular-nums md:text-3xl"
                  >
                    {stat.value}
                  </div>
                  <div class="mt-0.5 font-mono text-xs text-kursal-400">
                    {stat.label}
                  </div>
                </div>
              {/each}
            </div>
          {/if}
          <span
            class="mt-4 inline-flex items-center gap-1 font-mono text-xs text-kursal-400 transition-colors group-hover:text-accent-400"
          >
            learn more <ArrowUpRight
              size={13}
              class="transition-transform group-hover:translate-x-0.5 group-hover:-translate-y-0.5"
            />
          </span>
        </a>
      {/each}
    </div>
  </div>
</section>
