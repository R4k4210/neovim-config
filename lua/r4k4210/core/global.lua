local g = vim.g -- for conciseness

g.skip_ts_context_commentstring_module = true
-- disable default codeium keybidings
g.codeium_diable_bindings = 1
g.codeium_no_map_tab = 1

-- Clipboard for WSL2 (a little slow when paste)
g.clipboard = {
  name = "WslClipboard",
  copy = {
    ["+"] = "clip.exe",
    ["*"] = "clip.exe",
  },
  paste = {
    ["+"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
    ["*"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
  },
  cache_enabled = 0,
}
