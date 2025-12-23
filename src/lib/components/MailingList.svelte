<script lang="ts">
  import { Mail, ArrowRight, Check } from "lucide-svelte";
  import { LISTMONK_LIST_UUID, LISTMONK_URL } from "$lib/const";

  let email = $state("");
  let status = $state<"idle" | "loading" | "success" | "error">("idle");
  let errorMessage = $state("");

  function validateEmail(email: string): boolean {
    return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email);
  }

  async function handleSubmit(e: Event) {
    e.preventDefault();

    if (!validateEmail(email)) {
      status = "error";
      errorMessage = "Please enter a valid email address";
      return;
    }

    status = "loading";

    try {
      const response = await fetch(`${LISTMONK_URL}/api/public/subscription`, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          email: email,
          list_uuids: [LISTMONK_LIST_UUID],
        }),
      });

      if (response.ok) {
        status = "success";
      } else {
        status = "error";
        errorMessage =
          "Something went wrong. Please try again. (" +
          (await response.text()) +
          ")";
      }
    } catch {
      status = "error";
      errorMessage = "Could not connect. Please try again later.";
    }
  }
</script>

<section id="notify" class="py-16 bg-kursal-900 relative overflow-hidden">
  <div
    class="absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 w-[500px] h-[500px] bg-gradient-radial from-accent-500/8 via-transparent to-transparent rounded-full blur-3xl pointer-events-none"
  ></div>

  <div class="max-w-3xl mx-auto px-6 text-center relative z-10">
    <div
      class="inline-flex items-center gap-2 bg-kursal-700 px-4 py-2 rounded-full mb-6"
    >
      <Mail size={18} class="text-accent-400" />
      <span class="text-kursal-200 text-sm font-medium"
        >Expected April 2026</span
      >
    </div>

    <h2 class="text-3xl md:text-4xl font-bold text-kursal-50 mb-4">
      One Release, One Email
    </h2>

    <p class="text-kursal-300 text-lg mb-8 max-w-xl mx-auto">
      Get notified when Kursal launches it's first beta. As soon as this
      notification is sent, your email will be removed from our records.
    </p>

    {#if status === "success"}
      <div
        class="bg-green-900/30 border border-green-700 rounded-xl p-6 max-w-md mx-auto"
      >
        <div class="flex items-center justify-center gap-3 text-green-400">
          <Check size={24} />
          <span class="text-lg font-medium">You're on the list!</span>
        </div>
        <p class="text-green-300/80 mt-2 text-sm">
          Please click the confirmation email you've received. Check your spam
          :p
          <br /><br />
          We'll email you when Kursal is ready. Thank you for your interest!
        </p>
      </div>
    {:else}
      <form onsubmit={handleSubmit} class="max-w-md mx-auto">
        <div class="flex flex-col sm:flex-row gap-3">
          <div class="flex-1 relative">
            <Mail
              size={18}
              class="absolute left-4 top-1/2 -translate-y-1/2 text-kursal-400"
            />
            <input
              type="email"
              bind:value={email}
              placeholder="Enter your email"
              class="w-full pl-11 pr-4 py-3 bg-kursal-700 border border-kursal-600 rounded-xl text-kursal-50 placeholder:text-kursal-400 focus:outline-none focus:border-accent-500 focus:ring-1 focus:ring-accent-500 transition-colors"
              disabled={status === "loading"}
            />
          </div>
          <button
            type="submit"
            disabled={status === "loading"}
            class="px-6 py-3 bg-accent-500 hover:bg-accent-400 disabled:opacity-50 disabled:cursor-not-allowed text-white font-medium rounded-xl transition-colors flex items-center justify-center gap-2"
          >
            {#if status === "loading"}
              <div
                class="w-5 h-5 border-2 border-white/30 border-t-white rounded-full animate-spin"
              ></div>
            {:else}
              <span>Notify Me</span>
              <ArrowRight size={18} />
            {/if}
          </button>
        </div>

        {#if status === "error"}
          <p class="text-red-400 text-sm mt-2 text-left">{errorMessage}</p>
        {/if}
      </form>

      <p class="text-kursal-400 text-sm mt-4">
        Unsubscribe anytime via the confirmation email.
      </p>
    {/if}
  </div>
</section>
