return {
  { -- Active colorscheme: loads at startup, sets scheme
    'RRethy/base16-nvim',
    priority = 1000,
    init = function()
      vim.cmd.colorscheme 'base16-black-metal-bathory'
      vim.cmd.hi 'Comment gui=none'
    end,
  },
  { -- Backup scheme: lazy, available via `:colorscheme tokyonight`
    'folke/tokyonight.nvim',
    lazy = true,
  },
}
