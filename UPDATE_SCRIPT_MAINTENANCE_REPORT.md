# Update Script Maintenance Report

Date: 2026-03-03

- Ran updater via `./scripts/process.sh`.
- Hardened download behavior in `scripts/process.sh`:
  - changed to `curl --fail --silent --show-error --location ... -o ...`
  - added non-empty file check before processing
- Added workflow token write permission in `.github/workflows/update.yml` (`permissions: contents: write`).
- Regenerated `data/co2-mm-mlo.csv` (previously stale/empty issue in freshness report).
