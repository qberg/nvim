return {
  'epwalsh/obsidian.nvim',
  version = '*',
  lazy = true,
  ft = 'markdown',
  event = {
    'BufReadPre ~/notes/vaults/**.md',
    'BufNewFile ~/notes/vaults/**.md',
  },
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  opts = {
    workspaces = {
      {
        name = 'aws',
        path = '~/notes/vaults/aws',
      },
      {
        name = 'machine-learning',
        path = '~/notes/vaults/machine-learning/',
      },
      {
        name = 'programming-languages',
        path = '~/notes/vaults/prog-languages/',
      },
    },
  },
}
