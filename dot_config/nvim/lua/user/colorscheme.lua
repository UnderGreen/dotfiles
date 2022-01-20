vim.cmd [[
try
  let g:vscode_style = "dark"
  let g:vscode_transparency = 1
  let g:vscode_italic_comment = 1
  colorscheme vscode
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
  set background=dark
endtry
]]
