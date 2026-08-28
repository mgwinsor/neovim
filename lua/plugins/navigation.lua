local gh = require('core.pack').gh

local plugins = {
  { src = gh 'nvim-neo-tree/neo-tree.nvim', version = vim.version.range '*' },
  gh 'nvim-lua/plenary.nvim',
  gh 'MunifTanjim/nui.nvim',
  gh 'stevearc/oil.nvim',
  gh 'christoomey/vim-tmux-navigator',
  gh 'aimdevlee/herdr-nvim-nav',
}

if vim.g.have_nerd_font then
  table.insert(plugins, gh 'nvim-tree/nvim-web-devicons')
end

vim.g.tmux_navigator_no_mappings = 1

vim.pack.add(plugins)

vim.keymap.set('n', '\\', '<Cmd>Neotree float<CR>', { desc = 'NeoTree float', silent = true })
vim.keymap.set('n', '-', '<Cmd>Oil<CR>', { desc = 'Oil explorer' })

require('herdr-nvim-nav').setup {
  with_tmux = nil,
  keymaps = {
    left = { '<C-h>', '<C-Left>' },
    down = { '<C-j>', '<C-Down>' },
    up = { '<C-k>', '<C-Up>' },
    right = { '<C-l>', '<C-Right>' },
  },
  socket_path = nil,
  cache_dir = nil,
  herdr_bin = nil,
  socket_timeout_ms = 150,
}

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
