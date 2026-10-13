import {
  SiAndroid,
  SiApple,
  SiIos,
  SiLinux,
} from "@icons-pack/svelte-simple-icons";
import { DOWNLOAD_PREFIX } from "./const";
import { Monitor } from "lucide-svelte";

export type OSId = "mac" | "windows" | "linux" | "android" | "ios";
export type Architecture = "x64" | "arm64";

export type DownloadLink = {
  id: string;
  label: string;
  url: string;
  arch?: Architecture;
};

export const platforms: {
  id: OSId;
  name: string;
  icon: typeof SiApple | typeof Monitor;
  description: string;
  links: DownloadLink[];
}[] = [
  {
    id: "mac" as OSId,
    name: "macOS",
    icon: SiApple,
    description: "For macOS 14 and later",
    links: [
      {
        id: "dmg",
        label: "Apple Silicon (DMG)",
        url: `${DOWNLOAD_PREFIX}/Kursal.dmg`,
      },
      {
        id: "dmg_x64",
        label: "Intel (DMG)",
        url: `${DOWNLOAD_PREFIX}/Kursal_x64.dmg`,
      },
    ],
  },
  {
    id: "windows" as OSId,
    name: "Windows",
    icon: Monitor, // thanks microsoft https://github.com/simple-icons/simple-icons/pull/10019
    description: "For Windows 10 and later",
    links: [
      {
        id: "setup_x64",
        label: "Setup (x64)",
        url: `${DOWNLOAD_PREFIX}/Kursal_x64-setup.exe`,
      },
      {
        id: "standalone_x64",
        label: "Standalone (x64)",
        url: `${DOWNLOAD_PREFIX}/Kursal_x64.exe`,
      },
    ],
  },
  {
    id: "linux" as OSId,
    name: "Linux",
    icon: SiLinux,
    description: "Various distributions",
    links: [
      {
        id: "appimage_x64",
        label: "AppImage",
        url: `${DOWNLOAD_PREFIX}/Kursal_x64.AppImage`,
        arch: "x64",
      },
      {
        id: "deb_x64",
        label: "deb",
        url: `${DOWNLOAD_PREFIX}/Kursal_x64.deb`,
        arch: "x64",
      },
      {
        id: "rpm_x64",
        label: "rpm",
        url: `${DOWNLOAD_PREFIX}/Kursal_x64.rpm`,
        arch: "x64",
      },
      {
        id: "arch_x64",
        label: "arch",
        url: `${DOWNLOAD_PREFIX}/Kursal_arch.pkg.tar.zst`,
        arch: "x64",
      },
      {
        id: "appimage_arm",
        label: "AppImage",
        url: `${DOWNLOAD_PREFIX}/Kursal_arm.AppImage`,
        arch: "arm64",
      },
      {
        id: "deb_arm",
        label: "deb",
        url: `${DOWNLOAD_PREFIX}/Kursal_arm.deb`,
        arch: "arm64",
      },
      {
        id: "rpm_arm",
        label: "rpm",
        url: `${DOWNLOAD_PREFIX}/Kursal_arm.rpm`,
        arch: "arm64",
      },
    ],
  },
  {
    id: "android" as OSId,
    name: "Android",
    icon: SiAndroid,
    description: "Requires Android 8.0 or later",
    links: [{ id: "apk", label: "APK", url: `${DOWNLOAD_PREFIX}/Kursal.apk` }],
  },
  {
    id: "ios" as OSId,
    name: "iOS",
    icon: SiIos,
    description: "Requires iOS 15.6 or later",
    links: [{ id: "ipa", label: "IPA", url: `${DOWNLOAD_PREFIX}/Kursal.ipa` }],
  },
];
