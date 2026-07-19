<script lang="ts">
  import DocPage from "$lib/components/DocPage.svelte";
  import { SITE_OG, SITE_URL } from "$lib/const";

  const pageUrl = `${SITE_URL}/progress`;

  interface SubTask {
    label: string;
    done: boolean;
  }

  interface Milestone {
    title: string;
    description?: string;
    date?: string;
    status: "completed" | "in-progress" | "future";
    subtasks?: SubTask[];
  }

  const milestones: Milestone[] = [
    {
      title: "Paper & Website",
      description:
        "Published the Kursal technical paper and launched the project website.",
      date: "December 24, 2025",
      status: "completed",
    },
    {
      title: "Prototype",
      description:
        "Completed the first working prototype - the core idea works!",
      date: "January 1, 2026",
      status: "completed",
    },
    {
      title: "Local API Server",
      description: "Interact with the Kursal app via a built-in API.",
      status: "completed",
      date: "May 1st, 2026",
    },
    {
      title: "Interface",
      description: "Designing and implementing the application interface.",
      status: "completed",
      date: "May 3rd, 2026",
    },
    {
      title: "Calls",
      description: "Implemented audio calls.",
      status: "completed",
      date: "July 5th, 2026",
    },
    {
      title: "Offline messaging",
      description:
        "Send and receive messages when contacts are offline. Prototype worked the first time on May 13th!!",
      status: "in-progress",
    },
    {
      title: "Public Beta",
      description:
        "The Kursal public beta is out! Download it from the website.",
      status: "completed",
      date: "July 15th, 2026",
    },
    {
      title: "First Public Release",
      description: "First stable v0.1 release of Kursal! Planned to be August 20th 2026!",
      status: "in-progress",
    },
    {
      title: "Groups",
      description: "Support for group conversations.",
      status: "future",
    },
    {
      title: "Broadcast Channels",
      description: "Broadcast channels for community announcements.",
      status: "future",
    },
  ];

  const completedCount = milestones.filter(
    (m) => m.status === "completed",
  ).length;
  const totalCount = milestones.length;

  function logDate(date?: string) {
    if (!date) return "----------";
    const d = new Date(date.replace(/(\d+)(st|nd|rd|th)/, "$1"));
    const pad = (n: number) => String(n).padStart(2, "0");
    return `${d.getFullYear()}-${pad(d.getMonth() + 1)}-${pad(d.getDate())}`;
  }

  function statusToken(status: Milestone["status"]) {
    switch (status) {
      case "completed":
        return "ok";
      case "in-progress":
        return "wip";
      case "future":
        return "queued";
    }
  }

  function statusColor(status: Milestone["status"]) {
    switch (status) {
      case "completed":
        return "text-green-400";
      case "in-progress":
        return "text-accent-400";
      case "future":
        return "text-kursal-500";
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
  <meta property="og:image" content={SITE_OG} />

  <meta name="twitter:card" content="summary_large_image" />
  <meta name="twitter:title" content="Development Progress | Kursal" />
  <meta
    name="twitter:description"
    content="Follow the Kursal roadmap and milestone updates as we build private peer-to-peer messaging."
  />
  <meta name="twitter:image" content={SITE_OG} />
</svelte:head>

<DocPage
  file="progress.log"
  command="tail -f"
  title="Development Progress"
  stamp="Live"
  subtitle="Follow along as we build Kursal: from paper to production."
>
  <div class="mb-10">
    <div class="mb-2 flex justify-between font-mono text-sm text-kursal-300">
      <span>{completedCount} of {totalCount} milestones completed</span>
      <span class="text-accent-400"
        >{Math.round((completedCount / totalCount) * 100)}%</span
      >
    </div>
    <div class="h-2 overflow-hidden rounded-sm bg-kursal-700">
      <div
        class="h-full bg-gradient-to-r from-green-400 to-accent-400 transition-all duration-700"
        style="width: {(completedCount / totalCount) * 100}%"
      ></div>
    </div>
  </div>

  <div
    class="space-y-5 rounded-sm border border-kursal-700 bg-kursal-950/60 p-5 font-mono text-sm md:p-6"
  >
    {#each milestones as milestone}
      {@const future = milestone.status === "future"}
      <div class={future ? "opacity-60" : ""}>
        <div class="flex flex-wrap items-baseline gap-x-3 gap-y-0.5">
          <span class="text-kursal-500"
            >[{#if !milestone.date && milestone.status === "in-progress"}<span
                class="scan">----------</span
              >{:else}{logDate(milestone.date)}{/if}]</span
          >
          <span class="w-14 shrink-0 {statusColor(milestone.status)}">
            {statusToken(milestone.status)}
          </span>
          <span
            class="font-semibold {future
              ? 'text-kursal-300'
              : 'text-kursal-50'}">{milestone.title}</span
          >
        </div>

        {#if milestone.description}
          <p class="mt-1 pl-6 leading-relaxed text-kursal-400">
            {milestone.description}
          </p>
        {/if}

        {#if milestone.subtasks}
          <div class="mt-2 space-y-1 pl-6">
            {#each milestone.subtasks as sub, i}
              <div class="flex items-baseline gap-2">
                <span class="text-kursal-600 select-none"
                  >{i === milestone.subtasks.length - 1 ? "└─" : "├─"}</span
                >
                <span class={sub.done ? "text-green-400" : "text-kursal-500"}
                  >{sub.done ? "✓" : "○"}</span
                >
                <span class={sub.done ? "text-kursal-300" : "text-kursal-400"}
                  >{sub.label}</span
                >
              </div>
            {/each}
          </div>
        {/if}
      </div>
    {/each}

    <div class="flex items-center gap-1 text-kursal-500">
      <span class="caret" aria-hidden="true"></span>
    </div>
  </div>
</DocPage>

<style>
  .scan {
    background-image: linear-gradient(
      90deg,
      var(--color-kursal-500) 40%,
      var(--color-accent-400) 50%,
      var(--color-kursal-500) 60%
    );
    background-size: 200% 100%;
    -webkit-background-clip: text;
    background-clip: text;
    color: transparent;
    animation: scan 4.5s steps(24) infinite;
  }

  @keyframes scan {
    from {
      background-position: 200% center;
    }
    to {
      background-position: -200% center;
    }
  }
</style>
