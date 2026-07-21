<script lang="ts">
  import { Check } from "lucide-svelte";
  import { LISTMONK_LEGAL_LIST_UUID, LISTMONK_URL } from "$lib/const";

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
          list_uuids: [LISTMONK_LEGAL_LIST_UUID],
        }),
      });

      if (response.ok) {
        status = "success";
      } else {
        status = "error";
        errorMessage =
          response.status === 429
            ? "Too many attempts. Please wait a moment and try again."
            : "Something went wrong. Please try again, or email us.";
      }
    } catch {
      status = "error";
      errorMessage = "Could not connect. Please try again later.";
    }
  }
</script>

<div class="mt-2 rounded-sm border border-kursal-700 bg-kursal-800/40 p-5">
  <h3 class="mb-2 font-mono text-base font-semibold text-kursal-50">
    Get told before a change takes effect
  </h3>

  {#if status === "success"}
    <div class="flex items-center gap-3 font-mono text-accent-400">
      <Check size={20} />
      <span class="text-sm">Confirm the email we just sent you.</span>
    </div>
  {:else}
    <p class="mb-4 text-sm leading-relaxed text-kursal-300">
      A separate list, used only to announce changes to these terms and to our
      privacy policy. Nothing else is ever sent to it. Unsubscribe anytime via
      the link in any email, and see our
      <a
        href="/privacy"
        class="text-accent-400 underline underline-offset-2 hover:text-accent-300"
        >Privacy Policy</a
      > for what we do with the address (spoiler: basically nothing).
    </p>

    <form onsubmit={handleSubmit} class="flex flex-col gap-3 sm:flex-row">
      <div class="relative flex-1 font-mono">
        <span
          class="absolute top-1/2 left-4 -translate-y-1/2 text-accent-500 select-none"
          aria-hidden="true">&gt;</span
        >
        <input
          type="email"
          bind:value={email}
          placeholder="enter your email"
          aria-label="Email address for policy updates"
          class="w-full rounded-sm border border-kursal-600 bg-kursal-900 py-2.5 pr-4 pl-9 text-sm text-kursal-50 transition-colors placeholder:text-kursal-500 focus:border-accent-500 focus:outline-none"
          disabled={status === "loading"}
        />
      </div>
      <button
        type="submit"
        disabled={status === "loading"}
        class="flex items-center justify-center gap-2 rounded-sm border border-accent-500/70 px-5 py-2.5 font-mono text-sm font-semibold text-accent-400 transition-colors hover:bg-accent-500 hover:text-kursal-950 disabled:cursor-not-allowed disabled:opacity-50"
      >
        {#if status === "loading"}
          <div
            class="h-4 w-4 animate-spin rounded-full border-2 border-accent-400/30 border-t-accent-400"
          ></div>
        {:else}
          Notify me
        {/if}
      </button>
    </form>

    {#if status === "error"}
      <p class="mt-2 font-mono text-sm text-party-400">! {errorMessage}</p>
    {/if}
  {/if}
</div>
