<script lang="ts">
  import {
    FileText,
    Download,
    Menu,
    X,
    Activity,
    GitCompare,
    Star,
  } from "lucide-svelte";
  import { SiGithub } from "@icons-pack/svelte-simple-icons";
  import { page } from "$app/state";
  import { repository, PAPER_URL } from "$lib/const";

  import { slide } from "svelte/transition";

  let mobileMenuOpen = $state(false);
  let menuElement = $state<HTMLElement | null>(null);
  let toggleButton = $state<HTMLButtonElement | null>(null);

  function toggleMobileMenu() {
    mobileMenuOpen = !mobileMenuOpen;
  }

  function closeMobileMenu() {
    mobileMenuOpen = false;
  }

  $effect(() => {
    if (!mobileMenuOpen) return;

    document.body.style.overflow = "hidden";
    return () => {
      document.body.style.overflow = "";
    };
  });

  $effect(() => {
    if (!mobileMenuOpen || !menuElement) return;
    menuElement.querySelector<HTMLElement>("a[href]")?.focus();
  });

  function focusableItems() {
    const inMenu = menuElement
      ? [...menuElement.querySelectorAll<HTMLElement>("a[href]")]
      : [];
    return toggleButton ? [toggleButton, ...inMenu] : inMenu;
  }

  function handleKeydown(event: KeyboardEvent) {
    if (!mobileMenuOpen) return;

    if (event.key === "Escape") {
      closeMobileMenu();
      toggleButton?.focus();
      return;
    }

    if (event.key !== "Tab") return;

    const items = focusableItems();
    if (items.length === 0) return;

    const first = items[0];
    const last = items[items.length - 1];

    if (event.shiftKey && document.activeElement === first) {
      event.preventDefault();
      last.focus();
    } else if (!event.shiftKey && document.activeElement === last) {
      event.preventDefault();
      first.focus();
    }
  }

  const navLinks = [
    { href: "/compare", label: "compare", icon: GitCompare },
    { href: "/progress", label: "progress", icon: Activity },
  ];
</script>

<svelte:window onkeydown={handleKeydown} />

<nav
  style:view-transition-name="kursal-nav"
  class="fixed top-0 right-0 left-0 z-50 border-b border-kursal-700 bg-kursal-900/95 font-mono backdrop-blur-sm"
