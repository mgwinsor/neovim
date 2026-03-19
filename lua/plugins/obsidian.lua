vim.opt_local.conceallevel = 2

---@param str string
---@return string
local function title_case(str)
  return (str:gsub("(%a)([%w_']*)", function(first, rest)
    return first:upper() .. rest:lower()
  end))
end

---@param title string|?
---@return string
local function note_id(title)
  local suffix = ''
  if title ~= nil then
    suffix = title:gsub(' ', '-'):gsub('[^A-Za-z0-9-]', ''):lower()
  else
    for _ = 1, 4 do
      suffix = suffix .. string.char(math.random(65, 90))
    end
  end
  return tostring(os.time()) .. '_' .. suffix
end

---@param note obsidian.Note
---@return table
local function note_frontmatter(note)
  local is_daily = note.path and tostring(note.path):match '/captains_log/'

  local raw_tags = note.tags or {}
  local tags
  if is_daily then
    tags = #raw_tags > 0 and raw_tags or { 'journal' }
  else
    tags = #raw_tags > 0 and raw_tags or { 'inbox' }
  end

  local out = {
    id = note.id,
    aliases = { note.title:lower() } or note.aliases,
    tags = tags,
    date = note.metadata and note.metadata.date or os.date '%Y-%m-%d',
  }

  if not is_daily then
    out.draft = note.metadata and note.metadata.draft ~= nil and note.metadata.draft or true
    out.status = (note.metadata and note.metadata.status) or 'seedling'
  end

  if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
    for k, v in pairs(note.metadata) do
      if out[k] == nil then
        out[k] = v
      end
    end
  end

  out.title = note.title and title_case(note.title) or note.title

  return out
end

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
    link = {
      style = 'markdown',
    },

    cache = {
      enable = true,
    },

    note_id_func = note_id,

    frontmatter = {
      enabled = true,
      func = note_frontmatter,
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
