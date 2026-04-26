return {
  'mrcjkb/haskell-tools.nvim',
  version = '^4', -- Updated to the latest major release
  lazy = false, -- CRITICAL: haskell-tools now handles its own lazy-loading. Do not change this.
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
  },
  init = function()
    -- Global config must be set before the plugin loads
    vim.g.haskell_tools = {
      hls = {
        -- Pass Kickstart's CMP capabilities for autocompletion
        capabilities = require('cmp_nvim_lsp').default_capabilities(),
      },
    }

    -- Bind keymaps only when a Haskell file is opened
    local haskell_group = vim.api.nvim_create_augroup('haskell-tools', { clear = true })
    vim.api.nvim_create_autocmd('FileType', {
      pattern = { 'haskell', 'lhaskell', 'cabal', 'cabalproject' },
      callback = function(event)
        local ok, ht = pcall(require, 'haskell-tools')
        if not ok then
          vim.notify(
            'haskell-tools is installing or missing. Run :Lazy to check.',
            vim.log.levels.WARN
          )
          return
        end

        local bufnr = event.buf
        local map = function(keys, func, desc)
          vim.keymap.set('n', keys, func, { buffer = bufnr, desc = 'Haskell: ' .. desc })
        end

        -- REPL Integration
        map('<leader>rr', ht.repl.toggle, 'Toggle GHCi REPL')
        map('<leader>rf', function()
          ht.repl.toggle(vim.api.nvim_buf_get_name(0))
        end, 'Load File in REPL')
        map('<leader>rq', ht.repl.quit, 'Quit GHCi REPL')

        -- Hoogle Search
        map('<leader>hs', ht.hoogle.hoogle_signature, 'Hoogle Signature Search')

        -- Code Lens Evaluation
        map('<leader>ea', ht.lsp.buf_eval_all, 'Evaluate All Snippets')
      end,
      group = haskell_group,
    })
  end,
}
