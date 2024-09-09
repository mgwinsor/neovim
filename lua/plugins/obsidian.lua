return {
  'epwalsh/obsidian.nvim',
  version = '*', -- recommended, use latest release instead of latest commit
  lazy = true,
  keys = {
    { '<leader>ns', '<cmd>ObsidianQuickSwitch<cr>', desc = 'Obsidian [N]otes [S]earch' },
    { '<leader>nw', '<cmd>ObsidianWorkspace<cr>', desc = 'Obsidian [N]otes [W]orkspace switch ' },
    { '<leader>nn', '<cmd>ObsidianNew<cr>', desc = 'Obsidian [N]ew [N]ote' },
    { '<leader>nt', '<cmd>ObsidianTemplate<cr>', desc = 'Obsidian [N]ote [T]emplate' },
  },

  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
    'nvim-treesitter/nvim-treesitter',
  },

  opts = {
    workspaces = {
      {
        name = 'brain.db',
        path = '~/notes/brain_db',
      },
      {
        name = 'work',
        path = '~/notes/work',
      },
    },

    notes_subdir = '_inbox',
    new_notes_location = 'notes_subdir',
    preferred_link_style = 'markdown',
    disable_frontmatter = false,

    daily_notes = {
      folder = 'journal',
      date_format = '%Y-%m-%d',
      default_tags = { 'journal' },
      template = nil,
    },

    completion = {
      nvim_cmp = true,
      min_chars = 2,
    },

    mappings = {
      -- Overrides the 'gf' mapping to work on markdown/wiki links within your vault.
      ['gf'] = {
        action = function()
          return require('obsidian').util.gf_passthrough()
        end,
        opts = { noremap = false, expr = true, buffer = true },
      },
      -- Toggle check-boxes.
      ['<localleader>ch'] = {
        action = function()
          return require('obsidian').util.toggle_checkbox()
        end,
        opts = { buffer = true },
      },
      -- TODO: disable this smart action
      ['<cr>'] = {
        action = function()
          return require('obsidian').util.smart_action()
        end,
        opts = { buffer = true, expr = true },
      },
    },

    -- Generate IDs for new notes
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

    picker = {
      -- Set your preferred picker. Can be one of 'telescope.nvim', 'fzf-lua', or 'mini.pick'.
      name = 'telescope.nvim',
      -- Optional, configure key mappings for the picker. These are the defaults.
      -- Not all pickers support all mappings.
      note_mappings = {
        -- Create a new note from your query.
        new = '<C-x>',
        -- Insert a link to the selected note.
        insert_link = '<C-l>',
      },
    },

    attachments = {
      img_folder = '_assets/imgs',
    },

    templates = {
      folder = '_templates',
      date_format = '%Y-%m-%d-%a',
      time_format = '%H:%M',
    },
  },
}
