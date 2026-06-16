-- darc_uuid.lua — show DARC control codes in place of UUIDs (and back)
--
-- The DARC repo maps stable control codes (e.g. "GV-1.02") to UUID v4 strings
-- in catalog/control-uuids.json. UUIDs show up as {{<uuid>}} refs inside
-- source/controls/**/*.md (often inside single-quoted YAML values) and as bare
-- "<uuid>" values inside catalog/**/*.json.
--
-- Native :syntax conceal only swaps a match for a SINGLE char (cchar), so it
-- can't render a full code. We conceal the UUID range and put the code in its
-- place as inline virtual text. Two render paths, because two worlds:
--
--   * markdown  -> we DON'T render ourselves. render-markdown.nvim already owns
--     conceallevel/concealcursor and an anti_conceal pass on this buffer; two
--     systems toggling conceal on the cursor line race ("KM-1.07{{uuid}}"
--     flicker). Instead we plug into its pipeline as a custom_handler
--     (see plugins/render-markdown.lua) via M.rm_parse — then ONE system clears,
--     re-renders, and reveals-under-cursor for everyone, no race.
--
--   * json (and any non-render-markdown filetype) -> no competitor, so we draw
--     plain extmarks ourselves and refresh on autocommands.
--
-- NOTE: a decoration provider's *ephemeral* extmarks silently drop inline
-- virt_text (only conceal survives -> the text just vanishes), so both paths use
-- plain, non-ephemeral extmarks.

local M = {}

local ns = vim.api.nvim_create_namespace("darc_uuid")

-- 8-4-4-4-12 hex. %x is a hex digit; %- is a literal hyphen.
local UUID = "%x%x%x%x%x%x%x%x%-%x%x%x%x%-%x%x%x%x%-%x%x%x%x%-%x%x%x%x%x%x%x%x%x%x%x%x"

-- Filetypes render-markdown.nvim handles; we defer to it there.
local RM_FT = { markdown = true, Avante = true }

M.enabled = true
M.mode = "code" -- "code": render the code, reveal the UUID under the cursor
--                 "uuid": keep the UUID, show the code only under the cursor
M.reveal_on_cursor = true

M._mapfile_cache = {} -- mapfile -> { mtime, uuid2code }
M._buf = {} -- bufnr -> uuid2code | false

-- Walk up from a file path looking for <root>/catalog/control-uuids.json.
local function find_map_file(file)
  for dir in vim.fs.parents(file) do
    local f = dir .. "/catalog/control-uuids.json"
    if vim.uv.fs_stat(f) then
      return f
    end
  end
end

-- Parse the registry and invert it to uuid -> code. Cached by mtime.
local function load_map(file)
  local st = vim.uv.fs_stat(file)
  if not st then
    return nil
  end
  local cached = M._mapfile_cache[file]
  if cached and cached.mtime == st.mtime.sec then
    return cached.uuid2code
  end
  local ok, data = pcall(function()
    return vim.json.decode(table.concat(vim.fn.readfile(file), "\n"))
  end)
  if not ok or type(data) ~= "table" or type(data.mappings) ~= "table" then
    return nil
  end
  local uuid2code = {}
  for code, uuid in pairs(data.mappings) do
    uuid2code[uuid] = code
  end
  M._mapfile_cache[file] = { mtime = st.mtime.sec, uuid2code = uuid2code }
  return uuid2code
end

local function get_map_for_buf(bufnr)
  local cached = M._buf[bufnr]
  if cached ~= nil then
    return cached or nil
  end
  local res = false
  local name = vim.api.nvim_buf_get_name(bufnr)
  if name ~= "" then
    local file = find_map_file(name)
    if file then
      res = load_map(file) or false
    end
  end
  M._buf[bufnr] = res
  return res or nil
end

-- Find every UUID on one line and hand each to `emit(code, conceal_s, conceal_e)`
-- where the conceal range is 1-based inclusive and swallows any {{ }} wrapper.
local function scan_line(line, map, emit)
  local init = 1
  while true do
    local s, e = string.find(line, UUID, init)
    if not s then
      return
    end
    local code = map[string.sub(line, s, e)]
    if code then
      local cs, ce = s, e
      if s > 2 and line:sub(s - 2, s - 1) == "{{" and line:sub(e + 1, e + 2) == "}}" then
        cs, ce = s - 2, e + 2
      end
      emit(code, cs, ce, s, e)
    end
    init = e + 1
  end
