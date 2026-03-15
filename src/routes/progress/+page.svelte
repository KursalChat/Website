<script lang="ts">
  import {
    ArrowLeft,
    CircleCheckBig,
    LoaderCircle,
    Circle,
    FileText,
    FlaskConical,
    Server,
    Monitor,
    Users,
    Radio,
  } from "lucide-svelte";
  import Navbar from "$lib/components/Navbar.svelte";
  import Footer from "$lib/components/Footer.svelte";

  const milestones: Milestone[] = [
    {
      title: "Paper & Website",
      description:
        "Published the Kursal technical paper and launched the project website.",
      date: "December 24, 2025",
      status: "completed",
      icon: FileText,
    },
    {
      title: "Prototype",
      description: "Completed first working prototype - the core idea works!",
      date: "January 1, 2026",
      status: "completed",
      icon: FlaskConical,
    },
    {
      title: "Internal API",
      description: "Building the core API layer that powers the app.",
      status: "in-progress",
      icon: Server,
      subtasks: [
        { label: "Workspace Scaffolding", done: true },
        { label: "Core Dependencies", done: true },
        { label: "Error Types", done: true },
        { label: "Storage Layer", done: true },
        { label: "Identity Layer", done: true },
        { label: "Crypto Layer", done: true },
        { label: "Message Types", done: true },
        { label: "Network Layer", done: true },
        { label: "Peer ID Rotation", done: true },
        { label: "DHT Rendezvous", done: true },
        { label: "Contact Management", done: true },
        { label: "First Contact: OTP", done: true },
        { label: "First Contact: LTC", done: true },
        { label: "First Contact: Nearby Share", done: false },
        { label: "Messaging Pipeline", done: false },
        { label: "Tauri Wrapper", done: false },
        { label: "Local API Server", done: false },
      ],
    },
    {
      title: "Interface",
      description: "Designing and implementing the application interface.",
      status: "future",
      icon: Monitor,
    },
    {
      title: "Groups",
      description: "Support for group conversations.",
      status: "future",
      icon: Users,
    },
    {
      title: "Broadcast Channels",
      description: "Broadcasting channels for communities announcement.",
      status: "future",
      icon: Radio,
    },
  ];

  interface SubTask {
    label: string;
    done: boolean;
  }

  interface Milestone {
    title: string;
    description?: string;
    date?: string;
    status: "completed" | "in-progress" | "future";
    icon: typeof CircleCheckBig;
    subtasks?: SubTask[];
  }

  const completedCount = milestones.filter(
    (m) => m.status === "completed",
  ).length;
  const totalCount = milestones.length;

  function statusColor(status: Milestone["status"]) {
    switch (status) {
      case "completed":
        return "text-green-400";
      case "in-progress":
        return "text-accent-400";
      case "future":
        return "text-kursal-400";
    }
  }

  function statusBg(status: Milestone["status"]) {
    switch (status) {
      case "completed":
        return "bg-green-400/20 border-green-400/40";
      case "in-progress":
        return "bg-accent-500/20 border-accent-500/40";
      case "future":
        return "bg-kursal-700/50 border-kursal-600";
    }
  }

  function lineColor(status: Milestone["status"]) {
    switch (status) {
      case "completed":
        return "bg-green-400/60";
      case "in-progress":
        return "bg-accent-500/40";
      case "future":
        return "bg-kursal-600";
    }
  }

  function badgeLabel(status: Milestone["status"]) {
    switch (status) {
      case "completed":
        return "Completed";
      case "in-progress":
        return "In Progress";
      case "future":
        return "Planned";
    }
  }

  function badgeClass(status: Milestone["status"]) {
    switch (status) {
      case "completed":
        return "bg-green-400/10 text-green-400 border border-green-400/30";
      case "in-progress":
        return "bg-accent-500/10 text-accent-400 border border-accent-500/30";
      case "future":
        return "bg-kursal-700/50 text-kursal-300 border border-kursal-600";
    }
  }
</script>

<Navbar />

