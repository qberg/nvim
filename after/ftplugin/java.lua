vim.api.nvim_command 'compiler java'
-- vim.cmd('compiler java')
local map = vim.api.nvim_buf_set_keymap
local options = { noremap = true }
map(0, 'n', '<leader>rj', ':term java %<cr>', options)
