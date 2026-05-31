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
vim.keymap.set('n', '<leader>ag', '<cmd>CodePreviewInstallCopilotCliHooks<CR>', { desc = 'Install [G]itHub Copilot hooks' })
vim.keymap.set('n', '<leader>ax', '<cmd>CodePreviewInstallCodexCliHooks<CR>', { desc = 'Install Code[x] CLI hooks' })
