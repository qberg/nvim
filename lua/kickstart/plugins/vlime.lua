return {
  {
    'vlime/vlime',
    ft = 'lisp', -- Load only for Lisp files
    dependencies = {
      'kovisoft/paredit', -- Optional but recommended for Lisp editing
    },
    build = function()
      vim.fn.system { 'make', '-C', 'lisp' } -- Build the Lisp side
    end,
    config = function()
      -- Optional configuration
      vim.g.vlime_enable_autodoc = 1
      vim.g.vlime_window_settings = {
        sldb = { pos = 'belowright', size = 20 },
        repl = { pos = 'belowright', size = 15 },
        inspector = { pos = 'belowright', size = 15 },
      }
    end,
  },
}
