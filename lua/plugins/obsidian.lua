local gh = require('core.pack').gh

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
    aliases = note.title and { note.title:lower() } or note.aliases,
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

  if note.title then
    out.title = title_case(note.title)
  end

  return out
end

vim.pack.add {
  {
    src = gh 'obsidian-nvim/obsidian.nvim',
    version = vim.version.range '*',
  },
}

require('obsidian').setup {
  legacy_commands = false,
  workspaces = {
    {
      name = 'binarybrain',
      path = '~/notes/binarybrain',
    },
  },
  notes_subdir = 'notes',
  new_notes_location = 'notes_subdir',
  link = {
    style = 'markdown',
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
    substitutions = {
      week_num = function()
        return tostring(os.date '%V')
      end,
      weather = function()
        local handle = io.popen "curl -s 'wttr.in/?format=%c+%t' 2>/dev/null"
        local result = '⛅ Unknown'
        if handle then
          local content = handle:read '*a'
          handle:close()
          if content ~= '' and not content:find 'Error' then
            result = content:gsub('%s+$', '')
          end
        end
        return result
      end,
    },
  },
}

vim.keymap.set('n', '<leader>os', '<cmd>Obsidian quick_switch<cr>', { desc = 'Obsidian [N]otes [S]earch' })
vim.keymap.set('n', '<leader>on', '<cmd>Obsidian new<cr>', { desc = 'Obsidian [N]ew [N]ote' })
vim.keymap.set('n', '<leader>ot', '<cmd>Obsidian template<cr>', { desc = 'Obsidian [N]ote [T]emplate' })
vim.keymap.set('n', '<leader>oa', '<cmd>Obsidian tags<cr>', { desc = 'Obsidian [N]ote T[A]gs' })
vim.keymap.set('n', '<leader>od', '<cmd>Obsidian dailies<cr>', { desc = 'Obsidian [N]ote [D]aily' })
