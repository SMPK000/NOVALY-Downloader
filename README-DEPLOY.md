# NOVALY Downloader — deployment configuration

## Render / Docker
Use the supplied Dockerfile as the service runtime. It installs FFmpeg, Deno, yt-dlp with EJS support, and the bgutil PO-token provider. The Docker container starts the local PO-token provider and then the Telegram bot.

## Required environment variables
- `BOT_TOKEN`
- `OWNER_ID`
- `ADMIN_IDS`

## YouTube / anti-bot
No personal browser cookies are required. The image includes Deno/EJS support and the featured bgutil PO-token provider recommended by the current yt-dlp documentation for public YouTube extraction. A PO token does not guarantee that every YouTube request will succeed; YouTube can still change or enforce additional checks.

## Optional YouTube settings
- `YTDLP_PO_TOKEN`: leave empty unless you deliberately have a current valid token.
- `YTDLP_PLAYER_CLIENTS`: leave empty to use the bot's built-in public-client fallback.
- `YTDLP_JS_RUNTIME=deno`
- `YTDLP_REMOTE_COMPONENTS`: leave empty unless you deliberately configure remote EJS components.

## Supported sites
The bot does not maintain a hardcoded platform allow-list. It delegates URL extraction to yt-dlp's current extractor registry and generic extractor. This covers a very large number of sites, but no downloader can guarantee every URL: individual sites can require login, DRM, a currently broken extractor, regional access, or site-specific anti-bot verification.

## Persistence
The bot still uses PicklePersistence. Set `DATA_DIR`/`PERSISTENCE_FILE` to a genuinely persistent storage location. On an ephemeral filesystem, redeploys can erase it; use external PostgreSQL/other persistent storage later for durable migration.
