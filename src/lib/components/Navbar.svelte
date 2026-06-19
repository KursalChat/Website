<script lang="ts">
  import {
    FileText,
    Bell,
    Shield,
    Lock,
    Scale,
    Menu,
    X,
    Activity,
    GitCompare,
  } from "lucide-svelte";
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

  function getNotified() {
    closeMobileMenu();
    if (location.pathname == "/") scrollTo("notify");
    else location.href = "/#notify";
  }

  const navLinks = [
    { href: "/compare", label: "compare", icon: GitCompare },
    { href: "/progress", label: "progress", icon: Activity },
    { href: "/security", label: "security", icon: Shield },
    { href: "/privacy", label: "privacy", icon: Lock },
  ];
</script>

<nav
  class="fixed top-0 left-0 right-0 z-50 bg-kursal-900/95 backdrop-blur-sm border-b border-kursal-700 font-mono"
>
  <div
    class="max-w-6xl mx-auto px-4 md:px-6 py-3.5 flex items-center justify-between"
  >
    <div class="flex items-center gap-4 md:gap-8">
      <a
        href="/"
        class="flex items-center gap-2 md:gap-2.5 hover:opacity-80 transition-opacity"
      >
        <img
          fetchpriority="high"
          src="/icon.png"
          alt="Kursal"
          class="w-7 h-7"
        />
        <span class="text-lg font-semibold text-kursal-50 tracking-tight"
          >kursal<span class="text-accent-500">:~$</span></span
        >
      </a>

      <div class="hidden md:flex items-center gap-0.5 text-sm">
        {#each navLinks as link}
          <a
            href={link.href}
            class="flex items-center gap-1.5 text-kursal-300 hover:text-accent-400 transition-colors px-3 py-1.5 rounded-sm hover:bg-kursal-800"
          >
            <span class="text-kursal-500">~/</span><span>{link.label}</span>
          </a>
        {/each}
      </div>
    </div>

    <div class="flex items-center gap-3 md:gap-5 text-sm">
      <a
        href={PAPER_URL}
        target="_blank"
        class="flex items-center gap-2 text-kursal-300 hover:text-kursal-50 transition-colors"
      >
        <FileText size={17} />
        <span class="hidden sm:inline">paper</span>
      </a>

      <a
        href={repository}
        target="_blank"
        rel="noopener noreferrer"
        class="flex items-center gap-2 text-kursal-300 hover:text-kursal-50 transition-colors"
      >
        <SiGithub size={17} />
        <span class="hidden sm:inline">github</span>
      </a>

      <button
        onclick={getNotified}
        class="flex items-center gap-2 border border-accent-500/70 text-accent-400 hover:bg-accent-500 hover:text-kursal-950 px-3 md:px-3.5 py-1.5 rounded-sm font-medium transition-colors"
      >
        <span class="text-kursal-500 group-hover:text-kursal-950">[</span>
        <span class="hidden sm:inline">get notified</span>
        <Bell size={15} class="sm:hidden" />
        <span class="text-kursal-500">]</span>
      </button>

      <button
        type="button"
        class="md:hidden inline-flex items-center justify-center w-9 h-9 rounded-sm hover:bg-kursal-800 text-kursal-200 hover:text-kursal-50 transition-colors"
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
      class="md:hidden border-t border-kursal-700 bg-kursal-900 text-sm"
      transition:slide={{ duration: 160 }}
    >
      <div class="max-w-6xl mx-auto px-4 md:px-6 py-3">
        <div class="flex flex-col gap-0.5">
          {#each navLinks as link}
            <a
              href={link.href}
              onclick={closeMobileMenu}
              class="flex items-center gap-2 text-kursal-300 hover:text-accent-400 transition-colors px-3 py-2 rounded-sm hover:bg-kursal-800"
            >
              <link.icon size={16} class="text-kursal-500" />
              <span class="text-kursal-500">~/</span><span>{link.label}</span>
            </a>
          {/each}

          <div class="h-px bg-kursal-700 my-2"></div>

          <a
            href={PAPER_URL}
            target="_blank"
            onclick={closeMobileMenu}
            class="flex items-center gap-2 text-kursal-200 hover:text-kursal-50 transition-colors px-3 py-2 rounded-sm hover:bg-kursal-800"
          >
            <FileText size={18} />
            <span>paper</span>
          </a>
          <a
            href={repository}
            target="_blank"
            rel="noopener noreferrer"
            onclick={closeMobileMenu}
            class="flex items-center gap-2 text-kursal-200 hover:text-kursal-50 transition-colors px-3 py-2 rounded-sm hover:bg-kursal-800"
          >
            <SiGithub size={18} />
            <span>github</span>
          </a>

          <button
            type="button"
            onclick={getNotified}
            class="mt-2 flex items-center justify-center gap-2 border border-accent-500/70 text-accent-400 hover:bg-accent-500 hover:text-kursal-950 px-4 py-2.5 rounded-sm font-medium transition-colors"
          >
            <span class="text-kursal-500">[</span>
            <span>get notified</span>
            <span class="text-kursal-500">]</span>
          </button>
        </div>
      </div>
    </div>
  {/if}
</nav>
