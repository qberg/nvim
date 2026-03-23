return {
  'sindrets/diffview.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  cmd = {
    'DiffviewOpen',
    'DiffviewClose',
    'DiffviewToggleFiles',
    'DiffviewFocusFiles',
    'DiffviewFileHistory',
  },
  keys = {
    { '<leader>gd', '', desc = '+Diffview (Review)', mode = { 'n', 'v' } },
    { '<leader>gdo', '<cmd>DiffviewOpen<cr>', desc = 'Open Diffview' },
    { '<leader>gdc', '<cmd>DiffviewClose<cr>', desc = 'Close Diffview' },
    { '<leader>gdh', '<cmd>DiffviewFileHistory %<cr>', desc = 'Current File History' },
    { '<leader>gdH', '<cmd>DiffviewFileHistory<cr>', desc = 'Branch Commit History' },
  },
  config = function()
    local actions = require 'diffview.actions'

    require('diffview').setup {
      enhanced_diff_hl = true,
      diff_buf_read = function(bufnr)
        -- This ensures your local version is always editable
        if vim.api.nvim_buf_get_option(bufnr, 'buftype') == '' then
          vim.api.nvim_buf_set_option(bufnr, 'modifiable', true)
        end
      end,
      view = {
        default = {
          layout = 'diff2_horizontal',
        },
        merge_tool = {
          -- 3-way split: Local, Base, and Remote on top.
          -- The file you are actively fixing is on the bottom.
          layout = 'diff3_mixed',
          disable_diagnostics = true,
        },
      },
      keymaps = {
        -- These keymaps only activate when you are in merge mode
        merge_tool = {
          {
            'n',
            '<leader>co',
            actions.conflict_choose 'ours',
            { desc = 'Choose Ours (Destination)' },
          },
          {
            'n',
            '<leader>ct',
            actions.conflict_choose 'theirs',
            { desc = 'Choose Theirs (Incoming)' },
          },
          {
            'n',
            '<leader>cb',
            actions.conflict_choose 'base',
            { desc = 'Choose Base (Original)' },
          },
          { 'n', '<leader>ca', actions.conflict_choose 'all', { desc = 'Choose All (Append)' } },
          { 'n', '<leader>cx', actions.conflict_choose 'none', { desc = 'Choose None (Delete)' } },

          -- Navigation between conflict markers
          { 'n', ']x', actions.next_conflict, { desc = 'Next Conflict' } },
          { 'n', '[x', actions.prev_conflict, { desc = 'Previous Conflict' } },
        },
      },
    }
  end,
}
