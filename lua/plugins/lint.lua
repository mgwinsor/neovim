local gh = require('core.pack').gh

vim.pack.add { gh 'mfussenegger/nvim-lint' }
local lint = require 'lint'
lint.linters_by_ft = {
  dockerfile = { 'hadolint' },
  html = { 'htmlhint' },
  json = { 'jsonlint' },
  markdown = { 'markdownlint-cli2' },
  python = { 'ruff' },
  yaml = { 'yamllint' },
}

---@param global_path string
---@param local_filename string
---@return string|nil
local function resolve_config(global_path, local_filename)
  local local_path = vim.fn.getcwd() .. '/' .. local_filename
  if vim.fn.filereadable(local_path) == 1 then
    return local_path
  elseif vim.fn.filereadable(global_path) == 1 then
    return global_path
  end
  return nil
end

local nvim_root = vim.fn.stdpath 'config'

local md_config_global = nvim_root .. '/tool_configs/markdownlint-cli2.yaml'
local md_config = resolve_config(md_config_global, '.markdownlint-cli2.yaml')
if md_config then
  lint.linters['markdownlint-cli2'].args = { '--config', md_config, '-' }
end

local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
  group = lint_augroup,
  callback = function()
    if vim.bo.modifiable then
      lint.try_lint()
    end
  end,
})
