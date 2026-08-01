# NOVALY Downloader

Public-media downloader bot based on yt-dlp. No personal browser cookies are required.

## Runtime
The supplied Dockerfile installs FFmpeg, Deno, yt-dlp/EJS support, and the bgutil PO-token provider used by yt-dlp for public YouTube extraction.

## Supported URLs
NOVALY delegates extraction to yt-dlp's current extractor registry and generic extractor, without a platform allow-list. yt-dlp currently includes a very large set of site extractors and also has a generic extractor for additional pages. Individual sites can still fail when they require login, DRM, unavailable content, or site-specific anti-bot measures.

## Security
No personal browser cookies, session exports, or account credentials are included or required.

## Render
Deploy as a Docker Web Service using the supplied Dockerfile. Required variables: `BOT_TOKEN`, `OWNER_ID`, and `ADMIN_IDS`.
