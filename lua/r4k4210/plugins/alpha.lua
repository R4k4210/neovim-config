return {
  "goolord/alpha-nvim",
  event = "VimEnter",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local alpha = require("alpha")
    local dashboard = require("alpha.themes.dashboard")

    -- Set header
    dashboard.section.header.val = {
      -- "                                                     ",
      -- "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
      -- "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
      -- "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
      -- "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
      -- "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
      -- "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
      -- "                                                     ",
      -- [[                                                                     ]],
      -- [[       ███████████           █████      ██                     ]],
      -- [[      ███████████             █████                             ]],
      -- [[      ████████████████ ███████████ ███   ███████     ]],
      -- [[     ████████████████ ████████████ █████ ██████████████   ]],
      -- [[    █████████████████████████████ █████ █████ ████ █████   ]],
      -- [[  ██████████████████████████████████ █████ █████ ████ █████  ]],
      -- [[ ██████  ███ █████████████████ ████ █████ █████ ████ ██████ ]],
      -- [[ ██████   ██  ███████████████   ██ █████████████████ ]],
      -- [[ ██████   ██  ███████████████   ██ █████████████████ ]],

      -- [[88888888ba         ,d8    88               ,d8    ad888888b,      88     ,a8888a,     ]],
      -- [[88      "8b      ,d888    88             ,d888   d8"     "88    ,d88   ,8P"'  `"Y8,   ]],
      -- [[88      ,8P    ,d8" 88    88           ,d8" 88           a8P  888888  ,8P        Y8,  ]],
      -- [[88aaaaaa8P'  ,d8"   88    88   ,d8   ,d8"   88        ,d8P"       88  88          88  ]],
      -- [[88""""88'  ,d8"     88    88 ,a8"  ,d8"     88      a8P"          88  88          88  ]],
      -- [[88    `8b  8888888888888  8888[    8888888888888  a8P'            88  `8b        d8'  ]],
      -- [[88     `8b          88    88`"Yba,          88   d8"              88   `8ba,  ,ad8'   ]],
      -- [[88      `8b         88    88   `Y8a         88   88888888888      88     "Y8888P"     ]],

      -- [[ooooooooo.         .o   oooo              .o     .oooo.     .o    .oooo.   ]],
      -- [[`888   `Y88.     .d88   `888            .d88   .dP""Y88b  o888   d8P'`Y8b  ]],
      -- [[ 888   .d88'   .d'888    888  oooo    .d'888         ]8P'  888  888    888 ]],
      -- [[ 888ooo88P'  .d'  888    888 .8P'   .d'  888       .d8P'   888  888    888 ]],
      -- [[ 888`88b.    88ooo888oo  888888.    88ooo888oo   .dP'      888  888    888 ]],
      -- [[ 888  `88b.       888    888 `88b.       888   .oP     .o  888  `88b  d88' ]],
      -- [[o888o  o888o     o888o  o888o o888o     o888o  8888888888 o888o  `Y8bd8P'  ]],

      [[         _            _                   _              _              _       _                _          ]],
      [[        /\ \      _  /\ \                /\_\        _  /\ \          /\ \     / /\            / /\         ]],
      [[       /  \ \    /\_\\ \ \              / / /  _    /\_\\ \ \        /  \ \   / /  \          / /  \        ]],
      [[      / /\ \ \  / / / \ \ \            / / /  /\_\ / / / \ \ \      / /\ \ \ /_/ /\ \        / / /\ \       ]],
      [[     / / /\ \_\/ / /   \ \ \          / / /__/ / // / /   \ \ \     \/_/\ \ \\_\/\ \ \      / / /\ \ \      ]],
      [[    / / /_/ / /\ \ \____\ \ \        / /\_____/ / \ \ \____\ \ \        / / /     \ \ \    /_/ /  \ \ \     ]],
      [[   / / /__\/ /  \ \________\ \      / /\_______/   \ \________\ \      / / /       \ \ \   \ \ \   \ \ \    ]],
      [[  / / /_____/    \/________/\ \    / / /\ \ \       \/________/\ \    / / /  _      \ \ \   \ \ \   \ \ \   ]],
      [[ / / /\ \ \                \ \ \  / / /  \ \ \                \ \ \  / / /_/\_\    __\ \ \___\ \ \___\ \ \  ]],
      [[/ / /  \ \ \                \ \_\/ / /    \ \ \                \ \_\/ /_____/ /   /___\_\/__/\\ \/____\ \ \ ]],
      [[\/_/    \_\/                 \/_/\/_/      \_\_\                \/_/\________/    \_________\/ \_________\/ ]],
    }

    -- Set menu
    dashboard.section.buttons.val = {
      dashboard.button("LDR ff", "󰱼 > Find File", "<cmd>Telescope find_files<CR>"),
      dashboard.button("LDR fs", " > Find Word", "<cmd>Telescope live_grep<CR>"),
      dashboard.button("LDR wr", "󰁯 > Restore Session For Current Directory", "<cmd>SessionRestore<CR>"),
      dashboard.button("e", " > New File", "<cmd>ene<CR>"),
      dashboard.button("q", " > Quit NVIM", "<cmd>qa<CR>"),
    }

    dashboard.config.layout[1].val = vim.fn.max({ 2, vim.fn.floor(vim.fn.winheight(0) * 0.2) })
    dashboard.config.layout[3].val = 5
    dashboard.config.opts.noautocmd = true
    -- Send config to alpha
    alpha.setup(dashboard.opts)

    -- Disable folding on alpha buffer
    vim.cmd([[autocmd FileType alpha setlocal nofoldenable]])
  end,
}
