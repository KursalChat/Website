<script lang="ts">
  import {
    FileText,
    Lock,
    Mail,
    Scale,
    Shield,
    Activity,
    Award,
    GitCompare,
  } from "lucide-svelte";
  import { repository, email, PAPER_URL } from "$lib/const";
  import { SiGithub } from "@icons-pack/svelte-simple-icons";
</script>

<footer class="bg-kursal-950 border-t border-kursal-700">
  <div class="max-w-6xl mx-auto px-6 py-12">
    <div class="grid grid-cols-2 md:grid-cols-4 gap-8">
      <div class="col-span-2 md:col-span-2">
        <div class="flex items-center gap-2.5 mb-4">
          <img
            fetchpriority="high"
            src="/icon.png"
            alt="Kursal"
            class="w-7 h-7"
          />
          <span class="font-mono text-lg font-semibold text-kursal-50"
            >kursal<span class="text-accent-500">:~$</span></span
          >
        </div>
        <p class="text-kursal-300 max-w-md leading-relaxed">
          Peer-to-peer, end-to-end encrypted messaging. Your conversations
          belong to you, not to servers.
        </p>
        <div class="mt-4 font-mono text-sm">
          <a
            href={"mailto:" + email}
            class="text-kursal-400 hover:text-accent-400 transition-colors"
          >
            {email}
          </a>
        </div>
      </div>

      <div>
        <h3
          class="font-mono text-xs uppercase tracking-widest text-kursal-500 mb-4"
        >
          Resources
        </h3>
        <ul class="space-y-2.5 text-sm">
          <li>
            <a
              href={repository}
              target="_blank"
              rel="noopener noreferrer"
              class="text-kursal-300 hover:text-accent-400 transition-colors flex items-center gap-2"
            >
              <SiGithub size={15} />
              GitHub
            </a>
          </li>
          <li>
            <a
              href={PAPER_URL}
              target="_blank"
              class="text-kursal-300 hover:text-accent-400 transition-colors flex items-center gap-2"
            >
              <FileText size={15} />
              Whitepaper
            </a>
          </li>
          <li>
            <a
              href={"mailto:" + email}
              class="text-kursal-300 hover:text-accent-400 transition-colors flex items-center gap-2"
            >
              <Mail size={15} />
              Contact
            </a>
          </li>
          <li>
            <a
              href="/compare"
              class="text-kursal-300 hover:text-accent-400 transition-colors flex items-center gap-2"
            >
              <GitCompare size={15} />
              Compare
            </a>
          </li>
          <li>
            <a
              href="/progress"
              class="text-kursal-300 hover:text-accent-400 transition-colors flex items-center gap-2"
            >
              <Activity size={15} />
              Progress
            </a>
          </li>
          <li>
            <a
              href="/credits"
              class="text-kursal-300 hover:text-accent-400 transition-colors flex items-center gap-2"
            >
              <Award size={15} />
              Credits
            </a>
          </li>
        </ul>
      </div>

      <div>
        <h3
          class="font-mono text-xs uppercase tracking-widest text-kursal-500 mb-4"
        >
          Legal
        </h3>
        <ul class="space-y-2.5 text-sm">
          <li>
            <a
              href="/security"
              class="text-kursal-300 hover:text-accent-400 transition-colors flex items-center gap-2"
            >
              <Shield size={15} />
              Security
            </a>
          </li>
          <li>
            <a
              href="/privacy"
              class="text-kursal-300 hover:text-accent-400 transition-colors flex items-center gap-2"
            >
              <Lock size={15} />
              Privacy Policy
            </a>
          </li>
          <li>
            <a
              href="/terms"
              class="text-kursal-300 hover:text-accent-400 transition-colors flex items-center gap-2"
            >
              <Scale size={15} />
              Terms of Service
            </a>
          </li>
        </ul>
      </div>
    </div>

    <div
      class="mt-12 pt-8 border-t border-kursal-700 text-center font-mono text-sm text-kursal-400"
    >
      <p>
        © {new Date().getFullYear()} Kursal Chat — AGPL-3.0 License
      </p>
      <p class="mt-2">
        Made with <span class="text-accent-500">❤</span> by
        <a
          href="https://github.com/KodeurKubik"
          target="_blank"
          class="text-kursal-300 hover:text-accent-400 transition-colors underline underline-offset-2"
          >Kodeur_Kubik</a
        >
        & Arlo
      </p>
    </div>
  </div>
</footer>
