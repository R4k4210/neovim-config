local function get_project_root()
  return vim.fn.getcwd()
end

local function check_if_files_exists(root_files)
  local root = get_project_root()

  for _, file in ipairs(root_files) do
    if vim.fn.filereadable(root .. "/" .. file) == 1 then
      return true
    end
  end
  return false
end

local function eslint_config_exists()
  local eslint_files = {
    ".eslintrc",
    ".eslintrc.json",
    ".eslintrc.js",
    ".eslintrc.yml",
    ".eslintrc.yaml",
    ".eslintrc.cjs",
    "eslint.config.js",
    "eslint.config.ts",
    "eslint.config.mjs",
    "eslint.config.cjs",
  }

  return check_if_files_exists(eslint_files)
end

local function biome_config_exists()
  local biome_files = { "biome.json" }
  return check_if_files_exists(biome_files)
end

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  pattern = { "*.js", "*.ts", "*.tsx", "*.jsx" },
  callback = function()
    if eslint_config_exists() then
      vim.cmd("EslintFixAll")
    end
  end,
})

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  pattern = { "*.js", "*.ts", "*.tsx", "*.jsx" },
  callback = function()
    if biome_config_exists() then
      vim.cmd("!biome check % --write")
    end
  end,
})
