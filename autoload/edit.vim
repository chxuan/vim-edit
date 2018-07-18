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
" 编辑类型
let s:edit_type = ""

" 编辑文本
function! edit#edit_text(type)
    let s:edit_type = a:type
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
        call timer_start(100, 'OnlyOneTargetKey', {'repeat': 1})
    else
        call timer_start(100, 'ManyTargetKeyForUser', {'repeat': 1})
    endif
endfunction

" 只有一个位置
function! OnlyOneTargetKey(timer)
    call timer_stop(a:timer)
    call <sid>choice_edit_type(0)
    call edit#util#clean_highlight()
endfunction

" 多个位置供用户选择
function! ManyTargetKeyForUser(timer)
    call timer_stop(a:timer)
    let num = edit#util#getchar()
    call <sid>choice_edit_type(num)
    call edit#util#clean_highlight()
endfunction

" 选择编辑模式
function! s:choice_edit_type(num)
    let pos = get(s:idx, a:num - 1)

    if s:edit_type == "Y"
        call edit#copy#copy_text(s:tail, pos)
    elseif s:edit_type == "D"
        call edit#delete#delete_text(s:tail, pos)
    elseif s:edit_type == "C"
        call edit#change#change_text(s:tail, pos)
    endif
endfunction

" 获取列号
function! s:get_col_num(diff)
    let col = []
    
    for i in s:idx
        call add(col, i + 1 + a:diff)
    endfor
    
    return col
endfunction

