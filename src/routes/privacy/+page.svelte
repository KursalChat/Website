<script lang="ts">
  import {
    ArrowLeft,
    Shield,
    Eye,
    EyeOff,
    Lock,
    RefreshCw,
    Network,
    Code,
  } from "lucide-svelte";
  import Navbar from "$lib/components/Navbar.svelte";
  import Footer from "$lib/components/Footer.svelte";
  import { repository } from "$lib/const";
  import { SiGithub } from "@icons-pack/svelte-simple-icons";
</script>

<Navbar />

<main class="min-h-screen pt-24 pb-16 bg-kursal-900">
  <div class="max-w-4xl mx-auto px-6">
    <a
      href="/"
      onclick={() => window.scrollTo(0, 0)}
      class="inline-flex items-center gap-2 text-kursal-400 hover:text-kursal-300 transition-colors mb-8"
    >
      <ArrowLeft size={18} />
      Back to home
    </a>

    <div class="text-center mb-12">
      <div
        class="w-20 h-20 bg-accent-500/20 rounded-2xl flex items-center justify-center mx-auto mb-6"
      >
        <Shield size={40} class="text-accent-400" />
      </div>
      <h1 class="text-4xl md:text-5xl font-bold text-white mb-4">
        Privacy Policy
      </h1>
      <p class="text-xl text-kursal-100 max-w-2xl mx-auto">
        Your conversations belong to you. We've designed Kursal so literally no
        one can access your messages.
      </p>
    </div>

    <div class="bg-kursal-800 rounded-2xl border border-kursal-700 p-6 mb-8">
      <div class="flex items-start gap-4">
        <Lock size={24} class="text-accent-400 mt-1 flex-shrink-0" />
        <div>
          <h2 class="text-lg font-semibold text-white mb-2">Our Commitment</h2>
          <p class="text-kursal-50">
            Kursal is built with privacy as its foundation. We believe your
            conversations belong to you, and we've designed our system to ensure
            we literally cannot access your messages.
          </p>
        </div>
      </div>
    </div>

    <div class="space-y-6">
      <div class="bg-kursal-800/50 rounded-2xl border border-kursal-700 p-6">
        <div class="flex items-start gap-4">
          <EyeOff size={24} class="text-red-400 mt-1 flex-shrink-0" />
          <div>
            <h2 class="text-xl font-semibold text-white mb-3">
              Data We Don't Collect
            </h2>
            <p class="text-kursal-50 mb-4">
              Because the Kursal app is peer-to-peer and fully decentralized and
              we do not want to invade your privacy:
            </p>
            <div class="space-y-2">
              <div class="flex items-center gap-3 text-kursal-50">
                <div class="w-1.5 h-1.5 rounded-full bg-accent-500"></div>
                <span>No access to encryption keys</span>
              </div>
              <div class="flex items-center gap-3 text-kursal-50">
                <div class="w-1.5 h-1.5 rounded-full bg-accent-500"></div>
                <span>No analytics or usage tracking</span>
              </div>
              <div class="flex items-center gap-3 text-kursal-50">
                <div class="w-1.5 h-1.5 rounded-full bg-accent-500"></div>
                <span>No conversation metadata</span>
              </div>
            </div>
          </div>
        </div>
      </div>

      <div class="bg-kursal-800/50 rounded-2xl border border-kursal-700 p-6">
        <div class="flex items-start gap-4">
          <Eye size={24} class="text-green-400 mt-1 flex-shrink-0" />
          <div>
            <h2 class="text-xl font-semibold text-white mb-3">
              Data Peers Could Collect
            </h2>
            <p class="text-kursal-50 mb-4">
              Your encrypted messages go through public relays. Those relays can
              track some limited informations about you:
            </p>
            <div class="space-y-2">
              <div class="flex items-center gap-3 text-kursal-50">
                <div class="w-1.5 h-1.5 rounded-full bg-accent-500"></div>
                <span>Your IP address (can be changed with a VPN)</span>
              </div>
              <div class="flex items-center gap-3 text-kursal-50">
                <div class="w-1.5 h-1.5 rounded-full bg-accent-500"></div>
                <span>When you send messages</span>
              </div>
              <div class="flex items-center gap-3 text-kursal-50">
                <div class="w-1.5 h-1.5 rounded-full bg-accent-500"></div>
                <span
                  >Your Peer ID and the destination Peer ID (which periodically
                  rotates and makes the 'when' harder to track)</span
                >
              </div>
            </div>
          </div>
        </div>
      </div>

      <div class="bg-kursal-800/50 rounded-2xl border border-kursal-700 p-6">
        <div class="flex items-start gap-4">
          <RefreshCw size={24} class="text-accent-400 mt-1 flex-shrink-0" />
          <div>
            <h2 class="text-xl font-semibold text-white mb-3">
              How Kursal Works
            </h2>
            <p class="text-kursal-50">
              All encryption happens locally on your device. Messages are
              transmitted directly between peers using end-to-end encryption.
              There is no central server that processes or stores your
              communications. Even if your messages transit through public
              relays, no one but the receiver can decrypt them.
            </p>
          </div>
        </div>
      </div>

      <div class="bg-kursal-800/50 rounded-2xl border border-kursal-700 p-6">
        <div class="flex items-start gap-4">
          <Network size={24} class="text-accent-400 mt-1 flex-shrink-0" />
          <div>
            <h2 class="text-xl font-semibold text-white mb-3">Website Data</h2>
            <p class="text-kursal-50">
              This website does not use cookies but tracks the number of
              visitors using <a
                href="https://plausible.io/"
                target="_blank"
                class="underline">Plausible</a
              >, a privacy-friendly tracking platform (which will be self-hosted
              in a near future).
              <br /><br />
              If you sign up for our mailing list, your email is stored solely for
              the purpose of sending you updates. It is self-hosted and stored in
              Germany. You can unsubscribe at any time via the confirmation email.
              We will never distribute or sell your email! If you can't find the
              unsubscription link or need assistance, you can always reach us on
              our email for help.
            </p>
          </div>
        </div>
      </div>

      <div class="bg-kursal-800/50 rounded-2xl border border-kursal-700 p-6">
        <div class="flex items-start gap-4">
          <Code size={24} class="text-accent-400 mt-1 flex-shrink-0" />
          <div>
            <h2 class="text-xl font-semibold text-white mb-3">Open Source</h2>
            <p class="text-kursal-50 mb-4">
              Kursal is fully open source. You can audit our code at any time to
              verify our privacy claims. We encourage security researchers to
              review our implementation.
            </p>
            <a
              href={repository}
              target="_blank"
              rel="noopener noreferrer"
              class="inline-flex items-center gap-2 text-accent-400 hover:text-accent-300 transition-colors"
            >
              <SiGithub size={18} />
              View source code on GitHub
            </a>
          </div>
        </div>
      </div>
    </div>

    <div
      class="mt-12 p-6 bg-kursal-800/30 rounded-2xl border border-kursal-700"
    >
      <p class="text-kursal-100 text-sm text-center">
        This privacy policy is intentionally simple because our approach to
        privacy is simple: we don't collect your data because we can't. That's
        how Kursal is designed.
      </p>
    </div>
  </div>
</main>

<Footer />
