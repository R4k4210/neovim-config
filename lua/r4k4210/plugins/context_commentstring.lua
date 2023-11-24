return {
  "JoosepAlviste/nvim-ts-context-commentstring",
  config = function()
    local tscmm = require("ts_context_commentstring")

    tscmm.setup({
      enable_autocmd = false,
    })
  end,
}
