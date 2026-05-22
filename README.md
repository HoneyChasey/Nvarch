<div align="center">
    <img alt="neo-config logo" src="https://github.com/HoneyChasey/neo-config/blob/main/.github/assets/logo.jpg" width="120px"/>
</div>

# Fast installation with stow 

Run this command 

**After a push, nvim-tree may still show files as modified — press R to force a full refresh and update the git status.**

```sh 
stow --target=$HOME nvarch-config
```

# Explication: How use nvchad ? 

> **Please before install**, install the latest version of java on your machine, or javalsp not working

#TODO for the next time, check if all lsp installing automactly


## Development Setup And files for autoconfiguration of LSP 

In this section we will see how to create a file at the root of your project. Thx to this file, your lsp configured correctly for specific dev environment.

### Python LSP with PyRight 

Before, if you used .venv folder, you need to activate the .venv and after enter in nvim. This is bad. 
Now you have just to create a file named: **pyrightconfig.json**. 

Write: 

```json 
{
  "venvPath": ".",
  "venv": ".venv"
}
```
And now you have just need to open nvim and go to your project, lsp will auto configure himself.

### Lua With Lua_ls (lua-language-server)
You can add or auto configure lsp for each project. Like python, write your root project folder. The configuration file's name is: **.luarc.json**

Exemple: 
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

## Plugins 


## Hardtime 

https://github.com/m4xshen/hardtime.nvim  

Plugin to master the neovim commands. 

### Usage
> Check the github to have the latest usage case or else.

Hardtime is enabled by default. You can change its state with the following commands:

    :Hardtime enable enable Hardtime
    :Hardtime disable disable Hardtime
    :Hardtime toggle toggle Hardtime

You can view the most frequently seen hints with :Hardtime report.

Your log file is at ~/.local/state/nvim/hardtime.nvim.log.

## Parser 

If the parser make an error or crash (like the color of your code desapear), please Run :Lazy, and Sync and Update.
If not working again

```bash 
:TSUpdate # Update the parsers
:TSUninstall all # Do this if the previous command not working. After launching this command, please do again a :TSUpdate
```

### checkhealth
This plugin check what not working on your nvim config. Like the clipboard between nvim and pc not working, look checkhealth with 
```bash 
:h checkhealth
```

Nvchad uses lazy.nvim for plugin. 

### Lazy Loading

We lazy load almost 95% of the plugins, so we expect and recommend you to lazy load the plugins as well, as it's efficient in reducing startup-time.

- We don't want users making NvChad slow just because they didn't lazy load plugins they've added.
- Please read the lazy.nvim plugin specs docs to know what options are available for lazyloading etc.
- Try your best to lazy-load a plugin!

By default the ```lazy = true``` set. If you want a plugin to be enabled on startup, change it to ```lazy = false```
- lazy doc -> https://lazy.folke.io/spec/examples  
- plugins/anyname.lua


### Plugins who need Configuration

gitsigns: this plugins permit to have some information, but the most important is blame, to see who change this line. Run this nvim command after installation. (the line in blank where is write who modify the line on the file).

This command line tooggle the current line_blame
```nvim 
Gitsigns tooggle_current_line_blame
```
if you wanna more configuration: please check: https://github.com/lewis6991/gitsigns.nvim 

### Adding your plugins 
- go and find plugins on internet
- after, create a file on lua/plugins/nameplugin.lua 
- write your config, save
- run :Lazy and wait to the plugin as finish to be installed
- The plugin is now active

#### Exemple configuration

```lua

return {
  { "folke/which-key.nvim",  enabled = false }, -- disable a default nvchad plugin

  -- this opts will extend the default opts 
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = {"html", "css", "bash"} },
  }, 

  -- If your opts uses a function call ex: require*, then make opts spec a function
  -- Then modify the opts arg
  {
    "nvim-telescope/telescope.nvim",
    opts = function(_, conf)
      conf.defaults.mappings.i = {
        ["<C-j>"] = require("telescope.actions").move_selection_next,
        ["<Esc>"] = require("telescope.actions").close,
      }

     -- or 
     -- table.insert(conf.defaults.mappings.i, your table)
      return conf
    end,
  }
}

```
### LSP configuration 

