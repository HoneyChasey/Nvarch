<div align="center">
    <img alt="nvarch logo" src="/.github/assets/logo.jpg" width="120px"/>
</div>


> Only work with neovim >= 0.11

# Nvarch — Neovim Config

My personal Neovim configuration. Originally built on top of **NvChad v2.5**, then fully migrated off the `NvChad/NvChad` UI plugin — this is now a standalone config built directly on **lazy.nvim**, with hand-picked plugins and no NvChad runtime dependency. `lua/chadrc.lua` is a leftover stub from that migration and currently does nothing.



<div align="center">
    <img alt="nvarch logo" src="/.github/assets/demo.png"/>
</div>

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
4. Open Neovim with `nvim` — lazy.nvim bootstraps itself on first launch and installs every plugin under `lua/plugins/` and `lua/themes/`
5. You should see the dashboard (`dashboard-nvim`, "NVIM" ASCII header). If the icons look wrong, verify your terminal font supports Nerd Fonts
6. Run `:Mason` and install the binaries for the LSP servers you need (see the `servers` list in `lua/configs/lspconfig.lua` — there is no automatic "install all" command in this config)
7. Run `:Lazy`, press `I` to install all plugins if anything is missing. If some show errors (in red), clean and reinstall them (`x`, then `I`, then `U`). Use `C` to check all plugins or `c` for one. Run `:Lazy sync` to update

> **Before installing**, make sure the latest version of Java is installed on your machine — otherwise `jdtls` (Java LSP) won't work.

### install.sh

The script installs system-level dependencies. It supports:

- **macOS**: installs via `brew`
- **Debian/Ubuntu**: installs via `apt-get`
- **Arch Linux**: installs via `pacman` (see bottom of the script)

It also installs Rust via `rustup` and `tree-sitter-cli` via `cargo` on every platform.

Dependencies installed: `ripgrep`, `lazygit`, `lazydocker`, `luarocks`, `unixodbc`, plus `wl-clipboard` on Linux (Wayland clipboard support; macOS uses the built-in `pbcopy`/`pbpaste`).

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

- **Default colorscheme**: `dracula`, set in `init.lua` (`vim.cmd.colorscheme("dracula")`). Change that line to switch the default.
- **Available themes** (`lua/themes/`, each lazy-loaded at startup with `priority = 1000`): `dracula`, `catppuccin`, `cyberdream`, `onedark.vim` (as `onedark`), `tokyonight`, `vim-nightfly-colors` (as `nightfly`).
- **Pick a theme interactively**: `<leader>th` opens Telescope's colorscheme picker.
- **Statusline**: `lualine.nvim`, configured in `lua/configs/lualine.lua` — shows mode, git branch/diff, LSP diagnostics, filename, attached LSP client names, fileformat, filetype, and cursor location. `globalstatus` is enabled (one statusline for the whole window).
- **Bufferline**: `bufferline.nvim` draws a tab-style bar for open buffers. Cycle with `<Tab>` / `<S-Tab>`.
- **Dashboard**: `dashboard-nvim` (`hyper` theme, `lua/configs/dashboard-nvim.lua`) shows an ASCII "NVIM" header, Find File / Quit shortcuts, recent projects, and recent files on `VimEnter`.

---

## Plugins

This config uses **lazy.nvim** for plugin management (bootstrapped directly in `lua/configs/lazy.lua`, no longer via NvChad). Plugins live in `lua/plugins/`, one file per plugin; themes live in `lua/themes/`, both imported wholesale by the `lazy.setup` spec.

### Installed plugins

