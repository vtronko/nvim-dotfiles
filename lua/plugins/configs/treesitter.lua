local present, ts_config = pcall(require, "nvim-treesitter.configs")
if not present then
   return
end

ts_config.setup {
   ensure_installed = {
      "lua",
      "cmake",
      "cpp",
      "c",
      "python"
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
