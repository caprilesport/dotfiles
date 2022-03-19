local builtin = require('telescope.builtin')

-- vim.keymap.set('n', '<leader>gf', builtin.git_files, {}) -- git files - may add one day
vim.keymap.set('n', '<leader>ff', builtin.find_files, {desc = "[F]ind [F]iles"}) -- files 
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {desc = "[F]ind through [G]rep"}) -- grep
vim.keymap.set('n', '<leader>fk', builtin.keymaps, {desc = "[F]ind available [K]eymaps"})
vim.keymap.set('n', "<leader>fr", builtin.registers, {desc = "[F]ind [R]egisters"})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {desc = "[F]ind [B]uffers"})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {desc = "[S]earch in vim [H]elp"})
