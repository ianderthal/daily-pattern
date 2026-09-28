# README

This README would normally document whatever steps are necessary to get the
application up and running.

## Importing events from a CSV

1. Copy the exported CSV to `lib/data/events_import.csv`.
2. Run `bin/rails import_events`.

Notes:
- CSV must have headers `Date,Time,Notes`.
- Date format: `M/D/YYYY` (e.g. `8/14/2025`).
- Time format: shorthand like `10p`, `8:35p`, `12a` (hour, optional `:MM`, then `a`/`p`, no `m`).
- Blank rows are skipped automatically.
- **This task wipes all existing events first** (`Event.destroy_all`) before importing — it's meant for a full re-import, not an incremental one.

## Deploying

The app runs from the `ghcr.io/ianderthal/daily-pattern:latest` image, deployed as a Portainer stack using `docker-compose.yml`.

1. Make sure Docker Desktop is running.
2. From the project root, build and push the image:
   ```sh
   docker buildx build --platform linux/amd64 \
     -t ghcr.io/ianderthal/daily-pattern:latest --push .
   ```
3. In Portainer, open the daily-pattern stack, click **Update the stack**, turn on **Re-pull image and redeploy**, then click **Update**.

Notes:
- `--platform linux/amd64` is required when building on Apple Silicon, since the server is x86.
- The build uses the files on disk, including uncommitted changes.
- Without **Re-pull image**, Portainer restarts the cached image and the new code isn't deployed.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