| Plugin | Purpose |
|---|---|
| `neovim/nvim-lspconfig` | LSP server configuration |
| `hrsh7th/nvim-cmp` (+ `cmp-nvim-lsp`, `cmp-buffer`, `cmp-path`, `lspkind.nvim`) | Autocompletion with icons |
| `mason-org/mason.nvim` | Installs LSP/formatter/linter binaries |
| `ray-x/lsp_signature.nvim` | Function signature hints while typing |
| `smjonas/inc-rename.nvim` | Incremental rename with live preview |
| `nvim-treesitter/nvim-treesitter` | Syntax highlighting & parsing |
| `stevearc/conform.nvim` | Formatting |
| `windwp/nvim-autopairs` | Auto-closes brackets/quotes |
| `norcalli/nvim-colorizer.lua` | Highlights color codes (`#hex`, `rgb(...)`) inline |
| `folke/todo-comments.nvim` | Highlights/lists `TODO`, `FIXME`, `NOTE`, etc. |
| `lewis6991/gitsigns.nvim` | Git signs and line blame in the gutter |
| `kdheepak/lazygit.nvim` | LazyGit inside Neovim |
| `HoneyChasey/lazydocker.nvim` | LazyDocker inside Neovim |
| `stevearc/oil.nvim` | Default file explorer (edit a directory like a buffer) |
| `nvim-neo-tree/neo-tree.nvim` | Optional sidebar tree file explorer |
| `nvim-lualine/lualine.nvim` | Statusline |
| `akinsho/bufferline.nvim` | Buffer tab bar |
| `nvimdev/dashboard-nvim` | Startup dashboard |
| `akinsho/toggleterm.nvim` | Floating/split terminals |
| `folke/which-key.nvim` | Popup showing available keybindings |
| `nvim-telescope/telescope.nvim` (+ `telescope-fzf-native.nvim`) | Fuzzy finder |
| `nvim-tree/nvim-web-devicons` | Nerd Font icon glyphs used by other plugins |

### Lazy loading

By default `lazy = true`. Plugins that need to be available from startup (statusline, bufferline, treesitter, oil, neo-tree, themes) explicitly set `lazy = false`. When you add a plugin, try to lazy-load it unless it needs to run before you open a file.

- lazy.nvim spec docs: https://lazy.folke.io/spec/examples

### Adding your own plugin

1. Find a plugin on GitHub
2. Create `lua/plugins/nameplugin.lua`
3. Write your config and save
4. Run `:Lazy` and wait for the install to finish

Example config:

