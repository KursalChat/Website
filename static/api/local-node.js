(() => {
  const NAME = "kursal_local_node_dismissed";
  const MAX_AGE = 60 * 60 * 24 * 30;
  const toggle = document.getElementById("local-node-dismiss");

  const read = () =>
    document.cookie
      .split("; ")
      .some((entry) => entry === `${NAME}=1`);

  const write = (dismissed) => {
    const secure = location.protocol === "https:" ? "; Secure" : "";
    const age = dismissed ? MAX_AGE : 0;
    document.cookie = `${NAME}=1; Path=/; Max-Age=${age}; SameSite=Lax${secure}`;
  };

  toggle.checked = read();
  toggle.addEventListener("change", () => write(toggle.checked));
})();
