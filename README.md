# Sepeo Privacy Policy

Hosted on [GitHub Pages](https://cair-tech.github.io/sepeo-privacy/).

## Versions

| Version | URL |
|---------|-----|
| v2.0 (current) | [/v2.0/](https://cair-tech.github.io/sepeo-privacy/v2.0/) |
| v1.0 | [/v1.0/](https://cair-tech.github.io/sepeo-privacy/v1.0/) |

The root URL redirects to the latest version. `current.json` provides a machine-readable pointer
used by the Sepeo app to detect policy updates.

## Releasing a new version

See [RELEASING.md](RELEASING.md) for the full runbook, including when to bump the version
(material changes) vs. when to edit in place (trivial fixes).

Quick summary:
```bash
git checkout main && git pull
./release.sh new vX.Y      # scaffold + stamp current.json
# edit vX.Y/index.html
./release.sh publish vX.Y  # commit, tag, push → live on GitHub Pages
```

## Important: sequencing caution

Do **not** push an updated `current.json` to production until the app version that reads it
is shipped to users. Pushing prematurely means users on older app builds see a version they
cannot accept.
