local gh = require('core.pack').gh

vim.pack.add { gh 'Cannon07/code-preview.nvim' }
require('code-preview').setup {
  keys = {
    close_all = '<leader>ad',
    next_change = ']c',
    prev_change = '[c',
  },
}

vim.keymap.set('n', '<leader>ac', '<cmd>CodePreviewInstallClaudeCodeHooks<CR>', { desc = 'Install [C]laude Code hooks' })
vim.keymap.set('n', '<leader>ao', '<cmd>CodePreviewInstallOpenCodeHooks<CR>', { desc = 'Install [O]penCode hooks' })
vim.keymap.set('n', '<leader>ax', '<cmd>CodePreviewInstallCodexCliHooks<CR>', { desc = 'Install Code[x] CLI hooks' })

vim.pack.add {
  {
    src = gh 'nickjvandyke/opencode.nvim',
    version = vim.version.range '*',
  },
}

---@type opencode.Opts
vim.g.opencode_opts = {}

vim.keymap.set({ 'n', 'x' }, '<leader>aa', function()
  require('opencode').ask '@this: '
end, { desc = '[A]sk OpenCode this…' })

vim.keymap.set({ 'n', 'x' }, '<leader>aq', function()
  require('opencode').ask()
end, { desc = '[Q]uery OpenCode…' })

vim.keymap.set({ 'n', 'x' }, '<leader>as', function()
  require('opencode').select()
end, { desc = '[S]elect OpenCode…' })

vim.keymap.set({ 'n', 'x' }, 'go', function()
  return require('opencode').operator '@this '
end, { desc = 'Append range to OpenCode', expr = true })

vim.keymap.set({ 'n' }, 'goo', function()
  return require('opencode').operator '@this ' .. '_'
end, { desc = 'Append line to OpenCode', expr = true })

vim.keymap.set({ 'n' }, '<leader>a<C-u>', function()
  require('opencode').command 'session.half.page.up'
end, { desc = 'Scroll OpenCode [U]p' })

vim.keymap.set({ 'n' }, '<leader>a<C-d>', function()
  require('opencode').command 'session.half.page.down'
end, { desc = 'Scroll OpenCode [D]own' })
