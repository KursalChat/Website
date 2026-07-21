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
    Landmark,
  } from "lucide-svelte";
  import { repository, email, PAPER_URL } from "$lib/const";
  import { SiGithub } from "@icons-pack/svelte-simple-icons";
</script>

<footer class="border-t border-kursal-700 bg-kursal-950">
  <div class="mx-auto max-w-6xl px-6 py-12">
    <div class="grid grid-cols-2 gap-8 md:grid-cols-4">
      <div class="col-span-2 md:col-span-2">
        <div class="mb-4 flex items-center gap-2.5">
          <img
            src="/icon.png"
            alt="Kursal"
            width="28"
            height="28"
            loading="lazy"
            class="h-7 w-7"
          />
          <span class="font-mono text-lg font-semibold text-kursal-50"
            >kursal<span class="text-accent-500">:~$</span></span
          >
        </div>
        <p class="max-w-md leading-relaxed text-kursal-300">
          Peer-to-peer, end-to-end encrypted messaging. Your conversations
          belong to you, not to servers.
        </p>
        <div class="mt-4 font-mono text-sm">
          <a
            href={"mailto:" + email}
            class="text-kursal-400 transition-colors hover:text-accent-400"
          >
            {email}
          </a>
        </div>
      </div>

      <div>
        <h3
          class="mb-4 font-mono text-xs tracking-widest text-kursal-500 uppercase"
        >
          Resources
        </h3>
        <ul class="space-y-2.5 text-sm">
          <li>
            <a
              href={repository}
              target="_blank"
              rel="noopener noreferrer"
              class="flex items-center gap-2 text-kursal-300 transition-colors hover:text-accent-400"
            >
              <SiGithub size={15} />
              GitHub
            </a>
          </li>
          <li>
            <a
              href={PAPER_URL}
              target="_blank"
              rel="noopener noreferrer"
              class="flex items-center gap-2 text-kursal-300 transition-colors hover:text-accent-400"
            >
              <FileText size={15} />
              Whitepaper
            </a>
          </li>
          <li>
            <a
              href="/compare"
              class="flex items-center gap-2 text-kursal-300 transition-colors hover:text-accent-400"
            >
              <GitCompare size={15} />
              Compare
            </a>
          </li>
          <li>
            <a
              href="/progress"
              class="flex items-center gap-2 text-kursal-300 transition-colors hover:text-accent-400"
            >
              <Activity size={15} />
              Progress
            </a>
          </li>
          <li>
            <a
              href="/credits"
              class="flex items-center gap-2 text-kursal-300 transition-colors hover:text-accent-400"
            >
              <Award size={15} />
              Credits
            </a>
          </li>
        </ul>
      </div>

      <div>
        <h3
          class="mb-4 font-mono text-xs tracking-widest text-kursal-500 uppercase"
        >
          Legal
        </h3>
        <ul class="space-y-2.5 text-sm">
          <li>
            <a
              href="/security"
              class="flex items-center gap-2 text-kursal-300 transition-colors hover:text-accent-400"
            >
              <Shield size={15} />
              Security
            </a>
          </li>
          <li>
            <a
              href="/privacy"
              class="flex items-center gap-2 text-kursal-300 transition-colors hover:text-accent-400"
            >
              <Lock size={15} />
              Privacy Policy
            </a>
          </li>
          <li>
            <a
              href="/terms"
              class="flex items-center gap-2 text-kursal-300 transition-colors hover:text-accent-400"
            >
              <Scale size={15} />
              Terms of Service
            </a>
          </li>
          <li>
            <a
              href="/legal"
              class="flex items-center gap-2 text-kursal-300 transition-colors hover:text-accent-400"
            >
              <Landmark size={15} />
              Legal Notice
            </a>
          </li>
        </ul>
      </div>
    </div>

    <div
      class="mt-12 border-t border-kursal-700 pt-8 text-center font-mono text-sm text-kursal-400"
    >
      <p>
        © {new Date().getFullYear()} Kursal Chat — AGPL-3.0 License
      </p>
      <p class="mt-2">
        Made with <span class="text-accent-500">❤</span> by
        <a
          href="https://github.com/KodeurKubik"
          target="_blank"
          rel="noopener noreferrer"
          class="text-kursal-300 underline underline-offset-2 transition-colors hover:text-accent-400"
          >Kodeur_Kubik</a
        >
        &
        <a
          href="https://github.com/Arlo-real"
          target="_blank"
          rel="noopener noreferrer"
          class="text-kursal-300 underline underline-offset-2 transition-colors hover:text-accent-400"
          >Arlo</a
        >
      </p>
    </div>
  </div>
</footer>
