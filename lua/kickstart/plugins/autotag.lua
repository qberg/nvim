return {
  'windwp/nvim-ts-autotag',
  event = { 'BufReadPre', 'BufNewFile' }, -- Load it when opening a file
  opts = {}, -- This automatically calls require('nvim-ts-autotag').setup()
}
