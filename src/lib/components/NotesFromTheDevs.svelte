<script lang="ts">
  import { Heart } from "lucide-svelte";
  import { reveal } from "$lib/reveal";
</script>

<section class="bg-kursal-900 py-12">
  <div class="mx-auto max-w-3xl px-6">
    <div
      use:reveal
      class="rounded-sm border border-l-2 border-kursal-700 border-l-accent-500 bg-kursal-800 p-7"
    >
      <h3
        class="mb-3 flex items-center gap-2 font-mono text-sm text-accent-400"
      >
        <span class="text-kursal-500">#</span>
        A Note from the Devs
        <Heart class="h-4 w-4 fill-accent-500/30 text-accent-500" />
      </h3>
      <p class="leading-relaxed text-kursal-200">
        Thank you so much for the interest! We're a small team of students and
        we love open source! If you enjoy Kursal, let us know!
      </p>
    </div>
  </div>
</section>
