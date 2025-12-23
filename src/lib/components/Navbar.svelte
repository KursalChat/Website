<script lang="ts">
  import { FileText, Bell, Shield, Lock, Scale, Menu, X } from "lucide-svelte";
  import { SiGithub } from "@icons-pack/svelte-simple-icons";
  import { scrollTo } from "$lib/util";
  import { repository, PAPER_URL } from "$lib/const";

  import { slide } from "svelte/transition";

  let mobileMenuOpen = $state(false);

  function toggleMobileMenu() {
    mobileMenuOpen = !mobileMenuOpen;
  }

  function closeMobileMenu() {
    mobileMenuOpen = false;
  }
</script>

<nav
  class="fixed top-0 left-0 right-0 z-50 bg-kursal-900/80 backdrop-blur-lg border-b border-kursal-700"
>
  <div
    class="max-w-6xl mx-auto px-4 md:px-6 py-4 flex items-center justify-between"
  >
    <div class="flex items-center gap-4 md:gap-8">
      <a
        href="/"
        class="flex items-center gap-2 md:gap-3 hover:opacity-80 transition-opacity"
      >
        <img src="/icon.png" alt="Kursal" class="w-8 h-8" />
        <span class="text-xl font-semibold text-kursal-50">Kursal</span>
      </a>

      <div class="hidden md:flex items-center gap-1">
        <a
          href="/security"
          class="flex items-center gap-1.5 text-kursal-300 hover:text-kursal-50 transition-colors px-3 py-1.5 rounded-lg hover:bg-kursal-800"
        >
          <Shield size={16} />
          <span>Security</span>
        </a>
        <a
          href="/privacy"
          class="flex items-center gap-1.5 text-kursal-300 hover:text-kursal-50 transition-colors px-3 py-1.5 rounded-lg hover:bg-kursal-800"
        >
          <Lock size={16} />
          <span>Privacy</span>
        </a>
        <a
          href="/terms"
          class="flex items-center gap-1.5 text-kursal-300 hover:text-kursal-50 transition-colors px-3 py-1.5 rounded-lg hover:bg-kursal-800"
        >
          <Scale size={16} />
          <span>Terms</span>
        </a>
      </div>
    </div>

    <div class="flex items-center gap-3 md:gap-6">
      <a
        href={PAPER_URL}
        target="_blank"
        class="flex items-center gap-2 text-kursal-200 hover:text-kursal-50 transition-colors"
      >
        <FileText size={18} />
        <span class="hidden sm:inline">Paper</span>
      </a>

      <a
        href={repository}
        target="_blank"
        rel="noopener noreferrer"
        class="flex items-center gap-2 text-kursal-200 hover:text-kursal-50 transition-colors"
      >
        <SiGithub size={18} />
        <span class="hidden sm:inline">GitHub</span>
      </a>

      <button
        onclick={() => scrollTo("notify")}
        class="flex items-center gap-2 bg-accent-500 hover:bg-accent-400 text-white px-3 md:px-4 py-2 rounded-lg font-medium transition-colors"
      >
        <Bell size={18} />
        <span class="hidden sm:inline">Get Notified</span>
      </button>

      <button
        type="button"
        class="md:hidden inline-flex items-center justify-center w-10 h-10 rounded-lg hover:bg-kursal-800 text-kursal-200 hover:text-kursal-50 transition-colors"
        aria-label={mobileMenuOpen ? "Close menu" : "Open menu"}
        aria-expanded={mobileMenuOpen}
        aria-controls="mobile-nav"
        onclick={toggleMobileMenu}
      >
        {#if mobileMenuOpen}
          <X size={20} />
        {:else}
          <Menu size={20} />
        {/if}
      </button>
    </div>
  </div>

  {#if mobileMenuOpen}
    <div
      id="mobile-nav"
      class="md:hidden border-t border-kursal-700 bg-kursal-900/95"
      transition:slide={{ duration: 160 }}
    >
      <div class="max-w-6xl mx-auto px-4 md:px-6 py-3">
        <div class="flex flex-col gap-1">
          <a
            href="/security"
            onclick={closeMobileMenu}
            class="flex items-center gap-2 text-kursal-300 hover:text-kursal-50 transition-colors px-3 py-2 rounded-lg hover:bg-kursal-800"
          >
            <Shield size={16} />
            <span>Security</span>
          </a>
          <a
            href="/privacy"
            onclick={closeMobileMenu}
            class="flex items-center gap-2 text-kursal-300 hover:text-kursal-50 transition-colors px-3 py-2 rounded-lg hover:bg-kursal-800"
          >
            <Lock size={16} />
            <span>Privacy</span>
          </a>
          <a
            href="/terms"
            onclick={closeMobileMenu}
            class="flex items-center gap-2 text-kursal-300 hover:text-kursal-50 transition-colors px-3 py-2 rounded-lg hover:bg-kursal-800"
          >
            <Scale size={16} />
            <span>Terms</span>
          </a>

          <div class="h-px bg-kursal-700 my-2"></div>

          <a
            href={PAPER_URL}
            target="_blank"
            onclick={closeMobileMenu}
            class="flex items-center gap-2 text-kursal-200 hover:text-kursal-50 transition-colors px-3 py-2 rounded-lg hover:bg-kursal-800"
          >
            <FileText size={18} />
            <span>Paper</span>
          </a>
          <a
            href={repository}
            target="_blank"
            rel="noopener noreferrer"
            onclick={closeMobileMenu}
            class="flex items-center gap-2 text-kursal-200 hover:text-kursal-50 transition-colors px-3 py-2 rounded-lg hover:bg-kursal-800"
          >
            <SiGithub size={18} />
            <span>GitHub</span>
          </a>

          <button
            type="button"
            onclick={() => {
              closeMobileMenu();
              scrollTo("notify");
            }}
            class="mt-2 flex items-center justify-center gap-2 bg-accent-500 hover:bg-accent-400 text-white px-4 py-3 rounded-xl font-medium transition-colors"
          >
            <Bell size={18} />
            <span>Get Notified</span>
          </button>
        </div>
      </div>
    </div>
  {/if}
</nav>
