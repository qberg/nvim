return {
  {
    'nvim-treesitter/nvim-treesitter',
    branch = 'main',
    build = ':TSUpdate',
    lazy = false,
    opts = {
      ensure_installed = {
        'astro',
        'bash',
        'c',
        'css',
        'diff',
        'go',
        'graphql',
        'html',
        'javascript',
        'jsdoc',
        'json',
        'lua',
        'luadoc',
        'markdown',
        'markdown_inline',
        'python',
        'query',
        'regex',
        'toml',
        'tsx',
        'typescript',
        'vim',
        'vimdoc',
        'yaml',
        'ruby',
      },
    },
    config = function(_, opts)
      local ts = require 'nvim-treesitter'

      -- Call the new setup (minimalist)
      ts.setup {
        install_dir = vim.fn.stdpath 'data' .. '/site',
      }

      -- Modern installation call
      if opts.ensure_installed then
        ts.install(opts.ensure_installed)
      end

      -- Native Highlighting & Indent (The Kickstart/Top 1% way)
      vim.api.nvim_create_autocmd('FileType', {
        group = vim.api.nvim_create_augroup('TreesitterSetup', { clear = true }),
        callback = function(args)
          local lang = vim.treesitter.language.get_lang(vim.bo[args.buf].filetype)
          if not lang then
            return
          end

          -- Native highlight start
          pcall(vim.treesitter.start, args.buf)

          -- Native indentexpr
          vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })
    end,
  },
  {
    'nvim-treesitter/nvim-treesitter-context',
    event = 'BufReadPost',
    opts = { max_lines = 3 },
  },
}
