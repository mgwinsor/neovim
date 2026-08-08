local gh = require('core.pack').gh

vim.pack.add { gh 'Cannon07/code-preview.nvim' }
vim.pack.add { gh 'milanglacier/minuet-ai.nvim' }
vim.pack.add {
  {
    src = gh 'nickjvandyke/opencode.nvim',
    version = vim.version.range '*',
  },
}

require('code-preview').setup {
  keys = {
    close_all = '<leader>ad',
    next_change = ']c',
    prev_change = '[c',
  },
}

require('minuet').setup {
  provider = 'openai_compatible',
  request_timeout = 2.5,
  throttle = 1500, -- Increase to reduce costs and avoid rate limits
  debounce = 600, -- Increase to reduce costs and avoid rate limits
  provider_options = {
    openai_compatible = {
      api_key = 'OPENROUTER_API_KEY',
      end_point = 'https://openrouter.ai/api/v1/chat/completions',
      model = 'deepseek/deepseek-v4-flash',
      name = 'Openrouter',
      optional = {
        max_tokens = 56,
        top_p = 0.9,
        provider = {
          -- Prioritize throughput for faster completion
          sort = 'throughput',
        },
        -- disable thinking to avoid first token latency
        reasoning_effort = 'none',
      },
    },
  },
  virtualtext = {
    auto_trigger_ft = {},
    keymap = {
      -- accept whole completion
      accept = '<M-A>',
      -- accept one line
      accept_line = '<M-a>',
      -- accept n lines (prompts for number)
      -- e.g. "A-z 2 CR" will accept 2 lines
      accept_n_lines = '<M-z>',
      -- Cycle to prev completion item, or manually invoke completion
      prev = '<M-[>',
      -- Cycle to next completion item, or manually invoke completion
      next = '<M-]>',
      dismiss = '<M-e>',
    },
  },
}

vim.keymap.set('n', '<leader>at', '<cmd>Minuet virtualtext toggle<CR>', { desc = 'Toggle minuet virtual text' })
vim.keymap.set('n', '<leader>ao', '<cmd>CodePreviewInstallOpenCodeHooks<CR>', { desc = 'Install [O]penCode hooks' })

---@type opencode.Opts
vim.g.opencode_opts = {}

vim.keymap.set({ 'n', 'x' }, '<leader>aa', function()
  require('opencode').ask '@this: '
end, { desc = '[A]sk OpenCode @this…' })

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
