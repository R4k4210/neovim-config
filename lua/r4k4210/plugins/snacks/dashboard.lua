return {
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
    header = [[
 _  .-')             .-. .-')                                      
( \( -O )            \  ( OO )                                     
 ,------.     .---.  ,--. ,--.    .---.   .-----.  .---.  .----.   
 |   /`. '   / .  |  |  .'   /   / .  |  / ,-.   \/_   | /  ..  \  
 |  /  | |  / /|  |  |      /,  / /|  |  '-'  |  | |   |.  /  \  . 
 |  |_.' | / / |  |_ |     ' _)/ / |  |_    .'  /  |   ||  |  '  | 
 |  .  '.'/  '-'    ||  .   \ /  '-'    | .'  /__  |   |'  \  /  ' 
 |  |\  \ `----|  |-'|  |\   \`----|  |-'|       | |   | \  `'  /  
 `--' '--'     `--'  `--' '--'     `--'  `-------' `---'  `---''   
]],
  },
  sections = {
    {
      section = "terminal",
      cmd = "~/.config/nvim/scripts/center-pokemon.sh; sleep 0.2",
      random = 10,
      pane = 1,
      indent = 10,
      height = 20,
    },
    { section = "header" },
    { section = "keys", gap = 1, padding = 1 },
    { section = "startup" },
  },
}
