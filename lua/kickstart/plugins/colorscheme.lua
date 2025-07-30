return {
  { -- Primary colorscheme
    'folke/tokyonight.nvim',
    priority = 1000,
  },
  { -- Additional colorschemes available
    'theamallalgi/zitchdog',
    priority = 1000,
  },
  {
    'rose-pine/neovim',
    name = 'rose-pine',
    priority = 1000,
  },
  {
    'bettervim/yugen.nvim',
    priority = 1000,
  },
  { 'catppuccin/nvim', name = 'catppuccin', priority = 1000 },
  {
    'RRethy/base16-nvim',
    priority = 1000,
    init = function()
      vim.cmd.colorscheme 'base16-black-metal-bathory'
      vim.cmd.hi 'Comment gui=none'
    end,
  },
}
