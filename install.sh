#!/bin/sh
set -e

DEST="$HOME/.local/share/nvim/site/pack/themes/start/claude.inspired.theme.nvim"
PARENT_DIR="${DEST%/*}"

mkdir -p "$PARENT_DIR"

if [ -d "$DEST" ]; then
  echo "Updating claude.inspired.theme.nvim..."
  git -C "$DEST" pull --ff-only
else
  echo "Installing claude.inspired.theme.nvim..."
  git clone https://github.com/rapidrabbit76/claude.inspired.theme.nvim.git "$DEST"
fi

echo ""
echo "Done! Open Neovim and run:"
echo "  :colorscheme claude"
echo ""
echo "To make it permanent, add to ~/.config/nvim/init.lua:"
echo '  vim.cmd.colorscheme("claude")'
echo ""
echo "If you use lazy.nvim, prefer: setup + load + register_commands"
