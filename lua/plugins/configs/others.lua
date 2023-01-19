local M = {}

local config = require("core.utils").load_config()

M.autopairs = function()
   local present1, autopairs = pcall(require, "nvim-autopairs")
   local present2, cmp_autopairs = pcall(require, "nvim-autopairs.completion.cmp")

   if not (present1 or present2) then
      return
   end

   autopairs.setup()
   local cmp = require "cmp"
   cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
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
         names = true, -- "Name" codes like Blue
         RRGGBBAA = true, -- #RRGGBBAA hex codes
         rgb_fn = true, -- CSS rgb() and rgba() functions
         hsl_fn = true, -- CSS hsl() and hsla() functions
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
      nvim_comment.setup({
          -- Linters prefer comment and line to have a space in between markers
          marker_padding = true,
          -- should comment out empty or whitespace only lines
          comment_empty = true,
          -- Should key mappings be created
          create_mappings = true,
          -- Normal mode mapping left hand side
          line_mapping = "<leader>//",
          -- Visual/Operator mapping left hand side
          operator_mapping = "<leader>/",
          -- Hook function to call before commenting takes place
          hook = nil
      })

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
           -- -- All these keys will be mapped to their corresponding default scrolling animation
           hide_cursor = false,          -- Hide cursor while scrolling
           stop_eof = false,             -- Stop at <EOF> when scrolling downwards
           -- use_local_scrolloff = true, -- Use the local scope of scrolloff instead of the global scope
           respect_scrolloff = false,   -- Stop scrolling when the cursor reaches the scrolloff margin of the file
           cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
           easing_function = nil        -- Default easing function
       })
   end)

   local t = {}
   -- Syntax: t[keys] = {function, {function arguments}}
   -- Use the "sine" easing function
   -- t['<C-k>'] = {'scroll', {'-vim.wo.scroll' * 2 / 3, 'true', '225', [['sine']]}}
   -- t['<C-j>'] = {'scroll', { 'vim.wo.scroll' * 2 / 3, 'true', '225', [['sine']]}}
   t['<C-k>'] = {'scroll', { -12, 'true', '125', [['sine']]}}
   t['<C-j>'] = {'scroll', { 12, 'true', '125', [['sine']]}}
   -- Use the "circular" easing function
   t['<C-b>'] = {'scroll', {'-vim.api.nvim_win_get_height(0)', 'true', '225', [['sine']]}}
   t['<C-f>'] = {'scroll', { 'vim.api.nvim_win_get_height(0)', 'true', '225', [['sine']]}}
   -- Pass "nil" to disable the easing animation (constant scrolling speed)
   t['<C-y>'] = {'scroll', {'-0.10', 'false', '125', [['sine']] }}
   t['<C-e>'] = {'scroll', { '0.10', 'false', '125', [['sine']] }}
   -- When no easing function is provided the default easing function (in this case "quadratic") will be used
   t['zt']    = {'zt', {'50'}, [['sine']] }
   t['zz']    = {'zz', {'50'}, [['sine']] }
   t['zb']    = {'zb', {'50'}, [['sine']] }
   -- t['gg']    = {'scroll', {'-2*vim.api.nvim_buf_line_count(0)', 'true', '1', '5', e}}
   -- t['G']     = {'scroll', {'2*vim.api.nvim_buf_line_count(0)', 'true', '1', '5', e}}

   pcall(function()
       require('neoscroll.config').set_mappings(t)
   end)
end

