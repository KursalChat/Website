<script lang="ts">
  import { apps, kursal, mb, MEASURED_ON } from "../../src/lib/footprint";

  const rows = [...apps].sort((a, b) => a.ram - b.ram);
  const max = Math.max(...apps.map((app) => app.ram));
  const disks = apps.filter((app) => !app.highlight).map((app) => app.disk);
</script>

<div class="window">
  <div class="titlebar">
    <span class="dots"><span></span><span></span><span></span></span>
    <span class="url">kursal.chat/compare</span>
  </div>
  <div class="body">
    <p class="kicker">~/benchmarks</p>
    <h1>Lighter than everything it replaces.</h1>

    <div class="rows">
      {#each rows as app}
        <div class="row" class:us={app.highlight}>
          <span class="name">{app.name}</span>
          <span class="track">
            <span
              class="fill"
              style="width: {Math.max((app.ram / max) * 100, 2.5)}%"
            ></span>
          </span>
          <span class="value">{mb(app.ram)} MB</span>
        </div>
      {/each}
    </div>

    <div class="foot">
      <span class="arrow">&#8627;</span>
      <span>
        Idle RAM, measured on macOS, {MEASURED_ON}. Kursal also installs in
        <b>{mb(kursal.disk)} MB</b>
        against {mb(Math.min(...disks))}&ndash;{mb(Math.max(...disks))} MB for the
        rest.
      </span>
    </div>
  </div>
</div>

<style>
  .window {
    width: 100%;
    height: 100%;
    display: flex;
    flex-direction: column;
    border: 1px solid #2b3445;
    border-radius: 12px;
    background: #0b0e14;
    overflow: hidden;
  }

  .titlebar {
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 18px 30px;
    background: #121723;
    border-bottom: 1px solid #1d2433;
    font-size: 21px;
  }

  .dots {
    display: flex;
    gap: 10px;
  }

  .dots span {
    width: 16px;
    height: 16px;
    border-radius: 50%;
  }

  .dots span:nth-child(1) {
    background: #ff5f57;
  }

  .dots span:nth-child(2) {
    background: #febc2e;
  }

  .dots span:nth-child(3) {
    background: #28c840;
  }

  .titlebar .url {
    color: #687891;
  }

  .body {
    flex: 1;
    display: flex;
    flex-direction: column;
    justify-content: center;
    padding: 44px 56px 46px;
  }

  .kicker {
    font-size: 22px;
    color: #79a8ff;
    margin-bottom: 14px;
  }

  h1 {
    font-size: 46px;
    font-weight: 700;
    color: #eef3fa;
    letter-spacing: -0.02em;
    line-height: 1.15;
    margin-bottom: 34px;
  }

  .rows {
    display: flex;
    flex-direction: column;
    gap: 16px;
  }

  .row {
    display: flex;
    align-items: center;
    gap: 24px;
  }

  .name {
    width: 168px;
    flex-shrink: 0;
    font-size: 25px;
    color: #93a1ba;
  }

  .row.us .name {
    font-weight: 600;
    color: #eef3fa;
  }

  .track {
    display: flex;
    flex: 1;
    height: 44px;
    border: 1px solid #1d2433;
    border-radius: 3px;
    background: #06080c;
    padding: 4px;
  }

  .fill {
    display: block;
    height: 100%;
    border-radius: 2px;
    background: #2b3445;
  }

  .row.us .fill {
    background: #4d8dff;
  }

  .value {
    width: 148px;
    flex-shrink: 0;
    text-align: right;
    font-size: 25px;
    color: #93a1ba;
  }

  .row.us .value {
    font-weight: 600;
    color: #eef3fa;
  }

  .foot {
    display: flex;
    align-items: baseline;
    gap: 12px;
    margin-top: 34px;
    border-top: 1px solid #1d2433;
    padding-top: 24px;
    font-size: 21px;
    color: #78859c;
  }

  .foot .arrow {
    color: #4d8dff;
  }

  .foot b {
    font-weight: 600;
    color: #79a8ff;
  }
</style>
