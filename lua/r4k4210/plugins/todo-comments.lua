return {
  "folke/todo-comments.nvim",
  event = { "BufReadPre", "BufNewFile" },
  optional = true,
  keys = {
    {
      "<leader>pt",
      function()
        require("snacks").picker.todo_comments()
      end,
      desc = "Todo",
    },
    {
      "<leader>pT",
      function()
        require("snacks").picker.todo_comments({ keywords = { "TODO", "FIX", "FIXME" } })
      end,
      desc = "Todo/Fix/Fixme",
    },
  },
}
