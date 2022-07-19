local cmd = vim.cmd

local colors = require("colors").get()

local black = colors.black
local black2 = colors.black2
local blue = colors.blue
local darker_black = colors.darker_black
local folder_bg = colors.folder_bg
local green = colors.green
local grey = colors.grey
local grey_fg = colors.grey_fg
local grey_fg2 = colors.grey_fg2
local line = colors.line
local nord_blue = colors.nord_blue
local one_bg = colors.one_bg
local one_bg2 = colors.one_bg2
local pmenu_bg = colors.pmenu_bg
local purple = colors.purple
local red = colors.red
local white = colors.white
local yellow = colors.yellow
local cyan = colors.cyan

local ui = require("core.utils").load_config().ui

-- Define bg color
-- @param group Group
-- @param color Color
local function bg(group, color)
   cmd("hi " .. group .. " guibg=" .. color)
end

-- Define fg color
-- @param group Group
-- @param color Color
local function fg(group, color)
   cmd("hi " .. group .. " guifg=" .. color)
end

local function italic(group)
  cmd("hi " .. group .. " gui=italic")
end

-- Define bg and fg color
-- @param group Group
-- @param fgcol Fg Color
-- @param bgcol Bg Color
local function fg_bg(group, fgcol, bgcol)
   cmd("hi " .. group .. " guifg=" .. fgcol .. " guibg=" .. bgcol)
end

-- Comments
if ui.italic_comments then
   fg("Comment", grey_fg .. " gui=italic")
else
   fg("Comment", grey_fg)
end

-- -- Disable cusror line
-- cmd "hi clear CursorLine"
-- Line number
fg("cursorlinenr", white)

-- same it bg, so it doesn't appear
fg("EndOfBuffer", black)

-- For floating windows
fg("FloatBorder", blue)
bg("NormalFloat", one_bg)

-- Pmenu
bg("Pmenu", one_bg)
bg("PmenuSbar", one_bg2)
bg("PmenuSel", pmenu_bg)
bg("PmenuThumb", nord_blue)

-- misc
fg("LineNr", grey)

fg("NvimInternalError", red)

-- inactive statuslines as thin splitlines
fg("StatusLineNC", one_bg2 .. " gui=underline")
fg("VertSplit", one_bg2)
-- fg_bg("Visual",light_grey, colors.lightbg)

if ui.transparency then
   bg("Normal", "NONE")
   bg("Folded", "NONE")
   fg("Folded", "NONE")
   fg("Comment", grey)
end

-- [[ Plugin Highlights

-- Dashboard
fg("DashboardCenter", grey_fg)
fg("DashboardFooter", grey_fg)
fg("DashboardHeader", grey_fg)
fg("DashboardShortcut", grey_fg)

-- Git signs
fg_bg("DiffAdd", green, "none")
fg_bg("DiffChange", yellow, "none")
fg_bg("DiffModified", nord_blue, "none")
fg_bg("DiffDelete", red, "none")

-- Indent blankline plugin
fg("IndentBlanklineChar", line)

-- ]]

-- [[ LspDiagnostics

-- Errors
fg("DiagnosticError", red)
fg("DiagnosticWarn", yellow)
fg("DiagnosticInfo", green)
fg("DiagnosticHint", grey_fg2)

-- Info
fg("DiagnosticSignInformation", green)
fg("DiagnosticVirtualTextInformation", green)

-- Hints
fg("DiagnosticSignHint", purple)
fg("DiagnosticVirtualTextHint", purple)

-- ]]


fg("BookmarkSign", blue)

-- NvimTree
fg("NvimTreeEmptyFolderName", blue)
fg("NvimTreeEndOfBuffer", darker_black)
fg("NvimTreeFolderIcon", folder_bg)
fg("NvimTreeFolderName", folder_bg)
fg("NvimTreeGitDirty", red)
fg("NvimTreeIndentMarker", one_bg2)
bg("NvimTreeNormal", darker_black)
fg("NvimTreeOpenedFolderName", blue)
fg("NvimTreeRootFolder", red .. " gui=underline") -- enable underline for root folder in nvim tree
fg_bg("NvimTreeStatuslineNc", darker_black, darker_black)
fg("NvimTreeVertSplit", darker_black)
bg("NvimTreeVertSplit", darker_black)
fg_bg("NvimTreeWindowPicker", red, black2)

-- Disable some highlight in nvim tree if transparency enabled
-- if ui.transparency then
--    bg("NvimTreeNormal", "NONE")
--    bg("NvimTreeStatusLineNC", "NONE")
--    bg("NvimTreeVertSplit", "NONE")
--    fg("NvimTreeVertSplit", grey)
-- end

-- Telescope
fg("TelescopeBorder", line)
fg("TelescopePreviewBorder", grey)
fg("TelescopePromptBorder", line)
fg("TelescopeResultsBorder", line)

-- nvim-dap
fg("DapBreakpoint", red)
fg("DapStopped", yellow)

fg("HopNextKey", red)
fg("HopNextKey1", green)
fg("HopNextKey2", cyan)

italic("TSDefinitionUsage")
