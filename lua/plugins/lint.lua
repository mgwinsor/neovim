local gh = require('core.pack').gh

vim.pack.add { gh 'mfussenegger/nvim-lint' }
local lint = require 'lint'
lint.linters_by_ft = {
  dockerfile = { 'hadolint' },
  html = { 'htmlhint' },
  markdown = { 'markdownlint' },
  json = { 'jsonlint' },
  yaml = { 'yamllint' },
}

local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
  group = lint_augroup,
  callback = function()
    if vim.bo.modifiable then
      lint.try_lint()
    end
  end,
})
