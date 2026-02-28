local M = {}

M.config = {
  set_background = "dark",
  style = "medium",
  transparent = false,
}

local valid_styles = {
  soft = true,
  medium = true,
  hard = true,
}

M.setup = function(opts)
  local merged_opts = vim.tbl_deep_extend("force", {}, opts or {})

  if merged_opts.style and not valid_styles[merged_opts.style] then
    vim.notify_once(
      "claude: invalid style '" .. tostring(merged_opts.style) .. "'. Falling back to 'medium'",
      vim.log.levels.WARN
    )
    merged_opts.style = "medium"
  end

  M.config = vim.tbl_deep_extend("force", M.config, merged_opts)
end

local function load_colors_file()
  local files = vim.api.nvim_get_runtime_file("colors/claude.lua", false)
  local theme_file = files and files[1]

  if not theme_file then
    vim.notify_once("claude: colors/claude.lua was not found in runtimepath", vim.log.levels.ERROR)
    return false
  end

  local ok, err = pcall(dofile, theme_file)
  if not ok then
    vim.notify_once("claude: failed to load colors/claude.lua: " .. tostring(err), vim.log.levels.ERROR)
    return false
  end
  return true
end

M.load = function()
  local ver = vim.version()
  if ver.major == 0 and ver.minor < 8 then
    vim.notify_once("claude: Neovim 0.8 or higher is required", vim.log.levels.WARN)
    return
  end

  local set_background = M.config.set_background
  if set_background then
    vim.o.background = set_background
  end

  vim.g.claude_theme_config = {
    set_background = set_background,
    style = M.config.style,
    transparent = M.config.transparent == true,
  }

  if vim.g.colors_name then
    vim.cmd("hi clear")
  end

  vim.g.colors_name = "claude"
  vim.o.termguicolors = true

  load_colors_file()

  if set_background then
    vim.o.background = set_background
  end
end

local function create_or_replace_user_command(name, callback, opts)
  pcall(vim.api.nvim_del_user_command, name)
  vim.api.nvim_create_user_command(name, callback, opts)
end

M.register_commands = function()
  local function check_active()
    if vim.g.colors_name ~= "claude" then
      vim.notify("claude: colorscheme is not active", vim.log.levels.WARN)
      return false
    end
    return true
  end

  create_or_replace_user_command("ClaudeStyle", function(opts)
    if not check_active() then return end
    local style = opts.args
    if not valid_styles[style] then
      vim.notify("claude: invalid style '" .. style .. "'. Use: soft | medium | hard", vim.log.levels.WARN)
      return
    end
    M.config.style = style
    M.load()
  end, {
    nargs = 1,
    complete = function()
      return { "soft", "medium", "hard" }
    end,
  })

  create_or_replace_user_command("ClaudeTransparent", function(opts)
    if not check_active() then return end
    local val = opts.args
    if val == "on" then
      M.config.transparent = true
    elseif val == "off" then
      M.config.transparent = false
    else
      vim.notify("claude: use 'on' or 'off'", vim.log.levels.WARN)
      return
    end
    M.load()
  end, {
    nargs = 1,
    complete = function()
      return { "on", "off" }
    end,
  })
end

return M
