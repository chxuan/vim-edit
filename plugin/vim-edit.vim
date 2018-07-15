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

highlight default VimEdit ctermfg=red ctermbg=NONE cterm=bold,underline guifg=red guibg=NONE gui=bold,underline

" 拷贝文本
function! s:copy_text(arg)
    call <sid>clean_highlight()
    let text = <sid>get_text_to_row_tail()
    let pos = <sid>find(text, a:arg)
    let ret = <sid>substr(text, 0, pos + 1)
    let @" = ret

    let regex = '\%' . line('.') . 'l' . a:arg
    call matchadd('VimEdit', regex, 999)
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

" 清除语法高亮
function! s:clean_highlight()
    for h in filter(getmatches(), 'v:val.group ==# "VimEdit"')
        call matchdelete(h.id)
    endfor
endfunction
