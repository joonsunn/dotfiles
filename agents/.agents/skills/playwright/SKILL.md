---
name: playwright
description: Write and run Playwright end-to-end tests for clicks, forms, downloads, and uploads. Use when verifying user flows, testing calculations through the UI, or checking behavior across viewports.
---

# Skill: playwright

# Playwright end-to-end testing

Write and run Playwright interaction tests against a local web app:
clicking, typing, form submission, downloads, file uploads, and
assertions on rendered results. Complements `headless-chrome`, which
covers load/render/screenshot smoke checks without interaction.

## Setup

Install the runner (Node project):

```bash
pnpm add -D @playwright/test
```

Reuse the machine's installed Google Chrome instead of downloading a
browser. In `playwright.config.ts`, set `channel: "chrome"` on each
project:

```ts
import { defineConfig, devices } from "@playwright/test";

export default defineConfig({
  testDir: "./e2e",
  fullyParallel: true,
  retries: process.env.CI ? 2 : 0,
  reporter: "line",
  use: {
    baseURL: "http://localhost:5199",
    trace: "on-first-retry",
  },
  projects: [
    {
      name: "desktop",
      use: { ...devices["Desktop Chrome"], channel: "chrome" },
    },
    {
      name: "mobile",
      use: { ...devices["Pixel 7"], channel: "chrome" },
    },
  ],
  webServer: {
    command: "pnpm preview --port 5199",
    port: 5199,
    reuseExistingServer: true,
  },
});
```

Notes:

- Test the production build (`pnpm build` first, serve with `vite preview`)
  unless the goal is explicitly dev-mode behavior.
- Keep specs in `e2e/*.spec.ts`, colocated with the project under test.
- `channel: "chrome"` requires Google Chrome installed; fall back to the
  default bundled Chromium only when it is absent.
- On macOS the window floor that affects raw headless screenshots does
  not apply here; Playwright viewports (including mobile) are exact.

## Writing specs

```ts
import { expect, test } from "@playwright/test";

test("annualised returns", async ({ page }) => {
  const errors: string[] = [];
  page.on("pageerror", (err) => errors.push(String(err)));
  await page.goto("/calculators/annualisedReturns");
  await page.getByRole("button", { name: "Calculate" }).click();
  await expect(page.getByText("Annualised Returns:")).toBeVisible();
  expect(errors).toEqual([]);
});
```

Conventions:

- Prefer role-based locators (`getByRole`, `getByLabel`, `getByText`)
  over CSS selectors; add accessible names to the app if a control
  cannot be located.
- One behavior per test; name tests after the behavior, not the route.
- Assert absence of page errors in every test via a `pageerror`
  listener; console noise from dev servers is out of scope when testing
  production builds.
- Use web-first assertions (`await expect(locator)...`) so Playwright
  retries until the UI settles; never `sleep` for rendered content.

## Downloads and file uploads

```ts
// Download
const downloadPromise = page.waitForEvent("download");
await page.getByRole("button", { name: "Export CSV" }).click();
const download = await downloadPromise;
const path = await download.path();

// Upload the same file back
await page.locator('input[type="file"]').setInputFiles(path);
await expect(page.getByText(/Imported \d+ cash flows/)).toBeVisible();
```

- `setInputFiles` works on hidden inputs; no need to click the visible
  proxy button.
- Prefer round-tripping a downloaded file over committing fixture files.

## Running

```bash
pnpm exec playwright test            # all projects
pnpm exec playwright test --project=desktop
pnpm exec playwright test --project=mobile --grep "layout"
pnpm exec playwright show-report     # after a failure
```

To watch a run, pass `--headed`. There is no `--slow-mo` CLI flag;
slow motion is a browser launch option, so put it in a config that the
headed script points at:

```ts
// playwright.headed.config.ts
import base from "./playwright.config";

export default {
  ...base,
  use: { ...base.use, launchOptions: { slowMo: 500 } },
};
```

```json
{ "scripts": { "test:e2e:headed": "playwright test --config playwright.headed.config.ts --headed" } }
```

- First run on a machine may need `pnpm exec playwright install
  --with-deps` only when not using `channel: "chrome"`.
- Traces are captured on first retry; open with `show-report`.
- Keep the suite fast: share `baseURL`, avoid repeating full navigation
  in every test when one flow covers it.

## Limits

- Playwright cannot read visual correctness; pair interaction tests
  with `headless-chrome` screenshots for layout review.
- File downloads land in a temp dir per test; persist them explicitly
  when a later step needs the path.
- `webServer` starts one server for the run; point it at the build
  under test and rebuild before rerunning after app changes.