> Attention To used lsp in .env file, we need to lauch .env before to launch nvim, exemple with python .env 

```bash
# 1. launch .env environement (because a named my environement folder, .env )
source .env/bin/acctivate 
# 2. launch nvim 
nvim 
```

And now the lsp is now in .env enviroment

Read md (realy read https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md and read the doc of your lsp you want to setup )
**Note: If the docker-compose-langserver doesn't startup when entering a docker-compose.yaml file, make sure that the filetype is yaml.docker-compose. You can set with: :set filetype=yaml.docker-compose.**

Before starting, it is strongly recommended that you walk through the LSP configuration lspconfig repository.

Before to check install a LSP, check is the LSP is present on this list: https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md 

Also, you can find a lsp name with `:Mason` and find with `/` the language you want. Next is to download form internet or via Mason, 

- Plugin table 

Check you have this  

```lua
{
  "neovim/nvim-lspconfig",
   config = function()
      require "configs.lspconfig"
   end,
},

```

- configs/lspconfig.lua 

and this 

```lua
require("nvchad.configs.lspconfig").defaults()

local servers = { "html", "cssls" }
vim.lsp.enable(servers)

-- to configure lsps further read :h vim.lsp.config
```

In this version of nvim (0.11.5), to enable, and used a LSP, you need to follow this step: 

### 1. Via **Mason** (the simplest)

> Mason if for download binnaries for linter, lsp etc etc, Lazy for plugins (ui etc etc)

- Run **Mason** and select the lsp for the languadge you want, select and install him 
- Go to the *init.lua* file, and adding the lsp you just created. 
- Maybe you need to make a configuration, use **:checkhealth vim.lsp** and check if you have warning or errors, Mason does not install default configuration. 
- In the *init.lua* file, adding ```lua vim.lsp.enable('lspName')```, and save. 
- Open a file, in the language of lsp, for exemple python file for pyright, and go to isert mode, if the lsp logo at the butom right is present, the lsp is working, else used  **checkhealth vim.lsp* and look if the lsp need default configuration. 


### 2. Via command line 

- First, download your lsp on your copputer, here i need to have pyright for python, I install him with: ```bash npm i -g pyright```
- Go to your init.lua file, and adding this line to acctivate him: ```lua vim.lsp.enable('pyright')```, change pyright by the name of your lsp 
- Safe and open a file with nvim in the language you downloaded, here in python. 
- Enter in *insert* mode, and you need to see at the right bottom, the *lsp - languageName*. Rugh the command **:checkhealth vim.lsp** to see the status or to troubleshoot. Use this command on the language file you want, i wanna test if python lsp work, open or create python file and use the command.

See :help lspconfig-all for the full list of server-specific details. For servers not on your $PATH (e.g., jdtls, elixirls), you must manually set the cmd parameter:
```lua
vim.lsp.config('jdtls', {
  cmd = { '/path/to/jdtls' },
})
```
#### Configuration 

Nvim sets default options and mappings when LSP is active in a buffer:

- :help lsp-defaults
- :help diagnostic-defaults

To customize, see:

- :help lsp-attach
- :help lsp-buf

Extra settings can be specified for each LSP server. With Nvim 0.11+ you can extend a config by calling vim.lsp.config('…', {…}).

```lua
vim.lsp.config('rust_analyzer', {
  -- Server-specific settings. See `:help lsp-quickstart`
  settings = {
    ['rust-analyzer'] = {},
  },
})

```
#### Config priority

Configs are sourced in this order:

1. lsp/ in 'runtimepath'
2. after/lsp/ in 'runtimepath'
3. vim.lsp.config()

If you install nvim-lspconfig or similar plugins, the order that configs are applied depends on the load order. To ensure that your own config "wins" and overrides the others, use after/lsp/ and/or vim.lsp.config() to override/extend the defaults.

#### Mason.nvim

Run the MasonInstallAll command

> Once the binaries are installed, you will have to configure them to properly work with LSP, conform.nvim, nvim-lint, nvim-dap etc. It depends on what you installed. NvChad does not provide any language configuration aside from lua.