M.trouble = function()
    pcall(function()
        require("trouble").setup({
            position = "bottom", -- position of the list can be: bottom, top, left, right
            height = 10, -- height of the trouble list when position is top or bottom
            width = 50, -- width of the list when position is left or right
            icons = true, -- use devicons for filenames
            mode = "workspace_diagnostics", -- "lsp_workspace_diagnostics", "lsp_document_diagnostics", "quickfix", "lsp_references", "loclist"
            fold_open = "", -- icon used for open folds
             fold_closed = "", -- icon used for closed folds
            action_keys = { -- key mappings for actions in the trouble list
            -- map to {} to remove a mapping, for example:
            -- close = {},
            close = "q", -- close the list
            cancel = "<esc>", -- cancel the preview and get back to your last window / buffer / cursor
            refresh = "r", -- manually refresh
            jump = {"<cr>", "<tab>"}, -- jump to the diagnostic or open / close folds
            open_split = { "<c-x>" }, -- open buffer in new split
            open_vsplit = { "<c-v>" }, -- open buffer in new vsplit
            open_tab = { "<c-t>" }, -- open buffer in new tab
            jump_close = {"o"}, -- jump to the diagnostic and close the list
            toggle_mode = "m", -- toggle between "workspace" and "document" diagnostics mode
            toggle_preview = "P", -- toggle auto_preview
            hover = "K", -- opens a small popup with the full multiline message
            preview = "p", -- preview the diagnostic location
            close_folds = {"zM", "zm"}, -- close all folds
            open_folds = {"zR", "zr"}, -- open all folds
            toggle_fold = {"zA", "za"}, -- toggle fold of current file
            previous = "k", -- preview item
            next = "j" -- next item
        },
        indent_lines = true, -- add an indent guide below the fold icons
        auto_open = false, -- automatically open the list when you have diagnostics
        auto_close = false, -- automatically close the list when you have no diagnostics
        auto_preview = true, -- automatically preview the location of the diagnostic. <esc> to close preview and go back to last window
        auto_fold = false, -- automatically fold a file trouble list at creation
        signs = {
            -- icons / text used for a diagnostic
            error = "",
            warning = "",
            hint = "",
            information = "",
            other = "﫠"
        },
        use_diagnostic_signs = true -- enabling this will use the signs defined in your lsp client
        })
    end)
end

