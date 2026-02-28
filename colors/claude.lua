vim.cmd("hi clear")
if vim.fn.exists("syntax_on") then
  vim.cmd("syntax reset")
end
vim.g.colors_name = "claude"
vim.o.termguicolors = true
local config = vim.g.claude_theme_config or {}
local style = config.style or "medium"

local palettes = {
  soft = {
    bg        = "#262321",
    bg_dark   = "#1E1A18",
    bg_float  = "#2D2A28",
    bg_popup  = "#393533",
    bg_visual = "#53453F",
    bg_search = "#73543D",
    bg_cursorline = "#2F2A27",

    fg        = "#E7E4E2",
    fg_dim    = "#B7B0A9",
    fg_dark   = "#918A84",
    fg_gutter = "#645D58",

    orange    = "#E28B6D",
    orange_light = "#EEA98A",
    beige     = "#DCB28A",
    cream     = "#F8EDE1",
    tan       = "#CBB097",

    green     = "#B1CFA2",
    green_dim = "#98B88B",
    yellow    = "#F0D29D",
    red       = "#D48A8A",
    red_light = "#DE9F8E",
    blue      = "#8BC0DC",
    blue_dim  = "#7395B8",
    purple    = "#C39CC8",
    cyan      = "#98D2DE",
  },
  medium = {
    bg        = "#1C1917",
    bg_dark   = "#151311",
    bg_float  = "#211F1D",
    bg_popup  = "#292524",
    bg_visual = "#3D3532",
    bg_search = "#5C3D2E",
    bg_cursorline = "#252220",

    fg        = "#D6D3D1",
    fg_dim    = "#A8A29E",
    fg_dark   = "#78716C",
    fg_gutter = "#57534E",

    orange    = "#D97757",
    orange_light = "#E8956F",
    beige     = "#D4A574",
    cream     = "#F5E6D3",
    tan       = "#C4A584",

    green     = "#A3BE8C",
    green_dim = "#8FAF78",
    yellow    = "#EBCB8B",
    red       = "#BF616A",
    red_light = "#D08770",
    blue      = "#81A1C1",
    blue_dim  = "#6B8DAD",
    purple    = "#B48EAD",
    cyan      = "#88C0D0",
  },
  hard = {
    bg        = "#171412",
    bg_dark   = "#100E0D",
    bg_float  = "#1D1B1A",
    bg_popup  = "#24211F",
    bg_visual = "#3A2F2B",
    bg_search = "#503324",
    bg_cursorline = "#221E1C",

    fg        = "#C8C6C3",
    fg_dim    = "#9C9793",
    fg_dark   = "#746E69",
    fg_gutter = "#544E49",

    orange    = "#C76A4F",
    orange_light = "#DE8565",
    beige     = "#C99A68",
    cream     = "#EDDCC9",
    tan       = "#B69170",

    green     = "#99B37E",
    green_dim = "#839E6D",
    yellow    = "#D9B57A",
    red       = "#B44F5F",
    red_light = "#C66E56",
    blue      = "#7399B7",
    blue_dim  = "#607F9D",
    purple    = "#A67EA0",
    cyan      = "#7AA9BB",
  },
}

local c = vim.tbl_deep_extend("force", palettes.medium, palettes[style] or palettes.medium)

if config.transparent then
  c = vim.tbl_deep_extend("force", c, {
    bg = "NONE",
    bg_dark = "NONE",
    bg_float = "NONE",
    bg_popup = "NONE",
    bg_visual = "NONE",
    bg_search = "NONE",
    bg_cursorline = "NONE",
  })
end

local function transparentize(opts)
  if not config.transparent or not opts or not opts.bg then
    return opts
  end
  return vim.tbl_extend("force", opts, { bg = "NONE" })
end

local function hi(group, opts)
  vim.api.nvim_set_hl(0, group, transparentize(opts))
end

