# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH


export SSL_CERT_FILE=$(python3.11 -m certifi)

export HDG_CONFIG_HOME="$HOME/.config"

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes

ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
    zsh-history-substring-search
    docker
)

# source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"


# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
export PATH="$HOME/.local/bin:$PATH"

# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

#alias yy="yazi"

. "$HOME/.cargo/env"
# source /opt/homebrew/opt/spaceship/spaceship.zsh


eval "$(starship init zsh)"

source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# Disable underline
(( ${+ZSH_HIGHLIGHT_STYLES} )) || typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[path]=none
ZSH_HIGHLIGHT_STYLES[path_prefix]=none


# Shift-selection в ZLE (zsh line editor)

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

# Должно совпадать с тем, что отправляет WezTerm выше
bindkey '^[[1;2D' __sel_left
bindkey '^[[1;2C' __sel_right
bindkey '^[[1;4D' __sel_wleft
bindkey '^[[1;4C' __sel_wright
bindkey '^[[1;2H' __sel_home
bindkey '^[[1;2F' __sel_end
eval "$(rbenv init - zsh)"

# Claude Code
alias cc="claude"

alias ll="ls -l"
alias la="ls -a"
alias lla="ls -la"
alias v="nvim"
alias c="clear"

# Git
alias gs="git status"
alias ga="git add"
alias gc="git commit -m"
alias gca="git commit -a -m"
alias gp="git push origin HEAD"
alias gl="git pull origin"
alias gco="git checkout"
alias gb="git branch"
alias gd="git diff"
alias glog="git log --oneline --graph --decorate"

# Kubernetes
alias k="kubectl"
alias kg="kubectl get"
alias kd="kubectl describe"
alias kl="kubectl logs -f"
alias ke="kubectl exec -it"

# Docker
alias d="docker"
alias dc="docker compose"
alias dps="docker ps"


autoload -U compinit && compinit
export CARAPACE_BRIDGES='zsh,fish,bash,inshellisense' # optional
zstyle ':completion:*' format $'\e[2;37mCompleting %d\e[m'
source <(carapace _carapace)

zstyle ':completion:*:git:*' group-order 'main commands' 'alias commands' 'external commands'


# The next line updates PATH for CLI.
#if [ -f "$HOME/yandex-cloud/path.bash.inc" ]; then source "$HOME/yandex-cloud/path.bash.inc"; fi

# The next line enables shell command completion for yc.
#if [ -f "$HOME/yandex-cloud/completion.zsh.inc" ]; then source "$HOME/yandex-cloud/completion.zsh.inc"; fi

export GOENV_ROOT="$HOME/.goenv"
export PATH="$GOENV_ROOT/bin:$PATH"
eval "$(goenv init -)"


export PATH=$PATH:$HOME/.spicetify

# Запускать Nushell как интерактивную оболочку.
# zsh сначала настраивает окружение (.zshenv задаёт XDG_CONFIG_HOME, .zshrc — PATH),
# затем exec заменяет процесс на nu, который всё это наследует.
# Escape-hatch: внутри nu можно вызвать `zsh` — повторного входа в nu не будет
# благодаря флагу NU_LAUNCHED.
#if [[ -o interactive && -z "$NU_LAUNCHED" ]]; then
#    export NU_LAUNCHED=1
#    exec nu
#fi

# Added by LM Studio CLI (lms)
export PATH="$PATH:$HOME/.lmstudio/bin"
# End of LM Studio CLI section


# Added by GitButler installer
eval "$(but completions zsh)"


# paydo-api: open an encrypted environment file in $EDITOR through sops.
# The key never leaves the ignored secrets/ directory; sops re-encrypts on exit.
paydo-sops() {
  local environment=${1:?usage: paydo-sops <staging|production>}
  local root=${PAYDO_API_ROOT:-$(git rev-parse --show-toplevel 2>/dev/null)}
  [[ -d $root/config/environments ]] || root=~/dev/paydo-api

  local key=$root/secrets/$environment.age.key
  local file=$root/config/environments/$environment.sops.env

  [[ -f $key ]]  || { print -u2 "paydo-sops: no age key at $key"; return 1 }
  [[ -f $file ]] || { print -u2 "paydo-sops: no env file at $file"; return 1 }

  (cd "$root" && SOPS_AGE_KEY_FILE="$key" sops "config/environments/$environment.sops.env")
}
alias sops-staging='paydo-sops staging'
alias sops-prod='paydo-sops production'


# Added by Antigravity CLI installer
export PATH="$HOME/.local/bin:$PATH"
