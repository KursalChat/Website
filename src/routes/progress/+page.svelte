<script lang="ts">
  import {
    ChevronRight,
    CircleCheckBig,
    LoaderCircle,
    Circle,
    FileText,
    FlaskConical,
    Server,
    Monitor,
    Users,
    Radio,
    Keyboard,
    Rocket,
    MessageCircle,
    Phone,
  } from "lucide-svelte";
  import DocPage from "$lib/components/DocPage.svelte";
  import { SITE_ICON, SITE_URL } from "$lib/const";

  const pageUrl = `${SITE_URL}/progress`;

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
      description:
        "Completed the first working prototype - the core idea works!",
      date: "January 1, 2026",
      status: "completed",
      icon: FlaskConical,
    },
    {
      title: "Local API Server",
      description: "Interact with the Kursal app via a built-in API.",
      status: "completed",
      date: "May 1st, 2026",
      icon: Server,
    },
    {
      title: "Interface",
      description: "Designing and implementing the application interface.",
      status: "completed",
      date: "May 3rd, 2026",
      icon: Monitor,
    },
    {
      title: "Calls",
      description: "Implemented audio calls.",
      status: "completed",
      date: "July 5th, 2026",
      icon: Phone,
    },
    {
      title: "Offline messaging",
      description:
        "Send and receive messages when contacts are offline. Prototype worked the first time on May 13th!!",
      status: "in-progress",
      icon: MessageCircle,
    },
    {
      title: "First Public Release",
      description:
        "First v0.1 release of Kursal! Planned to be August 20th 2026! Public beta will be available before this date :)",
      status: "in-progress",
      icon: Rocket,
    },
    {
      title: "Groups",
      description: "Support for group conversations.",
      status: "future",
      icon: Users,
    },
    {
      title: "Broadcast Channels",
      description: "Broadcast channels for community announcements.",
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
        return "bg-green-400/15 border-green-400/40";
      case "in-progress":
        return "bg-accent-500/15 border-accent-500/40";
      case "future":
        return "bg-kursal-700/50 border-kursal-600";
    }
  }

  function lineColor(status: Milestone["status"]) {
    switch (status) {
      case "completed":
        return "bg-green-400/50";
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

<svelte:head>
  <title>Development Progress | Kursal</title>
  <meta
    name="description"
    content="Follow the Kursal roadmap and milestone updates as we build private peer-to-peer messaging."
  />
  <link rel="canonical" href={pageUrl} />

  <meta property="og:title" content="Development Progress | Kursal" />
  <meta
    property="og:description"
    content="Follow the Kursal roadmap and milestone updates as we build private peer-to-peer messaging."
  />
  <meta property="og:url" content={pageUrl} />
  <meta property="og:image" content={SITE_ICON} />

  <meta name="twitter:card" content="summary" />
  <meta name="twitter:title" content="Development Progress | Kursal" />
  <meta
    name="twitter:description"
    content="Follow the Kursal roadmap and milestone updates as we build private peer-to-peer messaging."
  />
  <meta name="twitter:image" content={SITE_ICON} />
</svelte:head>

<DocPage
  file="progress.log"
  title="Development Progress"
  stamp="Live"
  subtitle="Follow along as we build Kursal: from paper to production."
>
  <div class="mb-10">
    <div class="flex justify-between font-mono text-sm text-kursal-300 mb-2">
      <span>{completedCount} of {totalCount} milestones completed</span>
      <span class="text-accent-400"
        >{Math.round((completedCount / totalCount) * 100)}%</span
      >
    </div>
    <div class="h-2 bg-kursal-700 overflow-hidden rounded-sm">
      <div
        class="h-full bg-gradient-to-r from-green-400 to-accent-400 transition-all duration-700"
        style="width: {(completedCount / totalCount) * 100}%"
      ></div>
    </div>
  </div>

  <!-- Timeline -->
  <div class="relative">
    {#each milestones as milestone, i}
      <div class="relative flex gap-5 pb-10 last:pb-0">
        <!-- Timeline marker & line -->
        <div class="flex flex-col items-center">
          <div
            class="w-10 h-10 rounded-sm border-2 flex items-center justify-center shrink-0 {statusBg(
              milestone.status,
            )}"
          >
            {#if milestone.status === "completed"}
              <CircleCheckBig size={18} class="text-green-400" />
            {:else if milestone.status === "in-progress"}
              <LoaderCircle
                size={18}
                class="text-accent-400 animate-spin"
                style="animation-duration: 3s"
              />
            {:else}
              <Circle size={18} class="text-kursal-400" />
            {/if}
          </div>
          {#if i < milestones.length - 1}
            <div class="w-px grow mt-2 {lineColor(milestone.status)}"></div>
          {/if}
        </div>

        <!-- Content -->
        <div class="pt-1 pb-2 min-w-0">
          <div class="flex flex-wrap items-center gap-3 mb-1">
            <h3
              class="font-mono text-lg font-semibold text-kursal-50 flex items-center gap-2"
            >
              <milestone.icon size={18} class={statusColor(milestone.status)} />
              {milestone.title}
            </h3>
            {#if milestone.status !== "completed"}
              <span
                class="font-mono text-xs font-medium px-2 py-0.5 rounded-sm {badgeClass(
                  milestone.status,
                )}"
              >
                {badgeLabel(milestone.status)}
              </span>
            {/if}
          </div>

          {#if milestone.date}
            <p class="font-mono text-xs text-kursal-500 mb-2">
              {milestone.date}
            </p>
          {/if}

          {#if milestone.description}
            <p class="text-kursal-300 text-sm leading-relaxed">
              {milestone.description}
            </p>
          {/if}

          {#if milestone.subtasks}
            {@const doneCount = milestone.subtasks.filter((s) => s.done).length}
            {@const allDone = doneCount === milestone.subtasks.length}

            <details class="mt-4 group" open={!allDone}>
              <summary class="list-none cursor-pointer focus:outline-none mb-3">
                <div
                  class="max-w-xs flex items-center gap-3 group-hover:opacity-80 transition-opacity"
                >
                  <div
                    class="text-kursal-400 transition-transform duration-200 group-open:rotate-90 shrink-0"
                  >
                    <ChevronRight size={16} />
                  </div>
                  <div class="flex-1">
                    <div class="h-1.5 bg-kursal-700 overflow-hidden rounded-sm">
                      <div
                        class="h-full bg-accent-400/70 transition-all duration-500"
                        style="width: {milestone.subtasks.length > 0
                          ? (doneCount / milestone.subtasks.length) * 100
                          : 0}%"
                      ></div>
                    </div>
                    <p class="font-mono text-xs text-kursal-400 mt-1">
                      {doneCount} / {milestone.subtasks.length} subtasks
                    </p>
                  </div>
                </div>
              </summary>

              <div class="space-y-2 mb-2 pl-1">
                {#each milestone.subtasks as sub}
                  <div class="flex items-center gap-2.5 font-mono text-sm">
                    {#if sub.done}
                      <CircleCheckBig
                        size={14}
                        class="text-green-400 shrink-0"
                      />
                      <span class="text-kursal-300">{sub.label}</span>
                    {:else}
                      <Circle size={14} class="text-kursal-400 shrink-0" />
                      <span class="text-kursal-400">{sub.label}</span>
                    {/if}
                  </div>
                {/each}
              </div>
            </details>
          {/if}
        </div>
      </div>
    {/each}
  </div>
</DocPage>
