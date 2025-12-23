<script lang="ts">
  import { Heart } from "lucide-svelte";
</script>

<section class="py-12 bg-kursal-950">
  <div class="max-w-3xl mx-auto px-6">
    <div
      class="bg-gradient-to-br from-kursal-900 to-kursal-950 border border-accent-500/30 rounded-2xl p-8 relative overflow-hidden shadow-2xl shadow-accent-500/5"
    >
      <div
        class="absolute -top-24 -right-24 w-48 h-48 bg-accent-500/10 rounded-full blur-3xl"
      ></div>

      <div
        class="relative z-10 flex flex-col sm:flex-row gap-6 items-center text-center sm:text-left"
      >
        <div
          class="w-14 h-14 shrink-0 bg-accent-500/10 rounded-full flex items-center justify-center text-accent-400 border border-accent-500/20"
        >
          <Heart class="w-7 h-7 fill-accent-500/20" />
        </div>

        <div class="flex-1">
          <h3 class="text-lg font-semibold text-kursal-50 mb-2">
            A Note from the Devs
          </h3>
          <p class="text-kursal-300">
            Thank you so much for the interest! We're a small team of students
            and we love open source! If you enjoy our prototype application, let
            us know!
          </p>
        </div>
      </div>
    </div>
  </div>
</section>
