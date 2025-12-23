<script lang="ts">
  import { onMount } from "svelte";
  import { Lock, LockOpen, ShieldCheck, ShieldAlert } from "lucide-svelte";

  let scrollProgress = $state(0);
  let containerElement: HTMLElement;

  const plaintextMessages = [
    { from: "left", text: "Hey! Meeting at 5pm?" },
    { from: "right", text: "Sounds good to me!" },
    { from: "left", text: "Great, see you there! 🎉" },
  ];

  const SCRAMBLE_CHARS = "#$%&@0123456789 ABCDEFabcdef";

  function scrambleText(text: string): string {
    return text
      .split("")
      .map(
        () => SCRAMBLE_CHARS[Math.floor(Math.random() * SCRAMBLE_CHARS.length)]
      )
      .join("");
  }

  let isEncrypted = $derived(scrollProgress > 0.3);

  type MessageState = {
    from: string;
    text: string;
    key: number;
    phase: "sending" | "transit" | "received";
    transitProgress: number;
  };

  let messageStates = $derived.by(() => {
    const states: MessageState[] = [];
    const messageInterval = 0.22;
    const sendDuration = 0.01;
    const transitDuration = 0.22;
    const receiveDelay = 0.12;

    for (let i = 0; i < plaintextMessages.length; i++) {
      const previousMessagesDelay = i > 0 ? receiveDelay * i : 0;
      const messageStart = i * messageInterval + previousMessagesDelay;
      if (scrollProgress <= messageStart) continue;

      const elapsed = scrollProgress - messageStart;

      let phase: "sending" | "transit" | "received";
      let transitProgress = 0;

      if (elapsed < sendDuration) {
        phase = "sending";
      } else if (elapsed < sendDuration + transitDuration) {
        phase = "transit";
        transitProgress = (elapsed - sendDuration) / transitDuration;
      } else {
        phase = "received";
        transitProgress = 1;
      }

      states.push({
        from: plaintextMessages[i].from,
        text: plaintextMessages[i].text,
        key: i,
        phase,
        transitProgress: Math.min(1, Math.max(0, transitProgress)),
      });
    }
    return states;
  });

  let aliceMessages = $derived.by(() => {
    const msgs: Array<{ text: string; key: number; isSent: boolean }> = [];
    for (const m of messageStates) {
      if (m.from === "left") {
        msgs.push({
          text: plaintextMessages[m.key].text,
          key: m.key,
          isSent: true,
        });
      } else if (m.phase === "received") {
        msgs.push({
          text: plaintextMessages[m.key].text,
          key: m.key,
          isSent: false,
        });
      }
    }
    return msgs.sort((a, b) => a.key - b.key);
  });

  let bobMessages = $derived.by(() => {
    const msgs: Array<{ text: string; key: number; isSent: boolean }> = [];
    for (const m of messageStates) {
      if (m.from === "right") {
        msgs.push({
          text: plaintextMessages[m.key].text,
          key: m.key,
          isSent: true,
        });
      } else if (m.phase === "received") {
        msgs.push({
          text: plaintextMessages[m.key].text,
          key: m.key,
          isSent: false,
        });
      }
    }
    return msgs.sort((a, b) => a.key - b.key);
  });

  let transitMessages = $derived(
    messageStates
      .filter((m) => m.phase === "transit")
      .map((m) => {
        let displayText: string;
        if (isEncrypted) {
          displayText = scrambleText(plaintextMessages[m.key].text);
        } else {
          displayText = plaintextMessages[m.key].text;
        }

        return {
          from: m.from,
          text: displayText,
          key: m.key,
          progress: m.transitProgress,
        };
      })
  );

  onMount(() => {
    const handleScroll = () => {
      if (!containerElement) return;
      const rect = containerElement.getBoundingClientRect();
      const scrollableDistance = rect.height - window.innerHeight;
      const scrolled = -rect.top;
      scrollProgress = Math.max(0, Math.min(1, scrolled / scrollableDistance));
    };

    window.addEventListener("scroll", handleScroll, { passive: true });
    handleScroll();
    return () => window.removeEventListener("scroll", handleScroll);
  });
</script>

