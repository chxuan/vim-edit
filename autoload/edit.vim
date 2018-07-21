" ==============================================================
" Author: chxuan <787280310@qq.com>
" Repository: https://github.com/chxuan/vim-edit
" Create Date: 2018-07-17
" License: MIT
" ==============================================================

" 高亮属性
highlight default VimEdit ctermfg=196 ctermbg=NONE cterm=bold guifg=red guibg=NONE gui=bold

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

    let size = len(s:idx)
    if size == 1
        call <sid>check_edit_type("a")
    elseif size > 1
        let row_text = edit#util#get_current_row_text()
        let col = <sid>get_col_num(len(row_text) - len(s:tail))
        call edit#util#show_highlight(col)
        call timer_start(0, 'SelectHighlightChar', {'repeat': 1})
    else
        echo "Not found target key: " . target_key
    endif
endfunction

" 选择高亮字符
function! SelectHighlightChar(id)
    call timer_stop(a:id)
    let char = edit#util#getchar()
    call <sid>check_edit_type(char)
    call edit#util#clean_highlight()
endfunction

" 判断编辑类型
function! s:check_edit_type(char)
    let i = char2nr(a:char) - 97
    let pos = get(s:idx, i)

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