> For me, i think, mason, parse the configs.md -> https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md and install directly from github. 

## Autocmd 
Les Autocmd permettent de savoir qu'elle est le type de fichier est ouvert. On peut évidement changer le type d'un fichier ouvert en focntion d'un nom. Pour savoir qu'elle est le type du fichier qu'on a ovuert, ouvrir un fichier avec nvim, puis taper en commande: 
```bash 
:set ft
```
Évidement on peut changer cela, en disant que xxx parterne de nom de fichier, deviens un typefile précis. Pour cela il faut modifier et rajouter sa config dans, le fichier **autocmds.lua**

## Remote developement 
In neovim you can use plugins, but the better way is to use command line to open folder projet and write on it. Also you can copy the your configuration on the server, but yeah for new vm, or a machine than is not your, or just a machine haven't have neovim it's not worth it. 

```bash
nvim scp://user@host:/home/kyeh0l/repo/file
```


----

## Some shortcut 

- Aller a la définition = gd 
- Voir les références = gr 
- Renommer une variable/fonction dans tous le projet = rn
- Si on veut ouvrir un fichier en slit screen verticale, aller sur le fichier qu'on veut ouvrir (le nvimtree, la ou tous les fichiers sont écrits), mettre son curseur sur le fichier qu'on veut ouvrir et faire `ctrl + v` pour l'ouvrir en split screen, vertical. 
- Fermer une page d'édition: `ctrl+x`, `<leader> + x`. Fermer une fenetre: `:q`
- Pour ce déplacer directement dans le pc, depuis neovim, taper `:` puis cd, et ensuite le path, soit: `:cd path/to/your/file`
- Pour créer un folder avec les commandes nvim: ```:! mkdir new-directory```, car `!` = appel de commande exeterne a neovim
- Pour rechercher une string dans les fichiers du path actuelle: <leader> + fw
- Pour ouvrir les fichiers récent: <leader> + fo 
- Pour faire une rechrcher avec telescope d'un file name: <leader> + ff
- Pour recherche une string, taper `/`, et ensuite recehrcher l'itération suivante avec, `n`, et précedente avec `N`
- Pour aller rechercher dans l'historique des copier coller, il faut juste aller taper ", et ensuite l'historique s'ouvre (et même permet de voir si le texte est copier dans le presse parier system ou pas)
### LSP 
- Pour forcer le lancerment d'un lsp: 
```command 
:LspStart <lspName>
```
Si il y a une erreur ce cera marquer. 

- Utiliser les commadnes `Lsp` sa peut aider (genre LspStop, LspLogs, LspRestart etc...etc...)

## Plugins by default 

- Nvdash, if you wanna desactivate him by default, modify `lua/chadrc.lua` and comment 
```lua 
M.nvdash = { load_on_startup = true }
M.ui = {
       tabufline = {
          lazyload = false
      }
 }
```


## Installation

1. git clone this repo
2. copy the config into the ```~/.config/nvim```
3. Run nvim with ```ǹvim```
4. You see the default TUI of the config thx to nvchad, if you don't see the front, please verify your installation 
5. Run the nvim command `:MasonInstallAll`, to install all lsp, and code helper
6. After, run `Lazy`, and presse the install button (I), for installing plugins. Maybe, some plugins must be reinstall, check errors in Lazy(errors are wrting in red). You need to cleen a plugin, install , and upadte him (x, I, U). You can check with C for all plugins C and c for 1 plugin. Otherwise it's very simple with Lazy. After, just qui and voila. Btw to update your Lazy, run :Lazy sync

## Uninstall 
```bash
# Linux / MacOS (unix)
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

## Customize and docs 

Nvchad have documentation, and if you wann customise your ide, you need to read the docs. 
You can find online, but the way to read this file, is on your computer with the command `:h nvui`. You can find and customise your nvim like as you want. 
With this doc you can also modify the nvchad plugins like the header of nvdash, the satusline style etc etc.

The file you need to modify is `lua/chadrc.lua`, and you need into this file, your custom configuration. You just overwrite, the var default value on this file.
