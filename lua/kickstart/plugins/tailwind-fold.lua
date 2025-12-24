return {
  'razak17/tailwind-fold.nvim',
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  ft = { 'html', 'svelte', 'astro', 'vue', 'typescriptreact', 'php', 'lua' },
  opts = {
    min_chars = 50, -- Only fold if the class string is longer than 50 chars
  },
}
