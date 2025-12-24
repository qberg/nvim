return {
  'catgoose/nvim-colorizer.lua',
  event = 'BufReadPre',
  opts = {
    filetypes = { '*' },
    user_default_options = {
      rgb_fn = true, -- CSS rgb() and rgba() functions
      hsl_fn = true, -- CSS hsl() and hsla() functions
      css = true, -- Enable all CSS features: rgb, rgb, hsl, etc
      css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn

      -- The Magic Sauce for OKLCH and Modern CSS:
      -- This enables handling of functions like oklch(60% 0.1 180)
      mode = 'background', -- Set the background color. Options: 'foreground', 'background', 'virtualtext'
      tailwind = true, -- Enable tailwind colors

      -- Parsers allows you to force specific behaviors
      -- older plugins fail here, but catgoose succeeds
      sass = { enable = true, parsers = { 'css' } },
      virtualtext = '■',
    },
  },
}
