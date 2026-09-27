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
backup_and_link "$DOTFILES_DIR/ghostty/icons"    "$HOME/.config/ghostty/icons"
backup_and_link "$DOTFILES_DIR/ghostty/shaders"  "$HOME/.config/ghostty/shaders"

# tmux
backup_and_link "$DOTFILES_DIR/tmux/tmux.conf"       "$HOME/.config/tmux/tmux.conf"
backup_and_link "$DOTFILES_DIR/tmux/tmux.reset.conf" "$HOME/.config/tmux/tmux.reset.conf"

# alacritty
backup_and_link "$DOTFILES_DIR/alacritty" "$HOME/.config/alacritty"

# atuin
backup_and_link "$DOTFILES_DIR/atuin/config.toml" "$HOME/.config/atuin/config.toml"

# git
backup_and_link "$DOTFILES_DIR/git/gitconfig" "$HOME/.gitconfig"
backup_and_link "$DOTFILES_DIR/git/ignore"    "$HOME/.config/git/ignore"

# window management: yabai + skhd + borders + sketchybar
backup_and_link "$DOTFILES_DIR/yabai"      "$HOME/.config/yabai"
backup_and_link "$DOTFILES_DIR/skhd"       "$HOME/.config/skhd"
backup_and_link "$DOTFILES_DIR/borders"    "$HOME/.config/borders"
backup_and_link "$DOTFILES_DIR/sketchybar" "$HOME/.config/sketchybar"

# nvim
backup_and_link "$DOTFILES_DIR/nvim" "$HOME/.config/nvim"

# vscodium
backup_and_link "$DOTFILES_DIR/vscodium/settings.json" "$HOME/Library/Application Support/VSCodium/User/settings.json"

# zed
backup_and_link "$DOTFILES_DIR/zed/settings.json" "$HOME/.config/zed/settings.json"
backup_and_link "$DOTFILES_DIR/zed/keymap.json"   "$HOME/.config/zed/keymap.json"
backup_and_link "$DOTFILES_DIR/zed/tasks.json"    "$HOME/.config/zed/tasks.json"

# zen (Espresso Blur theme). Profile dir is machine-specific — auto-detect the
# default profile from profiles.ini instead of hard-coding it.
ZEN_ROOT="$HOME/Library/Application Support/zen"
if [[ -d "$ZEN_ROOT" ]]; then
    zen_profile="$(awk -F= '/^\[Profile/{p=""} /^Default=Profiles/{print $2}' "$ZEN_ROOT/profiles.ini" 2>/dev/null | head -1)"
    if [[ -n "$zen_profile" && -d "$ZEN_ROOT/$zen_profile" ]]; then
        mkdir -p "$ZEN_ROOT/$zen_profile/chrome"
        backup_and_link "$DOTFILES_DIR/zen/userChrome.css" "$ZEN_ROOT/$zen_profile/chrome/userChrome.css"
        backup_and_link "$DOTFILES_DIR/zen/mods"           "$ZEN_ROOT/$zen_profile/chrome/mods"
        backup_and_link "$DOTFILES_DIR/zen/user.js"        "$ZEN_ROOT/$zen_profile/user.js"
    else
        warning "Zen profile not found in profiles.ini — skipping Zen theme"
    fi
fi

# Chrome theme is loaded manually (chrome://extensions -> Load unpacked).
# See chrome-theme/README.md — Chrome cannot symlink an unpacked theme.

info "Done."
