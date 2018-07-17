" ==============================================================
" Author: chxuan <787280310@qq.com>
" Repository: https://github.com/chxuan/vim-edit
" Create Date: 2018-07-17
" License: MIT
" ==============================================================

" 高亮属性
highlight default VimEdit ctermfg=red ctermbg=NONE cterm=bold,underline guifg=red guibg=NONE gui=bold,underline

" 当前光标到行末的文本
let s:tail = ""
" target_key下标集合
let s:idx = []

" 拷贝文本
function! edit#edit#copy_text()
    echo "Target key: "
    let target_key = edit#util#getchar()

    let s:tail = edit#util#get_text_to_row_tail()
    let s:idx = edit#util#find_char(s:tail, target_key)

    if empty(s:idx)
        echo "Not found target key: " . target_key
        return
    endif

    let row_text = edit#util#get_current_row_text()
    let col = <sid>get_col_num(len(row_text) - len(s:tail))
    call edit#util#show_highlight(col)

    if len(s:idx) == 1
        call timer_start(200, 'OnlyOneTargetKey', {'repeat': 1})
    else
        call timer_start(200, 'ManyTargetKeyForUser', {'repeat': 1})
    endif
endfunction

" 只有一个位置
function! OnlyOneTargetKey(timer)
    call timer_stop(a:timer)
    call <sid>get_text(0)
    call edit#util#clean_highlight()
endfunction

" 多个位置供用户选择
function! ManyTargetKeyForUser(timer)
    call timer_stop(a:timer)
    let num = edit#util#getchar()
    call <sid>get_text(num)
    call edit#util#clean_highlight()
endfunction

" 获取文本
function! s:get_text(num)
    let pos = get(s:idx, a:num - 1)
    let ret = edit#util#substr(s:tail, 0, pos + 1)
    let @" = ret
endfunction

" 获取列号
function! s:get_col_num(diff)
    let col = []
    
    for i in s:idx
        call add(col, i + 1 + a:diff)
    endfor
    
    return col
endfunction

