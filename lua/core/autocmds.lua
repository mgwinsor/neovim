vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

vim.api.nvim_create_autocmd('BufEnter', {
  desc = 'Change conceal level for markdown files',
  group = vim.api.nvim_create_augroup('markdown-concealer-set', { clear = true }),
  callback = function(opts)
    if vim.bo[opts.buf].filetype == 'markdown' then
      vim.opt_local.conceallevel = 2
    end
  end,
})
