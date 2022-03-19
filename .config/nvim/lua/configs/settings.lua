vim.cmd [[autocmd BufWritePre <buffer> lua vim.lsp.buf.format()]]
vim.cmd [[autocmd FileType help wincmd L]]

-- Set highlight on search only for increments
vim.opt.hlsearch = false
vim.opt.incsearch = true

-- set cursor to be fatty
vim.opt.guicursor = ""

-- Make relative line numbers default
vim.wo.number = true
vim.opt.relativenumber = true

-- fix tab spaces
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- Enable mouse mode
vim.opt.mouse = 'a'

-- Fix splitting behaviour
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Save undo history, this is sweet sweet stuff
-- undotree benefits hugely from this setting
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

-- remove swapfile and backups
vim.opt.swapfile = false
vim.opt.backup = false

-- Case-insensitive searching UNLESS \C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'
vim.opt.scrolloff = 8

-- colorcolumn, do not cross the 80 characters limit
vim.opt.colorcolumn = "80"

-- update fast
vim.opt.updatetime = 50

-- set help to vertical split
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
    pattern = { "*.help" },
    command = "wincmd L"
})
