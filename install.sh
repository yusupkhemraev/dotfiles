#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles_backup/$(date +%Y%m%d_%H%M%S)"

info()    { echo "[INFO]  $*"; }
success() { echo "[OK]    $*"; }
warning() { echo "[WARN]  $*"; }

backup_and_link() {
    local src="$1"
    local dst="$2"

    if [[ -e "$dst" || -L "$dst" ]]; then
        if [[ -L "$dst" && "$(readlink "$dst")" == "$src" ]]; then
            success "Already linked: $dst"
            return
        fi
        mkdir -p "$BACKUP_DIR/$(dirname "${dst#$HOME/}")"
        mv "$dst" "$BACKUP_DIR/${dst#$HOME/}"
        warning "Backed up: $dst → $BACKUP_DIR/${dst#$HOME/}"
    fi

    mkdir -p "$(dirname "$dst")"
    ln -s "$src" "$dst"
    success "Linked: $dst → $src"
}

info "Dotfiles dir: $DOTFILES_DIR"

# zsh
backup_and_link "$DOTFILES_DIR/zsh/.zshrc"   "$HOME/.zshrc"
backup_and_link "$DOTFILES_DIR/zsh/.zprofile" "$HOME/.zprofile"
backup_and_link "$DOTFILES_DIR/zsh/.zshenv"   "$HOME/.zshenv"

# nushell (XDG_CONFIG_HOME points here via .zshenv)
backup_and_link "$DOTFILES_DIR/nushell/config.nu" "$HOME/.config/nushell/config.nu"
backup_and_link "$DOTFILES_DIR/nushell/env.nu"    "$HOME/.config/nushell/env.nu"

# starship
backup_and_link "$DOTFILES_DIR/starship/starship.toml" "$HOME/.config/starship.toml"

# wezterm
backup_and_link "$DOTFILES_DIR/wezterm/wezterm.lua" "$HOME/.config/wezterm/wezterm.lua"
backup_and_link "$DOTFILES_DIR/wezterm/config.lua"  "$HOME/.config/wezterm/config.lua"
backup_and_link "$DOTFILES_DIR/wezterm/events.lua"  "$HOME/.config/wezterm/events.lua"
backup_and_link "$DOTFILES_DIR/wezterm/makima.png"  "$HOME/.config/wezterm/makima.png"

# ghostty
backup_and_link "$DOTFILES_DIR/ghostty/config"  "$HOME/.config/ghostty/config"
backup_and_link "$DOTFILES_DIR/ghostty/themes"   "$HOME/.config/ghostty/themes"

# tmux
backup_and_link "$DOTFILES_DIR/tmux/tmux.conf" "$HOME/.config/tmux/tmux.conf"

# vscodium
backup_and_link "$DOTFILES_DIR/vscodium/settings.json" "$HOME/Library/Application Support/VSCodium/User/settings.json"

info "Done."