-- Editor
hi("Normal",           { fg = c.fg, bg = c.bg })
hi("NormalFloat",      { fg = c.fg, bg = c.bg_float })
hi("FloatBorder",      { fg = c.fg_dark, bg = c.bg_float })
hi("Cursor",           { fg = c.bg, bg = c.orange })
hi("CursorLine",       { bg = c.bg_cursorline })
hi("CursorLineNr",     { fg = c.orange, bold = true })
hi("LineNr",           { fg = c.fg_gutter })
hi("SignColumn",       { fg = c.fg_gutter, bg = c.bg })
hi("ColorColumn",      { bg = c.bg_cursorline })
hi("Visual",           { bg = c.bg_visual })
hi("VisualNOS",        { bg = c.bg_visual })
hi("Search",           { fg = c.cream, bg = c.bg_search })
hi("IncSearch",        { fg = c.bg, bg = c.orange })
hi("CurSearch",        { fg = c.bg, bg = c.orange, bold = true })
hi("Substitute",       { fg = c.bg, bg = c.red })
hi("MatchParen",       { fg = c.orange, bold = true, underline = true })
hi("Pmenu",            { fg = c.fg, bg = c.bg_popup })
hi("PmenuSel",         { fg = c.bg, bg = c.orange })
hi("PmenuSbar",        { bg = c.bg_popup })
hi("PmenuThumb",       { bg = c.fg_dark })
hi("WildMenu",         { fg = c.bg, bg = c.orange })
hi("Folded",           { fg = c.fg_dim, bg = c.bg_cursorline })
hi("FoldColumn",       { fg = c.fg_gutter, bg = c.bg })
hi("VertSplit",        { fg = c.bg_popup })
hi("WinSeparator",     { fg = c.bg_popup })
hi("StatusLine",       { fg = c.fg, bg = c.bg_popup })
hi("StatusLineNC",     { fg = c.fg_dark, bg = c.bg_dark })
hi("TabLine",          { fg = c.fg_dim, bg = c.bg_popup })
hi("TabLineSel",       { fg = c.bg, bg = c.orange, bold = true })
hi("TabLineFill",      { bg = c.bg_dark })
hi("WinBar",           { fg = c.fg_dim, bg = c.bg })
hi("WinBarNC",         { fg = c.fg_dark, bg = c.bg })
hi("Title",            { fg = c.orange, bold = true })
hi("NonText",          { fg = c.fg_gutter })
hi("SpecialKey",       { fg = c.fg_gutter })
hi("Whitespace",       { fg = c.fg_gutter })
hi("EndOfBuffer",      { fg = c.bg })
hi("Directory",        { fg = c.orange })
hi("Conceal",          { fg = c.fg_dark })
hi("SpellBad",         { undercurl = true, sp = c.red })
hi("SpellCap",         { undercurl = true, sp = c.yellow })
hi("SpellLocal",       { undercurl = true, sp = c.blue })
hi("SpellRare",        { undercurl = true, sp = c.purple })
hi("ErrorMsg",         { fg = c.red })
hi("WarningMsg",       { fg = c.yellow })
hi("ModeMsg",          { fg = c.fg, bold = true })
hi("MoreMsg",          { fg = c.orange })
hi("Question",         { fg = c.orange })
hi("QuickFixLine",     { bg = c.bg_visual })
hi("DiffAdd",          { bg = "#2A3625" })
hi("DiffChange",       { bg = "#2A2A1E" })
hi("DiffDelete",       { fg = c.red, bg = "#2D2024" })
hi("DiffText",         { bg = "#3A3520" })