end

--------------------------------------------------------------------------------
-- markdown: render-markdown.nvim custom handler
--------------------------------------------------------------------------------

-- Returns render.md.Mark[] for render-markdown to draw. `conceal = true` tells
-- it to hide the mark when the cursor enters that row (its anti_conceal pass),
-- which is our reveal-on-cursor — done by the same system that owns conceal, so
-- no flicker.
function M.rm_parse(ctx)
  local marks = {}
  local map = M.enabled and get_map_for_buf(ctx.buf)
  if not map then
    return marks
  end
  local srow, _, erow = ctx.root:range()
  local lines = vim.api.nvim_buf_get_lines(ctx.buf, srow, erow + 1, false)
  for i, line in ipairs(lines) do
    local row = srow + i - 1
    scan_line(line, map, function(code, cs, ce, us, ue)
      if M.mode == "uuid" then
        marks[#marks + 1] = {
          conceal = false,
          start_row = row,
          start_col = ue, -- after the uuid
          opts = {
            virt_text = { { " ⟶ " .. code, "DarcUuidCode" } },
            virt_text_pos = "inline",
          },
        }
      else
        marks[#marks + 1] = {
          conceal = M.reveal_on_cursor, -- hide (reveal raw UUID) under cursor
          start_row = row,
          start_col = cs - 1,
          opts = {
            end_row = row,
            end_col = ce,
            conceal = "",
            virt_text = { { code, "DarcUuidCode" } },
            virt_text_pos = "inline",
          },
        }
        local _ = us
      end
    end)
  end
  return marks
end

--------------------------------------------------------------------------------
-- json / everything else: our own extmarks + autocommand refresh
--------------------------------------------------------------------------------

local function render_line(bufnr, row, line, map)
  scan_line(line, map, function(code, cs, ce, us, ue)
    if M.mode == "uuid" then
      vim.api.nvim_buf_set_extmark(bufnr, ns, row, ue, {
        virt_text = { { " ⟶ " .. code, "DarcUuidCode" } },
        virt_text_pos = "inline",
        priority = 200,
      })
    else
      vim.api.nvim_buf_set_extmark(bufnr, ns, row, cs - 1, {
        end_row = row,
        end_col = ce,
        conceal = "",
        virt_text = { { code, "DarcUuidCode" } },
        virt_text_pos = "inline",
        priority = 200,
      })
      local _ = us
    end
  end)
end

local function render_win(winid)
  if not vim.api.nvim_win_is_valid(winid) then
    return
  end
  local bufnr = vim.api.nvim_win_get_buf(winid)
  if RM_FT[vim.bo[bufnr].filetype] then
    return -- render-markdown owns this buffer
  end
  vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)
  local map = M.enabled and get_map_for_buf(bufnr)
  if not map then
    return
  end
  local top = vim.fn.line("w0", winid) - 1
  local bot = vim.fn.line("w$", winid)
  local cursor = M.reveal_on_cursor and (vim.api.nvim_win_get_cursor(winid)[1] - 1) or -1
  local lines = vim.api.nvim_buf_get_lines(bufnr, top, math.max(top, bot), false)
  for i, line in ipairs(lines) do
    local row = top + i - 1
    local skip
    if M.mode == "code" then
      skip = (row == cursor)
    else
      skip = (row ~= cursor)
    end
    if not skip then
      render_line(bufnr, row, line, map)
    end
  end
end

local function refresh_current()
  local win = vim.api.nvim_get_current_win()
  local buf = vim.api.nvim_win_get_buf(win)
  if RM_FT[vim.bo[buf].filetype] then
    pcall(function()
      require("render-markdown.api").render({ buf = buf })
    end)
  else
    render_win(win)
  end
end

--------------------------------------------------------------------------------

