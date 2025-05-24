return {
  "stevearc/vim-arduino",
  lazy = false,
  config = function()
    local api = vim.api
    api.nvim_command("au BufRead,BufNewFile *.ino nnoremap <buffer> <leader>aa <cmd>call arduino#Attach()<CR>")
    api.nvim_command("au BufRead,BufNewFile *.ino nnoremap <buffer> <leader>am <cmd>call arduino#Verify()<CR>")
    api.nvim_command("au BufRead,BufNewFile *.ino nnoremap <buffer> <leader>au <cmd>call arduino#Upload()<CR>")
    api.nvim_command("au BufRead,BufNewFile *.ino nnoremap <buffer> <leader>as <cmd>call arduino#Serial()<CR>")
    api.nvim_command("au BufRead,BufNewFile *.ino nnoremap <buffer> <leader>ad <cmd>call arduino#UploadAndSerial()<CR>")
    api.nvim_command("au BufRead,BufNewFile *.ino nnoremap <buffer> <leader>ab <cmd>call arduino#ChooseBoard()<CR>")
    api.nvim_command("au BufRead,BufNewFile *.ino nnoremap <buffer> <leader>ac <cmd>call arduino#ChoosePort()<CR>")
    api.nvim_command("au BufRead,BufNewFile *.ino nnoremap <buffer> <leader>ai <cmd>call arduino#Info()<CR>")
    api.nvim_command(
      "au BufRead,BufNewFile *.ino nnoremap <buffer> <leader>ap <cmd>call arduino#ChooseProgrammer()<CR>"
    )
  end,
}
