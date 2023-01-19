local present, ts_config = pcall(require, "nvim-treesitter.configs")
if not present then
   return
end

local parser_configs = require('nvim-treesitter.parsers').get_parser_configs()

-- These two are optional and provide syntax highlighting
-- for Neorg tables and the @document.meta tag
parser_configs.norg_meta = {
    install_info = {
        url = "https://github.com/nvim-neorg/tree-sitter-norg-meta",
        files = { "src/parser.c" },
        branch = "main"
    },
}

parser_configs.norg_table = {
    install_info = {
        url = "https://github.com/nvim-neorg/tree-sitter-norg-table",
        files = { "src/parser.c" },
        branch = "main"
    },
}

ts_config.setup {
  refactor = {
    highlight_definitions = {
      enable = true,
      -- Set to false if you have an `updatetime` of ~100.
      clear_on_cursor_move = true,
    },
    highlight_current_scope = { enable = true },
  },
  ensure_installed = {
    "lua",
    "cmake",
    "cpp",
    "c",
    "python",
    "norg",
    "norg_meta",
    "norg_table",
  },
  highlight = {
    enable = true,
    use_languagetree = true,
  },
  matchup = {
    enable = true,
  },
  rainbow = {
    enable = true,
    -- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
    extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
    max_file_lines = nil, -- Do not enable for files with more than n lines, int
    colors = {
      "#a7c080",
      "#dbbc7f",
      "#d699b6",
      "#83c092",
      "#d3c6aa",
    },
    termcolors = {
      "Red",
      "Green",
      "Yellow",
      "Blue",
      "Magenta",
      "Cyan",
      "White",
    }, -- table of hex strings
    -- termcolors = {} -- table of colour name strings
  }
}
