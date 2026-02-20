<script lang="ts">
  import { FileText, Lock, Mail, Scale, Shield, Activity } from "lucide-svelte";
  import { repository, email, PAPER_URL } from "$lib/const";
  import { SiGithub } from "@icons-pack/svelte-simple-icons";
</script>

<footer class="bg-kursal-800 border-t border-kursal-700">
  <div class="max-w-6xl mx-auto px-6 py-12">
    <div class="grid grid-cols-2 md:grid-cols-4 gap-8">
      <div class="col-span-2 md:col-span-2">
        <div class="flex items-center gap-3 mb-4">
          <img src="/icon.png" alt="Kursal" class="w-8 h-8" />
          <span class="text-xl font-semibold text-kursal-50">Kursal Chat</span>
        </div>
        <p class="text-kursal-300 max-w-md">
          Peer-to-peer, end-to-end encrypted messaging. Your conversations
          belong to you, not to servers.
        </p>
      </div>

      <div>
        <h3 class="text-kursal-50 font-semibold mb-4">Resources</h3>
        <ul class="space-y-2">
          <li>
            <a
              href={repository}
              target="_blank"
              rel="noopener noreferrer"
              class="text-kursal-300 hover:text-kursal-50 transition-colors flex items-center gap-2"
            >
              <SiGithub size={16} />
              GitHub
            </a>
          </li>
          <li>
            <a
              href={PAPER_URL}
              target="_blank"
              class="text-kursal-300 hover:text-kursal-50 transition-colors flex items-center gap-2"
            >
              <FileText size={16} />
              Whitepaper
            </a>
          </li>
          <li>
            <a
              href={"mailto:" + email}
              class="text-kursal-300 hover:text-kursal-50 transition-colors flex items-center gap-2"
            >
              <Mail size={16} />
              Contact
            </a>
          </li>
          <li>
            <a
              href="/progress"
              class="text-kursal-300 hover:text-kursal-50 transition-colors flex items-center gap-2"
            >
              <Activity size={16} />
              Progress
            </a>
          </li>
        </ul>
      </div>

      <div>
        <h3 class="text-kursal-50 font-semibold mb-4">Legal</h3>
        <ul class="space-y-2">
          <li>
            <a
              href="/security"
              class="text-kursal-300 hover:text-kursal-50 transition-colors flex items-center gap-2"
            >
              <Shield size={16} />
              Security
            </a>
          </li>
          <li>
            <a
              href="/privacy"
              class="text-kursal-300 hover:text-kursal-50 transition-colors flex items-center gap-2"
            >
              <Lock size={16} />
              Privacy Policy
            </a>
          </li>
          <li>
            <a
              href="/terms"
              class="text-kursal-300 hover:text-kursal-50 transition-colors flex items-center gap-2"
            >
              <Scale size={16} />
              Terms of Service
            </a>
          </li>
        </ul>
      </div>
    </div>

    <div
      class="mt-12 pt-8 border-t border-kursal-700 text-center text-kursal-300 text-sm"
    >
      <p class="mt-2">
        © {new Date().getFullYear()} Kursal Chat - AGPL-3.0 License
      </p>
      <p class="mt-2">
        Made with ❤️ by <a
          href="https://github.com/KodeurKubik"
          target="_blank"
          class="text-kursal-300 hover:text-kursal-50 transition-colors underline"
          >Kodeur_Kubik</a
        >
        & Arlo
      </p>
    </div>
  </div>
</footer>
