<script lang="ts">
  import { ArrowRight, Check } from "lucide-svelte";
  import { LISTMONK_LIST_UUID, LISTMONK_URL, RELEASE_STATUS } from "$lib/const";
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

<section id="notify" class="border-y border-kursal-700 bg-kursal-800 py-20">
  <div class="mx-auto max-w-2xl px-6 text-center" use:reveal>
    <div
      class="mb-6 inline-flex items-center gap-2 font-mono text-sm text-kursal-300"
    >
      <span class="h-2 w-2 rounded-full bg-accent-500"></span>
      {RELEASE_STATUS}
    </div>

    <h2 class="mb-4 font-mono text-3xl font-bold text-kursal-50 md:text-4xl">
      One Release, One Email
    </h2>

    <p class="mx-auto mb-8 max-w-xl text-lg text-kursal-300">
      Get notified when Kursal ships its first stable release. As soon as this
      notification is sent, your email will be removed from our records.
    </p>

    <div
      class="mx-auto mb-8 max-w-xl rounded-sm border-l-2 border-accent-500 bg-accent-500/[0.07] p-4 text-left"
    >
      <p class="text-sm leading-relaxed text-kursal-200">
        <span class="font-mono font-semibold text-accent-400"
          >Beta Launched!</span
        >
        The Kursal public beta is out. Expect some rough edges, but you can
        <a
          href="/download"
          class="font-medium text-accent-400 underline underline-offset-2 transition-colors hover:text-accent-300"
          >download it now</a
        >.
      </p>
    </div>

    {#if status === "success"}
      <div
        class="mx-auto max-w-md rounded-sm border border-accent-500/40 bg-kursal-900 p-6 text-left font-mono"
      >
        <div class="flex items-center gap-3 text-accent-400">
          <Check size={22} />
          <span class="text-lg font-medium">You're on the list!</span>
        </div>
        <p class="mt-3 text-sm leading-relaxed text-kursal-300">
          Please click the confirmation email you've received. Check your spam
          :p
          <br /><br />
          We'll email you when the stable release is ready. Thank you for your
          interest!
        </p>
      </div>
    {:else}
      <form onsubmit={handleSubmit} class="mx-auto max-w-md">
        <div class="flex flex-col gap-3 sm:flex-row">
          <div class="relative flex-1 font-mono">
            <span
              class="absolute top-1/2 left-4 -translate-y-1/2 text-accent-500 select-none"
              aria-hidden="true">&gt;</span
            >
            <input
              type="email"
              bind:value={email}
              placeholder="enter your email"
              aria-label="Email address"
              class="w-full rounded-sm border border-kursal-600 bg-kursal-900 py-3 pr-4 pl-9 text-kursal-50 transition-colors placeholder:text-kursal-500 focus:border-accent-500 focus:outline-none"
              disabled={status === "loading"}
            />
          </div>
          <button
            type="submit"
            disabled={status === "loading"}
            class="group flex items-center justify-center gap-2 rounded-sm bg-accent-500 px-6 py-3 font-mono font-semibold text-kursal-950 transition-colors hover:bg-accent-400 disabled:cursor-not-allowed disabled:opacity-50"
          >
            {#if status === "loading"}
              <div
                class="h-5 w-5 animate-spin rounded-full border-2 border-kursal-950/30 border-t-kursal-950"
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
          <p class="mt-2 text-left font-mono text-sm text-party-400">
            ! {errorMessage}
          </p>
        {/if}
      </form>

      <p class="mt-4 font-mono text-xs text-kursal-400">
        Unsubscribe anytime via the confirmation email.
      </p>
    {/if}
  </div>
</section>
