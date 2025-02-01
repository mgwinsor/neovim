return {
  'preservim/vim-pencil',

  'folke/twilight.nvim',

  { 'folke/zen-mode.nvim', opts = {
    plugins = {
      gitsigns = { enabled = false },
      tmux = { enabled = true },
    },
  } },
}
