<script lang="ts">
  import { ArrowRight, Check } from "lucide-svelte";
  import { LISTMONK_LIST_UUID, LISTMONK_URL, EXPECTEDTIME } from "$lib/const";
  import { reveal } from "$lib/reveal";

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

<section id="notify" class="py-20 bg-kursal-800 border-y border-kursal-700">
  <div class="max-w-2xl mx-auto px-6 text-center" use:reveal>
    <div
      class="inline-flex items-center gap-2 font-mono text-sm text-kursal-300 mb-6"
    >
      <span class="h-2 w-2 rounded-full bg-accent-500"></span>
      {EXPECTEDTIME}
    </div>

    <h2 class="font-mono text-3xl md:text-4xl font-bold text-kursal-50 mb-4">
      One Release, One Email
    </h2>

    <p class="text-kursal-300 text-lg mb-8 max-w-xl mx-auto">
      Get notified when Kursal launches its first beta. As soon as this
      notification is sent, your email will be removed from our records.
    </p>

    <div
      class="bg-accent-500/[0.07] border-l-2 border-accent-500 rounded-sm p-4 mb-8 max-w-xl mx-auto text-left"
    >
      <p class="text-kursal-200 text-sm leading-relaxed">
        <span class="font-mono text-accent-400 font-semibold"
          >Prototype Launched!</span
        >
        We just released a very early-stage prototype. It is highly experimental and
        very buggy, but you can
        <a
          href="/download"
          class="text-accent-400 underline underline-offset-2 font-medium hover:text-accent-300 transition-colors"
          >download it here</a
        >.
      </p>
    </div>

    {#if status === "success"}
      <div
        class="bg-kursal-900 border border-accent-500/40 rounded-sm p-6 max-w-md mx-auto text-left font-mono"
      >
        <div class="flex items-center gap-3 text-accent-400">
          <Check size={22} />
          <span class="text-lg font-medium">You're on the list!</span>
        </div>
        <p class="text-kursal-300 mt-3 text-sm leading-relaxed">
          Please click the confirmation email you've received. Check your spam
          :p
          <br /><br />
          We'll email you when Kursal is ready. Thank you for your interest!
        </p>
      </div>
    {:else}
      <form onsubmit={handleSubmit} class="max-w-md mx-auto">
        <div class="flex flex-col sm:flex-row gap-3">
          <div class="flex-1 relative font-mono">
            <span
              class="absolute left-4 top-1/2 -translate-y-1/2 text-accent-500 select-none"
              aria-hidden="true">&gt;</span
            >
            <input
              type="email"
              bind:value={email}
              placeholder="enter your email"
              aria-label="Email address"
              class="w-full pl-9 pr-4 py-3 bg-kursal-900 border border-kursal-600 rounded-sm text-kursal-50 placeholder:text-kursal-500 focus:outline-none focus:border-accent-500 transition-colors"
              disabled={status === "loading"}
            />
          </div>
          <button
            type="submit"
            disabled={status === "loading"}
            class="group font-mono px-6 py-3 bg-accent-500 hover:bg-accent-400 disabled:opacity-50 disabled:cursor-not-allowed text-kursal-950 font-semibold rounded-sm transition-colors flex items-center justify-center gap-2"
          >
            {#if status === "loading"}
              <div
                class="w-5 h-5 border-2 border-kursal-950/30 border-t-kursal-950 rounded-full animate-spin"
              ></div>
            {:else}
              <span
                class="text-kursal-950/50 transition-transform group-hover:-translate-x-0.5"
                >[</span
              >
              <span>Notify Me</span>
              <span
                class="text-kursal-950/50 transition-transform group-hover:translate-x-0.5"
                >]</span
              >
              <ArrowRight size={18} />
            {/if}
          </button>
        </div>

        {#if status === "error"}
          <p class="font-mono text-party-400 text-sm mt-2 text-left">
            ! {errorMessage}
          </p>
        {/if}
      </form>

      <p class="font-mono text-kursal-400 text-xs mt-4">
        Unsubscribe anytime via the confirmation email.
      </p>
    {/if}
  </div>
</section>
