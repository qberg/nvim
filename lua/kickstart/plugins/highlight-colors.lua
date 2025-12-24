return {
  'brenoprata10/nvim-highlight-colors',
  opts = {
    render = 'virtual', -- Options: 'background' | 'foreground' | 'virtual'
    -- 'virtual' creates a colored bubble next to the class (VS Code style)
    -- 'background' highlights the text itself

    enable_tailwind = true, -- Enable tailwind colors

    virtual_symbol = '󰝤 ', -- Circle icon
    virtual_symbol_suffix = '',
  },
}
