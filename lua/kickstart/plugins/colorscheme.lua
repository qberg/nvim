return {
  { -- Primary colorscheme
    'folke/tokyonight.nvim',
    priority = 1000,
    init = function()
      -- Set tokyonight as default colorscheme
      vim.cmd.colorscheme 'tokyonight-moon'
      vim.cmd.hi 'Comment gui=none'
    end,
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
}
