local opt = vim.opt

-- Номера строк
opt.number = true
opt.relativenumber = true

-- Отступы (глобальный дефолт; per-filetype настроим на шаге 6)
opt.expandtab = true
opt.shiftwidth = 4
opt.tabstop = 4
opt.smartindent = true

-- Поиск
opt.ignorecase = true
opt.smartcase = true   -- учитывать регистр, если в запросе есть заглавные
opt.hlsearch = true
opt.incsearch = true

-- Внешний вид
opt.termguicolors = true   -- сразу глобально, а не внутри плагина
opt.signcolumn = "yes"     -- чтобы текст не прыгал от gitsigns/диагностики
opt.scrolloff = 8
opt.cursorline = true

-- Поведение
opt.mouse = "a"
opt.clipboard = "unnamedplus"  -- общий буфер с системой
opt.undofile = true            -- история отмен переживает перезапуск
opt.updatetime = 250
opt.timeoutlen = 400
opt.splitright = true
opt.splitbelow = true

-- Меньше визуального шума
opt.shortmess:append("c")