```lua
return {
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

---

## File explorers

Two are installed side by side:

- **Oil** (`stevearc/oil.nvim`) — the default file explorer, edits a directory as a normal buffer. Open with `<leader>e`. Hidden files are shown; `<C-v>` opens the file under the cursor in a vertical split.
- **Neo-tree** (`nvim-neo-tree/neo-tree.nvim`) — a sidebar tree view, for when you actually want a persistent file tree (`lua/configs/neo-tree.lua`). Open with `<leader>tr`. Dotfiles are visible, gitignored files are hidden by default (toggle hidden items with neo-tree's default `H` binding), `.git` is always hidden.

---

## Completion

`hrsh7th/nvim-cmp` (`lua/plugins/lua-cpm.lua`) provides autocompletion from the LSP, open buffers, and file paths, with `lspkind.nvim` icons. Its capabilities are merged into every LSP client via `vim.lsp.config('*', { capabilities = ... })`.

| Key (Insert mode) | Action |
|---|---|
| `<C-Space>` | Trigger completion |
| `<Tab>` / `<C-n>` | Next item |
| `<C-p>` | Previous item |
| `<CR>` / `<C-y>` | Confirm selection |
| `<C-b>` / `<C-f>` | Scroll docs up/down |

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

Configured in `lua/plugins/nvim-treesitter.lua` and `lua/configs/treesitter.lua` (new `main`-branch treesitter API).

Currently explicitly installed: `svelte`. Other parsers can be added to `ensure_installed` and pulled in with the `:TSInstallAll` user command defined in `lua/autocmds.lua`.

If a parser causes errors (e.g., code colors disappear), run:
```
:Lazy sync
```
or update parsers directly:
```
:TSUpdate
```

### Conform (Formatter)

Configured in `lua/configs/conform.lua`. Currently active formatters:

| Filetype | Formatter |
|---|---|
| Lua | `stylua` |

Format on save is disabled by default. To enable it, uncomment the `format_on_save` block in `lua/configs/conform.lua` and the `event = 'BufWritePre'` line in `lua/plugins/conform.lua`.

Lua formatting itself follows `.stylua.toml` at the repo root: 120-column width, 2-space indent, double quotes preferred, no parens on single-string/table calls.

---

## LSP Configuration

LSP servers are configured in `lua/configs/lspconfig.lua`. The `servers` table lists all enabled servers:

```lua
local servers = {
  "html", "cssls", "bashls", "clangd", "dockerls", "docker_compose_language_service",
  "gopls", "jdtls", "lua_ls", "pyright", "svelte", "nil_ls", "rust_analyzer",
}
vim.lsp.enable(servers)
```

Diagnostics are shown as virtual text (`vim.diagnostic.config`).

> To find the correct name for a server, check the lspconfig configs list: https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md

When you add a name to the `servers` list, Neovim looks for a matching file in lspconfig's `configs/` folder and reads it to know which binary to run and how to start it.

### Install an LSP via Mason (recommended)

> Mason downloads binaries (LSPs, linters, formatters). Lazy manages Neovim plugins (UI, etc.).

1. Run `:Mason` and find + install the LSP for the language you want
2. Add the server name to the `servers` table in `lua/configs/lspconfig.lua`
3. Run `:checkhealth vim.lsp` to spot any warnings or missing config
4. Open a file in the target language and enter insert mode — if the LSP name shows up in the lualine LSP segment, it's working

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

### LSP keymaps

No custom `gd`/`gr`/rename mappings are defined in `mappings.lua` — this config relies on Neovim 0.11's built-in LSP defaults (`:h lsp-defaults`): `grn` rename, `gra` code action, `grr` references, `gri` goto implementation, `gO` document symbols, `K` hover, `<C-s>` signature help (Insert mode), `]d` / `[d` next/prev diagnostic. `lsp_signature.nvim` additionally shows signature hints automatically while typing arguments in Insert mode. `inc-rename.nvim` is installed for incremental rename with a live preview but is not bound to a key — invoke it with `:IncRename <new name>`.

### Useful LSP commands

```
:LspStart <lspName>    -- force-start a specific LSP
:LspStop               -- stop LSP in current buffer
:LspRestart            -- restart LSP
:LspLog                -- view LSP logs
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

## Terminal

`toggleterm.nvim` provides floating/split terminals.

| Key | Mode | Action |
|---|---|---|
| `<leader>h` | Normal | New horizontal terminal |
| `<leader>v` | Normal | New vertical terminal |
| `<A-v>` | Normal/Terminal | Toggle a dedicated vertical terminal (instance 2) |
| `<A-h>` | Normal/Terminal | Toggle a dedicated horizontal terminal (instance 3) |
| `<A-i>` | Normal/Terminal | Toggle a dedicated floating terminal (instance 4) |
| `<C-x>` | Terminal | Escape terminal mode back to Normal |

`<leader>pt` (Telescope `terms`) lists and jumps to any hidden/running terminal.

---

## Which-key

`folke/which-key.nvim` pops up available keybindings as you type.

| Key | Action |
|---|---|
| `<leader>?` | Show buffer-local keymaps |
| `<leader>wK` | Show all keymaps |
| `<leader>wk` | Prompt for a key and look up its mapping |

---

## Filetype detection

`lua/configs/filetype.lua` adds filetype overrides via `vim.filetype.add`, matched by **exact filename**:

- `docker-compose.yml`, `docker-compose.yaml`, `compose.yml`, `compose.yaml` → `yaml.docker-compose`

> If the docker-compose LSP doesn't start when opening a compose file, check the filetype with `:set ft`. If it's not `yaml.docker-compose`, set it manually: `:set filetype=yaml.docker-compose`

### ftplugin/

Neovim runs any file in `ftplugin/` automatically when a matching filetype is opened — the filename is the filetype selector (`ftplugin/svelte.lua` runs only for `.svelte` files). Currently `ftplugin/svelte.lua` calls `vim.treesitter.start()` to make sure Svelte gets treesitter highlighting. See `ftplugin/README.md` for more detail.

---

## Autocmds

Custom autocmds live in `lua/autocmds.lua`:

- An `NvFilePost` autocmd waits until the UI is up and a real file buffer is open before firing a `FilePost` user event and re-running `FileType` — this defers file-related setup (syntax, filetype plugins, editorconfig) until it's actually needed, then removes itself so it only runs once.
- A global `FileType` autocmd starts treesitter highlighting (`vim.treesitter.start()`) for every filetype.
- The `:TSInstallAll` user command installs every parser listed in `nvim-treesitter`'s `ensure_installed` option.

---

## Options

Set in `lua/options.lua` (loaded from `init.lua`, alongside `autocmds.lua` and `configs/filetype.lua`):

- Leader key: `<Space>`; local leader: `\`
- `laststatus = 3` (one global statusline), `showmode = false`
- `clipboard = "unnamedplus"`, `mouse = "a"`
- 2-space indentation (`expandtab`, `shiftwidth`/`tabstop`/`softtabstop = 2`, `smartindent`)
- `ignorecase` + `smartcase` for search, `undofile` for persistent undo
- `number = true` with a narrow `numberwidth = 2`, `cursorline` highlighting just the line number
- Node/Python3/Perl/Ruby providers disabled for faster startup
- Mason's `bin` directory is prepended to `$PATH` so installed LSP/formatter binaries are found without a shell restart

---

## Remote Development

You can edit files on a remote server directly from Neovim over SSH:
```bash
nvim scp://user@host:/home/user/repo/file
```

---

## Keymaps & Shortcuts

Custom mappings are in `lua/mappings.lua`. Leader is `<Space>`.

| Key | Mode | Action |
|---|---|---|
| `;` | Normal | Enter command mode (`:`) |
| `<Esc>` | Normal | Clear search highlights |
| `<C-s>` | Normal | Save file |
| `<C-c>` | Normal | Copy whole file to clipboard |
| `<leader>n` | Normal | Toggle line numbers |
| `<leader>rn` | Normal | Toggle relative line numbers |
| `<leader>fm` | Normal/Visual | Format file (conform, LSP fallback) |
| `<leader>ds` | Normal | LSP diagnostics loclist |
| `<leader>/` | Normal/Visual | Toggle comment |
| `<leader>g` | Normal | Open LazyGit |
| `<leader>ld` | Normal | Open LazyDocker |
| `<leader>f` / `<leader>ff` | Normal | Telescope find files (hidden files included) |

### Insert-mode movement

| Key | Action |
|---|---|
| `<C-b>` / `<C-e>` | Beginning / end of line |
| `<C-h>` / `<C-l>` | Move left / right |
| `<C-j>` / `<C-k>` | Move down / up |

### Window navigation

| Key | Action |
|---|---|
| `<C-h>` / `<C-l>` | Switch window left / right |
| `<C-j>` / `<C-k>` | Switch window down / up |

### Buffers

| Key | Action |
|---|---|
| `<leader>b` | New buffer |
| `<Tab>` / `<S-Tab>` | Next / previous buffer (bufferline) |
| `<leader>x` | Close current buffer, keep the window |

### File & Window management

| Key | Action |
|---|---|
| `<leader>e` | Open Oil (file explorer) |
| `<leader>tr` | Open Neo-tree (sidebar tree explorer) |
| `<C-v>` (in Oil) | Open file under cursor in a vertical split |
| `:q` | Close current window |

### Search (Telescope)

| Key | Action |
|---|---|
| `<leader>fw` | Live grep in files (hidden files included) |
| `<leader>ff` / `<leader>f` | Find file by name (hidden files included) |
| `<leader>fb` | Find open buffers |
| `<leader>fh` | Help tags |
| `<leader>fo` | Recent files |
| `<leader>fz` | Fuzzy find in current buffer |
| `<leader>ma` | Find marks |
| `<leader>cm` | Git commits |
| `<leader>gt` | Git status |
| `<leader>pt` | Pick a hidden terminal |
| `<leader>th` | Colorscheme picker |
| `/`, `n`, `N` | Search in buffer, next/previous match (native Vim) |
| `"` | Open clipboard/register history (native Vim) |

### File system from Neovim

| Command | Action |
|---|---|
| `:cd path/to/dir` | Navigate to a directory |
| `:! mkdir new-directory` | Create a new folder (`!` = external command) |

> `:checkhealth` — run this to diagnose issues (clipboard not working, LSP problems, etc.): `:h checkhealth`

---

## License

`LICENSE` (Unlicense — public domain) covers the Neovim config under `nvarch-config/.config/nvim`.

## Customize

There's no NvChad UI layer to read docs from anymore (`:h nvui` won't resolve). To customize:

- Plugin specs: edit or add files under `lua/plugins/`
- Per-plugin setup options: edit the matching file under `lua/configs/` (only plugins with non-trivial config get one; simple plugins configure inline via `opts = {}` in their `lua/plugins/*.lua` file)
- Global options / keymaps / autocmds: `lua/options.lua`, `lua/mappings.lua`, `lua/autocmds.lua`
- Themes: add a new file under `lua/themes/`, following the existing ones as a template
