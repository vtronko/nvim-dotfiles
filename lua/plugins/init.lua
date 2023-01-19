local present, packer = pcall(require, "plugins.packerInit")

if not present then
   return false
end

local use = packer.use

return packer.startup(function()
   local plugin_status = require("core.utils").load_config().plugin_status

   -- this is arranged on the basis of when a plugin starts

   -- this is the nvchad core repo containing utilities for some features like theme swticher, no need to lazy load
   use {
      "NvChad/extensions",
      commit = "aca0859598b1107a206bf3bc9111d461c006ac84",
   }

   use {
      "nvim-lua/plenary.nvim",
   }

   use {
      "wbthomason/packer.nvim",
      event = "VimEnter",
   }

   use {
      "NvChad/base46",
      commit = "2ae23be472bdf32889e63341f74cfaf8ba1c4847",
      after = "packer.nvim",
      config = function()
         require("colors").init()
      end,
   }

   use {
      "kyazdani42/nvim-web-devicons",
      after = "base46",
      config = function()
         require "plugins.configs.icons"
      end,
   }

   use {
      "feline-nvim/feline.nvim",
      disable = not plugin_status.feline,
      after = "nvim-web-devicons",
      config = function()
         require "plugins.configs.statusline"
      end,
   }

   use {
      "akinsho/bufferline.nvim",
      disable = not plugin_status.bufferline,
      after = "nvim-web-devicons",
      config = function()
         require "plugins.configs.bufferline"
      end,
      setup = function()
         require("core.mappings").bufferline()
      end,
   }

   use {
      "lukas-reineke/indent-blankline.nvim",
      disable = not plugin_status.blankline,
      event = "BufRead",
      config = function()
         require("plugins.configs.others").blankline()
      end,
   }

   use {
      "norcalli/nvim-colorizer.lua",
      disable = not plugin_status.colorizer,
      event = "BufRead",
      config = function()
         require("plugins.configs.others").colorizer()
      end,
   }

   use {
      "nvim-treesitter/nvim-treesitter",
      event = "BufRead",
      config = function()
         require "plugins.configs.treesitter"
      end,
   }

   -- git stuff
   use {
      "lewis6991/gitsigns.nvim",
      disable = not plugin_status.gitsigns,
      opt = true,
      config = function()
         require "plugins.configs.gitsigns"
      end,
      setup = function()
         require("core.utils").packer_lazy_load "gitsigns.nvim"
      end,
   }

   use { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' }

   -- smooth scroll
   use {
      "karb94/neoscroll.nvim",
      disable = not plugin_status.neoscroll,
      opt = true,
      config = function()
         require("plugins.configs.others").neoscroll()
      end,
      setup = function()
         require("core.utils").packer_lazy_load "neoscroll.nvim"
      end,
   }

   use {
      "williamboman/nvim-lsp-installer"
   }

   use {
      "neovim/nvim-lspconfig",
      after = "nvim-lsp-installer",
      config = function()
         require "plugins.configs.lspconfig"
      end,
   }


   use {
      "ray-x/lsp_signature.nvim",
      disable = not plugin_status.lspsignature,
      after = "nvim-lspconfig",
      config = function()
         require("plugins.configs.others").signature()
      end,
   }

   use {
      "andymass/vim-matchup",
      disable = not plugin_status.vim_matchup,
      opt = true,
      setup = function()
         require("core.utils").packer_lazy_load "vim-matchup"
      end,
   }

   -- load autosave only if its globally enabled
   use {
      disable = not plugin_status.autosave,
      "Pocco81/AutoSave.nvim",
      config = function()
         require("plugins.configs.others").autosave()
      end,
      cond = function()
         return require("core.utils").load_config().options.plugin.autosave == true
      end,
   }

   -- load luasnips + cmp related in insert mode only

   use {
      "rafamadriz/friendly-snippets",
      event = "InsertEnter",
   }

   use {
      "hrsh7th/nvim-cmp",
      after = "friendly-snippets",
      config = function()
         require "plugins.configs.cmp"
      end,
   }

   use {
      "L3MON4D3/LuaSnip",
      wants = "friendly-snippets",
      after = "nvim-cmp",
      config = function()
         require("plugins.configs.others").luasnip()
      end,
   }

   use {
      "saadparwaiz1/cmp_luasnip",
      after = "LuaSnip",
   }

   use {
      "hrsh7th/cmp-nvim-lua",
      after = "cmp_luasnip",
   }

   use {
      "hrsh7th/cmp-nvim-lsp",
      after = "cmp-nvim-lua",
   }

   use {
       "hrsh7th/cmp-path",
       after = "cmp-nvim-lua"
   }

   use {
      "hrsh7th/cmp-buffer",
      after = "cmp-nvim-lsp",
   }

   -- misc plugins
   use {
      "windwp/nvim-autopairs",
      after = "nvim-cmp",
      config = function()
         require("plugins.configs.others").autopairs()
      end,
   }

   use {
      "sbdchd/neoformat",
      disable = not plugin_status.neoformat,
      cmd = "Neoformat",
      setup = function()
         require("core.mappings").neoformat()
      end,
   }

   --   use "alvan/vim-closetag" -- for html autoclosing tag
   use {
      "terrortylor/nvim-comment",
      disable = not plugin_status.comment,
      config = function()
         require("plugins.configs.others").comment()
      end,
   }

   -- file managing , picker etc
   use {
      "kyazdani42/nvim-tree.lua",
      cmd = { "NvimTreeToggle", "NvimTreeFocus" },
      config = function()
         require'nvim-tree'.setup()
         require "plugins.configs.nvimtree"
      end,
      setup = function()
         require("core.mappings").nvimtree()
      end,
   }

   use {
      "nvim-telescope/telescope.nvim",
      -- cmd = "Telescope",
      -- because cheatsheet is not activated by a teleacope command
      requires = {
         {
            "nvim-telescope/telescope-fzf-native.nvim",
            run = "make",
         },
         {
            "nvim-telescope/telescope-media-files.nvim",
            disable = not plugin_status.telescope_media,
            setup = function()
               require("core.mappings").telescope_media()
            end,
         },
         {
            "tom-anders/telescope-vim-bookmarks.nvim",

            requires = {
                "MattesGroeger/vim-bookmarks",
                config = function()
                    -- require("plugins.configs.others").bookmarks()
                end,
            },
         },
         -- {
             -- "nvim-telescope/telescope-project.nvim",
             -- config = function()
             --     require("plugins.configs.others").ts_project()
             -- end,
         -- },
      },
      config = function()
         require "plugins.configs.telescope"
      end,
      setup = function()
         require("core.mappings").telescope()
      end,
   }

   use {
       'phaazon/hop.nvim',
       disable = not plugin_status.hop,
         as = 'hop',
         config = function()
             -- you can configure Hop the way you like here; see :h hop-config
             require'hop'.setup {}
         end
   }

   use {
       'akinsho/toggleterm.nvim',
       disable = not plugin_status.toggleterm,
       config = function()
           require("plugins.configs.others").toggleterm()
       end,

   }

   use {
       'p00f/nvim-ts-rainbow',
       disable = not plugin_status.rainbow,
       after = "nvim-treesitter",
   }

   use {
       'machakann/vim-sandwich',
       disable = not plugin_status.vim_sandwich,
   }

   use {
      "Pocco81/true-zen.nvim",
      disable = not plugin_status.truezen,
      cmd = {
         "TZAtaraxis",
         "TZMinimalist",
         "TZFocus",
      },
      config = function()
         require "plugins.configs.zenmode"
      end,
      setup = function()
         require("core.mappings").truezen()
      end,
   }

   use {
      "tpope/vim-fugitive",
      disable = not plugin_status.vim_fugitive,
      cmd = {
         "Git",
         "Gdiff",
         "Gdiffsplit",
         "Gvdiffsplit",
         "Gwrite",
         "Gw",
      },
      setup = function()
         require("core.mappings").vim_fugitive()
      end,
   }

   use {
       "folke/trouble.nvim",
       disable = not plugin_status.trouble,
       requires = "kyazdani42/nvim-web-devicons",
       config = function()
           require("plugins.configs.others").trouble()
       end,
   }

   use {
       "folke/todo-comments.nvim",
       requires = "nvim-lua/plenary.nvim",
       config = function()
           require("plugins.configs.others").todo()
       end
   }

   use {
       "AckslD/nvim-neoclip.lua",
       requires = {'tami5/sqlite.lua', module = 'sqlite'},
       config = function()
           require("plugins.configs.others").neoclip()
       end,
   }

   use {
       "mfussenegger/nvim-dap",
        config = function()
            require "plugins.configs.ndap"
        end,
   }

   use {
       "rcarriga/nvim-dap-ui",
       requires = {"mfussenegger/nvim-dap"},
       config = function()
           require "plugins.configs.others".dapui()
       end,
       setup = function()
           require("core.mappings").dapui()
       end,
   }

   use {
       'rmagatti/goto-preview',
       config = function()
           require('goto-preview').setup {}
       end,
       setup = function()
           require("core.mappings").gotopreview()
       end,
   }

   use {
     "theHamsta/nvim-dap-virtual-text",
     config = function()
       require("nvim-dap-virtual-text").setup {
         enabled = true,                     -- enable this plugin (the default)
         enabled_commands = true,            -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
         highlight_changed_variables = true, -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
         highlight_new_as_changed = false,   -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
         show_stop_reason = true,            -- show stop reason when stopped for exceptions
         commented = false,                  -- prefix virtual text with comment string
         -- experimental features:
         virt_text_pos = 'eol',              -- position of virtual text, see `:h nvim_buf_set_extmark()`
         all_frames = false,                 -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
         virt_lines = false,                 -- show virtual lines instead of virtual text (will flicker!)
         virt_text_win_col = nil             -- position the virtual text at a fixed window column (starting from the first text column) ,
         -- e.g. 80 to position at column 80, see `:h nvim_buf_set_extmark()`
       }
     end,
   }

   use {
     "NTBBloodbath/rest.nvim",
     requires = { "nvim-lua/plenary.nvim" },
     config = function()
       require("rest-nvim").setup({
         -- Open request results in a horizontal split
         result_split_horizontal = false,
         -- Skip SSL verification, useful for unknown certificates
         skip_ssl_verification = true,
         -- Highlight request on run
         highlight = {
           enabled = true,
           timeout = 150,
         },
         result = {
           -- toggle showing URL, HTTP info, headers at top the of result window
           show_url = true,
           show_http_info = true,
           show_headers = true,
         },
         -- Jump to request line on run
         jump_to_request = false,
         env_file = '.env',
         custom_dynamic_variables = {},
         yank_dry_run = true,
       })
     end,
     setup = function()
       require("core.mappings").rest()
     end,
   }

   use {
     "beauwilliams/focus.nvim",
     config = function()
       require("focus").setup({})
     end,
     setup = function()
      require("core.mappings").focus()
     end
   }

   -- use {
   --   "nvim-treesitter/nvim-treesitter-refactor",
   --   after = "nvim-treesitter",
     -- config = function()
     --   require'nvim-treesitter.configs'.setup {
     --     refactor = {
     --       highlight_definitions = {
     --         enable = true,
     --         -- Set to false if you have an `updatetime` of ~100.
     --         clear_on_cursor_move = true,
     --       },
     --       highlight_current_scope = { enable = true },
     --     },
     --   }
     -- end
   -- }

   -- use {
   --   'nvim-orgmode/orgmode',
   --   after = "nvim-treesitter",
   --   config = function()
   --     require "plugins.configs.orgmode"
   --   end,
      -- }

   -- use {
   --   'akinsho/org-bullets.nvim',
   --   wants = "orgmode",
   --   config = function()
   --     require('org-bullets').setup({
   --       symbols = {
   --         checkboxes = {
   --           half = { "~", "OrgTSCheckboxHalfChecked" },
   --           done = { "✓", "OrgDone" },
   --           todo = { " ", "OrgTODO" },
   --         },
   --       }
   --     })
   --   end
   -- }

end)
