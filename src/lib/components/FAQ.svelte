<script lang="ts">
  import { ChevronDown } from "lucide-svelte";
  import { slide } from "svelte/transition";

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
        'Nothing! Kursal isn\'t designed to make money as it is a personal project. We just wanted to experiment with decentralization and Rust and it is amazing! So nope, free forever! If you want to financially support us, you could check out <a href="https://ko-fi.com/openvoxel" target="_blank" class="underline">our Ko-Fi</a>.',
    },
    {
      question: "What data do you collect?",
      answer:
        'We collect absolutely nothing. No analytics, no crash reports, no metadata about who you talk to or when. We literally can\'t see your messages even if we wanted to: that\'s the whole point.<br />The only things we can see are the public bug reports you can open on our <a href="https://github.com/KursalChat/Kursal" target="_blank" class="underline">repository</a> and the emails you subscribe to our mailing list. Check out our <a href="/privacy" class="underline">Privacy Policy</a> for more infos!',
    },
    {
      question: "Why Kursal? and technical infos",
      answer:
        'Kursal started as an idea on January 2024, a bit like <a href="https://matrix.org" target="_blank" class="underline">Matrix</a> does by hosting your own server, but it changed into a new plan: full decentralization. We finally started coding mid-2025, with the goal of learning Rust, desktop application and decentralization. More importantly, Kursal aims to demonstrate that full decentralization can achieve usability.' +
        "<br /><br />" +
        'Kursal is built with Rust using <a href="https://tauri.app" target="_blank" class="underline">Tauri</a> for the application. It uses Signal\'s <a href="https://github.com/signalapp/libsignal" target="_blank" class="underline">libsignal</a> library for the encryption and Libp2p\'s <a href="https://github.com/libp2p/rust-libp2p" target="_blank" class="underline">rust-libp2p</a> for the networking. Check out those amazing open source libraries!',
    },
  ] as { question: string; answer: string }[];

  let openIndex = $state<number | null>(null);

  function toggle(index: number) {
    openIndex = openIndex === index ? null : index;
  }
</script>

<section id="faq" class="py-24 bg-kursal-900 relative overflow-hidden">
  <div
    class="absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 w-[600px] h-[600px] bg-gradient-radial from-accent-500/5 via-transparent to-transparent rounded-full blur-3xl pointer-events-none"
  ></div>

  <div class="max-w-3xl mx-auto px-6 relative z-10">
    <div class="text-center mb-16">
      <h2 class="text-3xl md:text-4xl font-bold text-kursal-50 mb-4">
        Frequently Asked Questions
      </h2>
      <p class="text-kursal-300 text-lg max-w-2xl mx-auto">
        Got questions? We've got answers. If you don't find what you're looking
        for, feel free to reach out.
      </p>
    </div>

    <div class="space-y-3">
      {#each faqs as faq, index}
        <div
          class="bg-kursal-800/80 rounded-2xl border border-kursal-700 overflow-hidden transition-colors duration-200 hover:border-kursal-500"
        >
          <button
            onclick={() => toggle(index)}
            class="w-full px-6 py-5 flex items-center justify-between text-left cursor-pointer"
          >
            <span class="text-kursal-50 font-medium pr-4">{faq.question}</span>
            <div
              class="shrink-0 w-8 h-8 bg-kursal-700 rounded-lg flex items-center justify-center transition-all duration-300"
              class:rotate-180={openIndex === index}
            >
              <ChevronDown size={18} class="text-accent-400" />
            </div>
          </button>

          {#if openIndex === index}
            <div transition:slide={{ duration: 200 }} class="px-6 pb-5">
              <p class="text-kursal-300 leading-relaxed">
                {@html faq.answer}
              </p>
            </div>
          {/if}
        </div>
      {/each}
    </div>
  </div>
</section>
