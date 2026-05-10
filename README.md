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

## Install

```sh
git clone https://github.com/yusupkhemraev/dotfiles.git ~/dev/dotfiles
cd ~/dev/dotfiles
./install.sh
```

The script creates symlinks from `~` to the repo, backing up any existing files to `~/.dotfiles_backup/`.

## Dependencies

- [Starship](https://starship.rs) — prompt
- [WezTerm](https://wezfurlong.org/wezterm) — terminal
- [Ghostty](https://ghostty.org) — terminal
- [tmux](https://github.com/tmux/tmux) + [tpm](https://github.com/tmux-plugins/tpm) — multiplexer
- [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions) — via Homebrew
- [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting) — via Homebrew
- [VSCodium](https://vscodium.com) — editor
- [carapace](https://carapace.sh) — shell completions