-- Syntax
hi("Comment",          { fg = c.fg_dark, italic = true })
hi("Constant",         { fg = c.beige })
hi("String",           { fg = c.green })
hi("Character",        { fg = c.green })
hi("Number",           { fg = c.red_light })
hi("Boolean",          { fg = c.orange })
hi("Float",            { fg = c.red_light })
hi("Identifier",       { fg = c.fg })
hi("Function",         { fg = c.beige })
hi("Statement",        { fg = c.orange })
hi("Conditional",      { fg = c.orange })
hi("Repeat",           { fg = c.orange })
hi("Label",            { fg = c.orange })
hi("Operator",         { fg = c.fg_dim })
hi("Keyword",          { fg = c.orange })
hi("Exception",        { fg = c.orange })
hi("PreProc",          { fg = c.orange })
hi("Include",          { fg = c.orange })
hi("Define",           { fg = c.orange })
hi("Macro",            { fg = c.beige })
hi("PreCondit",        { fg = c.orange })
hi("Type",             { fg = c.blue })
hi("StorageClass",     { fg = c.orange })
hi("Structure",        { fg = c.blue })
hi("Typedef",          { fg = c.blue })
hi("Special",          { fg = c.tan })
hi("SpecialChar",      { fg = c.tan })
hi("Tag",              { fg = c.orange })
hi("Delimiter",        { fg = c.fg_dim })
hi("SpecialComment",   { fg = c.fg_dark, italic = true })
hi("Debug",            { fg = c.red })
hi("Underlined",       { underline = true })
hi("Error",            { fg = c.red })
hi("Todo",             { fg = c.bg, bg = c.yellow, bold = true })

-- Treesitter
hi("@variable",               { fg = c.fg })
hi("@variable.builtin",       { fg = c.red_light, italic = true })
hi("@variable.parameter",     { fg = c.tan })
hi("@variable.member",        { fg = c.fg })
hi("@constant",               { fg = c.beige })
hi("@constant.builtin",       { fg = c.red_light })
hi("@constant.macro",         { fg = c.beige })
hi("@module",                 { fg = c.beige })
hi("@label",                  { fg = c.orange })
hi("@string",                 { fg = c.green })
hi("@string.escape",          { fg = c.green_dim })
hi("@string.regex",           { fg = c.yellow })
hi("@string.special",         { fg = c.tan })
hi("@character",              { fg = c.green })
hi("@number",                 { fg = c.red_light })
hi("@boolean",                { fg = c.orange })
hi("@float",                  { fg = c.red_light })
hi("@function",               { fg = c.beige })
hi("@function.builtin",       { fg = c.beige, italic = true })
hi("@function.call",          { fg = c.beige })
hi("@function.macro",         { fg = c.beige })
hi("@function.method",        { fg = c.beige })
hi("@function.method.call",   { fg = c.beige })
hi("@constructor",            { fg = c.blue })
hi("@keyword",                { fg = c.orange })
hi("@keyword.function",       { fg = c.orange })
hi("@keyword.operator",       { fg = c.orange })
hi("@keyword.return",         { fg = c.orange })
hi("@keyword.import",         { fg = c.orange })
hi("@keyword.conditional",    { fg = c.orange })
hi("@keyword.repeat",         { fg = c.orange })
hi("@keyword.exception",      { fg = c.orange })
hi("@operator",               { fg = c.fg_dim })
hi("@punctuation.bracket",    { fg = c.fg_dim })
hi("@punctuation.delimiter",  { fg = c.fg_dim })
hi("@punctuation.special",    { fg = c.tan })
hi("@type",                   { fg = c.blue })
hi("@type.builtin",           { fg = c.blue, italic = true })
hi("@type.qualifier",         { fg = c.orange })
hi("@tag",                    { fg = c.orange })
hi("@tag.attribute",          { fg = c.beige })
hi("@tag.delimiter",          { fg = c.fg_dim })
hi("@attribute",              { fg = c.beige })
hi("@property",               { fg = c.fg })
hi("@comment",                { fg = c.fg_dark, italic = true })
hi("@markup.heading",         { fg = c.orange, bold = true })
hi("@markup.strong",          { bold = true })
hi("@markup.italic",          { italic = true })
hi("@markup.strikethrough",   { strikethrough = true })
hi("@markup.underline",       { underline = true })
hi("@markup.link",            { fg = c.blue, underline = true })
hi("@markup.link.url",        { fg = c.blue_dim, underline = true })
hi("@markup.raw",             { fg = c.green })
hi("@markup.list",            { fg = c.orange })

