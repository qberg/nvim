-- Autoformat
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
        local disable_filetypes = { c = true, cpp = true }
        return {
          timeout_ms = 500,
          lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
        }
      end,
      formatters_by_ft = {
        lua = { 'stylua' },
        html = { { 'prettierd', 'prettier' } },
        css = { { 'prettierd', 'prettier' } },
        javascript = { { 'prettierd', 'prettier' } },
        javascriptreact = { { 'prettierd', 'prettier' } },
        json = { { 'prettierd', 'prettier' } },
        graphql = { { 'prettierd', 'prettier' } },
        markdown = { { 'prettierd', 'prettier' } },
        sql = { 'sql-formatter' },
        svelte = { { 'prettierd', 'prettier' } },
        typescript = { { 'prettierd', 'prettier' } },
        typescriptreact = { { 'prettierd', 'prettier' } },
        go = { 'goimports_reviser', 'gofmt', 'golines' },
        rust = { 'rustfmt' },
        python = { 'isort', 'black' },
        scss = { 'prettier' },
        sh = { 'shfmt' },
        toml = { 'taplo' },
        yaml = { 'prettier' },
      },
    },
  },
}
