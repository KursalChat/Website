<script lang="ts">
  import { slide } from "svelte/transition";
  import { reveal } from "$lib/reveal";

  const faqs = [
    {
      question: "What makes Kursal unique?",
      answer:
        "Kursal is built on a fully decentralized, peer-to-peer architecture with end-to-end encryption by default. Unlike traditional apps, there's no central server storing your messages or metadata. Your conversations exist only between you and your recipients.",
    },
    {
      question: "How does the peer-to-peer system work?",
      answer:
        "When you send a message, it travels directly from your device to the recipient's device through an encrypted tunnel. It often has to go through 'relays' which cannot decrypt anything.<br />Kursal tries to obfuscate everything it can, making it hard for the relays to track who you're talking to.",
    },
    {
      question: "What's the business model?",
      answer:
        'Nothing! Kursal isn\'t designed to make money as it is a personal project. We just wanted to experiment with decentralization and Rust and it is amazing! So nope, free forever! If you want to financially support us, you could check out <a href="https://ko-fi.com/kursal" target="_blank" class="underline">our Ko-Fi</a>.',
    },
    {
      question: "What data do you collect?",
      answer:
        'We collect absolutely nothing. No analytics and no metadata about who you talk to or when. We literally can\'t see your messages even if we wanted to: that\'s the whole point.<br />The only things we can see are the crash and bug reports you optionally decide to send to help improve the app. Check out our <a href="/privacy" class="underline">Privacy Policy</a> for more infos!',
    },
    {
      question: "Why Kursal? and technical infos",
      answer:
        'Kursal started as an idea on January 2024, a bit like <a href="https://matrix.org" target="_blank" class="underline">Matrix</a> does by hosting your own server, but it changed into a new plan: full decentralization. We finally started coding mid-2025, with the goal of learning Rust, desktop application and decentralization. More importantly, Kursal aims to demonstrate that full decentralization can achieve usability.' +
        "<br /><br />" +
        'Kursal is built with Rust using <a href="https://tauri.app" target="_blank" class="underline">Tauri</a> for the application. It uses Signal\'s <a href="https://github.com/signalapp/libsignal" target="_blank" class="underline">libsignal</a> library for the encryption and Libp2p\'s <a href="https://github.com/libp2p/rust-libp2p" target="_blank" class="underline">rust-libp2p</a> for the networking. Check out those amazing open source libraries!',
    },
  ] as { question: string; answer: string }[];

  let openIndex = $state<number | null>(0);

  function toggle(index: number) {
    openIndex = openIndex === index ? null : index;
  }
</script>

<section id="faq" class="py-24 bg-kursal-900">
  <div class="max-w-3xl mx-auto px-6">
    <div class="text-center mb-12" use:reveal>
      <p class="font-mono text-sm text-accent-400 mb-4">~/faq</p>
      <h2 class="font-mono text-3xl md:text-4xl font-bold text-kursal-50 mb-4">
        Frequently Asked Questions
      </h2>
      <p class="text-kursal-300 text-lg max-w-2xl mx-auto">
        Got questions? We've got answers. If you don't find what you're looking
        for, feel free to reach out.
      </p>
    </div>

    <div class="space-y-2.5">
      {#each faqs as faq, index}
        <div
          use:reveal={{ delay: index * 50 }}
          class="bg-kursal-800 rounded-sm border border-kursal-700 overflow-hidden transition-colors duration-200 hover:border-kursal-600"
          class:border-accent-500={openIndex === index}
        >
          <button
            onclick={() => toggle(index)}
            class="w-full px-5 py-4 flex items-center justify-between gap-4 text-left cursor-pointer"
          >
            <span class="flex items-baseline gap-2.5 min-w-0">
              <span class="font-mono text-accent-400 shrink-0">Q:</span>
              <span class="text-kursal-50 font-medium">{faq.question}</span>
            </span>
            <span
              class="font-mono text-lg text-accent-400 shrink-0 select-none w-6 text-center"
              aria-hidden="true">{openIndex === index ? "−" : "+"}</span
            >
          </button>

          {#if openIndex === index}
            <div transition:slide={{ duration: 200 }} class="px-5 pb-5">
              <p
                class="answer text-kursal-300 leading-relaxed pl-[1.9rem] border-l border-kursal-700 ml-[0.1rem]"
              >
                <span class="font-mono text-accent-400/70 -ml-[1.9rem] pr-2"
                  >A:</span
                >{@html faq.answer}
              </p>
            </div>
          {/if}
        </div>
      {/each}
    </div>
  </div>
</section>

<style>
  .answer :global(a) {
    color: var(--color-accent-400);
    text-decoration: underline;
    text-underline-offset: 2px;
  }
  .answer :global(a:hover) {
    color: var(--color-accent-300);
  }
</style>
