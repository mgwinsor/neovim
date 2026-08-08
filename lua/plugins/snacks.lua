local gh = require('core.pack').gh

vim.pack.add { gh 'folke/snacks.nvim' }
require('snacks').setup {
  input = { enabled = true },
  picker = { enabled = true },
  dim = { enabled = true },
}

vim.keymap.set('n', '<leader>tt', function()
  if vim.g.snacks_dim == false then
    vim.g.snacks_dim = nil
    Snacks.dim.enable()
  else
    Snacks.dim.disable()
    vim.g.snacks_dim = false
  end
end, { desc = '[T]oggle [D]im' })
