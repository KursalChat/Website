<script lang="ts">
  import "../app.css";
  import { onNavigate } from "$app/navigation";

  onNavigate((navigation) => {
    if (navigation.shallow && navigation.type === "goto") return;
    if (!document.startViewTransition) return;
    return new Promise((resolve) => {
      document.startViewTransition(async () => {
        resolve();
        await navigation.complete;
      });
    });
  });
</script>

<slot></slot>
