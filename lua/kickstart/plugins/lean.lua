return {
  'Julian/lean.nvim',
  ft = { 'lean' },
  dependencies = {
    'neovim/nvim-lspconfig',
    'nvim-lua/plenary.nvim',
  },
  config = function()
    require('lean').setup {
      abbreviations = { enable = true },
      -- adds lean-specific mappings (<LocalLeader>i for infoview, etc.)
      mappings = true,
      infoview = {
        autoopen = true,
        -- open on the right
        horizontal_position = 'right',
        width = 50,
        height = 20,
      },
      progress_bars = { enable = true },
      lsp = {
        capabilities = require('cmp_nvim_lsp').default_capabilities(),
      },
    }
  end,
}
