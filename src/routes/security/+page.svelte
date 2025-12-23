<script lang="ts">
  import {
    ArrowLeft,
    Shield,
    Key,
    Bug,
    FileText,
    Mail,
    Lock,
    Server,
    Search,
    RefreshCw,
    CircleCheckBig,
    ExternalLink,
  } from "lucide-svelte";
  import { SiGithub } from "@icons-pack/svelte-simple-icons";
  import Navbar from "$lib/components/Navbar.svelte";
  import Footer from "$lib/components/Footer.svelte";
  import { repository, email, PAPER_URL } from "$lib/const";
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
      <h1 class="text-4xl md:text-5xl font-bold text-white mb-4">Security</h1>
      <p class="text-xl text-kursal-100 max-w-2xl mx-auto">
        Our mission is to protect your privacy through proven cryptographic
        protocols and transparent security practices.
      </p>
    </div>

    <div class="space-y-8">
      <section>
        <div class="flex items-center gap-3 mb-6">
          <Lock size={28} class="text-accent-400" />
          <h2 class="text-2xl md:text-3xl font-semibold text-white">
            Cryptographic Protocols
          </h2>
        </div>
        <div
          class="bg-kursal-800/50 rounded-2xl border border-kursal-700 p-6 md:p-8"
        >
          <div class="grid md:grid-cols-2 gap-8">
            <div>
              <h3
                class="text-xl font-semibold text-white mb-3 flex items-center gap-2"
              >
                <Key size={20} class="text-green-400" />
                PQXDH Key Agreement
                <a
                  href="https://signal.org/docs/specifications/pqxdh/"
                  target="_blank"
                  rel="noopener noreferrer"
                  class="text-kursal-400 hover:text-accent-400 transition-colors"
                >
                  <ExternalLink size={16} />
                </a>
              </h3>
              <p class="text-kursal-50">
                Kursal uses the Post-Quantum Extended Diffie-Hellman (PQXDH)
                protocol to establish shared secrets when initiating
                conversations.
              </p>
            </div>
            <div>
              <h3
                class="text-xl font-semibold text-white mb-3 flex items-center gap-2"
              >
                <RefreshCw size={20} class="text-accent-400" />
                Sesame
                <a
                  href="https://signal.org/docs/specifications/sesame/"
                  target="_blank"
                  rel="noopener noreferrer"
                  class="text-kursal-400 hover:text-accent-400 transition-colors"
                >
                  <ExternalLink size={16} />
                </a>
                + Double Ratchet
                <a
                  href="https://signal.org/docs/specifications/doubleratchet/"
                  target="_blank"
                  rel="noopener noreferrer"
                  class="text-kursal-400 hover:text-accent-400 transition-colors"
                >
                  <ExternalLink size={16} />
                </a>
              </h3>
              <p class="text-kursal-50">
                All message exchanges use the Sesame algorithm with Double
                Ratchet, providing both forward secrecy and post-compromise
                security.
              </p>
            </div>
          </div>
        </div>
      </section>

      <section>
        <div class="flex items-center gap-3 mb-6">
          <Bug size={28} class="text-red-400" />
          <h2 class="text-2xl md:text-3xl font-semibold text-white">
            Vulnerability Disclosure
          </h2>
        </div>
        <div
          class="bg-kursal-800/50 rounded-2xl border border-kursal-700 p-6 md:p-8"
        >
          <p class="text-kursal-50 mb-8">
            Security is at the core of Kursal. We encourage responsible
            disclosure of any vulnerabilities and are committed to addressing
            issues promptly.
          </p>

          <div class="space-y-8">
            <div>
              <h3
                class="text-lg font-semibold text-white mb-3 flex items-center gap-2"
              >
                <SiGithub size={20} />
                General Issues
              </h3>
              <p class="text-kursal-100 mb-4">
                For bugs, feature requests, and non-security issues, please open
                an issue on GitHub:
              </p>
              <a
                href={repository + "/issues"}
                target="_blank"
                rel="noopener noreferrer"
                class="inline-flex items-center gap-2 bg-kursal-700 hover:bg-kursal-600 text-kursal-100 px-4 py-2 rounded-lg transition-colors"
              >
                <SiGithub size={18} />
                Open GitHub Issue
              </a>
            </div>

            <div>
              <h3
                class="text-lg font-semibold text-white mb-3 flex items-center gap-2"
              >
                <Mail size={20} class="text-red-400" />
                Security Vulnerabilities
              </h3>
              <p class="text-kursal-100 mb-4">
                For security-sensitive issues that could compromise user privacy
                or safety, please contact us directly:
              </p>
              <div
                class="bg-kursal-900/50 border border-kursal-700 rounded-lg p-4 mb-4"
              >
                <a href={"mailto:" + email} class="text-accent-400 font-mono"
                  >{email}</a
                >
              </div>
              <div class="space-y-2">
                <div class="flex items-center gap-3 text-kursal-50">
                  <div class="w-1.5 h-1.5 rounded-full bg-accent-500"></div>
                  <span
                    >Include detailed steps to reproduce the vulnerability</span
                  >
                </div>
                <div class="flex items-center gap-3 text-kursal-50">
                  <div class="w-1.5 h-1.5 rounded-full bg-accent-500"></div>
                  <span
                    >Allow 90 days to address the issue before public disclosure</span
                  >
                </div>
                <div class="flex items-center gap-3 text-kursal-50">
                  <div class="w-1.5 h-1.5 rounded-full bg-accent-500"></div>
                  <span
                    >We aim to acknowledge receipt within 48 hours, though
                    response times may vary as we're a small team</span
                  >
                </div>
              </div>
            </div>

            <div>
              <h3
                class="text-lg font-semibold text-white mb-3 flex items-center gap-2"
              >
                <CircleCheckBig size={20} class="text-green-400" />
                Our Commitment
              </h3>
              <div class="space-y-2">
                <div class="flex items-center gap-3 text-kursal-50">
                  <div class="w-1.5 h-1.5 rounded-full bg-accent-500"></div>
                  <span
                    >Credit in our security acknowledgments (if desired)</span
                  >
                </div>
                <div class="flex items-center gap-3 text-kursal-50">
                  <div class="w-1.5 h-1.5 rounded-full bg-accent-500"></div>
                  <span
                    >Regular updates on our progress addressing the issue</span
                  >
                </div>
                <div class="flex items-center gap-3 text-kursal-50">
                  <div class="w-1.5 h-1.5 rounded-full bg-accent-500"></div>
                  <span>Transparent communication throughout the process</span>
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>

      <section>
        <div class="flex items-center gap-3 mb-6">
          <FileText size={28} class="text-green-400" />
          <h2 class="text-2xl md:text-3xl font-semibold text-white">
            Security Practices
          </h2>
        </div>
        <div
          class="bg-kursal-800/50 rounded-2xl border border-kursal-700 p-6 md:p-8"
        >
          <div class="grid md:grid-cols-2 gap-8">
            <div>
              <h3
                class="text-lg font-semibold text-white mb-4 flex items-center gap-2"
              >
                <Search size={18} class="text-accent-400" />
                Code Security
              </h3>
              <div class="space-y-2">
                <div class="flex items-center gap-3 text-kursal-50">
                  <div class="w-1.5 h-1.5 rounded-full bg-accent-500"></div>
                  <span>All code is open source and publicly auditable</span>
                </div>
                <div class="flex items-center gap-3 text-kursal-50">
                  <div class="w-1.5 h-1.5 rounded-full bg-accent-500"></div>
                  <span>Continuous dependency vulnerability monitoring</span>
                </div>
              </div>
            </div>
            <div>
              <h3
                class="text-lg font-semibold text-white mb-4 flex items-center gap-2"
              >
                <Server size={18} class="text-accent-400" />
                Infrastructure
              </h3>
              <div class="space-y-2">
                <div class="flex items-center gap-3 text-kursal-50">
                  <div class="w-1.5 h-1.5 rounded-full bg-accent-500"></div>
                  <span>All communications are end-to-end encrypted</span>
                </div>
                <div class="flex items-center gap-3 text-kursal-50">
                  <div class="w-1.5 h-1.5 rounded-full bg-accent-500"></div>
                  <span>Resistant decentralized network</span>
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>
    </div>

    <div
      class="mt-12 p-6 bg-kursal-800/30 rounded-2xl border border-kursal-700 text-center"
    >
      <p class="text-kursal-100 text-sm">
        For more details on our cryptographic implementation, read our
        <a
          href={PAPER_URL}
          target="_blank"
          class="text-accent-400 hover:underline"
        >
          technical paper
        </a>
        or review the
        <a
          href={repository}
          target="_blank"
          rel="noopener noreferrer"
          class="text-accent-400 hover:underline"
        >
          source code
        </a>.
      </p>
    </div>
  </div>
</main>

<Footer />
