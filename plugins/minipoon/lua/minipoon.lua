local M = {}
M.marks = {}

function M.add_file()
  local file = vim.fn.expand '%:p'
  if file == '' then
    return
  end

  for _, f in ipairs(M.marks) do
    if f == file then
      print '(!) ALREADY MARKED (hence the yelling)'
      return
    end
  end

  table.insert(M.marks, file)
  print('[+] BUFFER MARKED :: ' .. vim.fn.fnamemodify(file, ':t'))
end

function M.toggle_menu()
  if #M.marks == 0 then
    print '[!] LIST EMPTY'
    return
  end

  print '>> JUMP LIST <<'
  for i, file in ipairs(M.marks) do
    -- Format: [1] filename.lua
    print('[' .. i .. '] ' .. vim.fn.fnamemodify(file, ':t'))
  end
end

function M.nav_file(index)
  local file = M.marks[index]
  if file then
    vim.cmd('e ' .. file)
  else
    print '[!] INVALID INDEX'
  end
end

function M.clear_all()
  M.marks = {}
  print '[*] SYSTEM PURGED'
end

return M
