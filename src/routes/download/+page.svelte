<script lang="ts">
  import { Monitor, Clock, Bell } from "lucide-svelte";
  import Navbar from "$lib/components/Navbar.svelte";
  import Footer from "$lib/components/Footer.svelte";
  import { SiApple, SiLinux } from "@icons-pack/svelte-simple-icons";

  const platforms = [
    {
      id: "mac",
      name: "macOS",
      icon: SiApple,
      description: "For macOS 11 (Big Sur) and later",
    },
    {
      id: "windows",
      name: "Windows",
      icon: Monitor, // thanks microsoft https://github.com/simple-icons/simple-icons/pull/10019
      description: "For Windows 10 and later",
    },
    {
      id: "linux",
      name: "Linux",
      icon: SiLinux,
      description: "AppImage for most distributions",
    },
  ];
</script>

<Navbar />

<main class="min-h-screen pt-24 pb-16 bg-kursal-900">
  <div class="max-w-4xl mx-auto px-6">
    <div class="text-center mb-12">
      <div
        class="inline-flex items-center gap-2 bg-accent-500/20 text-accent-400 px-4 py-2 rounded-full mb-6 text-sm font-medium"
      >
        <Clock size={16} />
        Expected April 2026
      </div>

      <h1 class="text-4xl md:text-5xl font-bold text-white mb-4">
        Download Kursal
      </h1>
      <p class="text-lg text-kursal-50 max-w-xl mx-auto">
        Oh, you're here early! We're working as hard as we can on Kursal. Sign
        up to be notified when it's ready.
      </p>
    </div>

    <div class="grid gap-6 opacity-60">
      {#each platforms as platform}
        <div
          class="flex items-center gap-6 p-6 bg-kursal-800 rounded-2xl border border-kursal-700"
        >
          <div
            class="w-16 h-16 bg-kursal-700 rounded-xl flex items-center justify-center"
          >
            <platform.icon size={32} class="text-kursal-400" />
          </div>

          <div class="flex-1">
            <h2 class="text-xl font-semibold text-white">
              {platform.name}
            </h2>
            <p class="text-kursal-100 text-sm mt-1">{platform.description}</p>
          </div>

          <div class="flex items-center gap-2 text-kursal-500">
            <Clock size={20} />
            <span class="font-medium">Soon</span>
          </div>
        </div>
      {/each}
    </div>

    <div
      class="mt-12 p-8 bg-kursal-800 rounded-2xl border border-accent-500/30 text-center"
    >
      <h3 class="text-xl font-semibold text-white mb-2">
        Get notified when we launch
      </h3>
      <p class="text-kursal-50 mb-6">
        Be the first to download Kursal when it's ready.
      </p>
      <a
        href="/#notify"
        class="inline-flex items-center gap-2 bg-accent-500 hover:bg-accent-400 text-white px-6 py-3 rounded-xl font-medium transition-colors"
      >
        <Bell size={18} />
        Sign up for updates
      </a>
    </div>
  </div>
</main>

<Footer />
