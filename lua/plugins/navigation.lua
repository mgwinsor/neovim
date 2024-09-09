local detail = false

return {
  {
    'stevearc/oil.nvim',
    opts = {
      default_file_explorer = false,
      columns = {
        'icon',
      },
      view_options = {
        show_hidden = false,
      },
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
    },
    keys = {
      { '<leader>o', ':Oil<CR>', { desc = 'Oil explorer' } },
    },
    dependencies = { 'nvim-tree/nvim-web-devicons' },
  },

  {
    'nvim-neo-tree/neo-tree.nvim',
    version = '*',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
      'MunifTanjim/nui.nvim',
    },
    cmd = 'Neotree',
    keys = {
      { '\\', ':Neotree float<CR>', desc = 'NeoTree float' },
    },
    opts = {
      filesystem = {
        window = {
          mappings = {
            ['\\'] = 'close_window',
          },
        },
      },
    },
  },
}
