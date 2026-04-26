return {
  'unblevable/quick-scope',
  keys = { 'f', 'F', 't', 'T' }, -- Only load when you actually use horizontal movement
  init = function()
    -- Trigger a highlight only when pressing these keys
    vim.g.qs_highlight_on_key = 1

    -- Customizing colors to ensure it looks "correct" and beautiful
    -- These autocmds ensure colors are set even after colorscheme changes
    vim.api.nvim_create_autocmd('ColorScheme', {
      callback = function()
        vim.api.nvim_set_hl(
          0,
          'QuickScopePrimary',
          { underline = true, bold = true, fg = '#81A2BE' }
        )
        vim.api.nvim_set_hl(
          0,
          'QuickScopeSecondary',
          { underline = true, bold = true, fg = '#8ABEB7' }
        )
      end,
    })
  end,
}
