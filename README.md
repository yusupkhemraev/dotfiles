# dotfiles

My personal macOS dotfiles.

## Contents

| Directory | Config |
|-----------|--------|
| `zsh/` | `.zshrc`, `.zprofile`, `.zshenv` |
| `starship/` | `starship.toml` |
| `wezterm/` | `wezterm.lua`, `config.lua`, `events.lua` |
| `ghostty/` | `config`, `themes/` |
| `tmux/` | `tmux.conf` |
| `vscodium/` | `settings.json` |
| `Brewfile` | Homebrew packages, casks, VSCodium extensions |

## Install

```sh
git clone https://github.com/yusupkhemraev/dotfiles.git ~/dev/dotfiles
cd ~/dev/dotfiles
./install.sh
```

The script creates symlinks from `~` to the repo, backing up any existing files to `~/.dotfiles_backup/`.

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
