return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    opts = {
      flavour = 'mocha',
      background = {
        light = 'latte',
        dark = 'mocha',
      },
      transparent_background = false,
      dim_inactive = {
        enabled = true,
        shade = 'dark',
        percentage = 0.01,
      },
    },
    init = function()
      vim.cmd.colorscheme 'catppuccin'
      vim.cmd.hi 'Comment gui=none'
    end,
  },

  {
    'folke/todo-comments.nvim',
    event = 'VimEnter',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = { signs = false },
  },
}
