<script lang="ts">
  import {
    ArrowLeft,
    FileText,
    Globe,
    Users,
    Scale,
    TriangleAlert,
    Network,
    Code,
  } from "lucide-svelte";
  import Navbar from "$lib/components/Navbar.svelte";
  import Footer from "$lib/components/Footer.svelte";
  import { repository, email } from "$lib/const";
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
        <FileText size={40} class="text-accent-400" />
      </div>
      <h1 class="text-4xl md:text-5xl font-bold text-white mb-4">
        Terms of Service
      </h1>
      <p class="text-xl text-kursal-100 max-w-2xl mx-auto">
        Open-source, decentralized, and peer-to-peer. Understand how Kursal
        works and your responsibilities.
      </p>
    </div>

    <div class="bg-kursal-800 rounded-2xl border border-kursal-700 p-6 mb-8">
      <div class="flex items-start gap-4">
        <Globe size={24} class="text-accent-400 mt-1 flex-shrink-0" />
        <div>
          <h2 class="text-lg font-semibold text-white mb-2">About Kursal</h2>
          <p class="text-kursal-50">
            Kursal is an open-source, decentralized, peer-to-peer messaging
            application. There is no central authority, company, or organization
            that controls the Kursal network. The software is provided as-is
            under an open source license (AGPL-3).
          </p>
        </div>
      </div>
    </div>

    <div class="space-y-6">
      <div class="bg-kursal-800/50 rounded-2xl border border-kursal-700 p-6">
        <div class="flex items-start gap-4">
          <Network size={24} class="text-accent-400 mt-1 flex-shrink-0" />
          <div>
            <h2 class="text-xl font-semibold text-white mb-3">
              Decentralization
            </h2>
            <p class="text-kursal-50 mb-4">
              By design, Kursal operates without central servers or control.
              This means:
            </p>
            <div class="space-y-2">
              <div class="flex items-center gap-3 text-kursal-50">
                <div class="w-1.5 h-1.5 rounded-full bg-accent-500"></div>
                <span>We cannot moderate, filter, or censor messages</span>
              </div>
              <div class="flex items-center gap-3 text-kursal-50">
                <div class="w-1.5 h-1.5 rounded-full bg-accent-500"></div>
                <span>We cannot recover lost accounts or encryption keys</span>
              </div>
              <div class="flex items-center gap-3 text-kursal-50">
                <div class="w-1.5 h-1.5 rounded-full bg-accent-500"></div>
                <span>We cannot access or read your communications</span>
              </div>
              <div class="flex items-center gap-3 text-kursal-50">
                <div class="w-1.5 h-1.5 rounded-full bg-accent-500"></div>
                <span>We cannot delete or modify your data</span>
              </div>
            </div>
            <p class="text-kursal-100 mt-4 text-sm">
              You are solely responsible for your use of the software and for
              backing up your encryption keys.
            </p>
          </div>
        </div>
      </div>

      <div class="bg-kursal-800/50 rounded-2xl border border-kursal-700 p-6">
        <div class="flex items-start gap-4">
          <Users size={24} class="text-accent-400 mt-1 flex-shrink-0" />
          <div>
            <h2 class="text-xl font-semibold text-white mb-3">
              Your Responsibilities
            </h2>
            <p class="text-kursal-50 mb-4">When using Kursal, you agree to:</p>
            <div class="space-y-2">
              <div class="flex items-center gap-3 text-kursal-50">
                <div class="w-1.5 h-1.5 rounded-full bg-accent-500"></div>
                <span>Comply with all applicable laws in your jurisdiction</span
                >
              </div>
              <div class="flex items-center gap-3 text-kursal-50">
                <div class="w-1.5 h-1.5 rounded-full bg-accent-500"></div>
                <span>Not use the software for illegal activities</span>
              </div>
              <div class="flex items-center gap-3 text-kursal-50">
                <div class="w-1.5 h-1.5 rounded-full bg-accent-500"></div>
                <span>Safeguard your encryption keys and credentials</span>
              </div>
              <div class="flex items-center gap-3 text-kursal-50">
                <div class="w-1.5 h-1.5 rounded-full bg-accent-500"></div>
                <span>Understand that lost keys cannot be recovered</span>
              </div>
            </div>
          </div>
        </div>
      </div>

      <div class="bg-kursal-800/50 rounded-2xl border border-kursal-700 p-6">
        <div class="flex items-start gap-4">
          <Code size={24} class="text-accent-400 mt-1 flex-shrink-0" />
          <div>
            <h2 class="text-xl font-semibold text-white mb-3">
              Open Source License
            </h2>
            <p class="text-kursal-50 mb-4">
              Kursal is released under the AGPL-3.0 License. You are free to
              use, modify, and distribute the software according to the terms of
              this license. The full license text is available in our GitHub
              repository.
            </p>
          </div>
        </div>
      </div>

      <div class="bg-amber-900/20 rounded-2xl border border-amber-700/50 p-6">
        <div class="flex items-start gap-4">
          <TriangleAlert size={24} class="text-amber-400 mt-1 flex-shrink-0" />
          <div>
            <h2 class="text-xl font-semibold text-white mb-3">No Warranty</h2>
            <p class="text-kursal-50 text-sm">
              THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
              EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
              MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
              NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
              HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY.
            </p>
          </div>
        </div>
      </div>

      <div class="bg-kursal-800/50 rounded-2xl border border-kursal-700 p-6">
        <div class="flex items-start gap-4">
          <Scale size={24} class="text-accent-400 mt-1 flex-shrink-0" />
          <div>
            <h2 class="text-xl font-semibold text-white mb-3">
              Limitation of Liability
            </h2>
            <p class="text-kursal-50 mb-4">
              Because Kursal is decentralized and we have no control over the
              network or user activities, we cannot be held liable for:
            </p>
            <div class="space-y-2">
              <div class="flex items-center gap-3 text-kursal-50">
                <div class="w-1.5 h-1.5 rounded-full bg-accent-500"></div>
                <span>Any content transmitted through the network</span>
              </div>
              <div class="flex items-center gap-3 text-kursal-50">
                <div class="w-1.5 h-1.5 rounded-full bg-accent-500"></div>
                <span>Loss of data or encryption keys</span>
              </div>
              <div class="flex items-center gap-3 text-kursal-50">
                <div class="w-1.5 h-1.5 rounded-full bg-accent-500"></div>
                <span>Service interruptions or unavailability</span>
              </div>
              <div class="flex items-center gap-3 text-kursal-50">
                <div class="w-1.5 h-1.5 rounded-full bg-accent-500"></div>
                <span>Any actions taken by other users</span>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <div
      class="mt-12 p-6 bg-kursal-800/30 rounded-2xl border border-kursal-700 text-center"
    >
      <p class="text-kursal-100 text-sm">
        For questions about these terms, please open an issue on our
        <a
          href={repository}
          target="_blank"
          rel="noopener noreferrer"
          class="text-accent-400 hover:underline">GitHub repository</a
        >
        or email us at
        <a
          href={"mailto:" + email}
          target="_blank"
          rel="noopener noreferrer"
          class="text-accent-400 hover:underline">{email}</a
        >.
      </p>
    </div>
  </div>
</main>

<Footer />