-- LSP Semantic Tokens
hi("@lsp.type.class",         { fg = c.blue })
hi("@lsp.type.decorator",     { fg = c.beige })
hi("@lsp.type.enum",          { fg = c.blue })
hi("@lsp.type.enumMember",    { fg = c.beige })
hi("@lsp.type.function",      { fg = c.beige })
hi("@lsp.type.interface",     { fg = c.blue })
hi("@lsp.type.macro",         { fg = c.beige })
hi("@lsp.type.method",        { fg = c.beige })
hi("@lsp.type.namespace",     { fg = c.beige })
hi("@lsp.type.parameter",     { fg = c.tan })
hi("@lsp.type.property",      { fg = c.fg })
hi("@lsp.type.struct",        { fg = c.blue })
hi("@lsp.type.type",          { fg = c.blue })
hi("@lsp.type.variable",      { fg = c.fg })
hi("@lsp.mod.deprecated",     { strikethrough = true })

-- Diagnostics
hi("DiagnosticError",          { fg = c.red })
hi("DiagnosticWarn",           { fg = c.yellow })
hi("DiagnosticInfo",           { fg = c.blue })
hi("DiagnosticHint",           { fg = c.cyan })
hi("DiagnosticUnderlineError", { undercurl = true, sp = c.red })
hi("DiagnosticUnderlineWarn",  { undercurl = true, sp = c.yellow })
hi("DiagnosticUnderlineInfo",  { undercurl = true, sp = c.blue })
hi("DiagnosticUnderlineHint",  { undercurl = true, sp = c.cyan })
hi("DiagnosticVirtualTextError", { fg = c.red, bg = "#2D2024" })
hi("DiagnosticVirtualTextWarn",  { fg = c.yellow, bg = "#2D2A1E" })
hi("DiagnosticVirtualTextInfo",  { fg = c.blue, bg = "#1E2530" })
hi("DiagnosticVirtualTextHint",  { fg = c.cyan, bg = "#1E2A2D" })

-- Git signs
hi("GitSignsAdd",             { fg = c.green })
hi("GitSignsChange",          { fg = c.yellow })
hi("GitSignsDelete",          { fg = c.red })
hi("GitGutterAdd",            { fg = c.green })
hi("GitGutterChange",         { fg = c.yellow })
hi("GitGutterDelete",         { fg = c.red })

-- Telescope
hi("TelescopeNormal",         { fg = c.fg, bg = c.bg_float })
hi("TelescopeBorder",         { fg = c.fg_dark, bg = c.bg_float })
hi("TelescopePromptNormal",   { fg = c.fg, bg = c.bg_popup })
hi("TelescopePromptBorder",   { fg = c.bg_popup, bg = c.bg_popup })
hi("TelescopePromptTitle",    { fg = c.bg, bg = c.orange, bold = true })
hi("TelescopePreviewTitle",   { fg = c.bg, bg = c.green, bold = true })
hi("TelescopeResultsTitle",   { fg = c.bg, bg = c.blue, bold = true })
hi("TelescopeSelection",      { bg = c.bg_visual })
hi("TelescopeMatching",       { fg = c.orange, bold = true })

-- NeoTree
hi("NeoTreeNormal",           { fg = c.fg, bg = c.bg_dark })
hi("NeoTreeNormalNC",         { fg = c.fg, bg = c.bg_dark })
hi("NeoTreeDirectoryIcon",    { fg = c.orange })
hi("NeoTreeDirectoryName",    { fg = c.orange })
hi("NeoTreeRootName",         { fg = c.orange, bold = true })
hi("NeoTreeFileName",         { fg = c.fg })
hi("NeoTreeGitAdded",         { fg = c.green })
hi("NeoTreeGitModified",      { fg = c.yellow })
hi("NeoTreeGitDeleted",       { fg = c.red })
hi("NeoTreeGitUntracked",     { fg = c.fg_dark })
hi("NeoTreeIndentMarker",     { fg = c.fg_gutter })

