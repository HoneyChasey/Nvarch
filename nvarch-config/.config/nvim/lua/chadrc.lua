-- This file needs to have same structure as nvconfig.lua 
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :( 

---@type ChadrcConfig
local M = {}

M.base46 = {
	theme = "bearded-arc",

	-- hl_override = {
	-- 	Comment = { italic = true },
	-- 	["@comment"] = { italic = true },
	-- },
}

 M.ui = {
   statusline = {
     theme = "minimal", -- to see default theme and separator_style, please enter the command :h nvui
     separator_style = "round",
    default = { "mode", "file", "git", "%=", "lsp_msg", "%=", "diagnostics", "lsp", "cwd", "cursor" },
    modules = {
       abc = function()
         return "hi"
       end,

       xyz =  "hi",
       f = "%F"
     }
   },
 }

M.nvdash = {
  load_on_startup = true,
  header = {
    "                             +         ",
    "              --  --  ---    -++      ",
    "          ------------------- ----=   ",
    "        *--=******####*****---*--=-.  ",
    " ..    *+++++#******##########=*+--.. ",
    " .:=  ++ ++++:########## #== ###=+*+..",
    "..=-= #++  ++*########## #### ##----..",
    "..==-##+++++*#--:::---###    ####*--..",
    "..--=#*++:*-----::-----#+++++**##=+--.",
    "..---:*+===----:-:-----.======**----..",
    " ..--=*+=====================+*#-=-.. ",
    "  ..---**+=================++*+--...  ",
    "   ...-=- *+=============+*#---..     ",
    "       ..---:**# #####+##-=-..        ",
    "           ..-=-:     :--..           ",
    "              +.-:-=+:-::             ",
    "              --.:-:-  :-.            ",
    "               ::-:=+.+:              ",
    "               .::-  +:.              ",
    "                                      ",
    "        Power by lua language      ",
    "                                      "

  }
}

return M
