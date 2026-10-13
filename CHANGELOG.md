# Changelog

## [fix] - 2026-10-07

### Fixed
- God mode now actually applies: the toggling admin gets SetPlayerInvincible instead of a server-id vs PlayerId mismatch.
- Name-tag broadcast split into its own setGodModeTag event with a safe name fallback.
- Removed the unused mysql-async dependency from the manifest.
