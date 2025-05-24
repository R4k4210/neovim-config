return {
  "folke/snacks.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
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
        { icon = " ", title = "Keymaps", section = "keys", indent = 2, padding = 1 },
        { icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
        { icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
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
    session = {
      enabled = true,
      autosave = true,
      autorestore = true,
    },
    image = {
      enabled = true,
      doc = {
        float = true, -- show image on cursor hover
        inline = false, -- show image inline
        max_width = 50,
        max_height = 30,
        wo = {
          wrap = false,
        },
      },
      convert = {
        notify = true,
        command = "magick",
      },
      img_dirs = {
        "img",
        "images",
        "assets",
        "static",
        "public",
        "media",
        "attachments",
        "Archives/All-Vault-Images/",
        "~/Library",
        "~/Downloads",
      },
    },
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
