return {
  --- @class AvanteConflictMappings
  diff = {
    ours = "co",
    theirs = "ct",
    all_theirs = "ca",
    both = "cb",
    cursor = "cc",
    next = "]x",
    prev = "[x",
  },
  suggestion = {
    accept = "<M-l>",
    next = "<M-]>",
    prev = "<M-[>",
    dismiss = "<C-]>",
  },
  jump = {
    next = "]]",
    prev = "[[",
  },
  submit = {
    normal = "<CR>",
    insert = "<C-s>",
  },
  sidebar = {
    apply_all = "A",
    apply_cursor = "a",
    switch_windows = "<Tab>",
    reverse_switch_windows = "<S-Tab>",
  },
  confirm = {
    focus_window = "<C-w>f",
    code = "c",
    resp = "r",
    input = "i",
  },
}
