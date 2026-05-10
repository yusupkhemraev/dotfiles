export SSL_CERT_FILE=$(python3.11 -m certifi)

export PATH="$HOME/.local/bin:$PATH"

# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

alias yy="yazi"

source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
(( ${+ZSH_HIGHLIGHT_STYLES} )) || typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[path]=none
ZSH_HIGHLIGHT_STYLES[path_prefix]=none

# Shift-selection in ZLE (key sequences match WezTerm config)
__sel_left()  { (( REGION_ACTIVE )) || zle set-mark-command; zle backward-char }
__sel_right() { (( REGION_ACTIVE )) || zle set-mark-command; zle forward-char }
__sel_wleft() { (( REGION_ACTIVE )) || zle set-mark-command; zle backward-word }
__sel_wright(){ (( REGION_ACTIVE )) || zle set-mark-command; zle forward-word }
__sel_home()  { (( REGION_ACTIVE )) || zle set-mark-command; zle beginning-of-line }
__sel_end()   { (( REGION_ACTIVE )) || zle set-mark-command; zle end-of-line }

zle -N __sel_left
zle -N __sel_right
zle -N __sel_wleft
zle -N __sel_wright
zle -N __sel_home
zle -N __sel_end

bindkey '^[[1;2D' __sel_left
bindkey '^[[1;2C' __sel_right
bindkey '^[[1;4D' __sel_wleft
bindkey '^[[1;4C' __sel_wright
bindkey '^[[1;2H' __sel_home
bindkey '^[[1;2F' __sel_end

autoload -U compinit && compinit
export CARAPACE_BRIDGES='zsh,fish,bash,inshellisense' # optional
zstyle ':completion:*' format $'\e[2;37mCompleting %d\e[m'
zstyle ':completion:*:git:*' group-order 'main commands' 'alias commands' 'external commands'
source <(carapace _carapace)

if [ -f "$HOME/yandex-cloud/path.bash.inc" ]; then source "$HOME/yandex-cloud/path.bash.inc"; fi
if [ -f "$HOME/yandex-cloud/completion.zsh.inc" ]; then source "$HOME/yandex-cloud/completion.zsh.inc"; fi

eval "$(starship init zsh)"
