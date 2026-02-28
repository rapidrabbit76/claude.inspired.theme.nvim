#!/bin/sh
set -e

# ── Colors & helpers ──────────────────────────────────────────────────────────

BOLD='\033[1m'
DIM='\033[2m'
ORANGE='\033[38;5;208m'
GREEN='\033[38;5;114m'
YELLOW='\033[38;5;222m'
BLUE='\033[38;5;110m'
RED='\033[38;5;167m'
CREAM='\033[38;5;223m'
RESET='\033[0m'

step() {
  printf "${ORANGE}  ▸${RESET} %s " "$1"
}

done_ok() {
  printf "${GREEN}✓${RESET}\n"
}

done_skip() {
  printf "${DIM}skipped${RESET}\n"
}

warn() {
  printf "${YELLOW}  ⚠ %s${RESET}\n" "$1"
}

info() {
  printf "${DIM}  │ %s${RESET}\n" "$1"
}

code_block() {
  printf "${CREAM}  │ %s${RESET}\n" "$1"
}

# ── Banner ────────────────────────────────────────────────────────────────────

printf "\n"
printf "${ORANGE}   _____ _                 _       ${RESET}\n"
printf "${ORANGE}  / ____| |               | |      ${RESET}\n"
printf "${ORANGE} | |    | | __ _ _   _  __| | ___  ${RESET}\n"
printf "${ORANGE} | |    | |/ _\` | | | |/ _\` |/ _ \\ ${RESET}\n"
printf "${ORANGE} | |____| | (_| | |_| | (_| |  __/ ${RESET}\n"
printf "${ORANGE}  \\_____|_|\\__,_|\\__,_|\\__,_|\\___| ${RESET}\n"
printf "${DIM}  Anthropic-inspired theme for Neovim${RESET}\n"
printf "\n"

# ── Install / Update ──────────────────────────────────────────────────────────

DEST="$HOME/.local/share/nvim/site/pack/themes/start/claude.inspired.theme.nvim"
PARENT_DIR="${DEST%/*}"

mkdir -p "$PARENT_DIR"

if [ -d "$DEST" ]; then
  step "Updating plugin"
  git -C "$DEST" pull --ff-only --quiet 2>/dev/null
  done_ok
else
  step "Cloning plugin"
  git clone --quiet https://github.com/rapidrabbit76/claude.inspired.theme.nvim.git "$DEST" 2>/dev/null
  done_ok
fi

info "installed to $DEST"

# ── Detect environment ────────────────────────────────────────────────────────

step "Detecting plugin manager"

INIT_LUA="$HOME/.config/nvim/init.lua"
LAZY_DIR="$HOME/.local/share/nvim/lazy"
LAZY_LOCK="$HOME/.config/nvim/lazy-lock.json"

USING_LAZY=0
if [ -d "$LAZY_DIR" ] || [ -f "$LAZY_LOCK" ]; then
  USING_LAZY=1
  printf "${BLUE}lazy.nvim${RESET}\n"
else
  printf "${DIM}none (native pack)${RESET}\n"
fi

# ── Configure ─────────────────────────────────────────────────────────────────

if [ "$USING_LAZY" = "1" ]; then
  step "Configuring for lazy.nvim"
  done_skip
  printf "\n"
  warn "Do NOT use vim.cmd.colorscheme() — lazy.nvim will override it."
  printf "\n"
  printf "${DIM}  │ Create ${RESET}${BOLD}~/.config/nvim/lua/plugins/claude-theme.lua${RESET}${DIM}:${RESET}\n"
  printf "\n"
  code_block 'return {'
  code_block '  "rapidrabbit76/claude.inspired.theme.nvim",'
  code_block '  lazy = false,'
  code_block '  priority = 1000,'
  code_block '  config = function(_, opts)'
  code_block '    require("claude").setup(opts)'
  code_block '    require("claude").load()'
  code_block '    require("claude").register_commands()'
  code_block '  end,'
  code_block '  opts = { style = "medium" },'
  code_block '}'
  printf "\n"
  info "For LazyVim, also add:"
  code_block '{ "LazyVim/LazyVim", opts = { colorscheme = "claude" } }'
  printf "\n"
else
  ALREADY_CONFIGURED=0
  if [ -f "$INIT_LUA" ]; then
    if grep -qE "colorscheme.*claude|claude\.load|claude\.setup" "$INIT_LUA" 2>/dev/null; then
      ALREADY_CONFIGURED=1
    fi
  fi

  if [ "$ALREADY_CONFIGURED" = "1" ]; then
    step "Configuring init.lua"
    printf "${DIM}already set${RESET}\n"
  elif [ -f "$INIT_LUA" ]; then
    step "Configuring init.lua"
    printf '\n-- claude colorscheme\nvim.cmd.colorscheme("claude")\n' >> "$INIT_LUA"
    done_ok
  else
    step "Configuring init.lua"
    done_skip
    info "Add to ~/.config/nvim/init.lua:"
    code_block 'vim.cmd.colorscheme("claude")'
    printf "\n"
  fi
fi

# ── Summary ───────────────────────────────────────────────────────────────────

printf "\n"
printf "${ORANGE}  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}\n"
printf "${GREEN}${BOLD}  Installation complete!${RESET}\n"
printf "${ORANGE}  ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}\n"
printf "\n"
printf "  ${BOLD}Try it now${RESET}        ${DIM}:colorscheme claude${RESET}\n"
printf "  ${BOLD}Style variants${RESET}    ${DIM}:ClaudeStyle soft | medium | hard${RESET}\n"
printf "  ${BOLD}Transparency${RESET}      ${DIM}:ClaudeTransparent on | off${RESET}\n"
printf "\n"
printf "  ${DIM}Commands require register_commands() — see README${RESET}\n"
printf "\n"
