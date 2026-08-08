local gh = require('core.pack').gh

vim.pack.add { gh 'folke/snacks.nvim' }
require('snacks').setup {
  input = { enabled = true },
  picker = { enabled = true },
}