-- Which-key
hi("WhichKey",                { fg = c.orange })
hi("WhichKeyGroup",           { fg = c.beige })
hi("WhichKeyDesc",            { fg = c.fg })
hi("WhichKeySeparator",       { fg = c.fg_dark })
hi("WhichKeyFloat",           { bg = c.bg_float })

-- Indent blankline
hi("IblIndent",               { fg = c.bg_popup })
hi("IblScope",                { fg = c.fg_gutter })

-- Notify
hi("NotifyERRORBorder",       { fg = c.red })
hi("NotifyWARNBorder",        { fg = c.yellow })
hi("NotifyINFOBorder",        { fg = c.blue })
hi("NotifyDEBUGBorder",       { fg = c.fg_dark })
hi("NotifyTRACEBorder",       { fg = c.purple })
hi("NotifyERRORIcon",         { fg = c.red })
hi("NotifyWARNIcon",          { fg = c.yellow })
hi("NotifyINFOIcon",          { fg = c.blue })
hi("NotifyDEBUGIcon",         { fg = c.fg_dark })
hi("NotifyTRACEIcon",         { fg = c.purple })
hi("NotifyERRORTitle",        { fg = c.red })
hi("NotifyWARNTitle",         { fg = c.yellow })
hi("NotifyINFOTitle",         { fg = c.blue })
hi("NotifyDEBUGTitle",        { fg = c.fg_dark })
hi("NotifyTRACETitle",        { fg = c.purple })

-- Mini
hi("MiniStatuslineFilename",  { fg = c.fg, bg = c.bg_popup })
hi("MiniStatuslineDevinfo",   { fg = c.fg, bg = c.bg_popup })
hi("MiniStatuslineModeNormal",  { fg = c.bg, bg = c.orange, bold = true })
hi("MiniStatuslineModeInsert",  { fg = c.bg, bg = c.green, bold = true })
hi("MiniStatuslineModeVisual",  { fg = c.bg, bg = c.purple, bold = true })
hi("MiniStatuslineModeCommand", { fg = c.bg, bg = c.yellow, bold = true })
hi("MiniStatuslineModeReplace", { fg = c.bg, bg = c.red, bold = true })

-- Bufferline
hi("BufferLineBackground",    { fg = c.fg_dark, bg = c.bg_dark })
hi("BufferLineFill",           { bg = c.bg_dark })
hi("BufferLineBufferSelected", { fg = c.fg, bg = c.bg, bold = true })
hi("BufferLineIndicatorSelected", { fg = c.orange, bg = c.bg })

-- Dashboard
hi("DashboardHeader",         { fg = c.orange })
hi("DashboardFooter",         { fg = c.fg_dark, italic = true })
hi("DashboardIcon",           { fg = c.orange })
hi("DashboardDesc",           { fg = c.fg_dim })
hi("DashboardKey",            { fg = c.beige })
hi("DashboardShortCut",       { fg = c.beige })

-- Lazy
hi("LazyButton",              { fg = c.fg, bg = c.bg_popup })
hi("LazyButtonActive",        { fg = c.bg, bg = c.orange, bold = true })
hi("LazyH1",                  { fg = c.bg, bg = c.orange, bold = true })

-- Noice / Cmdline
hi("NoiceCmdlinePopup",       { fg = c.fg, bg = c.bg_float })
hi("NoiceCmdlinePopupBorder", { fg = c.orange })
hi("NoiceCmdlineIcon",        { fg = c.orange })

-- Flash
hi("FlashLabel",              { fg = c.bg, bg = c.orange, bold = true })
hi("FlashMatch",              { fg = c.fg, bg = c.bg_search })
hi("FlashCurrent",            { fg = c.fg, bg = c.bg_visual })
