return {
  {
    dir = vim.fn.stdpath 'config' .. '/plugins/minipoon',
    name = 'minipoon',
    keys = {
      -- Menu and System Ops
      {
        '<leader>mh',
        function()
          require('minipoon').toggle_menu()
        end,
        desc = 'MINIPOON UI',
      },
      {
        '<leader>mx',
        function()
          require('minipoon').clear_all()
        end,
        desc = 'PURGE LIST',
      },

      -- Set Marks (The Precision Overrides)
      {
        '<leader>m1',
        function()
          require('minipoon').set_mark(1)
        end,
        desc = 'MARK SLOT [1]',
      },
      {
        '<leader>m2',
        function()
          require('minipoon').set_mark(2)
        end,
        desc = 'MARK SLOT [2]',
      },
      {
        '<leader>m3',
        function()
          require('minipoon').set_mark(3)
        end,
        desc = 'MARK SLOT [3]',
      },
      {
        '<leader>m4',
        function()
          require('minipoon').set_mark(4)
        end,
        desc = 'MARK SLOT [4]',
      },
      {
        '<leader>m5',
        function()
          require('minipoon').set_mark(5)
        end,
        desc = 'MARK SLOT [5]',
      },
      {
        '<leader>m6',
        function()
          require('minipoon').set_mark(6)
        end,
        desc = 'MARK SLOT [6]',
      },

      -- Jump to Marks
      {
        '<leader>1',
        function()
          require('minipoon').nav_file(1)
        end,
        desc = 'JUMP [1]',
      },
      {
        '<leader>2',
        function()
          require('minipoon').nav_file(2)
        end,
        desc = 'JUMP [2]',
      },
      {
        '<leader>3',
        function()
          require('minipoon').nav_file(3)
        end,
        desc = 'JUMP [3]',
      },
      {
        '<leader>4',
        function()
          require('minipoon').nav_file(4)
        end,
        desc = 'JUMP [4]',
      },
      {
        '<leader>5',
        function()
          require('minipoon').nav_file(5)
        end,
        desc = 'JUMP [5]',
      },
      {
        '<leader>6',
        function()
          require('minipoon').nav_file(6)
        end,
        desc = 'JUMP [6]',
      },
    },

    config = function()
      print '>> MINIPOON V2 ONLINE <<'
    end,
  },
}
