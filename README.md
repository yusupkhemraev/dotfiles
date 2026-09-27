# dotfiles

My personal macOS dotfiles.

## Contents

| Directory | Config |
|-----------|--------|
| `zsh/` | `.zshrc`, `.zprofile`, `.zshenv` |
| `nushell/` | `config.nu`, `env.nu` |
| `starship/` | `starship.toml` |
| `wezterm/` | `wezterm.lua`, `config.lua`, `events.lua` |
| `ghostty/` | `config`, `themes/`, `icons/`, `shaders/` |
| `tmux/` | `tmux.conf`, `tmux.reset.conf` |
| `nvim/` | Neovim config (lazy.nvim) |
| `vscodium/` | `settings.json` |
| `zed/` | `settings.json`, `keymap.json`, `tasks.json` |
| `zen/` | Zen browser `userChrome.css`, `user.js`, `mods/` |
| `alacritty/` | `alacritty.toml` |
| `atuin/` | `config.toml` |
| `git/` | `gitconfig` (→ `~/.gitconfig`), global `ignore` |
| `yabai/`, `skhd/`, `borders/`, `sketchybar/` | Tiling WM, hotkeys, window borders, status bar |
| `chrome-theme/`, `chrome-newtab/` | Chrome theme and new-tab extension (load unpacked) |
| `Brewfile` | Homebrew packages, casks, VSCodium extensions |

## Install

```sh
git clone https://github.com/yusupkhemraev/dotfiles.git ~/dev/dotfiles
cd ~/dev/dotfiles
./install.sh
```

The script creates symlinks from `~` to the repo, backing up any existing files to `~/.dotfiles_backup/`.

### Window management

yabai's scripting addition needs SIP partially disabled and a sudoers entry — see the
[yabai wiki](https://github.com/asmvik/yabai/wiki/Installing-yabai-(latest-release)).
Then start the services:

```sh
yabai --start-service
skhd --start-service
brew services start sketchybar
brew services start borders
```

### Zen browser

`install.sh` links the theme into the default Zen profile, so launch Zen once before
running it. For the sidebar bookmarks mod, drag *Bookmarks toolbar items* into the
sidebar via *Customize Toolbar…*.

### Nushell theme

The [Catppuccin Mocha](https://github.com/catppuccin/nushell) theme is downloaded
automatically by `env.nu` into `nushell/themes/` on first launch (git-ignored, not
committed). To update it, delete the file and restart Nushell:

```nu
rm ($nu.default-config-dir | path join "themes" "catppuccin_mocha.nu")
exec nu
```

Switch flavor by changing `$theme_flavor` in `env.nu` and the `source` line in `config.nu`
(`latte` | `frappe` | `macchiato` | `mocha`).

### Homebrew packages

Install everything from `Brewfile`:

```sh
brew bundle
```

### Manual installs

- [PuntoSwitcher](https://yandex.ru/soft/punto/) — keyboard layout switcher
- [PyCharm](https://www.jetbrains.com/pycharm/) — Python IDE
- [GoLand](https://www.jetbrains.com/goland/) — Go IDE
- [RustRover](https://www.jetbrains.com/rust/) — Rust IDE
