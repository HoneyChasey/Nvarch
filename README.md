<div align="center">
    <img alt="nvarch logo" src="https://github.com/HoneyChasey/neo-config/blob/main/.github/assets/logo.jpg" width="120px"/>
</div>

# Nvarch — NvChad Neovim Config

Personal Neovim configuration built on top of **NvChad v2.5**, managed with **GNU Stow**.

> **After a push, nvim-tree may still show files as modified — press `R` to force a full refresh and update the git status.**

---

## Fast installation with Stow

```sh
stow --target=$HOME nvarch-config
```

Then follow the full installation steps below.

---

## Installation

1. Clone this repo
2. Run `stow --target=$HOME nvarch-config` to symlink the config into `~/.config/nvim`
3. Run `install.sh` to install system dependencies (ripgrep, lazygit, etc.)
4. Open Neovim with `nvim`
5. You should see the custom NvDash. If the font looks wrong, verify your terminal font supports Nerd Fonts
6. Run `:MasonInstallAll` to install all LSP servers and tools
7. Run `:Lazy`, press `I` to install all plugins. If some show errors (in red), clean and reinstall them (`x`, then `I`, then `U`). Use `C` to check all plugins or `c` for one. Run `:Lazy sync` to update

> **Before installing**, make sure the latest version of Java is installed on your machine — otherwise `jdtls` (Java LSP) won't work.

### install.sh

The script installs system-level dependencies. It supports:

- **macOS**: installs via `brew`
- **Debian/Ubuntu**: installs via `apt-get`
- **Arch Linux**: installs via `pacman` (see bottom of the script)

Dependencies installed: `ripgrep`, `lazygit`, `luarocks`, `wl-clipboard`, `unixodbc`

---

## Uninstall

```bash
# Linux / macOS
rm -rf ~/.config/nvim
rm -rf ~/.local/state/nvim
rm -rf ~/.local/share/nvim

# Flatpak (linux)
rm -rf ~/.var/app/io.neovim.nvim/config/nvim
rm -rf ~/.var/app/io.neovim.nvim/data/nvim
rm -rf ~/.var/app/io.neovim.nvim/.local/state/nvim

# Windows CMD
rd -r ~\AppData\Local\nvim
rd -r ~\AppData\Local\nvim-data

# Windows PowerShell
rm -Force ~\AppData\Local\nvim
rm -Force ~\AppData\Local\nvim-data
```

---

## Theme & UI

Configured in `lua/chadrc.lua`:

- **Theme**: `ayu_dark`
- **Statusline**: `minimal` theme, `round` separator style
- **NvDash**: loads on startup with a custom ASCII art header

To disable NvDash on startup, comment out in `lua/chadrc.lua`:
```lua
M.nvdash = { load_on_startup = true }
```

To customize the UI further (statusline style, NvDash header, tabufline, etc.), read `:h nvui` inside Neovim. All your customizations go into `lua/chadrc.lua` — you just override the default values there.

---

## Plugins

This config uses **lazy.nvim** (bundled by NvChad) for plugin management. Plugins live in `lua/plugins/`, one file per plugin.

### Installed plugins

| Plugin | Purpose |
|---|---|
| `neovim/nvim-lspconfig` | LSP configuration |
| `nvim-treesitter/nvim-treesitter` | Syntax highlighting & parsing |
| `stevearc/conform.nvim` | Formatting |
| `lewis6991/gitsigns.nvim` | Git signs and line blame |
| `kdheepak/lazygit.nvim` | LazyGit inside Neovim |
| `HoneyChasey/lazydocker.nvim` | LazyDocker inside Neovim |

### Lazy loading

NvChad lazy-loads ~95% of plugins. When you add a plugin, try your best to lazy-load it too. By default `lazy = true` is set. To load a plugin on startup, set `lazy = false`.

- lazy.nvim spec docs: https://lazy.folke.io/spec/examples

### Adding your own plugin

1. Find a plugin on GitHub
2. Create `lua/plugins/nameplugin.lua`
3. Write your config and save
4. Run `:Lazy` and wait for the install to finish

Example config:

```lua
return {
  { "folke/which-key.nvim", enabled = false }, -- disable a default NvChad plugin

  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "html", "css", "bash" } },
  },

  {
    "nvim-telescope/telescope.nvim",
    opts = function(_, conf)
      conf.defaults.mappings.i = {
        ["<C-j>"] = require("telescope.actions").move_selection_next,
        ["<Esc>"] = require("telescope.actions").close,
      }
      return conf
    end,
  },
}
```

### Gitsigns

Shows git info inline. The most useful feature is **current line blame** — shows who last modified the line you're on.

Toggle current line blame:
```
:Gitsigns toggle_current_line_blame
```

Full docs: https://github.com/lewis6991/gitsigns.nvim

### LazyGit

Open LazyGit inside Neovim: `<leader>g`

### LazyDocker

Open LazyDocker inside Neovim: `<leader>ld`

### Treesitter (Parser)

Configured in `lua/plugins/nvim-treesitter.lua` and `lua/configs/treesitter.lua`.

Currently installed parsers: `svelte` (plus all NvChad defaults).

If the parser causes errors (e.g., code colors disappear), run:
```
:Lazy sync
```
If still broken:
```
:TSUpdate          -- update all parsers
:TSUninstall all   -- nuclear option: uninstall everything, then run :TSUpdate again
```

### Conform (Formatter)

Configured in `lua/configs/conform.lua`. Currently active formatters:

| Filetype | Formatter |
|---|---|
| Lua | `stylua` |

Format on save is disabled by default. To enable it, uncomment the `format_on_save` block in `lua/configs/conform.lua`.

