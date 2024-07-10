return {
  'echasnovski/mini.files',
  opts = {
    windows = {
      preview = true,
    },
  },
  config = function(_, opts)
    local show_dotfiles = true
    local filter_show = function()
      return true
    end
    local filter_hide = function(fs_entry)
      return not vim.startswith(fs_entry.name, '.')
    end
    local toggle_dotfiles = function()
      show_dotfiles = not show_dotfiles
      local new_filter = show_dotfiles and filter_show or filter_hide
      MiniFiles.refresh { content = { filter = new_filter } }
    end
    vim.api.nvim_create_autocmd('User', {
      pattern = 'MiniFilesBufferCreate',
      callback = function(args)
        local buf_id = args.data.buf_id
        -- Tweak left-hand side of mapping to your liking
        vim.keymap.set('n', 'H', toggle_dotfiles, { desc = 'Toggle hidden files', buffer = buf_id })
      end,
    })
    require('mini.files').setup(opts)
  end,
  keys = {
    {
      '<leader>fm',
      function()
        MiniFiles.open()
      end,
      desc = 'Open Mini Files',
    },
  },
}
