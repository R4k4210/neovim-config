return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false, -- Required: treesitter does NOT support lazy loading
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter").setup({
      install_dir = vim.fn.stdpath("data") .. "/site",
    })

    -- Install required parsers
    local parsers = {
      "markdown",
      "markdown_inline",
      "lua",
      "vim",
      "vimdoc",
      "javascript",
      "typescript",
      "tsx",
      "html",
      "css",
      "json",
      "yaml",
      "bash",
      "python",
    }

    -- Schedule parser installation after startup
    vim.schedule(function()
      require("nvim-treesitter").install(parsers)
    end)
  end,
}
