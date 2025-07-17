return {
  "Exafunction/codeium.vim",
  event = "BufEnter",
  config = function()
    -- Codeium keymaps (sin conflictos con Avante)
    vim.keymap.set("i", "<C-y>", function()
      return vim.fn["codeium#Accept"]()
    end, { expr = true, desc = "Codeium: Accept suggestion" })

    vim.keymap.set("i", "<C-;>", function()
      return vim.fn["codeium#CycleCompletions"](1)
    end, { expr = true, desc = "Codeium: Next suggestion" })

    vim.keymap.set("i", "<C-,>", function()
      return vim.fn["codeium#CycleCompletions"](-1)
    end, { expr = true, desc = "Codeium: Previous suggestion" })

    vim.keymap.set("i", "<C-x>", function()
      return vim.fn["codeium#Clear"]()
    end, { expr = true, desc = "Codeium: Clear suggestions" })
  end,
}
