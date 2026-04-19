import { SiAndroid, SiApple, SiLinux } from "@icons-pack/svelte-simple-icons";
import { DOWNLOAD_PREFIX } from "./const";
import { Monitor } from "lucide-svelte";

export type OSId = "mac" | "windows" | "linux" | "android";

export const platforms = [
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
    description: "Various distributions (does not work on Arch Linux yet)",
    links: [
      {
        id: "appimage_x64",
        label: "AppImage",
        url: `${DOWNLOAD_PREFIX}/Kursal_x64.AppImage`,
      },
      { id: "deb_x64", label: "deb", url: `${DOWNLOAD_PREFIX}/Kursal_x64.deb` },
      { id: "rpm_x64", label: "rpm", url: `${DOWNLOAD_PREFIX}/Kursal_x64.rpm` },
      {
        id: "appimage_arm",
        label: "AppImage",
        url: `${DOWNLOAD_PREFIX}/Kursal_arm.AppImage`,
      },
      { id: "deb_arm", label: "deb", url: `${DOWNLOAD_PREFIX}/Kursal_arm.deb` },
      { id: "rpm_arm", label: "rpm", url: `${DOWNLOAD_PREFIX}/Kursal_arm.rpm` },
    ],
  },
  {
    id: "android" as OSId,
    name: "Android",
    icon: SiAndroid,
    description: "Requires Android 7.0 or later",
    links: [{ id: "apk", label: "APK", url: `${DOWNLOAD_PREFIX}/Kursal.apk` }],
  },
];
