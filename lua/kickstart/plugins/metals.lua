return {
  'scalameta/nvim-metals',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
  },
  ft = { 'scala', 'sbt', 'java' },
  config = function()
    local metals_config = require('metals').bare_config()

    metals_config.serverProperties = {
      '-Dmetals.worksheet-timeout=120',
    }

    -- 1. Scala-Specific Settings
    metals_config.settings = {
      showImplicitArguments = true,
      showInferredType = true,
      excludedPackages = { 'akka.actor.typed.javadsl', 'com.github.swagger.akka.javadsl' },
    }

    -- 2. UI & Capabilities
    metals_config.init_options.statusBarProvider = 'off'
    metals_config.capabilities = require('cmp_nvim_lsp').default_capabilities()

    -- 3. On-Attach Keymaps
    metals_config.on_attach = function(client, bufnr)
      local map = function(keys, func, desc)
        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = 'Metals: ' .. desc })
      end

      map('<leader>ws', function()
        require('metals').hover_worksheet()
      end, 'Hover Worksheet')
      map('<leader>mc', function()
        require('telescope').extensions.metals.commands()
      end, 'Telescope Metals Commands')
    end

    -- 4. The Autocmd for future files
    local nvim_metals_group = vim.api.nvim_create_augroup('nvim-metals', { clear = true })
    vim.api.nvim_create_autocmd('FileType', {
      pattern = { 'scala', 'sbt', 'java' },
      callback = function()
        require('metals').initialize_or_attach(metals_config)
      end,
      group = nvim_metals_group,
    })

    -- Because the FileType event already fired to load the plugin, we must
    -- manually trigger the initialization for the very first file you open.
    require('metals').initialize_or_attach(metals_config)
  end,
}
