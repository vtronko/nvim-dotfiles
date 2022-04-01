local M = {}
M.ui, M.options, M.plugin_status, M.mappings, M.custom = {}, {}, {}, {}, {}

-- non plugin ui configs, available without any plugins
M.ui = {
   italic_comments = true,

   -- theme to be used, to see all available themes, open the theme switcher by <leader> + th
   theme = "everforest",

   -- theme toggler, toggle between two themes, see theme_toggleer mappings
   theme_toggler = {
      enabled = false,
      fav_themes = {
         "nord",
         "everforest",
      },
   },

   -- Enable this only if your terminal has the colorscheme set which nvchad uses
   -- For Ex : if you have onedark set in nvchad , set onedark's bg color on your terminal
   transparency = true,
}

-- plugin related ui options
M.ui.plugin = {
   -- statusline related options
   statusline = {
      -- these are filetypes, not pattern matched
      -- if a filetype is present in shown, it will always show the statusline, irrespective of filetypes in hidden
      hidden = {},
      shown = {},
      -- default, round , slant , block , arrow
      style = "block",
   },
}

-- non plugin normal, available without any plugins
M.options = {
   clipboard = "unnamedplus",
   cmdheight = 1,
   copy_cut = true, -- copy cut text ( x key ), visual and normal mode
   copy_del = true, -- copy deleted text ( dd key ), visual and normal mode
   expandtab = true,
   hidden = true,
   ignorecase = false,
   inccommand = "nosplit",
   insert_nav = true, -- navigation in insertmode
   mouse = "a",
   number = true,
   -- relative numbers in normal mode tool at the bottom of options.lua
   numberwidth = 1,
   permanent_undo = false,
   shiftwidth = 2,
   smartindent = true,
   tabstop = 2, -- Number of spaces that a <Tab> in the file counts for
   timeoutlen = 400,
   relativenumber = true,
   ruler = true,
   updatetime = 250,

   global = {
       mapleader = ";",
       bookmark_sign = "",
   },
}

-- these are plugin related options
M.options.plugin = {
   autosave = false, -- autosave on changed text or insert mode leave
   -- timeout to be used for using escape with a key combination, see mappings.plugin.better_escape
   esc_insertmode_timeout = 300,
}

-- enable and disable plugins (false for disable)
M.plugin_status = {
   autosave = false, -- to autosave files
   blankline = false, -- beautified blank lines
   bufferline = true, -- buffer shown as tabs
   cheatsheet = true, -- fuzzy search your commands/keymappings
   colorizer = true,
   comment = true, -- universal commentor
   dashboard = false, -- a nice looking dashboard
   hop = true, -- hop — easymotion alternative
   esc_insertmode = true, -- escape from insert mode using custom keys
   feline = true, -- statusline
   lualine = false, -- statusline
   gitsigns = true, -- gitsigns in statusline
   lspsignature = true, -- lsp enhancements
   neoformat = false, -- universal forlatter
   neoscroll = true, -- smooth scroll
   rainbow = true, -- rainbow parentheses
   telescope_media = true, -- see media files in telescope picker
   toggleterm = true, -- toggleterm
   trouble = true, -- trouble plugin
   truezen = true, -- no distraction mode for nvim
   vim_fugitive = true, -- git in nvim
   vim_matchup = true, -- % magic, match it but improved
   vim_sandwich = true, -- replace/add/remove surrounding token
}

-- mappings -- don't use a single keymap twice --
-- non plugin mappings
M.mappings = {
   -- close current focused buffer
   close_buffer = "<leader>x",
   copy_whole_file = "<C-s-a>", -- copy all contents of the current buffer

   -- navigation in insert mode, only if enabled in options
   insert_nav = {
      backward = "<C-h>",
      end_of_line = "<C-e>",
      forward = "<C-l>",
      next_line = "<C-k>",
      prev_line = "<C-j>",
      top_of_line = "<C-a>",
   },

   new_buffer = "<leader>bc", -- open a new buffer
   new_tab = "<leader>ct", -- open a new vim tab
   save_file = "<C-s>", -- save file using :w
   -- theme_toggler = "<leader>theme", -- for theme toggler, see in ui.theme_toggler

   -- terminal related mappings
   terminal = {
      -- multiple mappings can be given for esc_termmode and esc_hide_termmode
      -- get out of terminal mode
      esc_termmode = { "<Esc>" }, -- multiple mappings allowed
      -- get out of terminal mode and hide it
      -- it does not close it, see pick_term mapping to see hidden terminals
      esc_hide_termmode = { "<Esc>" }, -- multiple mappings allowed
      -- show hidden terminal buffers in a telescope picker
      pick_term = "<leader>W",
      -- below three are for spawning terminals
      -- new_horizontal = "tt",
      -- new_vertical = "tt",
      -- new_window = "<leader>w",
   },

   -- lspcustom = {
   --     toggler = { '<leader>lsp' },
   -- },

   reload_config = "<leader>rl",
   hop_motion = " ",

   trouble = {
       lsp_document_diagnostics = "<leader>q",
       todo = "<leader>todo",
       -- references = "<leader>gr"
   }
}