function M.setup(opts)
  opts = opts or {}
  if opts.mode then
    M.mode = opts.mode
  end
  if opts.reveal_on_cursor ~= nil then
    M.reveal_on_cursor = opts.reveal_on_cursor
  end

  -- A distinct "reference" colour + italic + a faint chip background, so a
  -- rendered code can't be mistaken for one typed literally (neither italic nor
  -- a background can be expressed in plain text), nor for a same-coloured accent
  -- like a true/false. Colours are borrowed from theme groups so they track the
  -- colorscheme; override freely with e.g.
  --   :hi DarcUuidCode guifg=#e0af68 guibg=#2a2a37 gui=italic
  local function attr(groups, key)
    for _, g in ipairs(groups) do
      local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = g, link = false })
      if ok and hl and hl[key] then
        return hl[key]
      end
    end
  end
  -- mix `over` (0xRRGGBB) into `base` by `a` (0..1); used to tint a chip bg.
  local function blend(base, over, a)
    local function ch(c, n)
      return math.floor(c / n) % 256
    end
    local function mix(c)
      return math.floor(ch(base, c) * (1 - a) + ch(over, c) * a + 0.5)
    end
    return mix(65536) * 65536 + mix(256) * 256 + mix(1)
  end
  local function set_hl()
    local fg = attr({ "@markup.link.label", "@markup.link", "Special", "Identifier" }, "fg")
    local nbg = attr({ "Normal" }, "bg") or (vim.o.background == "light" and 0xffffff or 0x000000)
    -- A chip clearly tinted with the accent (not the near-invisible CursorLine),
    -- but still dark enough to keep the fg readable.
    local bg = fg and blend(nbg, fg, 0.3) or attr({ "ColorColumn", "Visual" }, "bg")
    vim.api.nvim_set_hl(0, "DarcUuidCode", { fg = fg, bg = bg, italic = true })
  end
  set_hl()

  local grp = vim.api.nvim_create_augroup("DarcUuid", { clear = true })
  -- Re-derive the colour when the colorscheme changes.
  vim.api.nvim_create_autocmd("ColorScheme", { group = grp, callback = set_hl })

  vim.api.nvim_create_autocmd({ "BufWinEnter", "FileType" }, {
    group = grp,
    callback = function(ev)
      if not get_map_for_buf(ev.buf) then
        return
      end
      if RM_FT[vim.bo[ev.buf].filetype] then
        -- render-markdown owns conceal/rendering here. We only soft-wrap so the
        -- long single-quoted YAML values never scroll horizontally — Neovim's
        -- conceal + inline virt_text break under a non-zero 'leftcol'. These are
        -- window-local display options ONLY; the file on disk is untouched.
        vim.wo.wrap = true
        vim.wo.linebreak = true
      else
        -- json & friends: no competitor, draw our own marks.
        if vim.wo.conceallevel < 2 then
          vim.wo.conceallevel = 2
        end
        -- Always conceal even on the cursor line; we reveal by removing the
        -- mark in render_win, so a stale frame shows the code, never both.
        vim.wo.concealcursor = "nvic"
        render_win(vim.api.nvim_get_current_win())
      end
    end,
  })

  vim.api.nvim_create_autocmd(
    { "CursorMoved", "CursorMovedI", "TextChanged", "TextChangedI", "InsertLeave", "WinScrolled", "WinEnter" },
    {
      group = grp,
      callback = function()
        local win = vim.api.nvim_get_current_win()
        if not RM_FT[vim.bo[vim.api.nvim_win_get_buf(win)].filetype] then
          render_win(win)
        end
      end,
    }
  )

  vim.api.nvim_create_autocmd("BufDelete", {
    group = grp,
    callback = function(ev)
      M._buf[ev.buf] = nil
    end,
  })

  vim.api.nvim_create_user_command("DarcUuidToggle", function()
    M.enabled = not M.enabled
    refresh_current()
    vim.notify("DARC uuid render: " .. (M.enabled and "on" or "off"))
  end, {})

  vim.api.nvim_create_user_command("DarcUuidMode", function()
    M.mode = (M.mode == "code") and "uuid" or "code"
    refresh_current()
    vim.notify("DARC uuid mode: " .. M.mode)
  end, { desc = "Swap between showing the code or the UUID" })

  vim.api.nvim_create_user_command("DarcUuidReload", function()
    M._mapfile_cache = {}
    M._buf = {}
    refresh_current()
    vim.notify("DARC uuid map reloaded")
  end, {})
end

return M
