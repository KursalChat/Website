<script lang="ts">
  import { Shield, Server, Eye, Code } from "lucide-svelte";

  const features = [
    {
      icon: Shield,
      title: "End-to-End Encrypted",
      description:
        "Messages are encrypted on your device and can only be read by the recipient. No one else can see them, not even us.",
    },
    {
      icon: Server,
      title: "Decentralized",
      description:
        "There exist no central Kursal server: no single point of failure or control. The network belongs to everyone.",
    },
    {
      icon: Eye,
      title: "No Tracking",
      description:
        "We don't collect analytics, metadata, or any information about your conversations or your usage.",
    },
    {
      icon: Code,
      title: "Open Source",
      description:
        "Fully transparent codebase. Audit the code yourself or contribute to the project. Even ideas are welcome!",
    },
  ];
</script>

<section id="features" class="py-24 bg-kursal-900">
  <div class="max-w-6xl mx-auto px-6">
    <div class="text-center mb-16">
      <h2 class="text-3xl md:text-4xl font-bold text-kursal-50 mb-4">
        Privacy by Design
      </h2>
      <p class="text-kursal-300 text-lg max-w-2xl mx-auto">
        Kursal is built from the ground up with privacy and security as the core
        principles. No compromises.
      </p>
    </div>

    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-2 gap-6">
      {#each features as feature}
        <div
          class="group p-6 bg-kursal-800 rounded-2xl border border-kursal-700 hover:border-kursal-500 transition-colors"
        >
          <div
            class="w-12 h-12 bg-kursal-700 group-hover:bg-accent-500/20 rounded-xl flex items-center justify-center mb-4 transition-colors"
          >
            <feature.icon size={24} class="text-accent-400" />
          </div>
          <h3 class="text-xl font-semibold text-kursal-50 mb-2">
            {feature.title}
          </h3>
          <p class="text-kursal-300">
            {feature.description}
          </p>
        </div>
      {/each}
    </div>
  </div>
</section>
