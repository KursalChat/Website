export type CreditEntry = {
  name: string;
  url?: string;
  github?: string;
  meta?: string;
  detail?: string;
};

export type TranslatorEntry = CreditEntry & { language: string };

export const contributorOverrides: CreditEntry[] = [
  {
    name: "Kubik",
    github: "KodeurKubik",
    meta: "Main Kursal dev",
  },
];

export const translators: TranslatorEntry[] = [
  {
    language: "French",
    name: "Kubik",
    github: "KodeurKubik",
  },
  {
    language: "Dutch",
    name: "Tiazzz",
    github: "ItsTiazzz",
  },
];

export const researchers: CreditEntry[] = [];

export const supporters: CreditEntry[] = [
  {
    name: "Kubik",
    github: "KodeurKubik",
  },
];
