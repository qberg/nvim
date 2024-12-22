return {
  {
    'stevearc/conform.nvim',
    lazy = false,
    keys = {
      {
        '<leader>f',
        function()
          require('conform').format { async = true, lsp_fallback = true }
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
    opts = {
      notify_on_error = false,

      format_on_save = function(bufnr)
        -- Add your specific filetype exclusions here
        local disable_filetypes = {
          c = true,
          cpp = true,
          cuda = true,
          asm = true,
        }
        return {
          timeout_ms = 500,
          lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
        }
      end,

      formatters_by_ft = {
        -- Web Development (using prettierd with prettier fallback)
        javascript = { { 'prettierd', 'prettier' } },
        typescript = { { 'prettierd', 'prettier' } },
        javascriptreact = { { 'prettierd', 'prettier' } },
        typescriptreact = { { 'prettierd', 'prettier' } },
        svelte = { { 'prettierd', 'prettier' } },
        vue = { { 'prettierd', 'prettier' } },
        css = { { 'prettierd', 'prettier' } },
        scss = { { 'prettierd', 'prettier' } },
        html = { { 'prettierd', 'prettier' } },
        json = { { 'prettierd', 'prettier' } },
        jsonc = { { 'prettierd', 'prettier' } },
        yaml = { { 'prettierd', 'prettier' } },
        markdown = { { 'prettierd', 'prettier' } },
        graphql = { { 'prettierd', 'prettier' } },

        -- Systems Programming
        c = { 'clang_format' },
        cpp = { 'clang_format' },
        cuda = { 'clang_format' },
        rust = { 'rustfmt' },
        go = { 'gofumpt', 'goimports' },

        -- Python
        python = { 'ruff_format', 'black', 'isort' }, -- ruff is faster

        -- PHP
        php = { 'php_cs_fixer', 'phpcbf' },

        -- Configuration & Markup
        lua = { 'stylua' },
        toml = { 'taplo' },

        -- Shell
        sh = { 'shfmt' },
        bash = { 'shfmt' },

        -- Database
        sql = { 'sql_formatter' },
      },

      -- Formatter-specific configurations
      formatters = {
        clang_format = {
          prepend_args = {
            '--style={BasedOnStyle: Google, IndentWidth: 2, ColumnLimit: 100}',
          },
        },

        prettier = {
          prepend_args = {
            '--print-width',
            '100',
            '--single-quote',
            '--jsx-single-quote',
            '--trailing-comma',
            'es5',
          },
        },

        -- Match your Go settings with gopls configuration
        gofumpt = {
          prepend_args = { '-extra' },
        },

        -- Configure PHP formatting to match your LSP settings
        php_cs_fixer = {
          prepend_args = { '--rules=@PSR12,ordered_imports,no_unused_imports' },
        },

        -- Match your Lua LSP settings
        stylua = {
          prepend_args = {
            '--indent-type',
            'Spaces',
            '--indent-width',
            '2',
            '--column-width',
            '100',
          },
        },

        -- Fast Python formatting with ruff
        ruff_format = {
          prepend_args = { '--line-length=100' },
        },
      },
    },
  },
}
