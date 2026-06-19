<script lang="ts">
  import { Heart } from "lucide-svelte";
  import { reveal } from "$lib/reveal";
</script>

<section class="py-12 bg-kursal-900">
  <div class="max-w-3xl mx-auto px-6">
    <div
      use:reveal
      class="bg-kursal-800 border border-kursal-700 border-l-2 border-l-accent-500 rounded-sm p-7"
    >
      <h3
        class="font-mono text-sm text-accent-400 mb-3 flex items-center gap-2"
      >
        <span class="text-kursal-500">#</span>
        A Note from the Devs
        <Heart class="w-4 h-4 fill-accent-500/30 text-accent-500" />
      </h3>
      <p class="text-kursal-200 leading-relaxed">
        Thank you so much for the interest! We're a small team of students and
        we love open source! If you enjoy our prototype application, let us
        know!
      </p>
    </div>
  </div>
</section>
