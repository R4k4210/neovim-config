-- Local "plugin": render DARC control codes in place of UUIDs.
-- Lives entirely in lua/r4k4210/darc_uuid.lua; this spec just lazy-loads it
-- on markdown/json (the only filetypes that carry DARC UUIDs).
return {
  dir = vim.fn.stdpath("config"),
  name = "darc-uuid",
  lazy = true,
  ft = { "markdown", "json" },
  config = function()
    require("r4k4210.darc_uuid").setup({
      mode = "code", -- "code" = show GV-1.02, reveal UUID on the cursor line
      reveal_on_cursor = true, -- set false to keep the code even under the cursor
    })
  end,
}
