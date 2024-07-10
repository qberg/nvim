local map = vim.api.nvim_buf_set_keymap
local options = { noremap = true }
map(0, 'n', '<leader>8', '<Esc>:w<cr>:term ipython %<cr>', options)
map(0, 'n', '<leader>rp', '<Esc>:w<cr>:!python3 %<cr>', options)