>
  <div
    class="mx-auto flex max-w-6xl items-center justify-between px-4 py-3.5 md:px-6"
  >
    <div class="flex items-center gap-4 md:gap-8">
      <a
        href="/"
        class="flex items-center gap-2 transition-opacity hover:opacity-80 md:gap-2.5"
      >
        <img
          fetchpriority="high"
          src="/icon.png"
          alt="Kursal"
          width="28"
          height="28"
          class="h-7 w-7"
        />
        <span class="text-lg font-semibold tracking-tight text-kursal-50"
          >kursal<span class="text-accent-500">:~$</span></span
        >
      </a>

      <div class="hidden items-center gap-0.5 text-sm md:flex">
        {#each navLinks as link}
          {@const active = page.url.pathname === link.href}
          <a
            href={link.href}
            aria-current={active ? "page" : undefined}
            class="group flex items-center gap-1.5 rounded-sm px-3 py-1.5 transition-colors {active
              ? 'bg-kursal-800 text-accent-400'
              : 'text-kursal-300 hover:bg-kursal-800 hover:text-accent-400'}"
          >
            <span
              class="text-kursal-500 transition-colors group-hover:text-accent-500/70"
              >~/</span
            ><span>{link.label}</span>{#if active}<span
                class="text-accent-500/70 select-none">*</span
              >{/if}
          </a>
        {/each}
      </div>
    </div>

    <div class="flex items-center gap-3 text-sm md:gap-5">
      <a
        href={PAPER_URL}
        target="_blank"
        rel="noopener noreferrer"
        class="flex items-center gap-2 text-kursal-300 transition-colors hover:text-kursal-50"
      >
        <FileText size={17} />
        <span class="hidden sm:inline">paper</span>
      </a>

      <a
        href={repository}
        target="_blank"
        rel="noopener noreferrer"
        class="group flex items-center gap-2 text-kursal-300 transition-colors hover:text-kursal-50"
      >
        <SiGithub size={17} />
        <span class="hidden sm:inline">star us</span>
        <Star
          size={14}
          class="hidden fill-transparent text-kursal-500 transition-colors group-hover:fill-accent-400 group-hover:text-accent-400 sm:inline"
        />
      </a>

      <a
        href="/download"
        class="group flex items-center gap-2 rounded-sm border border-accent-500/70 px-3 py-1.5 font-medium text-accent-400 transition-colors hover:bg-accent-500 hover:text-kursal-950 md:px-3.5"
      >
        <span
          class="text-kursal-500 transition group-hover:-translate-x-0.5 group-hover:text-kursal-950/60"
          >[</span
        >
        <span class="hidden sm:inline">download beta</span>
        <Download size={15} class="sm:hidden" />
        <span
          class="text-kursal-500 transition group-hover:translate-x-0.5 group-hover:text-kursal-950/60"
          >]</span
        >
      </a>

      <button
        bind:this={toggleButton}
        type="button"
        class="inline-flex h-9 w-9 items-center justify-center rounded-sm text-kursal-200 transition-colors hover:bg-kursal-800 hover:text-kursal-50 md:hidden"
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
      bind:this={menuElement}
      id="mobile-nav"
      class="border-t border-kursal-700 bg-kursal-900 text-sm md:hidden"
      transition:slide={{ duration: 160 }}
    >
      <div class="mx-auto max-w-6xl px-4 py-3 md:px-6">
        <div class="flex flex-col gap-0.5">
          {#each navLinks as link}
            {@const active = page.url.pathname === link.href}
            <a
              href={link.href}
              onclick={closeMobileMenu}
              aria-current={active ? "page" : undefined}
              class="group flex items-center gap-2 rounded-sm px-3 py-2 transition-colors {active
                ? 'bg-kursal-800 text-accent-400'
                : 'text-kursal-300 hover:bg-kursal-800 hover:text-accent-400'}"
            >
              <link.icon
                size={16}
                class={active ? "text-accent-500" : "text-kursal-500"}
              />
              <span
                class="text-kursal-500 transition-colors group-hover:text-accent-500/70"
                >~/</span
              ><span>{link.label}</span>
            </a>
          {/each}

          <div class="my-2 h-px bg-kursal-700"></div>

          <a
            href={PAPER_URL}
            target="_blank"
            rel="noopener noreferrer"
            onclick={closeMobileMenu}
            class="flex items-center gap-2 rounded-sm px-3 py-2 text-kursal-200 transition-colors hover:bg-kursal-800 hover:text-kursal-50"
          >
            <FileText size={18} />
            <span>paper</span>
          </a>
          <a
            href={repository}
            target="_blank"
            rel="noopener noreferrer"
            onclick={closeMobileMenu}
            class="group flex items-center gap-2 rounded-sm px-3 py-2 text-kursal-200 transition-colors hover:bg-kursal-800 hover:text-kursal-50"
          >
            <SiGithub size={18} />
            <span>star us on github</span>
            <Star
              size={15}
              class="fill-transparent text-kursal-500 transition-colors group-hover:fill-accent-400 group-hover:text-accent-400"
            />
          </a>

          <a
            href="/download"
            onclick={closeMobileMenu}
            class="group mt-2 flex items-center justify-center gap-2 rounded-sm border border-accent-500/70 px-4 py-2.5 font-medium text-accent-400 transition-colors hover:bg-accent-500 hover:text-kursal-950"
          >
            <span
              class="text-kursal-500 transition group-hover:-translate-x-0.5 group-hover:text-kursal-950/60"
              >[</span
            >
            <span>download beta</span>
            <span
              class="text-kursal-500 transition group-hover:translate-x-0.5 group-hover:text-kursal-950/60"
              >]</span
            >
          </a>
        </div>
      </div>
    </div>
  {/if}
</nav>
