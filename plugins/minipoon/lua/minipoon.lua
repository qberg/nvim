local M = {}

-- Initialize exactly 6 empty slots
M.marks = { nil, nil, nil, nil, nil, nil }

function M.set_mark(index)
  local file = vim.fn.expand '%:p'
  if file == '' then
    print '[!] CANNOT MARK EMPTY BUFFER'
    return
  end

  M.marks[index] = file
  print(string.format('>> SLOT [%d] OVERWRITTEN :: %s <<', index, vim.fn.fnamemodify(file, ':t')))
end

function M.toggle_menu()
  local items = {}

  -- Format the 6 slots for the UI picker
  for i = 1, 6 do
    local file = M.marks[i]
    local display_name = file and vim.fn.fnamemodify(file, ':t') or 'EMPTY'
    table.insert(items, string.format('[%d] %s', i, display_name))
  end

  -- vim.ui.select will be intercepted by Telescope automatically
  vim.ui.select(items, {
    prompt = '>> MINIPOON JUMP <<',
    format_item = function(item)
      return item
    end,
  }, function(choice, idx)
    -- This callback runs when you press Enter in Telescope
    if not choice then
      return -- User aborted/pressed Esc
    end

    -- The index of the selected item perfectly matches our 1-6 slots
    M.nav_file(idx)
  end)
end

function M.nav_file(index)
  local file = M.marks[index]
  if file and file ~= '' then
    vim.cmd('e ' .. file)
  else
    print(string.format('[!] SLOT [%d] IS EMPTY', index))
  end
end

function M.clear_all()
  M.marks = { nil, nil, nil, nil, nil, nil }
  print '[*] SYSTEM PURGED: ALL SLOTS CLEARED'
end

return M
