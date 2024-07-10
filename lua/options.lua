local opt = vim.opt
local g = vim.g

g.have_nerd_font = true -- Enable Nerd Font

opt.number = true -- Make line numbers default
opt.relativenumber = true
opt.mouse = 'a' -- Enable mouse mode
opt.showmode = false -- Don't show the mode, since it's already in the status line
opt.clipboard = 'unnamedplus' -- Sync clipboard between OS and Neovim.
opt.breakindent = true -- Enable break indent
opt.undofile = true -- Save undo history
opt.ignorecase = true -- Ignore case in search patterns
opt.smartcase = true -- Smart case
opt.signcolumn = 'yes' -- Keep signcolumn on by default
opt.updatetime = 250 -- Decrease update time
opt.timeoutlen = 300 -- Decrease mapped sequence wait time
opt.splitright = true -- Configure how new splits should be opened
opt.splitbelow = true
opt.list = true -- Sets whitespace characters in the editor.
opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
opt.inccommand = 'split' -- Preview substitutions live, as you type!
opt.cursorline = true -- Show which line your cursor is on
opt.scrolloff = 10 -- Minimal number of screen lines to keep above and below the cursor.
opt.wildignore = [[
.git,.hg,.svn
*.aux,*.out,*.toc
*.o,*.obj,*.exe,*.dll,*.manifest,*.rbc,*.class
*.ai,*.bmp,*.gif,*.ico,*.jpg,*.jpeg,*.png,*.psd,*.webp
*.avi,*.divx,*.mp4,*.webm,*.mov,*.m2ts,*.mkv,*.vob,*.mpg,*.mpeg
*.mp3,*.oga,*.ogg,*.wav,*.flac
*.eot,*.otf,*.ttf,*.woff
*.doc,*.pdf,*.cbr,*.cbz
*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz,*.kgb
*.swp,.lock,.DS_Store,._*
*/tmp/*,*.so,*.swp,*.zip,**/node_modules/**,**/target/**,**.terraform/**"
]]
