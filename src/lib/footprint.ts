export type MetricKey = "ram" | "disk";

export type FootprintApp = {
  name: string;
  ram: number;
  disk: number;
  highlight?: boolean;
};

export const MEASURED_ON = "August 2026";

export const metrics = [
  {
    key: "disk",
    flag: "--install-size",
    title: "Install size",
    caption: "Each desktop app as it sits on disk once installed.",
    noun: "disk space",
  },
  {
    key: "ram",
    flag: "--idle-ram",
    title: "Idle RAM usage",
    caption:
      "Each desktop app left open and idle, averaged over 30 samples per app.",
    noun: "memory",
  },
] as const;

export const apps: FootprintApp[] = [
  { name: "Kursal", ram: 179, disk: 28, highlight: true },
  { name: "Signal", ram: 681, disk: 630 },
  { name: "Discord", ram: 611, disk: 499 },
  { name: "WhatsApp", ram: 187, disk: 656 },
];

export const kursal = apps.find((app) => app.highlight)!;

export function mb(value: number) {
  return Math.round(value).toLocaleString("en-US");
}

export function lighterFactor(metric: MetricKey) {
  const others = apps.filter((app) => !app.highlight);
  const factor =
    others.reduce((sum, app) => sum + app[metric], 0) /
    others.length /
    kursal[metric];

  return factor >= 10 ? Math.round(factor) : Math.round(factor * 10) / 10;
}
