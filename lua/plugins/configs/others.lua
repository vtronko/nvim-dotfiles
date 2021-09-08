local M = {}

local config = require("core.utils").load_config()

M.autopairs = function()
   local present1, autopairs = pcall(require, "nvim-autopairs")
   local present2, autopairs_completion = pcall(require, "nvim-autopairs.completion.cmp")

   if not (present1 or present2) then
      return
   end

   autopairs.setup()
   autopairs_completion.setup {
      map_complete = true, -- insert () func completion
      map_cr = true,
   }
end

M.autosave = function()
   -- autosave.nvim plugin is disabled by default
   local present, autosave = pcall(require, "autosave")
   if not present then
      return
   end

   autosave.setup {
      enabled = config.options.plugin.autosave, -- takes boolean value from chadrc.lua
      execution_message = "autosaved at : " .. vim.fn.strftime "%H:%M:%S",
      events = { "InsertLeave", "TextChanged" },
      conditions = {
         exists = true,
         filetype_is_not = {},
         modifiable = true,
      },
      clean_command_line_interval = 2500,
      on_off_commands = true,
      write_all_buffers = false,
   }
end

M.better_escape = function()
   vim.g.better_escape_interval = config.options.plugin.esc_insertmode_timeout or 300
end

M.blankline = function()
   require("indent_blankline").setup {
      indentLine_enabled = 1,
      char = "▏",
      filetype_exclude = {
         "help",
         "terminal",
         "dashboard",
         "packer",
         "lspinfo",
         "TelescopePrompt",
         "TelescopeResults",
      },
      buftype_exclude = { "terminal" },
      show_trailing_blankline_indent = false,
      show_first_indent_level = false,
   }
end

M.colorizer = function()
   local present, colorizer = pcall(require, "colorizer")
   if present then
      colorizer.setup({ "*" }, {
         RGB = true, -- #RGB hex codes
         RRGGBB = true, -- #RRGGBB hex codes
         names = false, -- "Name" codes like Blue
         RRGGBBAA = false, -- #RRGGBBAA hex codes
         rgb_fn = false, -- CSS rgb() and rgba() functions
         hsl_fn = false, -- CSS hsl() and hsla() functions
         css = false, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
         css_fn = false, -- Enable all CSS *functions*: rgb_fn, hsl_fn

         -- Available modes: foreground, background
         mode = "background", -- Set the display mode.
      })
      vim.cmd "ColorizerReloadAllBuffers"
   end
end

M.comment = function()
   local present, nvim_comment = pcall(require, "nvim_comment")
   if present then
      nvim_comment.setup()
   end
end

M.luasnip = function()
   local present, luasnip = pcall(require, "luasnip")
   if not present then
      return
   end

   luasnip.config.set_config {
      history = true,
      updateevents = "TextChanged,TextChangedI",
   }
   require("luasnip/loaders/from_vscode").load()
end

M.neoscroll = function()
   pcall(function()
       require("neoscroll").setup({
           -- All these keys will be mapped to their corresponding default scrolling animation
           hide_cursor = true,          -- Hide cursor while scrolling
           stop_eof = true,             -- Stop at <EOF> when scrolling downwards
           use_local_scrolloff = true, -- Use the local scope of scrolloff instead of the global scope
           respect_scrolloff = true,   -- Stop scrolling when the cursor reaches the scrolloff margin of the file
           cursor_scrolls_alone = false, -- The cursor will keep on scrolling even if the window cannot scroll further
           easing_function = nil        -- Default easing function
       })
   end)

   local t = {}
   -- Syntax: t[keys] = {function, {function arguments}}
   -- Use the "sine" easing function
   t['<C-k>'] = {'scroll', {'-vim.wo.scroll', 'true', '225', [['sine']]}}
   t['<C-j>'] = {'scroll', { 'vim.wo.scroll', 'true', '225', [['sine']]}}
   -- Use the "circular" easing function
   t['<C-b>'] = {'scroll', {'-vim.api.nvim_win_get_height(0)', 'true', '225', [['sine']]}}
   t['<C-f>'] = {'scroll', { 'vim.api.nvim_win_get_height(0)', 'true', '225', [['sine']]}}
   -- Pass "nil" to disable the easing animation (constant scrolling speed)
   t['<C-y>'] = {'scroll', {'-0.10', 'false', '150', [['sine']] }}
   t['<C-e>'] = {'scroll', { '0.10', 'false', '150', [['sine']] }}
   -- When no easing function is provided the default easing function (in this case "quadratic") will be used
   t['zt']    = {'zt', {'100'}, [['sine']] }
   t['zz']    = {'zz', {'100'}, [['sine']] }
   t['zb']    = {'zb', {'100'}, [['sine']] }

   pcall(function()
       require('neoscroll.config').set_mappings(t)
   end)
end

M.toggleterm= function()
require("toggleterm").setup{

}
end

M.signature = function()
   local present, lspsignature = pcall(require, "lsp_signature")
   if present then
      lspsignature.setup {
         bind = true,
         doc_lines = 2,
         floating_window = true,
         fix_pos = true,
         hint_enable = true,
         hint_prefix = " ",
         hint_scheme = "String",
         hi_parameter = "Search",
         max_height = 22,
         max_width = 120, -- max_width of signature floating_window, line will be wrapped if exceed max_width
         handler_opts = {
            border = "single", -- double, single, shadow, none
         },
         zindex = 200, -- by default it will be on top of all floating windows, set to 50 send it to bottom
         padding = "", -- character to pad on left and right of signature can be ' ', or '|'  etc
      }
   end
end

return M
