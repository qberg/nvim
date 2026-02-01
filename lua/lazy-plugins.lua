require('lazy').setup({
  require 'kickstart.plugins.vim-sleuth', -- Detect tabstop and shiftwidth automatically
  require 'kickstart.plugins.comment', -- "gc" to comment visual regions/lines
  require 'kickstart.plugins.gitsigns', -- Adds git related signs to the gutter
  require 'kickstart.plugins.which-key', -- Useful plugin to show you pending keybinds.
  require 'kickstart.plugins.telescope', -- Fuzzy Finder (files, lsp, etc)
  require 'kickstart.plugins.lspconfig', -- LSP Configuration & Plugins
  require 'kickstart.plugins.vlime',
  require 'kickstart.plugins.conform', -- Autoformatting
  require 'kickstart.plugins.cmp', -- Autocompletion
  require 'kickstart.plugins.colorscheme', -- Colorscheme of tokynight, can be changed.
  require 'kickstart.plugins.todo-comments', -- Highlight todo, notes, etc in comments
  require 'kickstart.plugins.mini', -- Collection of various small independent plugins/modules
  require 'kickstart.plugins.minifiles', -- Collection of various small independent plugins/modules
  require 'kickstart.plugins.treesitter', -- Highlight, edit, and navigate code
  -- require 'kickstart.plugins.debug',
  require 'kickstart.plugins.indent_line',
  -- require 'kickstart.plugins.lint',
  require 'kickstart.plugins.autopairs',
  require 'kickstart.plugins.neo-tree',
  -- require 'kickstart.plugins.oil',
  require 'kickstart.plugins.vim-tmux-navigator',
  -- require 'kickstart.plugins.headlines',
  -- require 'kickstart.plugins.obsidian',
  require 'kickstart.plugins.snacks',

  -- enhancements for webdev
  require 'kickstart.plugins.autotag',
  require 'kickstart.plugins.surround',
  require 'kickstart.plugins.colorizer',
  require 'kickstart.plugins.trouble',

  { import = 'custom.plugins' },
}, {
  ui = {
    -- If you are using a Nerd Font: set icons to an empty table which will use the
    -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
    icons = vim.g.have_nerd_font and {} or {
      cmd = '⌘',
      config = '🛠',
      event = '📅',
      ft = '📂',
      init = '⚙',
      keys = '🗝',
      plugin = '🔌',
      runtime = '💻',
      require = '🌙',
      source = '📄',
      start = '🚀',
      task = '📌',
      lazy = '💤 ',
    },
  },
})
