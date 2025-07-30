local map = vim.keymap.set

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
map('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
local diagnostic_goto = function(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go { severity = severity }
  end
end
map('n', '<leader>cd', vim.diagnostic.open_float, { desc = 'Line Diagnostics' })
map('n', ']d', diagnostic_goto(true), { desc = 'Next Diagnostic' })
map('n', '[d', diagnostic_goto(false), { desc = 'Prev Diagnostic' })
map('n', ']e', diagnostic_goto(true, 'ERROR'), { desc = 'Next Error' })
map('n', '[e', diagnostic_goto(false, 'ERROR'), { desc = 'Prev Error' })
map('n', ']w', diagnostic_goto(true, 'WARN'), { desc = 'Next Warning' })
map('n', '[w', diagnostic_goto(false, 'WARN'), { desc = 'Prev Warning' })
map('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode

map('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
map('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
map('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
map('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
map('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
map('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
map('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
map('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
map('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Go to start or end of line easier
map({ 'n', 'x' }, 'H', '^')
map({ 'n', 'x' }, 'L', 'g_')
-- Go to the beginning and end of current line in insert mode quickly
map('i', '<C-A>', '<HOME>')
map('i', '<C-E>', '<END>')

-- Buffers
map('n', '[b', '<cmd>bprevious<cr>', { desc = 'Previous buffer' })
map('n', ']b', '<cmd>bnext<cr>', { desc = 'Next buffer' })
map('n', '<leader>bb', '<cmd>e #<cr>', { desc = 'Switch to other buffer' })
map('n', '<leader>bd', '<cmd>:bd<cr>', { desc = 'Delete Buffer and Window' })

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

map('n', '<leader>sv', function()
  vim.cmd [[
      update $MYVIMRC
      source $MYVIMRC
    ]]
  vim.notify('Nvim config successfully reloaded!', vim.log.levels.INFO, { title = 'nvim-config' })
end, {
  silent = true,
  desc = 'reload init.lua',
})

map('n', '<leader>tc', function()
  local colorschemes = {
    'tokyonight-night',
    'tokyonight-storm',
    'tokyonight-day',
    'tokyonight-moon',
    'rose-pine',
    'rose-pine-moon',
    'rose-pine-dawn',
    'catppuccin-latte',
    'catppuccin-frappe',
    'catppuccin-macchiato',
    'catppuccin-mocha',
    'yugen',
    'zitchdog-grape',
    'base16-black-metal-bathory',
  }

  vim.ui.select(colorschemes, {
    prompt = 'Choose colorscheme:',
    format_item = function(item)
      return 'Theme: ' .. item
    end,
  }, function(choice)
    if choice then
      vim.cmd.colorscheme(choice)
      vim.notify('Switched to ' .. choice, vim.log.levels.INFO, { title = 'colorscheme' })
    end
  end)
end, { desc = 'Select colorscheme' })
