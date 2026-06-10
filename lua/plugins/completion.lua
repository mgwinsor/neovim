local gh = require('core.pack').gh

vim.pack.add { 'https://github.com/windwp/nvim-autopairs' }
require('nvim-autopairs').setup {}

vim.pack.add { { src = gh 'L3MON4D3/LuaSnip', version = vim.version.range '2.*' } }
local ls = require 'luasnip'
ls.setup {}
ls.add_snippets('markdown', {
  ls.parser.parse_snippet('md103', '<!-- markdownlint-disable-next-line MD013 -->'),
})

vim.pack.add { gh 'rafamadriz/friendly-snippets' }
require('luasnip.loaders.from_vscode').lazy_load()

-- [[ Autocomplete Engine ]]
vim.pack.add { { src = gh 'saghen/blink.cmp', version = vim.version.range '1.*' } }
require('blink.cmp').setup {
  keymap = {
    -- For an understanding of why the 'default' preset is recommended,
    -- you will need to read `:help ins-completion`
    --
    -- No, but seriously. Please read `:help ins-completion`, it is really good!
    --
    -- All presets have the following mappings:
    -- <tab>/<s-tab>: move to right/left of your snippet expansion
    -- <c-space>: Open menu or open docs if already open
    -- <c-n>/<c-p> or <up>/<down>: Select next/previous item
    -- <c-e>: Hide menu
    -- <c-k>: Toggle signature help
    --
    -- See `:help blink-cmp-config-keymap` for defining your own keymap
    preset = 'default',

    -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
    --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
  },

  appearance = {
    nerd_font_variant = 'mono',
  },

  completion = {
    -- By default, you may press `<c-space>` to show the documentation.
    -- Optionally, set `auto_show = true` to show the documentation after a delay.
    documentation = { auto_show = true, auto_show_delay_ms = 500 },
  },

  sources = {
    default = { 'lsp', 'path', 'snippets' },
  },

  snippets = { preset = 'luasnip' },

  -- See `:help blink-cmp-config-fuzzy` for more information
  fuzzy = { implementation = 'prefer_rust_with_warning' },

  -- Shows a signature help window while you type arguments for a function
  signature = { enabled = true },
}
