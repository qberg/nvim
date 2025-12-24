-- LSP Configuration & Plugins

return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'williamboman/mason.nvim', config = true }, -- NOTE: Must be loaded before dependants
      'williamboman/mason-lspconfig.nvim',
      'WhoIsSethDaniel/mason-tool-installer.nvim',
      'b0o/schemastore.nvim',
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim', opts = {} },
      -- `neodev` configures Lua LSP for your Neovim config, runtime and plugins
      -- used for completion, annotations and signatures of Neovim apis
      { 'folke/neodev.nvim', opts = {} },
    },

    config = function()
      require('mason').setup {
        ui = {
          check_outdated_packages_on_open = true,
          border = 'rounded',
        },
      }
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
        callback = function(event)
          local map = function(keys, func, desc)
            vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
          end
          map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
          map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
          map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
          map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
          map(
            '<leader>ds',
            require('telescope.builtin').lsp_document_symbols,
            '[D]ocument [S]ymbols'
          )
          map(
            '<leader>ws',
            require('telescope.builtin').lsp_dynamic_workspace_symbols,
            '[W]orkspace [S]ymbols'
          )
          map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
          map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
          map('K', vim.lsp.buf.hover, 'Hover Documentation')
          map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client.server_capabilities.documentHighlightProvider then
            local highlight_augroup =
              vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
            vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd('LspDetach', {
              group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
              callback = function(event2)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
              end,
            })
          end

          if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
            map('<leader>th', function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
            end, '[T]oggle Inlay [H]ints')
          end
        end,
      })

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities =
        vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())
      --  Add any additional override configuration in the following tables. Available keys are:
      --  - cmd (table): Override the default command used to start the server
      --  - filetypes (table): Override the default list of associated filetypes for the server
      --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
      --  - settings (table): Override the default settings passed when initializing the server.
      --        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
      local servers = {
        bashls = {},
        html = {},
        eslint = {},
        svelte = {},
        jdtls = {},

        dockerls = {},
        terraformls = {},

        -- Lua
        lua_ls = {
          settings = {
            Lua = {
              completion = {
                callSnippet = 'Replace',
              },
            },
          },
        },

        -- C familia
        clangd = {
          filetypes = {
            'c',
            'cpp',
            'objc',
            'objcpp',
            'cuda',
          },
          cmd = {
            'clangd',
            '--background-index',
            '--clang-tidy',
            '--header-insertion=iwyu',
            '--completion-style=detailed',
            '--function-arg-placeholders',
            '--fallback-style=llvm',
          },
          init_options = {
            usePlaceholders = true,
            completeUnimported = true,
            clangdFileStatus = true,
          },
        },

        -- PHP
        phpactor = {
          filetypes = { 'php' },
          init_options = {
            ['completion.import_globals'] = true,
          },
          settings = {
            ['phpactor.completion.global_search'] = true,
          },
        },
        -- Rust
        rust_analyzer = {
          settings = {
            ['rust-analyzer'] = {
              rust = {
                analyzerTargetDir = true,
              },
              assist = {
                importMergeBehavior = 'last',
                importPrefix = 'by_self',
              },
              diagnostics = {
                disabled = { 'unresolved-import' },
              },
              cargo = {
                loadOutDirsFromCheck = true,
              },
              procMacro = {
                enable = true,
              },
              checkOnSave = {
                command = 'clippy',
              },
              files = {
                excludeDirs = {
                  '.direnv',
                  'target',
                  'js',
                  'node_modules',
                  'assets',
                  'ci',
                  'data',
                  'docs',
                  'store-metadata',
                  '.gitlab',
                  '.vscode',
                  '.git',
                },
              },
            },
          },
        },

        -- Go
        gopls = {
          filetypes = {
            'go',
            'gomod',
            'gowork',
            'gotmpl',
          },
          settings = {
            gopls = {
              completeUnimported = true,
              usePlaceholders = true,
              analyses = {
                unusedparams = true,
              },
              hints = {
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = true,
                rangeVariableTypes = true,
              },
              staticcheck = true,
            },
          },
        },

        -- Python
        pyright = {
          settings = {
            python = {
              analysis = {
                typeCheckingMode = 'off',
              },
            },
          },
        },

        ts_ls = {
          init_options = {
            preferences = {
              importModuleSpecifierPreference = 'non-relative',
            },
          },

          settings = {
            typescript = {
              inlayHints = {
                includeInlayParameterNameHints = 'literals', -- 'none' | 'literals' | 'all'
                includeInlayParameterNameHintsWhenArgumentMatchesName = false,
                includeInlayFunctionParameterTypeHints = true,
                includeInlayVariableTypeHints = true,
                includeInlayVariableTypeHintsWhenTypeMatchesName = false,
                includeInlayPropertyDeclarationTypeHints = true,
                includeInlayFunctionLikeReturnTypeHints = true,
                includeInlayEnumMemberValueHints = true,
              },

              updateImportsOnFileMove = {
                enabled = 'always',
              },
            },
          },
        },

        -- Typescript
        -- tsserver = {
        --   filetypes = {
        --     'javascript',
        --     'javascriptreact',
        --     'javascript.jsx',
        --     'typescript',
        --     'typescriptreact',
        --     'typescript.tsx',
        --   },
        --   settings = {
        --     typescript = {
        --       inlayHints = {
        --         includeInlayParameterNameHints = 'literal',
        --         includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        --         includeInlayFunctionParameterTypeHints = true,
        --         includeInlayVariableTypeHints = false,
        --         includeInlayPropertyDeclarationTypeHints = true,
        --         includeInlayFunctionLikeReturnTypeHints = true,
        --         includeInlayEnumMemberValueHints = true,
        --       },
        --     },
        --     javascript = {
        --       inlayHints = {
        --         includeInlayParameterNameHints = 'all',
        --         includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        --         includeInlayFunctionParameterTypeHints = true,
        --         includeInlayVariableTypeHints = true,
        --         includeInlayPropertyDeclarationTypeHints = true,
        --         includeInlayFunctionLikeReturnTypeHints = true,
        --         includeInlayEnumMemberValueHints = true,
        --       },
        --     },
        --   },
        -- },
        -- CSS
        cssls = {
          cmd = { 'vscode-css-language-server', '--stdio' },
          filetypes = { 'css', 'scss' },
          single_file_support = true,
          settings = {
            css = {
              validate = true,
              lint = {
                unknownAtRules = 'ignore',
              },
            },
          },
        },

        -- TailwindCSS
        tailwindcss = {
          filetypes = {
            'html',
            'mdx',
            'javascript',
            'typescript',
            'javascriptreact',
            'typescriptreact',
            'vue',
            'svelte',
            'elixir',
            'gohtml',
            'gohtmltmpl',
          },
          settings = {
            tailwindcss = {
              lint = {
                cssConflict = 'warning',
                invalidApply = 'error',
                invalidConfigPath = 'error',
                invalidScreen = 'error',
                invalidTailwindDirective = 'error',
                invalidVariant = 'error',
                recommendedVariantOrder = 'warning',
              },
              experimental = {
                classRegex = {
                  'tw`([^`]*)',
                  'tw="([^"]*)',
                  'tw={"([^"}]*)',
                  'tw\\.\\w+`([^`]*)',
                  'tw\\(.*?\\)`([^`]*)',
                  { 'clsx\\(([^)]*)\\)', "(?:'|\"|`)([^']*)(?:'|\"|`)" },
                  { 'classnames\\(([^)]*)\\)', "'([^']*)'" },
                  { 'cva\\(([^)]*)\\)', '["\'`]([^"\'`]*).*?["\'`]' },
                  { 'cn\\(([^)]*)\\)', "(?:'|\"|`)([^']*)(?:'|\"|`)" },
                },
              },
              validate = true,
            },
          },
        },

        -- Emmet: Adds 'div.container>ul>li*3' expansions to React/HTML
        emmet_language_server = {
          filetypes = {
            'css',
            'eruby',
            'html',
            'javascript',
            'javascriptreact',
            'less',
            'sass',
            'scss',
            'pug',
            'typescriptreact',
          },
          -- Read more about this specific server to customize snippet behavior
        },

        -- Biome: Adds in-editor linting (red squigglies) for JS/TS
        -- Note: Formatting is handled by Conform, but this gives you the diagnostics
        biome = {},

        -- NGINX
        -- nginx_language_server = {
        --   cmd = { 'nginx-language-server' },
        --   cmd_env = {
        --     GLOB_PATTERN = '*@(nginx.conf)',
        --   },
        --   filetypes = { 'nginx' },
        --   single_file_support = true,
        -- },

        -- JSON
        jsonls = {
          settings = {
            json = {
              schemas = require('schemastore').json.schemas(),
              validate = { enable = true },
            },
          },
        },

        -- YAML
        yamlls = {
          settings = {
            yaml = {
              schemaStore = { enable = false, url = '' },
              schemas = require('schemastore').yaml.schemas {
                select = {
                  'package.json',
                  '.eslintrc',
                  'GitHub Action',
                  'prettierrc.json',
                },
              },
            },
          },
        },

        -- GraphQL
        graphql = {
          filetypes = {
            'graphql',
            'typescript',
            'javascript',
            'typescriptreact',
            'javascriptreact',
          },
        },
      }

      require('mason').setup()
      local ensure_installed = vim.tbl_keys(servers or {})
      local ensure_installed_tools = {
        -- Formatters
        'stylua', -- Lua
        'prettier', -- Web
        'prettierd', -- Faster prettier
        'clang-format', -- C/C++
        'rustfmt', -- Rust
        'gofumpt', -- Go
        'goimports', -- Go
        'black', -- Python
        'isort', -- Python imports
        'ruff', -- Python (faster)
        'php-cs-fixer', -- PHP
        'phpcbf', -- PHP
        'shfmt', -- Shell
        'taplo', -- TOML
        'sql-formatter', -- SQL

        'biome', --cool kid on the js block

        -- Linters
        'eslint_d', -- JavaScript/TypeScript
        'ruff-lsp', -- Python
        'pylint', -- Python
        'cpplint', -- C/C++
        'phpcs', -- PHP
        'shellcheck', -- Shell
        'hadolint', -- Dockerfile

        -- Language Servers (if not already in servers table)
        'lua-language-server',
        'pyright',
        'css-lsp',
        'html-lsp',
        'clangd',
        'rust-analyzer',
        'gopls',
        'intelephense', -- PHP
        'tailwindcss',
        'graphql',
        'docker-compose-language-service',
      }
      require('mason-tool-installer').setup { ensure_installed = ensure_installed_tools }

      require('mason-lspconfig').setup {
        ensure_installed = ensure_installed,
        handlers = {
          function(server_name)
            local server = servers[server_name] or {}
            server.capabilities =
              vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
            require('lspconfig')[server_name].setup(server)
          end,
        },
      }
    end,
  },
}
