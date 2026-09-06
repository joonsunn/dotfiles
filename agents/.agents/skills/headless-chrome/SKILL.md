---
name: headless-chrome
description: Smoke-test a local web app with headless Chrome. Use when checking routes render, capturing screenshots, dumping rendered DOM, or collecting page console errors.
---

# Skill: headless-chrome

# Headless Chrome testing

Smoke-test a local web app with headless Chrome: load routes, capture
console errors, dump rendered DOM, and take screenshots for visual review.
No extra dependencies; uses the Chrome binary directly.

## Locate the binary

- macOS: `/Applications/Google Chrome.app/Contents/MacOS/Google Chrome`
  (quote the path, it contains a space).
- Linux: `google-chrome`, `chromium`, or `chromium-browser` on PATH.
- Confirm with `<binary> --version` before use.

## Start the app server first

Headless Chrome only tests a running server. Start it in the background,
wait for readiness, and verify with curl:

```bash
pnpm dev --port 5199 &>/tmp/opencode/app.log & echo $! > /tmp/opencode/app.pid
sleep 5
curl -s -o /dev/null -w "%{http_code}\n" http://localhost:5199/
```

Prefer the project's scratch dir for logs outside the repo. Kill the
server when done: `kill $(cat /tmp/opencode/app.pid)`.

## Screenshots

One invocation per route. Always pass an absolute `--screenshot` path and
an explicit `--window-size`:

```bash
"<binary>" --headless --disable-gpu --hide-scrollbars \
  --window-size=1440,900 \
  --screenshot=/tmp/opencode/home.png \
  http://localhost:5199/
```

- Desktop: `--window-size=1440,900`. Mobile: `--window-size=390,844`.
- Save under `/tmp/opencode/` (or the session scratch dir), never in the repo.
- Review results with the Read tool, which renders images.
- Flags alone always capture default client state. To screenshot anything else (e.g. the non-default theme), seed it first with a throwaway Playwright spec that writes localStorage, reloads, and screenshots, then delete the spec.

## Rendered DOM

`--dump-dom` prints the DOM after page load, but client-rendered apps may
not have executed their scripts yet. Always add
`--virtual-time-budget=8000` (milliseconds) so timers, module loads, and
fetches settle before the dump. Then grep for expected markers:

```bash
"<binary>" --headless --disable-gpu --virtual-time-budget=8000 \
  --dump-dom http://localhost:5199/calculators/xirr-calculator | \
  grep -c "Cash flows"
```

An empty root div in the dump means scripts had not run yet, not that the
page is broken. In dev servers, a broken module graph renders as an error
overlay instead; grep the dump for `vite-error-overlay` or
`Uncaught` to catch that. Never trust HTTP 200 alone: it only proves the
server responded, not that the app rendered.

## Console errors

Add `--enable-logging=stderr --v=0` to mirror page console messages
(`console.error`, uncaught exceptions) to stderr:

```bash
"<binary>" --headless --disable-gpu --enable-logging=stderr --v=0 \
  --screenshot=/tmp/opencode/xirr.png \
  http://localhost:5199/calculators/xirr-calculator 2>&1 | \
  grep -iE "uncaught|console.*error|failed to load" || echo "CONSOLE CLEAN"
```

Treat `Uncaught` entries, `ERROR:CONSOLE` lines, and failed resource loads
as failures. Ignore browser-internal noise (`CVDisplayLink`,
`SharedImageManager`, `task_policy_set`, fontconfig): those come from
headless Chrome itself, not the page. Vite/HMR connection chatter
(`[vite] connecting...`, React DevTools suggestion) is also benign.

## Suggested route sweep

For each route: assert HTTP 200 via curl, dump DOM and grep for one
expected marker, screenshot at desktop width, and screenshot key pages at
mobile width. Capture console output on at least one heavy page.

## Narrow viewports need device emulation

Headless Chrome clamps windows to about 500px wide, so
`--window-size=390,844` still lays out at 500px and the screenshot just
crops it. For true phone widths, drive the page over CDP: launch with
`--remote-debugging-port=9333 --remote-allow-origins=*` (the origins flag
is required on recent Chrome), attach to the page target from
`http://127.0.0.1:9333/json/list`, then send
`Emulation.setDeviceMetricsOverride` with `{"width":390,"height":844,
"deviceScaleFactor":2,"mobile":true}` before `Page.captureScreenshot`.
A `websocket-client` style library is enough; no automation framework
needed for screenshots.

## Limits

- No interaction: no clicks, typing, or form submission. If a test needs
  interaction, escalate to a CDP automation tool (e.g. Playwright) instead
  of stretching these flags.
- `--dump-dom` is a single pass; it cannot wait on user-driven state.
- On Linux CI containers the sandbox may need `--no-sandbox`; prefer
  keeping the sandbox on dev machines.
