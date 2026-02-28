local c = {
  bg        = "#1C1917",
  bg_dark   = "#151311",
  bg_popup  = "#292524",
  fg        = "#D6D3D1",
  fg_dim    = "#A8A29E",
  fg_dark   = "#78716C",
  orange    = "#D97757",
  green     = "#A3BE8C",
  yellow    = "#EBCB8B",
  red       = "#BF616A",
  blue      = "#81A1C1",
  purple    = "#B48EAD",
}

return {
  normal = {
    a = { fg = c.bg, bg = c.orange, gui = "bold" },
    b = { fg = c.fg, bg = c.bg_popup },
    c = { fg = c.fg_dim, bg = c.bg_dark },
  },
  insert = {
    a = { fg = c.bg, bg = c.green, gui = "bold" },
    b = { fg = c.fg, bg = c.bg_popup },
    c = { fg = c.fg_dim, bg = c.bg_dark },
  },
  visual = {
    a = { fg = c.bg, bg = c.purple, gui = "bold" },
    b = { fg = c.fg, bg = c.bg_popup },
    c = { fg = c.fg_dim, bg = c.bg_dark },
  },
  command = {
    a = { fg = c.bg, bg = c.yellow, gui = "bold" },
    b = { fg = c.fg, bg = c.bg_popup },
    c = { fg = c.fg_dim, bg = c.bg_dark },
  },
  replace = {
    a = { fg = c.bg, bg = c.red, gui = "bold" },
    b = { fg = c.fg, bg = c.bg_popup },
    c = { fg = c.fg_dim, bg = c.bg_dark },
  },
  inactive = {
    a = { fg = c.fg_dark, bg = c.bg_dark },
    b = { fg = c.fg_dark, bg = c.bg_dark },
    c = { fg = c.fg_dark, bg = c.bg_dark },
  },
}
