---
name: playwright-cli
description: Automates browser interactions for web testing, form filling, screenshots, and data extraction. Use when the user needs to navigate websites, interact with web pages, fill forms, take screenshots, test web applications, or extract information from web pages.
allowed-tools: Bash(playwright-cli:*)
---

# Browser Automation with playwright-cli

## Key concepts

- After each command, playwright-cli returns a snapshot of the page. Use element refs (e.g. `e3`, `e15`) from the snapshot to interact with elements — don't guess refs, always snapshot first.
- `eval` runs JS in the page context and returns the result. Use it when refs aren't enough.
- `run-code` runs an async Playwright function — use it for multi-step logic that can't be done with individual commands.
- Refs are not stable across navigations — re-snapshot after any page change.

## Interacting with elements when refs don't work

Use `run-code` with full Playwright selectors:

```bash
playwright-cli run-code "async page => {
  await page.fill('input[placeholder=\"Enter your username\"]', 'admin');
  await page.click('button:has-text(\"Log in\")');
  await page.waitForLoadState('networkidle', {timeout: 15000}).catch(() => {});
}"
```

## Extracting cookies for use in hurl/API scripts

```bash
# Full cookie string
playwright-cli run-code "async page => { const c = await page.context().cookies(); return JSON.stringify(c.map(x => x.name + '=' + x.value).join('; ')); }"
# Single cookie by name
playwright-cli run-code "async page => { const c = await page.context().cookies(); return c.find(x => x.name === 'XSRF-TOKEN')?.value; }"
```

## Named sessions (run multiple browsers independently)

```bash
playwright-cli -s=mysession open https://example.com
playwright-cli -s=mysession click e6
playwright-cli -s=mysession close
playwright-cli kill-all  # force-kill all browser processes
```

## Lightspeed dev environment login

```bash
playwright-cli open https://weggieincl.dev.gottagolightspeed.works
playwright-cli run-code "async page => {
  await page.fill('input[placeholder=\"Enter your username\"]', 'admin');
  await page.fill('input[placeholder=\"Enter your password\"]', 'password');
  await page.click('button:has-text(\"Log in\")');
  await page.waitForLoadState('networkidle', {timeout: 15000}).catch(() => {});
}"
# Dismiss the "Change your password" prompt if it appears
playwright-cli run-code "async page => {
  const btn = page.locator('button:has-text(\"Not now\")');
  if (await btn.isVisible()) await btn.click();
  await page.waitForLoadState('networkidle', {timeout: 10000}).catch(() => {});
}"
# Extract cookies
playwright-cli run-code "async page => { const c = await page.context().cookies(); return JSON.stringify(c.map(x => x.name + '=' + x.value).join('; ')); }"
playwright-cli close
```

Credentials: username `admin`, password `password`.