<main class="min-h-screen pt-24 pb-16 bg-kursal-900">
  <div class="max-w-3xl mx-auto px-6">
    <a
      href="/"
      onclick={() => window.scrollTo(0, 0)}
      class="inline-flex items-center gap-2 text-kursal-400 hover:text-kursal-300 transition-colors mb-8"
    >
      <ArrowLeft size={18} />
      Back to home
    </a>

    <!-- Header -->
    <div class="text-center mb-14">
      <div
        class="w-20 h-20 bg-accent-500/20 rounded-2xl flex items-center justify-center mx-auto mb-6"
      >
        <img src="/icon.png" alt="Kursal" class="w-18 h-18" />
      </div>
      <h1 class="text-4xl md:text-5xl font-bold text-white mb-4">
        Development Progress
      </h1>
      <p class="text-xl text-kursal-100 max-w-2xl mx-auto">
        Follow along as we build Kursal: from paper to production.
      </p>

      <!-- Overall progress bar -->
      <div class="mt-8 max-w-md mx-auto">
        <div class="flex justify-between text-sm text-kursal-200 mb-2">
          <span>{completedCount} of {totalCount} milestones completed</span>
          <span>{Math.round((completedCount / totalCount) * 100)}%</span>
        </div>
        <div class="h-2 bg-kursal-700 rounded-full overflow-hidden">
          <div
            class="h-full bg-gradient-to-r from-green-400 to-accent-400 rounded-full transition-all duration-700"
            style="width: {(completedCount / totalCount) * 100}%"
          ></div>
        </div>
      </div>
    </div>

    <!-- Timeline -->
    <div class="relative">
      {#each milestones as milestone, i}
        <div class="relative flex gap-6 pb-12 last:pb-0">
          <!-- Timeline line & dot -->
          <div class="flex flex-col items-center">
            <div
              class="w-11 h-11 rounded-full border-2 flex items-center justify-center shrink-0 {statusBg(
                milestone.status,
              )}"
            >
              {#if milestone.status === "completed"}
                <CircleCheckBig size={20} class="text-green-400" />
              {:else if milestone.status === "in-progress"}
                <LoaderCircle
                  size={20}
                  class="text-accent-400 animate-spin"
                  style="animation-duration: 3s"
                />
              {:else}
                <Circle size={20} class="text-kursal-400" />
              {/if}
            </div>
            {#if i < milestones.length - 1}
              <div class="w-0.5 grow mt-2 {lineColor(milestone.status)}"></div>
            {/if}
          </div>

          <!-- Content -->
          <div class="pt-1.5 pb-2 min-w-0">
            <div class="flex flex-wrap items-center gap-3 mb-1">
              <h3
                class="text-xl font-semibold text-white flex items-center gap-2"
              >
                <svelte:component
                  this={milestone.icon}
                  size={20}
                  class={statusColor(milestone.status)}
                />
                {milestone.title}
              </h3>
              <span
                class="text-xs font-medium px-2.5 py-0.5 rounded-full {badgeClass(
                  milestone.status,
                )}"
              >
                {badgeLabel(milestone.status)}
              </span>
            </div>

            {#if milestone.date}
              <p class="text-sm text-kursal-300 mb-2">{milestone.date}</p>
            {/if}

            {#if milestone.description}
              <p class="text-kursal-100 text-sm leading-relaxed">
                {milestone.description}
              </p>
            {/if}

            {#if milestone.subtasks}
              <div class="mt-3 space-y-2">
                {#each milestone.subtasks as sub}
                  <div class="flex items-center gap-2.5 text-sm">
                    {#if sub.done}
                      <CircleCheckBig
                        size={15}
                        class="text-green-400 shrink-0"
                      />
                      <span class="text-kursal-100">{sub.label}</span>
                    {:else}
                      <Circle size={15} class="text-kursal-400 shrink-0" />
                      <span class="text-kursal-300">{sub.label}</span>
                    {/if}
                  </div>
                {/each}
              </div>
              <!-- Subtasks -->
              {@const doneCount = milestone.subtasks.filter(
                (s) => s.done,
              ).length}
              <div class="mt-3 max-w-xs">
                <div class="h-1.5 bg-kursal-700 rounded-full overflow-hidden">
                  <div
                    class="h-full bg-accent-400/70 rounded-full transition-all duration-500"
                    style="width: {milestone.subtasks.length > 0
                      ? (doneCount / milestone.subtasks.length) * 100
                      : 0}%"
                  ></div>
                </div>
                <p class="text-xs text-kursal-400 mt-1">
                  {doneCount} / {milestone.subtasks.length} subtasks
                </p>
              </div>
            {/if}
          </div>
        </div>
      {/each}
    </div>
  </div>
</main>

<Footer />
