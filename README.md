# Upgrade procedure

## Prerequisites

- Make sure you have a backup of your server.
- When downloading custom mods, ensure they are compatible with the Minecraft version you are using.

---

```json
{
  "minecraft_version" : "1.21.1",
  "mod_loader" : [
    {
      "name" : "neoforge",
      "version" : "21.1.203"
    }
  ],
  "custom_mods" : [

    {
      "name" : "simplebackups",
      "url" : "https://modrinth.com/mod/simple-backups?version=1.21.1&loader=neoforge#download"
    },
    {
      "name" : "dcintegration",
      "url" : "https://modrinth.com/plugin/dcintegration?version=1.21&loader=neoforge#download"
    },
    {
      "name" : "minimotd",
      "url" : "https://modrinth.com/plugin/minimotd?loader=neoforge&version=1.21.1#download"
    }
  ]
}
```

---

## Upgrade Steps

Follow these steps to upgrade your Minecraft server: [here](https://allthemods.github.io/alltheguides/help/server/#manually-2-methods)

- Backup your server

- Download the latest server files

- Unzip the downloaded server files

- Run the `setupserver.sh` script to install the new version of NeoForge and set up the server
