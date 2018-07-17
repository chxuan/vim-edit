" ==============================================================
" Author: chxuan <787280310@qq.com>
" Repository: https://github.com/chxuan/vim-edit
" Create Date: 2018-07-15
" License: MIT
" ==============================================================

if exists("g:vim_edit_loaded")
    finish
endif

let g:vim_edit_loaded = 1

command! -nargs=0 CopyText call edit#edit_text("Y")
command! -nargs=0 DeleteText call edit#edit_text("D")
command! -nargs=0 ChangeText call edit#edit_text("C")