-- all plugins related mappings
-- to get short info about a plugin, see the respective string in plugin_status, if not present, then info here
M.mappings.plugin = {
   bufferline = {
      next_buffer = "<leader>bn", -- next buffer
      prev_buffer = "<leader>bp", -- previous buffer
      --better window movement
      moveLeft = "<C-h>",
      moveRight = "<C-l>",
      moveUp = "<C-k>",
      moveDown = "<C-j>",
   },
   nvimtree = {
      toggle = "<leader>tt",
      filetoggle = "<leader>tf",
   },
   neoformat = {
      format = "<leader>fm",
   },
   telescope = {
      open = "<leader>ts",
      buffers = "<leader>bb",
      bookmarks_all = "<leader>bma",
      find_files = "<leader>fd",
      find_hiddenfiles = "<leader>fd",
      git_commits = "<leader>cm",
      git_status = "<leader>gs",
      help_tags = "<leader>fh",
      live_grep = "<leader>rg",
      oldfiles = "<leader>hh",
      lsp_references = "<leader>gr",
      lsp_document_symbols = "<leader>ls",
      themes = "<leader>theme",
      todo = "<leader>todo",
      neoclip = "<leader>cl",
      jumplist = "<leader>jl",
   },
   telescope_media = {
      media_files = "<leader>fp",
   },
   truezen = { -- distraction free modes mapping, hide statusline, tabline, line numbers
      ataraxis_mode = "<leader>zf", -- center
      focus_mode = "<leader>zz",
      minimalistic_mode = "<leader>zm", -- as it is
   },
   vim_fugitive = {
      git_blame = "<leader>gb",
   },
   vim_bookmarks = {
       toggle = "<leader>bm",
       next = "<leader>bmn",
       prev = "<leader>bmp",
       clear = "<leader>bmr",
       clear_all = "<leader>bmra",
   },
   dapui = {
       toggle = "<leader>dv",
       toggle_tray = "<leader>df"
   },
   gotopreview = {
       preview = "<leader>gp",
       closepreview = "<leader>gP"
   },
   calltree = {
     incoming_call = "<leader>ic",
     list_symbols = "<leader>sls",
   },
   rest = {
     run = "<leader>rs",
     run_prev = "<leader>rsl",
   },
}

-- user custom mappings
-- e.g: name = { "mode" , "keys" , "cmd" , "options"}
-- name: can be empty or something unique with repect to other custom mappings
--    { mode, key, cmd } or name = { mode, key, cmd }
-- mode: usage: mode or { mode1, mode2 }, multiple modes allowed, available modes => :h map-modes,
-- keys: multiple keys allowed, same synxtax as modes
-- cmd:  for vim commands, must use ':' at start and add <CR> at the end if want to execute
-- options: see :h nvim_set_keymap() opts section
M.custom.mappings = {
    edit_config = {
        "n",
        "<leader>conf",
        ":e ~/.config/nvim/lua/chadrc.lua<CR>",
    },
    next_tab = {
        "n",
        "<leader>nt",
        ":tabnext<CR>"
    },
    close_tab = {
        "n",
        "<leader>tc",
        ":tabclose<CR>"
    },
    disable_recording = {
        "n",
        "q",
        "<Nop>"
    },
    disable_comm_normal = {
        "n",
        "<leader>gc",
        "<Nop>",
    },
    disable_comm_normal_2 = {
        "n",
        "gcc",
        "<Nop>",
    },
    toggleterm = {
        "n",
        "tt",
        ":ToggleTerm<CR>",
    },
    move_visual_up = {
        "v",
        "K",
        ":move '<-2<CR>gv-gv"
    },
    move_visual_down = {
        "v",
        "J",
        ":move '>+1<CR>gv-gv"
    },
}

return M
