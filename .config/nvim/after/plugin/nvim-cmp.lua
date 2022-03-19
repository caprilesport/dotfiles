local cmp = require('cmp')
local cmp_format = require('lsp-zero').cmp_format()

cmp.setup({
    sources = {
        {name = 'nvim_lsp'},
        {name = 'nvim_lua'},
        {name = 'neorg'},
        {name = 'buffer'},
        {name = 'luasnip'},
    },
    formatting = cmp_format,
    preselect = 'item',
    completion = {
        completeopt = 'menu,menuone,noinsert'
    },
  })