M.todo = function()
    require("todo-comments").setup {
        signs = true, -- show icons in the signs column
        sign_priority = 8, -- sign priority
        -- keywords recognized as todo comments
        keywords = {
            TODO = {
                icon = " ", color = "info",
            },
            FIX = {
                icon = " ", -- icon used for the sign, and in search results
                color = "error", -- can be a hex color, or a named color (see below)
                alt = { "FIXME", "BUG", "FIXIT", "ISSUE" }, -- a set of other keywords that all map to this FIX keywords
                -- signs = false, -- configure signs for some keywords individually
            },
            HACK = { icon = " ", color = "warning" },
            WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
            PERF = { icon = " ", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
            NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
        },
        merge_keywords = true, -- when true, custom keywords will be merged with the defaults
        -- highlighting of the line containing the todo comment
        -- * before: highlights before the keyword (typically comment characters)
        -- * keyword: highlights of the keyword
        -- * after: highlights after the keyword (todo text)
        highlight = {
            before = "", -- "fg" or "bg" or empty
            keyword = "wide", -- "fg", "bg", "wide" or empty. (wide is the same as bg, but will also highlight surrounding characters)
            after = "fg", -- "fg" or "bg" or empty
            pattern = [[.*<(KEYWORDS)\s*:]], -- pattern or table of patterns, used for highlightng (vim regex)
            comments_only = true, -- uses treesitter to match keywords in comments only
            max_line_len = 400, -- ignore lines longer than this
            exclude = {}, -- list of file types to exclude highlighting
        },
        -- list of named colors where we try to extract the guifg from the
        -- list of hilight groups or use the hex color if hl not found as a fallback
        colors = {
            error = { "DiagnosticError", "ErrorMsg", "#DC2626" },
            warning = { "DiagnosticWarning", "WarningMsg", "#FBBF24" },
            info = { "DiagnosticInfo", "#2563EB" },
            hint = { "DiagnosticHint", "#10B981" },
            default = { "Identifier", "#7C3AED" },
        },
        search = {
            command = "rg",
            args = {
                "--color=never",
                "--no-heading",
                "--with-filename",
                "--line-number",
                "--column",
            },
            -- regex that will be used to match keywords.
            -- don't replace the (KEYWORDS) placeholder
            pattern = [[\b(KEYWORDS):]], -- ripgrep regex
            -- pattern = [[\b(KEYWORDS)\b]], -- match without the extra colon. You'll likely get false positives
        },
    }
end

M.neoclip = function()
    require('neoclip').setup({
        history = 1000,
        enable_persistent_history = true,
        preview = true,
        default_register = '"',
        content_spec_column = false,
        on_paste = {
            set_reg = false,
        },
        keys = {
          telescope = {
            i = {
                select = '<cr>',
                paste = '<c-p>',
                paste_behind = '<c-k>',
                custom = {},
            },
            n = {
                select = '<cr>',
                paste = 'p',
                paste_behind = 'P',
                custom = {},
            },
          }
        },
    })
end

M.toggleterm= function()
    require("toggleterm").setup{
        -- size can be a number or function which is passed the current terminal
        size = 16,
        open_mapping = [[<c-\>]],
        hide_numbers = true, -- hide the number column in toggleterm buffers
        shade_filetypes = {},
        shade_terminals = false,
        shading_factor = '0', -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
        start_in_insert = true,
        insert_mappings = true, -- whether or not the open mapping applies in insert mode
        persist_size = true,
        -- direction = 'vertical' | 'horizontal' | 'window' | 'float',
        close_on_exit = true, -- close the terminal window when the process exits
        shell = vim.o.shell, -- change the default shell
        -- This field is only relevant if direction is set to 'float'
        float_opts = {
            -- The border key is *almost* the same as 'nvim_open_win'
            -- see :h nvim_open_win for details on borders however
            -- the 'curved' border is a custom border type
            -- not natively supported but implemented in this plugin.
            -- border = 'single' | 'double' | 'shadow' | 'curved' | ... other options supported by win open
            -- width = <value>,
            -- height = <value>,
            -- winblend = 3,
            highlights = {
                border = "Normal",
                background = "Normal",
            }
        }
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

M.gotopreview = function()
    require('goto-preview').setup {
        width = 80; -- Width of the floating window
        height = 15; -- Height of the floating window
        border = {"↖", "─" ,"┐", "│", "┘", "─", "└", "│"}; -- Border characters of the floating window
        default_mappings = false; -- Bind default mappings
        debug = false; -- Print debug information
        opacity = nil; -- 0-100 opacity level of the floating window where 100 is fully transparent.
        resizing_mappings = false; -- Binds arrow keys to resizing the floating window.
        post_open_hook = nil; -- A function taking two arguments, a buffer and a window to be ran as a hook.
        -- references = { -- Configure the telescope UI for slowing the references cycling window.
        -- telescope = telescope.themes.get_dropdown({ hide_preview = false })
        -- };
        -- These two configs can also be passed down to the goto-preview definition and implementation calls for one off "peak" functionality.
        focus_on_open = false; -- Focus the floating window when opening it.
        dismiss_on_move = true; -- Dismiss the floating window when moving the cursor.
        force_close = true, -- passed into vim.api.nvim_win_close's second argument. See :h nvim_win_close
        bufhidden = "wipe", -- the bufhidden option to set on the floating window. See :h bufhidden
    }
end

M.calltree = function()
  require('calltree').setup({
    layout = "right",
    icons = "nerd",
    layout_size = 50,
    indent_guides = false,
  })
end

M.dapui = function()
    require("dapui").setup({
        icons = { expanded = "▾", collapsed = "▸" },
        mappings = {
            -- Use a table to apply multiple mappings
            expand = { "<CR>", "<2-LeftMouse>" },
            open = "o",
            remove = "d",
            edit = "e",
            repl = "r",
            toggle = "t",
        },
        expand_lines = vim.fn.has("nvim-0.7"),
        layouts = {
          {
            id = "sidebar",
            elements = {
              -- Elements can be strings or table with id and size keys.
              "scopes",
              { id = "breakpoints", size = 0.25 },
            },
            size = 30,
            position = "right",
          },
          {
            elements = {
              "stacks"
            },
            size = 0.25, -- 25% of total lines
            position = "bottom",
          },
        },
        windows = { indent = 1 },
        render = {
          max_type_length = nil, -- Can be integer or nil.
        }
    })

    local dap, dapui = require("dap"), require("dapui")
    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
      dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
      dapui.close()
    end
end

return M
