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
        name = 'cs',
        path = '~/notes/vaults/cs',
      },
      {
        name = 'math',
        path = '~/notes/vaults/math/',
      },
      {
        name = 'baduk',
        path = '~/notes/vaults/baduk/',
      },
      {
        name = 'phil',
        path = '~/notes/vaults/phil/',
      },
      {
        name = 'fin',
        path = '~/notes/vaults/math/',
      },
      {
        name = 'projects',
        path = '~/notes/vaults/projects/',
      },
    },
  },
}
