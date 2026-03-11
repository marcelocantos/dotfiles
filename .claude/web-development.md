# Web-Based Development

Guidelines for projects with a web frontend (HTML/JS/CSS, SvelteKit,
Next.js, etc.) served by a local dev server.

## Smoke testing

Always deploy locally and perform smoke tests after completing any
reviewable unit of work — a feature, a refactor, a bug fix. Don't
present work as done until you've verified it runs.

- Build the frontend and backend.
- Start the server on a non-conflicting port.
- Exercise the changed functionality end-to-end in a browser.
- If something breaks, fix it before reporting completion.

## Deep links and sample data

Whenever possible, provide deep links that get straight to the page
and content of interest. Don't make the reviewer navigate through
menus and forms to find the thing you changed.

- Include the full clickable URL (LAN IP, not `localhost`) so it works
  from phones and other devices.
- If the feature needs data to be meaningful, prepare sample data
  (seed records, API calls, etc.) so the reviewer sees a realistic
  result on first load.
- If appropriate, provide brief guidance on what to look for — what
  changed, what the expected behaviour is, and where to focus
  attention.

## Visual verification cadence

Visual verification is not just a final step. Run the server at
natural checkpoints during development:

- After creating or refactoring UI components.
- After changing API responses that feed the UI.
- After modifying routing, auth, or middleware.

Catching rendering issues early is cheaper than debugging them after
a long chain of changes.
