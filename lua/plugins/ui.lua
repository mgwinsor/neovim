local gh = require('core.pack').gh

vim.pack.add { gh 'NMAC427/guess-indent.nvim' }
require('guess-indent').setup {}

vim.pack.add { gh 'lukas-reineke/indent-blankline.nvim' }
require('ibl').setup {}

if vim.g.have_nerd_font then
  vim.pack.add { gh 'nvim-tree/nvim-web-devicons' }
end

vim.pack.add { gh 'folke/which-key.nvim' }
require('which-key').setup {
  preset = 'helix',
  delay = 500,
  icons = { mappings = vim.g.have_nerd_font },
  spec = {
    { '<leader>o', group = '[O]bsidian', icon = '', mode = { 'n', 'v' } },
    { '<leader>s', group = '[S]earch', icon = '', mode = { 'n', 'v' } },
    { '<leader>t', group = '[T]oggle', icon = '' },
    { '<leader>d', group = '[D]iagnostics', icon = '' },
    { '<leader>dx', '<cmd>Trouble diagnostics_preview toggle<cr>', desc = 'Diagnostics', icon = '' },
    { '<leader>dc', '<cmd>Trouble cascade toggle<cr>', desc = 'Cascade', icon = '' },
    { '<leader>dX', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>', desc = 'Buffer Diagnostics', icon = '' },
    { '<leader>ds', '<cmd>Trouble symbols toggle focus=false win.size=0.3<cr>', desc = 'Symbols', icon = '' },
    { '<leader>dl', '<cmd>Trouble lsp toggle focus=false win.position=right win.size=0.3<cr>', desc = 'LSP refs', icon = '' },
    { '<leader>dL', '<cmd>Trouble loclist toggle<cr>', desc = 'Location List', icon = '' },
    { '<leader>dQ', '<cmd>Trouble qflist toggle<cr>', desc = 'Quickfix List', icon = '' },
    { '<leader>a', group = '[A]I', icon = '󰚩' },
    { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
    { 'gr', group = 'LSP Actions', icon = '', mode = { 'n' } },
    {
      '<leader>u',
      function()
        require('undotree').open {
          command = math.floor(vim.api.nvim_win_get_width(0) / 3) .. 'vnew',
        }
      end,
      desc = '[U]ndotree',
      icon = '',
    },
  },
}

vim.pack.add { { src = gh 'catppuccin/nvim', name = 'catppuccin' } }
require('catppuccin').setup {
  flavour = 'mocha',
  transparent_background = false,
  float = {
    solid = false,
    transparent = false,
  },
  dim_inactive = {
    enabled = true,
    shade = 'dark',
    percentage = 0.01,
  },
}
vim.cmd.colorscheme 'catppuccin'

vim.pack.add { gh 'folke/todo-comments.nvim' }
require('todo-comments').setup { signs = false }

vim.pack.add { gh 'nvim-mini/mini.nvim' }
require('mini.ai').setup {
  mappings = {
    around_next = 'aa',
    inside_next = 'ii',
  },
  n_lines = 500,
}

require('mini.surround').setup()
local statusline = require 'mini.statusline'
statusline.setup { use_icons = vim.g.have_nerd_font }
---@diagnostic disable-next-line: duplicate-set-field
statusline.section_location = function()
  return '%2l:%-2v'
end

require('mini.misc').setup()
MiniMisc.setup_auto_root { '.git', '.venv/', 'Makefile' }

vim.pack.add { gh 'lewis6991/gitsigns.nvim' }
require('gitsigns').setup {
  signs = {
    add = { text = '+' },
    change = { text = '~' },
    delete = { text = '_' },
    topdelete = { text = '‾' },
    changedelete = { text = '~' },
  },
  on_attach = function(bufnr)
    local gitsigns = require 'gitsigns'
    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map('n', ']c', function()
      if vim.wo.diff then
        vim.cmd.normal { ']c', bang = true }
      else
        gitsigns.nav_hunk 'next'
      end
    end, { desc = 'Jump to next git [c]hange' })

    map('n', '[c', function()
      if vim.wo.diff then
        vim.cmd.normal { '[c', bang = true }
      else
        gitsigns.nav_hunk 'prev'
      end
    end, { desc = 'Jump to previous git [c]hange' })

    map('v', '<leader>hs', function()
      gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
    end, { desc = 'git [s]tage hunk' })
    map('v', '<leader>hr', function()
      gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
    end, { desc = 'git [r]eset hunk' })
    -- normal mode
    map('n', '<leader>hs', gitsigns.stage_hunk, { desc = 'git [s]tage hunk' })
    map('n', '<leader>hr', gitsigns.reset_hunk, { desc = 'git [r]eset hunk' })
    map('n', '<leader>hS', gitsigns.stage_buffer, { desc = 'git [S]tage buffer' })
    map('n', '<leader>hR', gitsigns.reset_buffer, { desc = 'git [R]eset buffer' })
    map('n', '<leader>hp', gitsigns.preview_hunk, { desc = 'git [p]review hunk' })
    map('n', '<leader>hi', gitsigns.preview_hunk_inline, { desc = 'git preview hunk [i]nline' })
    map('n', '<leader>hb', function()
      gitsigns.blame_line { full = true }
    end, { desc = 'git [b]lame line' })
    map('n', '<leader>hd', gitsigns.diffthis, { desc = 'git [d]iff against index' })
    map('n', '<leader>hD', function()
      gitsigns.diffthis '@'
    end, { desc = 'git [D]iff against last commit' })
    map('n', '<leader>hQ', function()
      gitsigns.setqflist 'all'
    end, { desc = 'git hunk [Q]uickfix list (all files in repo)' })
    map('n', '<leader>hq', gitsigns.setqflist, { desc = 'git hunk [q]uickfix list (all changes in this file)' })
    -- Toggles
    map('n', '<leader>tb', gitsigns.toggle_current_line_blame, { desc = '[T]oggle git show [b]lame line' })
    map('n', '<leader>tw', gitsigns.toggle_word_diff, { desc = '[T]oggle git intra-line [w]ord diff' })

    -- Text object
    map({ 'o', 'x' }, 'ih', gitsigns.select_hunk)
  end,
}
