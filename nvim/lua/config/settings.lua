vim.opt.guicursor = ""

vim.opt.cursorline = true

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"

vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.isfname:append("@-@")
vim.opt.signcolumn = "yes"

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"

vim.opt.autoread = true

vim.api.nvim_set_hl(0, "Normal", { bg = "NONE", ctermbg = "NONE" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#1e222a" }) -- Set your preferred background color

vim.api.nvim_set_hl(0, "Pmenu", { bg = "#282c34" })       -- For popup menu
vim.api.nvim_set_hl(0, "PmenuSel", { bg = "#4b5263" })    -- For selected item in popup menu
vim.api.nvim_set_hl(0, "PmenuSbar", { bg = "#3e4452" })   -- For scrollbar
vim.api.nvim_set_hl(0, "PmenuThumb", { bg = "#626a73" })  -- For scrollbar thumb

vim.api.nvim_set_hl(0, "LspFloatWinNormal", { bg = "#1e222a" })
vim.api.nvim_set_hl(0, "LspFloatWinBorder", { bg = "#1e222a" })
