# env.nu — loaded before config.nu
#
# Здесь генерируются init-скрипты внешних инструментов и кэшируются в
# init-cache/. Регенерация происходит ТОЛЬКО если файла нет — это убирает
# задержку старта (внешние процессы не дёргаются на каждый запуск шелла).
#
# Чтобы обновить кэш после обновления инструмента:
#   rm -rf ($nu.default-config-dir | path join "init-cache")

$env.EDITOR = "nvim"
$env.VISUAL = "nvim"

let cache_dir = ($nu.default-config-dir | path join "init-cache")
mkdir $cache_dir

let inits = {
    starship: { || starship init nu }
    zoxide: { || zoxide init nushell }
    carapace: { || carapace _carapace nushell }
    atuin: { || atuin init nu }
}

for entry in ($inits | transpose name generator) {
    let target = ($cache_dir | path join $"($entry.name).nu")
    if not ($target | path exists) {
        do $entry.generator | save -f $target
    }
}
