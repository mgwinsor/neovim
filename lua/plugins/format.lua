local gh = require('core.pack').gh

vim.pack.add { gh 'stevearc/conform.nvim' }
require('conform').setup {
  notify_on_error = false,
  format_on_save = function(bufnr)
    local enabled_filetypes = {
      go = true,
      html = true,
      lua = true,
      markdown = false,
      javascript = true,
      python = true,
      rust = true,
      typescript = true,
    }
    if enabled_filetypes[vim.bo[bufnr].filetype] then
      return { timeout_ms = 500 }
    else
      return nil
    end
  end,
  default_format_opts = {},
  formatters_by_ft = {
    go = { 'goimports', 'gofumpt' },
    html = { 'prettierd', 'prettier', stop_after_first = true },
    lua = { 'stylua' },
    markdown = { 'mdformat' },
    javascript = { 'prettierd', 'prettier', stop_after_first = true },
    python = { 'isort', 'ruff_format' },
    rust = { 'rustfmt' },
    typescript = { 'prettierd', 'prettier', stop_after_first = true },
  },
}

vim.keymap.set({ 'n', 'v' }, '<leader>f', function()
  require('conform').format { async = true }
end, { desc = '[F]ormat buffer' })
