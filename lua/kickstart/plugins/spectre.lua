rturn {
  'nvim-pack/nvim-spectre',
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts = { open_cmd = 'noswapfile vnew' },
  keys = {
    {
      '<leader>S',
      function()
        require('spectre').toggle()
      end,
      desc = '[S]pectre: Toggle Search/Replace panel',
    },
    {
      '<leader>sw',
      function()
        require('spectre').open_visual { select_word = true }
      end,
      desc = '[S]pectre: Search [W]ord under cursor',
    },
  },
}
