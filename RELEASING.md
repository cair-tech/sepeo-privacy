# Releasing a new privacy policy version

The site is hosted on GitHub Pages. **Pushing to the repo publishes it automatically** — there is
no separate "go live" step (allow ~1–10 min for it to appear).

## First decide: is a version bump needed?
- **Bump the version** for a **material change** — a new use of data, a new processor, a changed
  legal basis, or anything affecting users' rights. Bumping makes the app re-prompt every user to
  re-accept, which is required for the new consent to be valid.
- **Do NOT bump** for a **trivial change** — a typo, formatting, or fixing a link. Just edit and
  commit; users are not re-prompted. (Git history still records it.)
- **If unsure, treat it as material and bump.**

## Releasing a new version (example: v2.0 → v2.1)
```bash
git checkout main && git pull
./release.sh new v2.1            # scaffolds v2.1/ from v2.0/ and stamps current.json with today
# → edit v2.1/index.html: write your changes and update the "Last updated" date shown on the page
./release.sh publish v2.1        # commits, tags v2.1, and pushes → live automatically
```

## After publishing, verify
- `https://cair-tech.github.io/sepeo-privacy/current.json` shows the new version.
- `.../v2.1/` renders correctly.
- `.../v2.0/` is still reachable. **Never delete old versions** — they are the audit record.

## Trivial fix (no re-prompt)
Edit the file directly and commit/push as normal — do NOT run `release.sh` and do NOT change the
version in `current.json`.
