export function reveal(
  node: HTMLElement,
  params: { delay?: number; y?: number } = {},
) {
  const reduce =
    typeof window !== "undefined" &&
    window.matchMedia("(prefers-reduced-motion: reduce)").matches;

  if (reduce) return {};

  const y = params.y ?? 18;
  const delay = params.delay ?? 0;

  node.style.opacity = "0";
  node.style.transform = `translateY(${y}px)`;
  node.style.transition = `opacity 600ms ease ${delay}ms, transform 700ms cubic-bezier(0.2, 0.7, 0.2, 1) ${delay}ms`;
  node.style.willChange = "opacity, transform";

  let cleanup: ReturnType<typeof setTimeout> | undefined;

  const io = new IntersectionObserver(
    (entries) => {
      for (const e of entries) {
        if (e.isIntersecting) {
          node.style.opacity = "1";
          node.style.transform = "none";
          io.unobserve(node);

          cleanup = setTimeout(() => {
            node.style.transition = "";
            node.style.transform = "";
            node.style.opacity = "";
            node.style.willChange = "";
          }, delay + 800);
        }
      }
    },
    { threshold: 0.12, rootMargin: "0px 0px -8% 0px" },
  );

  io.observe(node);

  return {
    destroy() {
      io.disconnect();
      if (cleanup) clearTimeout(cleanup);
    },
  };
}
