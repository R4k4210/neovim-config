return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  keys = require("r4k4210.core.snacks-keymaps"),
  opts = {
    dashboard = {
      preset = {
        pick = nil,
        ---@type snacks.dashboard.Item[]
        keys = {
          { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
          { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
          { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
          { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
          {
            icon = " ",
            key = "c",
            desc = "Config",
            action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
          },
          { icon = " ", key = "s", desc = "Restore Session", section = "session" },
          { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
          { icon = " ", key = "q", desc = "Quit", action = ":qa" },
        },
        header = [[         _            _                   _              _              _       _                _ 
                /\ \      _  /\ \                /\_\        _  /\ \          /\ \     / /\            / /\         
               /  \ \    /\_\\ \ \              / / /  _    /\_\\ \ \        /  \ \   / /  \          / /  \        
              / /\ \ \  / / / \ \ \            / / /  /\_\ / / / \ \ \      / /\ \ \ /_/ /\ \        / / /\ \       
             / / /\ \_\/ / /   \ \ \          / / /__/ / // / /   \ \ \     \/_/\ \ \\_\/\ \ \      / / /\ \ \      
            / / /_/ / /\ \ \____\ \ \        / /\_____/ / \ \ \____\ \ \        / / /     \ \ \    /_/ /  \ \ \     
           / / /__\/ /  \ \________\ \      / /\_______/   \ \________\ \      / / /       \ \ \   \ \ \   \ \ \    
          / / /_____/    \/________/\ \    / / /\ \ \       \/________/\ \    / / /  _      \ \ \   \ \ \   \ \ \   
         / / /\ \ \                \ \ \  / / /  \ \ \                \ \ \  / / /_/\_\    __\ \ \___\ \ \___\ \ \  
        / / /  \ \ \                \ \_\/ / /    \ \ \                \ \_\/ /_____/ /   /___\_\/__/\\ \/____\ \ \ 
        \/_/    \_\/                 \/_/\/_/      \_\_\                \/_/\________/    \_________\/ \_________\/ ]],
      },
      sections = {
        { section = "header" },
        {
          section = "keys",
          indent = 1,
          padding = 1,
        },
        { section = "recent_files", icon = " ", title = "Recent Files", indent = 3, padding = 2 },
        { section = "startup" },
      },
    },
    bigfile = { enabled = true },
    explorer = { enabled = true },
    indent = { enabled = true },
    input = { enabled = true },
    picker = { enabled = true },
    notifier = { enabled = false },
    quickfile = { enabled = true },
    scope = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },
    rename = { enabled = true },
    zen = {
      enabled = true,
      toggles = {
        ufo = true,
        dim = true,
        git_signs = true,
        diagnostics = true,
        line_number = true,
        relative_number = true,
        signcolumn = "no",
        indent = true,
      },
    },
  },
  init = function()
    vim.api.nvim_create_autocmd("User", {
      pattern = "OilActionsPost",
      callback = function(event)
        if event.data.actions.type == "move" then
          Snacks.rename.on_rename_file(event.data.actions.src_url, event.data.actions.dest_url)
        end
      end,
    })
    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      callback = function()
        -- Setup some globals for debugging (lazy-loaded)
        _G.dd = function(...)
          Snacks.debug.inspect(...)
        end
        _G.bt = function()
          Snacks.debug.backtrace()
        end
        vim.print = _G.dd -- Override print to use snacks for `:=` command

        -- Create some toggle mappings
        Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
        Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
        Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
        Snacks.toggle.diagnostics():map("<leader>ud")
        Snacks.toggle.line_number():map("<leader>ul")
        Snacks.toggle
          .option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 })
          :map("<leader>uc")
        Snacks.toggle.treesitter():map("<leader>uT")
        Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>ub")
        Snacks.toggle.inlay_hints():map("<leader>uh")
        Snacks.toggle.indent():map("<leader>ug")
        Snacks.toggle.dim():map("<leader>uD")
      end,
    })
  end,
}
