<script lang="ts">
  import { Bell, FileText, ArrowDown } from "lucide-svelte";
  import { scrollTo } from "$lib/util";
  import { PAPER_URL } from "$lib/const";
</script>

<section
  class="min-h-screen flex flex-col pt-20 pb-12 relative overflow-hidden bg-kursal-950"
>
  <!-- Base gradient -->
  <div
    class="absolute inset-0 bg-gradient-to-b from-kursal-950 via-kursal-900 to-kursal-900"
  ></div>

  <!-- Noise texture overlay -->
  <div
    class="absolute inset-0 opacity-[0.015]"
    style="background-image: url('data:image/svg+xml,%3Csvg viewBox=%220 0 256 256%22 xmlns=%22http://www.w3.org/2000/svg%22%3E%3Cfilter id=%22noise%22%3E%3CfeTurbulence type=%22fractalNoise%22 baseFrequency=%220.9%22 numOctaves=%224%22 stitchTiles=%22stitch%22/%3E%3C/filter%3E%3Crect width=%22100%25%22 height=%22100%25%22 filter=%22url(%23noise)%22/%3E%3C/svg%3E');"
  ></div>

  <!-- Radial glow -->
  <div
    class="absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 w-[800px] h-[800px] bg-gradient-radial from-accent-500/8 via-accent-500/3 to-transparent rounded-full blur-3xl"
  ></div>

  <!-- Animated accent orb -->
  <div
    class="absolute top-1/3 right-1/4 w-72 h-72 bg-accent-500/6 rounded-full blur-[100px] animate-drift"
  ></div>

  <!-- Secondary orb -->
  <div
    class="absolute bottom-1/3 left-1/5 w-64 h-64 bg-indigo-500/5 rounded-full blur-[80px] animate-drift-reverse"
  ></div>

  <!-- Vignette effect -->
  <div
    class="absolute inset-0 bg-gradient-radial from-transparent via-transparent to-kursal-950/50"
  ></div>

  <div class="flex-1 flex items-center justify-center relative z-10">
    <div class="max-w-4xl mx-auto px-6 text-center">
      <div
        class="inline-flex items-center gap-2 bg-accent-500/15 backdrop-blur-sm text-accent-400 px-4 py-2 rounded-full mb-8 text-sm font-medium border border-accent-500/20"
      >
        <Bell size={16} />
        Expected April 2026
      </div>

      <div class="flex items-center justify-center gap-4 md:gap-6 mb-8">
        <img
          src="/icon.png"
          alt="Kursal"
          class="w-16 h-16 md:w-24 md:h-24 lg:w-28 lg:h-28 drop-shadow-[0_0_30px_rgba(59,130,246,0.3)] animate-float"
        />
        <h1
          class="text-5xl md:text-7xl lg:text-8xl font-bold text-white tracking-tight"
        >
          Kursal
        </h1>
      </div>

      <p
        class="text-2xl md:text-3xl lg:text-4xl font-semibold text-white mb-4 tracking-wide"
      >
        Big Brother <span class="text-accent-400">was</span> watching you.
      </p>

      <p
        class="text-base md:text-lg text-kursal-200 max-w-xl mx-auto mb-12 leading-relaxed"
      >
        Peer-to-peer, end-to-end encrypted messaging that puts you in control.
        No servers. No tracking. Just your private conversations.
      </p>

      <div class="flex flex-col sm:flex-row gap-4 justify-center mb-16">
        <button
          onclick={() => scrollTo("notify")}
          class="group inline-flex items-center justify-center gap-3 bg-accent-500 hover:bg-accent-400 text-white px-8 py-4 rounded-2xl font-semibold text-lg transition-all duration-300 shadow-[0_0_30px_rgba(59,130,246,0.3)] hover:shadow-[0_0_40px_rgba(59,130,246,0.5)] hover:scale-[1.02]"
        >
          <Bell size={20} class="group-hover:animate-wiggle" />
          Get Notified at Launch
        </button>

        <a
          href={PAPER_URL}
          target="_blank"
          class="inline-flex items-center justify-center gap-3 bg-kursal-800/80 backdrop-blur-sm hover:bg-kursal-700/80 text-kursal-100 px-8 py-4 rounded-2xl font-semibold text-lg transition-all duration-300 border border-kursal-700/50 hover:border-kursal-600 hover:scale-[1.02]"
        >
          <FileText size={20} />
          Read the Paper
        </a>
      </div>

      <div class="mt-16">
        <button
          onclick={() => scrollTo("animation")}
          class="inline-flex flex-col items-center gap-2 text-kursal-400 hover:text-kursal-300 transition-colors cursor-pointer animate-bounce"
        >
          <span class="text-sm font-medium">Learn more</span>
          <ArrowDown size={20} />
        </button>
      </div>
    </div>
  </div>
</section>

<style>
  @keyframes float {
    0%,
    100% {
      transform: translateY(0);
    }
    50% {
      transform: translateY(-8px);
    }
  }

  @keyframes drift {
    0%,
    100% {
      transform: translate(0, 0);
    }
    25% {
      transform: translate(20px, -20px);
    }
    50% {
      transform: translate(0, -10px);
    }
    75% {
      transform: translate(-20px, -20px);
    }
  }

  @keyframes drift-reverse {
    0%,
    100% {
      transform: translate(0, 0);
    }
    25% {
      transform: translate(-15px, 15px);
    }
    50% {
      transform: translate(0, 10px);
    }
    75% {
      transform: translate(15px, 15px);
    }
  }

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

  .animate-float {
    animation: float 5s ease-in-out infinite;
  }

  .animate-drift {
    animation: drift 20s ease-in-out infinite;
  }

  .animate-drift-reverse {
    animation: drift-reverse 25s ease-in-out infinite;
  }

  .bg-gradient-radial {
    background: radial-gradient(circle, var(--tw-gradient-stops));
  }

  :global(.group:hover .group-hover\:animate-wiggle) {
    animation: wiggle 0.5s ease-in-out;
  }
</style>