---

## LSP Configuration

LSP servers are configured in `lua/configs/lspconfig.lua`. The `local servers` table lists all enabled servers:

```lua
local servers = { "html", "cssls", "bashls", "clangd", "dockerls", "gopls", "jdtls", "lua_ls", "pyright", "svelte" }
vim.lsp.enable(servers)
```

> To find the correct name for a server, check the lspconfig configs list: https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md
> More information on the file .config/nvim/lua/configs/lspconfig.lua

When you add a name to the `servers` list, Neovim looks for a matching file in lspconfig's `configs/` folder and reads it to know which binary to run and how to start it.

### Install an LSP via Mason (recommended)

> Mason downloads binaries (LSPs, linters, formatters). Lazy manages Neovim plugins (UI, etc.).

1. Run `:Mason` and find + install the LSP for the language you want
2. Add the server name to the `servers` table in `lua/configs/lspconfig.lua`
3. Run `:checkhealth vim.lsp` to spot any warnings or missing config
4. Open a file in the target language and enter insert mode — if the LSP icon appears in the bottom right, it's working

### Install an LSP via command line

Example for pyright:
```bash
npm i -g pyright
```
Then add `"pyright"` to the `servers` table and save.

### Servers not on $PATH (e.g. jdtls, elixirls)

You must set the `cmd` manually:
```lua
vim.lsp.config('jdtls', {
  cmd = { '/path/to/jdtls' },
})
```

### Extra LSP server config

Use `vim.lsp.config()` to extend a server's default settings (Nvim 0.11+):
```lua
vim.lsp.config('rust_analyzer', {
  settings = {
    ['rust-analyzer'] = {},
  },
})
```

### Config priority order

1. `lsp/` in `runtimepath`
2. `after/lsp/` in `runtimepath`
3. `vim.lsp.config()`

To make your config override plugin defaults, use `after/lsp/` or `vim.lsp.config()`.

### Useful LSP commands

```
:LspStart <lspName>    -- force-start a specific LSP
:LspStop               -- stop LSP in current buffer
:LspRestart            -- restart LSP
:LspLogs               -- view LSP logs
:checkhealth vim.lsp   -- check LSP health (run this inside the target language file)
```

### Troubleshooting

If an LSP is not working properly, check the log file:

```bash
cat ~/.local/state/nvim/lsp.log
```

This file records all LSP activity and errors — it's the first place to look when a server fails to start or behaves unexpectedly.

---

## Per-project LSP configuration

### Python — PyRight

Create a `pyrightconfig.json` at the root of your project:
```json
{
  "venvPath": ".",
  "venv": ".venv"
}
```
Now just open Neovim normally — no need to activate the venv manually first.

If you're using a `.env` folder instead of `.venv`:
```bash
source .env/bin/activate
nvim
```

### Lua — lua_ls

Create a `.luarc.json` at the root of your project:
```json
{
  "workspace": {
    "library": [
      "/usr/share/hypr/stubs"
    ]
  },
  "diagnostics": {
    "globals": ["hl"]
  }
}
```

---

## Autocmds

Autocmds detect the filetype of opened files. You can also remap filenames to a specific filetype.

To check the filetype of the current file:
```
:set ft
```

Custom autocmds live in `lua/autocmds.lua`. Currently configured:

- `*docker-compose.y*ml` → automatically sets filetype to `yaml.docker-compose`

> If the docker-compose LSP doesn't start when opening a `docker-compose.yaml`, check the filetype with `:set ft`. If it's not `yaml.docker-compose`, set it manually: `:set filetype=yaml.docker-compose`

---

## Remote Development

You can edit files on a remote server directly from Neovim over SSH:
```bash
nvim scp://user@host:/home/user/repo/file
```

---

## Keymaps & Shortcuts

Custom mappings are in `lua/mappings.lua`.

| Key | Mode | Action |
|---|---|---|
| `;` | Normal | Enter command mode (`:`) |
| `jk` | Insert | Exit to Normal mode |
| `<leader>g` | Normal | Open LazyGit |
| `<leader>f` | Normal | Telescope find files |
| `<leader>ld` | Normal | Open LazyDocker |

### Navigation

| Key | Action |
|---|---|
| `ctrl + u` | Scroll up |
| `ctrl + d` | Scroll down |
| `w` | Go right faster (word forward) |
| `b` | Go left faster (word backward) |
| `gd` | Go to definition |
| `gr` | See references |
| `rn` | Rename variable/function across project |

### File & Window management

| Key | Action |
|---|---|
| `ctrl + v` (on nvim-tree) | Open file in vertical split |
| `<leader>x` | Close current buffer |
| `:q` | Close current window |
| `shift + I` (on nvim-tree) | Show/hide gitignored files |

### Search

| Key | Action |
|---|---|
| `<leader>fw` | Search string in files (live grep) |
| `<leader>fo` | Open recent files |
| `<leader>ff` | Find file by name (Telescope) |
| `/` | Search string in current buffer |
| `n` | Next match |
| `N` | Previous match |
| `"` | Open clipboard/register history |

### File system from Neovim

| Command | Action |
|---|---|
| `:cd path/to/dir` | Navigate to a directory |
| `:! mkdir new-directory` | Create a new folder (`!` = external command) |

> `:checkhealth` — run this to diagnose issues (clipboard not working, LSP problems, etc.): `:h checkhealth`

---

## Customize and Docs

NvChad has built-in docs. Read them inside Neovim:
```
:h nvui
```

All your customizations go into `lua/chadrc.lua`. You override default values there — theme, statusline, NvDash header, tabufline, etc.
