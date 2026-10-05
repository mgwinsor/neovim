vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

vim.keymap.set({ 'n', 'x' }, '<leader>v', [["_d]], { desc = 'Delete into the void' })

vim.keymap.set('n', '<leader>tn', '<cmd>tabnew<CR>', { desc = '[T]ab [N]ew' })

vim.keymap.set('n', '<leader>pa', function()
  local path = vim.fn.expand '%:p'
  vim.fn.setreg('+', path)
  vim.notify('Copied absolute path: ' .. path)
end, { desc = '[P]ath [A]bsolute (copy to clipboard)' })

vim.keymap.set('n', '<leader>pr', function()
  local path = vim.fn.expand '%:.'
  vim.fn.setreg('+', path)
  vim.notify('Copied relative path: ' .. path)
end, { desc = '[P]ath [R]elative (copy to clipboard)' })
