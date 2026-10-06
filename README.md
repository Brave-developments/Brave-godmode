# Brave-godmode

Admin god mode toggle for FiveM (QBCore). When an admin enables it, they become
invincible and get a red **Administrator** nametag drawn over their head so other
staff can see who is tagged in.

## Features

- `/godmode` command (QBCore admin permission required, checked server-side)
- Invincibility applied to the admin's own client
- "Administrator" + player name drawn above the admin's head for everyone
- Visual transparency indicator on the admin while god mode is on

## Requirements

- [qb-core](https://github.com/qbcore-framework/qb-core)

## Installation

1. Drop the resource into your `resources` folder.
2. Add to your `server.cfg`:

```cfg
ensure Brave-godmode
```

## Usage

Run `/godmode` as a player with the `admin` permission group.
Run it again to toggle it off.

Permissions are validated on the server (``QBCore.Functions.HasPermission``),
so clients can't toggle it by spamming the event.

## License

All rights reserved.
