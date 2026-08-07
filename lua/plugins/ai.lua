local gh = require('core.pack').gh

vim.pack.add { gh 'milanglacier/minuet-ai.nvim' }
require('minuet').setup {
  provider = 'openai_fim_compatible',
  request_timeout = 2.5,
  throttle = 1500,
  debounce = 150,
  n_completions = 1,
  context_window = 512,
  provider_options = {
    openai_fim_compatible = {
      api_key = 'TERM',
      name = 'Llama.cpp',
      end_point = 'http://localhost:8012/v1/completions',
      -- The model is set by the llama-cpp server and cannot be altered
      -- post-launch.
      model = 'ggml-org/Qwen2.5-Coder-7B-Q8_0-GGUF',
      optional = {
        max_tokens = 56,
        top_p = 0.9,
      },
      -- Llama.cpp does not support the `suffix` option in FIM completion.
      -- Therefore, we must disable it and manually populate the special
      -- tokens required for FIM completion.
      template = {
        prompt = function(context_before_cursor, context_after_cursor, _)
          return '<|fim_prefix|>' .. context_before_cursor .. '<|fim_suffix|>' .. context_after_cursor .. '<|fim_middle|>'
        end,
        suffix = false,
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

vim.pack.add { gh 'Cannon07/code-preview.nvim' }
require('code-preview').setup {
  keys = {
    close_all = '<leader>ad',
    next_change = ']c',
    prev_change = '[c',
  },
}

vim.keymap.set('n', '<leader>at', '<cmd>Minuet virtualtext toggle<CR>', { desc = 'Toggle minuet virtual text' })
vim.keymap.set('n', '<leader>ac', '<cmd>CodePreviewInstallClaudeCodeHooks<CR>', { desc = 'Install [C]laude Code hooks' })
vim.keymap.set('n', '<leader>ao', '<cmd>CodePreviewInstallOpenCodeHooks<CR>', { desc = 'Install [O]penCode hooks' })
vim.keymap.set('n', '<leader>ax', '<cmd>CodePreviewInstallCodexCliHooks<CR>', { desc = 'Install Code[x] CLI hooks' })
