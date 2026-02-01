return {
  {
    dir = vim.fn.stdpath 'config' .. '/plugins/minipoon',

    name = 'minipoon',

    keys = {
      {
        '<leader>ma',
        function()
          require('minipoon').add_file()
        end,
        desc = 'MARK BUFFER',
      },
      {
        '<leader>mh',
        function()
          require('minipoon').toggle_menu()
        end,
        desc = 'VIEW LIST',
      },
      {
        '<leader>mx',
        function()
          require('minipoon').clear_all()
        end,
        desc = 'PURGE LIST',
      },

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
    },

    config = function()
      print '>> MINIPOON SYSTEM ONLINE <<'
    end,
  },
}
