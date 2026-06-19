# config.nu — main Nushell configuration
# Docs: https://www.nushell.sh/book/configuration.html

# Carapace provides completions for ~1000 external commands.
let carapace_completer = {|spans: list<string>|
    carapace $spans.0 nushell ...$spans
    | from json
}

$env.config = {
    show_banner: false

    ls: { use_ls_colors: true }

    rm: { always_trash: false }

    table: {
        mode: rounded
        index_mode: auto
        show_empty: true
        trim: { methodology: wrapping, wrapping_try_keep_words: true }
    }

    history: {
        max_size: 100_000
        sync_on_enter: true
        file_format: "plaintext"
    }

    completions: {
        case_sensitive: false
        quick: true
        partial: true
        algorithm: "fuzzy"
        external: {
            enable: true
            max_results: 100
            completer: $carapace_completer
        }
        use_ls_colors: true
    }

    # Развёрнутые таблицы только на широком терминале.
    hooks: {
        display_output: "if (term size).columns >= 100 { table -e } else { table }"
    }

    # edit_mode: vi   # раскомментируй для vi-режима вместо emacs
    cursor_shape: {
        emacs: line
        vi_insert: line
        vi_normal: block
    }
}

# --- Aliases -----------------------------------------------------------------

alias ll = ls -l
alias la = ls -a
alias lla = ls -la
alias v = nvim
alias c = clear

# Git
alias gs = git status
alias ga = git add
alias gc = git commit -m
alias gca = git commit -a -m
alias gp = git push origin HEAD
alias gl = git pull origin
alias gco = git checkout
alias gb = git branch
alias gd = git diff
alias glog = git log --oneline --graph --decorate

# Kubernetes
alias k = kubectl
alias kg = kubectl get
alias kd = kubectl describe
alias kl = kubectl logs -f
alias ke = kubectl exec -it

# Docker
alias d = docker
alias dc = docker compose
alias dps = docker ps

# --- Tool init (cached in env.nu) --------------------------------------------
# Пути должны быть const, чтобы `source` отработал на этапе парсинга.

const cache_dir = ($nu.default-config-dir | path join "init-cache")

source ($cache_dir | path join "zoxide.nu")
source ($cache_dir | path join "starship.nu")
source ($cache_dir | path join "carapace.nu")
source ($cache_dir | path join "atuin.nu")   # перехватывает Ctrl-R для поиска по истории