<section id="animation" bind:this={containerElement} class="relative h-[400vh]">
  <div
    class="sticky top-0 h-screen flex items-center justify-center overflow-hidden transition-colors duration-700"
    style="background: {isEncrypted
      ? 'radial-gradient(ellipse at center, rgba(34, 197, 94, 0.15) 0%, rgba(10, 13, 20, 1) 70%)'
      : 'radial-gradient(ellipse at center, rgba(239, 68, 68, 0.15) 0%, rgba(10, 13, 20, 1) 70%)'}"
  >
    <div
      class="absolute inset-0 transition-opacity duration-700"
      style="background: radial-gradient(circle at 50% 50%, {isEncrypted
        ? 'rgba(34, 197, 94, 0.1)'
        : 'rgba(239, 68, 68, 0.1)'} 0%, transparent 50%); opacity: {0.5 +
        scrollProgress * 0.5}"
    ></div>

    <div class="max-w-6xl w-full px-3 md:px-6 relative z-10">
      <div class="text-center mb-8 md:mb-12">
        <div
          class="inline-flex items-center gap-2 px-4 py-2 rounded-full mb-4 transition-all duration-500 {isEncrypted
            ? 'bg-green-500/20 text-green-400'
            : 'bg-red-500/20 text-red-400'}"
        >
          {#if isEncrypted}
            <ShieldCheck size={20} />
            <span class="font-medium">Protected</span>
          {:else}
            <ShieldAlert size={20} />
            <span class="font-medium">Unprotected</span>
          {/if}
        </div>

        <h2 class="text-2xl md:text-4xl font-bold text-kursal-50 mb-3">
          {#if isEncrypted}
            <span class="text-green-400">End-to-End Encrypted</span>
          {:else}
            Your Messages, Exposed
          {/if}
        </h2>
        <p class="text-kursal-300 text-sm md:text-lg max-w-lg mx-auto">
          {#if isEncrypted}
            Only you and the recipient can read these messages
          {:else}
            Without encryption, anyone can intercept your conversations
          {/if}
        </p>
      </div>

      <div class="flex items-stretch justify-center gap-6 sm:gap-12 lg:gap-24">
        <div class="flex flex-col items-center z-10">
          <div class="relative">
            <div
              class="absolute -inset-3 rounded-2xl transition-all duration-500 blur-xl {isEncrypted
                ? 'bg-green-500/30'
                : 'bg-red-500/20'}"
            ></div>
            <div
              class="relative bg-kursal-800 rounded-lg sm:rounded-xl border-2 transition-colors duration-500 {isEncrypted
                ? 'border-green-500/50'
                : 'border-red-500/30'} shadow-2xl overflow-hidden"
            >
              <div
                class="w-[140px] h-[100px] sm:w-[200px] sm:h-[140px] lg:w-[320px] lg:h-[220px] p-1.5 sm:p-2 lg:p-4"
              >
                <div
                  class="flex items-center gap-1 sm:gap-1.5 mb-1.5 sm:mb-2 lg:mb-3"
                >
                  <div
                    class="w-1.5 h-1.5 sm:w-2 sm:h-2 lg:w-3 lg:h-3 rounded-full transition-colors duration-500 {isEncrypted
                      ? 'bg-green-400'
                      : 'bg-red-400'}"
                  ></div>
                  <div
                    class="w-1.5 h-1.5 sm:w-2 sm:h-2 lg:w-3 lg:h-3 rounded-full bg-kursal-600"
                  ></div>
                  <div
                    class="w-1.5 h-1.5 sm:w-2 sm:h-2 lg:w-3 lg:h-3 rounded-full bg-kursal-600"
                  ></div>
                  <div
                    class="flex-1 h-2 sm:h-3 lg:h-5 bg-kursal-700 rounded ml-1 sm:ml-2"
                  ></div>
                </div>
                <div class="space-y-1 sm:space-y-1.5 lg:space-y-2">
                  {#each aliceMessages as message (message.key)}
                    <div
                      class="animate-fade-in {message.isSent
                        ? ''
                        : 'text-right'}"
                    >
                      <div
                        class="inline-block px-1.5 py-0.5 sm:px-2 sm:py-1 lg:px-3 lg:py-1.5 rounded-md sm:rounded-lg text-[10px] sm:text-xs lg:text-sm max-w-[95%] {message.isSent
                          ? 'bg-accent-500 text-white rounded-bl-sm'
                          : 'bg-kursal-600 text-kursal-100 rounded-br-sm'}"
                      >
                        {message.text}
                      </div>
                    </div>
                  {/each}
                </div>
              </div>
              <div
                class="h-2 sm:h-3 lg:h-5 bg-kursal-700 rounded-b-lg flex items-center justify-center"
              >
                <div
                  class="w-6 sm:w-10 lg:w-16 h-0.5 sm:h-1 lg:h-1.5 bg-kursal-600 rounded-full"
                ></div>
              </div>
            </div>
          </div>
          <span
            class="mt-2 sm:mt-3 text-kursal-300 text-[10px] sm:text-xs lg:text-sm font-medium"
            >Alice</span
          >
        </div>

        <div
          class="flex flex-col items-center justify-center gap-2 sm:gap-3 lg:gap-4 relative min-w-[120px] sm:min-w-[180px] lg:min-w-[280px]"
        >
          <div
            class="absolute inset-x-0 top-0 flex items-center justify-center pointer-events-none z-0"
            style="height: 100%"
          >
            {#each transitMessages as transit (transit.key)}
              {@const fromLeft = transit.from === "left"}
              {@const eased =
                transit.progress < 0.5
                  ? 2 * transit.progress * transit.progress
                  : 1 - Math.pow(-2 * transit.progress + 2, 2) / 2}
              {@const xPos = fromLeft ? -80 + eased * 160 : 80 - eased * 160}
              <div
                class="absolute px-2 py-1 sm:px-3 sm:py-1.5 rounded-lg text-[10px] sm:text-sm lg:text-base whitespace-nowrap transition-colors duration-300 font-medium {isEncrypted
                  ? 'bg-green-500 text-white'
                  : 'bg-red-500 text-white'} shadow-xl"
                style="transform: translateX({xPos}%)"
              >
                {transit.text}
              </div>
            {/each}
          </div>

          <div class="relative z-10">
            <div
              class="absolute -inset-3 sm:-inset-4 rounded-full blur-2xl transition-all duration-500 {isEncrypted
                ? 'bg-green-500/40'
                : 'bg-red-500/30'}"
            ></div>
            <div
              class="relative w-10 h-10 sm:w-14 sm:h-14 lg:w-24 lg:h-24 rounded-full flex items-center justify-center transition-all duration-500 {isEncrypted
                ? 'bg-green-500 shadow-lg shadow-green-500/50'
                : 'bg-red-500/80 shadow-lg shadow-red-500/50'}"
            >
              {#if isEncrypted}
                <Lock
                  class="text-white w-5 h-5 sm:w-7 sm:h-7 lg:w-12 lg:h-12"
                />
              {:else}
                <LockOpen
                  class="text-white w-5 h-5 sm:w-7 sm:h-7 lg:w-12 lg:h-12"
                />
              {/if}
            </div>
          </div>

          <div class="hidden sm:block h-8 z-10"></div>

          <div
            class="w-1 h-12 sm:h-16 lg:h-24 bg-kursal-700 rounded-full overflow-hidden z-10"
          >
            <div
              class="w-full transition-colors duration-500 {isEncrypted
                ? 'bg-green-500'
                : 'bg-red-500'}"
              style="height: {scrollProgress * 100}%"
            ></div>
          </div>
        </div>

        <div class="flex flex-col items-center z-10">
          <div class="relative">
            <div
              class="absolute -inset-3 rounded-2xl transition-all duration-500 blur-xl {isEncrypted
                ? 'bg-green-500/30'
                : 'bg-red-500/20'}"
            ></div>
            <div
              class="relative bg-kursal-800 rounded-lg sm:rounded-xl border-2 transition-colors duration-500 {isEncrypted
                ? 'border-green-500/50'
                : 'border-red-500/30'} shadow-2xl overflow-hidden"
            >
              <div
                class="w-[140px] h-[100px] sm:w-[200px] sm:h-[140px] lg:w-[320px] lg:h-[220px] p-1.5 sm:p-2 lg:p-4"
              >
                <div
                  class="flex items-center gap-1 sm:gap-1.5 mb-1.5 sm:mb-2 lg:mb-3"
                >
                  <div
                    class="w-1.5 h-1.5 sm:w-2 sm:h-2 lg:w-3 lg:h-3 rounded-full transition-colors duration-500 {isEncrypted
                      ? 'bg-green-400'
                      : 'bg-red-400'}"
                  ></div>
                  <div
                    class="w-1.5 h-1.5 sm:w-2 sm:h-2 lg:w-3 lg:h-3 rounded-full bg-kursal-600"
                  ></div>
                  <div
                    class="w-1.5 h-1.5 sm:w-2 sm:h-2 lg:w-3 lg:h-3 rounded-full bg-kursal-600"
                  ></div>
                  <div
                    class="flex-1 h-2 sm:h-3 lg:h-5 bg-kursal-700 rounded ml-1 sm:ml-2"
                  ></div>
                </div>
                <div class="space-y-1 sm:space-y-1.5 lg:space-y-2">
                  {#each bobMessages as message (message.key)}
                    <div
                      class="animate-fade-in {message.isSent
                        ? ''
                        : 'text-right'}"
                    >
                      <div
                        class="inline-block px-1.5 py-0.5 sm:px-2 sm:py-1 lg:px-3 lg:py-1.5 rounded-md sm:rounded-lg text-[10px] sm:text-xs lg:text-sm max-w-[95%] {message.isSent
                          ? 'bg-accent-500 text-white rounded-bl-sm'
                          : 'bg-kursal-600 text-kursal-100 rounded-br-sm'}"
                      >
                        {message.text}
                      </div>
                    </div>
                  {/each}
                </div>
              </div>
              <div
                class="h-2 sm:h-3 lg:h-5 bg-kursal-700 rounded-b-lg flex items-center justify-center"
              >
                <div
                  class="w-6 sm:w-10 lg:w-16 h-0.5 sm:h-1 lg:h-1.5 bg-kursal-600 rounded-full"
                ></div>
              </div>
            </div>
          </div>
          <span
            class="mt-2 sm:mt-3 text-kursal-300 text-[10px] sm:text-xs lg:text-sm font-medium"
            >Bob</span
          >
        </div>
      </div>
    </div>
  </div>
</section>

<style>
  @keyframes fade-in {
    from {
      opacity: 0;
      transform: translateY(8px);
    }
    to {
      opacity: 1;
      transform: translateY(0);
    }
  }

  .animate-fade-in {
    animation: fade-in 0.3s ease-out;
  }
</style>
