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

done_exists() {
  printf "${DIM}already set${RESET}\n"
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
PLUGINS_DIR="$HOME/.config/nvim/lua/plugins"
SPEC_FILE="$PLUGINS_DIR/claude-theme.lua"
COLORSCHEME_FILE="$PLUGINS_DIR/colorscheme.lua"

USING_LAZY=0
USING_LAZYVIM=0

if [ -d "$LAZY_DIR" ] || [ -f "$LAZY_LOCK" ]; then
  USING_LAZY=1
  # Detect LazyVim (has LazyVim in lazy dir or referenced in colorscheme.lua)
  if [ -d "$LAZY_DIR/LazyVim" ] || grep -q "LazyVim" "$COLORSCHEME_FILE" 2>/dev/null; then
    USING_LAZYVIM=1
    printf "${BLUE}LazyVim${RESET}\n"
  else
    printf "${BLUE}lazy.nvim${RESET}\n"
  fi
else
  printf "${DIM}none (native pack)${RESET}\n"
fi

# ── Configure ─────────────────────────────────────────────────────────────────

if [ "$USING_LAZY" = "1" ]; then

  # Step 1: Create plugin spec file
  step "Creating plugin spec"

  if [ -f "$SPEC_FILE" ]; then
    if grep -q "claude" "$SPEC_FILE" 2>/dev/null; then
      done_exists
    else
      # File exists but not for claude — don't overwrite
      done_skip
      warn "claude-theme.lua exists but has different content — skipping"
    fi
  else
    mkdir -p "$PLUGINS_DIR"
    cat > "$SPEC_FILE" << 'SPEC'
return {
  "rapidrabbit76/claude.inspired.theme.nvim",
  lazy = false,
  priority = 1000,
  config = function(_, opts)
    require("claude").setup(opts)
    require("claude").load()
    require("claude").register_commands()
  end,
  opts = {
    set_background = "dark",
    style = "medium", -- "soft" | "medium" | "hard"
    transparent = false,
  },
}
SPEC
    done_ok
    info "created $SPEC_FILE"
  fi

  # Step 2: Set LazyVim colorscheme (if LazyVim detected)
  if [ "$USING_LAZYVIM" = "1" ]; then
    step "Setting LazyVim colorscheme"

    if [ -f "$COLORSCHEME_FILE" ]; then
      if grep -q 'colorscheme.*=.*"claude"' "$COLORSCHEME_FILE" 2>/dev/null; then
        done_exists
      else
        # Replace existing colorscheme value with "claude"
        sed -i.bak 's/colorscheme *= *"[^"]*"/colorscheme = "claude"/' "$COLORSCHEME_FILE"
        rm -f "${COLORSCHEME_FILE}.bak"
        done_ok
        info "updated $COLORSCHEME_FILE"
      fi
    else
      # No colorscheme.lua — create one
      mkdir -p "$PLUGINS_DIR"
      cat > "$COLORSCHEME_FILE" << 'CSPEC'
return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "claude",
    },
  },
}
CSPEC
      done_ok
      info "created $COLORSCHEME_FILE"
    fi
  fi

else
  # ── Native pack (no lazy.nvim) ────────────────────────────────────────────

  ALREADY_CONFIGURED=0
  if [ -f "$INIT_LUA" ]; then
    if grep -qE "colorscheme.*claude|claude\.load|claude\.setup" "$INIT_LUA" 2>/dev/null; then
      ALREADY_CONFIGURED=1
    fi
  fi

  step "Configuring init.lua"

  if [ "$ALREADY_CONFIGURED" = "1" ]; then
    done_exists
  elif [ -f "$INIT_LUA" ]; then
    printf '\n-- claude colorscheme\nvim.cmd.colorscheme("claude")\n' >> "$INIT_LUA"
    done_ok
  else
    done_skip
    info "Add to ~/.config/nvim/init.lua:"
    code_block 'vim.cmd.colorscheme("claude")'
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
