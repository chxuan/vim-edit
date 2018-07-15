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

command! -nargs=1 CopyText call <sid>copy_text(<f-args>)

" 拷贝文本
function! s:copy_text(arg)
    let text = <sid>get_text_to_row_tail()
    let pos = <sid>find(text, a:arg)
    let ret = <sid>substr(text, 0, pos + 1)
    let @" = ret
endfunction

" 获取当前光标到行末的文本
function! s:get_text_to_row_tail()
    execute "normal! y$"
    return @"
endfunction

" 查找字符串
function! s:find(str, target)
    return stridx(a:str, a:target)
endfunction

" 获得子字符串
function! s:substr(str, start, count)
    return strpart(a:str, a:start, a:count)
endfunction

