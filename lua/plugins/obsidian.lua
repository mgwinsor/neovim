vim.opt_local.conceallevel = 2

return {
  'obsidian-nvim/obsidian.nvim',
  version = '*', -- recommended, use latest release instead of latest commit
  lazy = true,
  event = { 'BufReadPre ' .. vim.fn.expand '~' .. '/notes/binarybrain/**.md' },
  keys = {
    { '<leader>ns', '<cmd>Obsidian quick_switch<cr>', desc = 'Obsidian [N]otes [S]earch' },
    { '<leader>nf', '<cmd>Obsidian follow_link vsplit<cr>', desc = 'Obsidian [N]otes [F]ollow link' },
    { '<leader>nw', '<cmd>Obsidian workspace<cr>', desc = 'Obsidian [N]otes [W]orkspace switch' },
    { '<leader>nn', '<cmd>Obsidian new<cr>', desc = 'Obsidian [N]ew [N]ote' },
    { '<leader>nt', '<cmd>Obsidian template<cr>', desc = 'Obsidian [N]ote [T]emplate' },
    { '<leader>na', '<cmd>Obsidian tags<cr>', desc = 'Obsidian [N]ote T[A]gs' },
    { '<leader>nd', '<cmd>Obsidian today<cr>', desc = 'Obsidian [N]ote [D]aily' },
    { '<leader>nb', '<cmd>Obsidian backlinks<cr>', desc = 'Obsidian [N]ote [B]acklinks' },
    { '<leader>nl', '<cmd>Obsidian links<cr>', desc = 'Obsidian [N]ote [L]inks' },
    -- Keymaps that need to be set for markdown files
    {
      'gf',
      function()
        if require('obsidian').util.cursor_on_markdown_link() then
          return '<cmd>Obsidian follow_link vsplit<CR>'
        else
          return 'gf'
        end
      end,
      ft = 'markdown',
      expr = true,
      desc = 'Obsidian follow link',
    },
    { '<leader>ch', '<cmd>Obsidian toggle_checkbox<CR>', ft = 'markdown', desc = 'Toggle checkbox' },
  },

  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
    'nvim-treesitter/nvim-treesitter',
  },

  opts = {
    workspaces = {
      {
        name = 'binarybrain',
        path = '~/notes/binarybrain',
      },
    },

    legacy_commands = false,

    notes_subdir = 'notes',
    new_notes_location = 'notes_subdir',
    preferred_link_style = 'markdown',
    frontmatter = {
      enaabled = true,
    },

    daily_notes = {
      folder = 'captains_log',
      date_format = '%Y-%m-%d',
      default_tags = { 'journal' },
      template = 'daily-template.md',
    },

    completion = {
      nvim_cmp = true,
      min_chars = 2,
    },

    -- Generate IDs for new notes with unix timestamp
    ---@param title string|?
    ---@return string
    note_id_func = function(title)
      local suffix = ''
      if title ~= nil then
        suffix = title:gsub(' ', '-'):gsub('[^A-Za-z0-9-]', ''):lower()
      else
        for _ = 1, 4 do
          suffix = suffix .. string.char(math.random(65, 90))
        end
      end
      return tostring(os.time()) .. '_' .. suffix
    end,

    -- Customize frontmatter
    note_frontmatter = {
      ---@return table
      func = function(note)
        local function titleCase(str)
          return str:gsub("(%a)([%w_']*)", function(first, rest)
            return first:upper() .. rest:lower()
          end)
        end

        -- Check if this is a daily note (captains_log instead of dailies)
        local is_daily = note.path and note.path:match '/captains_log/'

        if note.title then
          note.title = titleCase(note.title)
          note.aliases = { note.title }
        end

        -- Different defaults for daily notes
        if is_daily then
          note.draft = false -- dailies aren't drafts
          note.tags = note.tags or { 'journal' }
          note.status = nil -- dailies don't need status
        else
          note.draft = note.draft == nil and true or note.draft
          note.tags = next(note.tags) == nil and { 'inbox' } or note.tags
          note.status = note.status or 'seedling'
        end

        if note.date == nil then
          note.date = os.date '%Y-%m-%d'
        end

        local out = {
          title = note.title,
          id = note.id,
          aliases = note.aliases,
          date = note.date,
        }

        -- Only add these fields for non-daily notes
        if not is_daily then
          out.status = note.status
          out.draft = note.draft
        end

        out.tags = note.tags

        if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
          for k, v in pairs(note.metadata) do
            out[k] = v
          end
        end

        return out
      end,
    },

    picker = {
      name = 'telescope.nvim',
      note_mappings = {
        new = '<C-x>',
        insert_link = '<C-l>',
      },
    },

    attachments = {
      folder = '_assets/imgs',
    },

    templates = {
      folder = '_templates',
      date_format = '%Y-%m-%d-%a',
      time_format = '%H:%M',
    },

    ui = {
      enable = true,
      markdown_folding = true,
    },
  },
}
