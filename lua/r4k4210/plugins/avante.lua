return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  lazy = false,
  version = false, -- set this to "*" if you want to always pull the latest change, false to update on release
  build = "make", -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
  dependencies = {
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    --- The below dependencies are optional,
    "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
    "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
    "zbirenbaum/copilot.lua", -- for providers='copilot'
    {
      -- support for image pasting
      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy",
      opts = {
        -- recommended settings
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          -- required for Windows users
          use_absolute_path = true,
        },
      },
    },
    {
      -- Make sure to set this up properly if you have lazy=true
      "MeanderingProgrammer/render-markdown.nvim",
      opts = {
        file_types = { "markdown", "Avante" },
      },
      ft = { "markdown", "Avante" },
    },
  },
  config = function()
    -- Basic setup with default options
    require("avante").setup({
      -- add any options here
    })

    -- Create autocmd for toggling custom prompt
    vim.api.nvim_create_autocmd("User", {
      pattern = "ToggleMyPrompt",
      callback = function()
        -- Load the system prompt from an external file
        local prompt_file = vim.fn.stdpath("config") .. "/lua/r4k4210/llm/system_prompt.lua"
        local ok, system_prompt = pcall(dofile, prompt_file)

        if ok and system_prompt then
          require("avante.config").override({ system_prompt = system_prompt })
          vim.notify("Custom system prompt loaded", vim.log.levels.INFO)
        else
          vim.notify("Failed to load system prompt from file", vim.log.levels.ERROR)
        end
      end,
    })

    -- Set up keymap for toggling the prompt
    vim.keymap.set("n", "<leader>am", function()
      vim.api.nvim_exec_autocmds("User", { pattern = "ToggleMyPrompt" })
    end, { desc = "avante: toggle my prompt" })
  end,
}
