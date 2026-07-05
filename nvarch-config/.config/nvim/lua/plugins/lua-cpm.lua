return { -- it's pretty heavy bc the developer do not export the plugin for lazy. Thx claud and reddit
  'hrsh7th/nvim-cmp',
  event = 'InsertEnter',
  dependencies = {
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
  },
  config = function()
    local cmp = require('cmp')

    cmp.setup({
      completion = {
        completeopt = 'menu,menuone,noinsert',
      },
      mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
        ['<C-Space>'] = cmp.mapping.complete(),
        ["<Tab>"] = cmp.mapping.select_next_item(), -- press tab to selec the next item
        ['<CR>'] = cmp.mapping.confirm({ select = true }),
        ['<C-y>'] = cmp.mapping.confirm({ select = true }),
      }),
      sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'path' },
      }, {
        { name = 'buffer' },
      }),
    })

    -- register LSP capabilities so LSP servers know cmp can handle completions
    vim.lsp.config('*', { capabilities = require('cmp_nvim_lsp').default_capabilities() })
  end
}
