local gh = require('core.pack').gh

local plugins = {
  { src = gh 'nvim-neo-tree/neo-tree.nvim', version = vim.version.range '*' },
  gh 'nvim-lua/plenary.nvim',
  gh 'MunifTanjim/nui.nvim',
  gh 'stevearc/oil.nvim',
  gh 'christoomey/vim-tmux-navigator',
}

if vim.g.have_nerd_font then
  table.insert(plugins, gh 'nvim-tree/nvim-web-devicons')
end

vim.pack.add(plugins)

vim.keymap.set('n', '\\', '<Cmd>Neotree float<CR>', { desc = 'NeoTree float', silent = true })
vim.keymap.set('n', '-', '<Cmd>Oil<CR>', { desc = 'Oil explorer' })
vim.keymap.set('n', '<c-h>', '<Cmd>TmuxNavigateLeft<cr>', { desc = 'Tmux navigate left' })
vim.keymap.set('n', '<c-j>', '<Cmd>TmuxNavigateDown<cr>', { desc = 'Tmux navigate down' })
vim.keymap.set('n', '<c-k>', '<Cmd>TmuxNavigateUp<cr>', { desc = 'Tmux navigate up' })
vim.keymap.set('n', '<c-l>', '<Cmd>TmuxNavigateRight<cr>', { desc = 'Tmux navigate right' })

require('neo-tree').setup {
  filesystem = {
    window = {
      mappings = {
        ['\\'] = 'close_window',
      },
    },
  },
}

local detail = false
require('oil').setup {
  view_options = { show_hidden = true },
  keymaps = {
    ['gd'] = {
      desc = 'Toggle file detail view',
      callback = function()
        detail = not detail
        if detail then
          require('oil').set_columns { 'icon', 'permissions', 'size', 'mtime' }
        else
          require('oil').set_columns { 'icon' }
        end
      end,
    },
  },
}
