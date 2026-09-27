---
name: browser-warmed
description: Drive a warmed Chrome via DevTools MCP or Playwright MCP with visual feedback. Use ONLY when task needs existing session, logged in state, or screenshot grounded browser acts.
---

# Browser warmed

Use warmed Chrome for tasks that need existing logins, cookies, or visual confirmation. Prefer DevTools MCP for live window work. Prefer Playwright MCP for repeat flows, headless runs, and cross browser checks.

## Launch

Isolated persistent profile — runs side-by-side with human Chrome. Run in zsh. Never use main profile for agent work.

```zsh
mkdir -p "$HOME/.chrome-agent-profile"
"/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" --remote-debugging-port=9222 --user-data-dir="$HOME/.chrome-agent-profile" about:blank &
curl -s http://127.0.0.1:9222/json/version
```
First run shows `Person 1` — normal, rename in `chrome://settings/manageProfile`. Logins persist in that dir. Same `user-data-dir` can't run twice — second launch just forwards (`Opening in existing browser session`) and ignores the port flag.

Expect JSON with `webSocketDebuggerUrl`. If port is closed, stop and ask user to launch. Do not guess flags. Exception: may auto-launch isolated agent profile (`$HOME/.chrome-agent-profile`) only after explicit user approval; never auto-launch main profile.

## Attach

DevTools MCP connects with `--browser-url=http://127.0.0.1:9222`. Playwright uses `connectOverCDP` to same port or `browser.bind` to running instance. Confirm one tab before acting. Use isolated profile by default. Attach to real profile only on explicit request.

## Act loop

Follow act, observe, decide. One act per step. After each act take snapshot plus screenshot for visual feedback. Read image before next act. Assert no page errors on local apps via `pageerror` listener. Never sleep for rendered content, use web first assertions and refs. Close blocking banners first (donate/cookie: CLOSE/MAYBE LATER). For watch mode: scrollIntoView, screenshot, then click. Large pages truncate snapshots — fallback to evaluate_script link hunt (match absolute `en.wikipedia.org/wiki/` hrefs, not just `/wiki/`). Pass screenshot filePath under `/tmp/opencode/<run>/`, then Read file to view.

## Safety

Scope to asked URLs. Ask before login, pay, post, delete, or grant permissions. Treat profile as credential. Never commit cookies, `storageState.json`, auth files, or screenshots with personal data. Run state in own subfolder `/tmp/opencode/<run>/` (shared agent Chrome profile at `$HOME/.chrome-agent-profile` is the only exception), delete throwaway specs after use. HTTP 200 proves nothing for client rendered apps, confirm with DOM marker or screenshot.
