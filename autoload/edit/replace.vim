" ==============================================================
" Author: chxuan <787280310@qq.com>
" Repository: https://github.com/chxuan/vim-edit
" Create Date: 2018-07-19
" License: MIT
" ==============================================================

" 寄存器内容
let s:reg_content = ""

" 替换文本
function! edit#replace#replace_text()
    let m = edit#util#get_current_mode()

    if m == "n"
        return ":call ReplaceTextInNormal()\<cr>"
    elseif m == "V" || m == "v"
        let s:reg_content = @"
        return "d:call ReplaceTextInVisual()\<cr>"
    endif
endfunction

" 替换全部
function! edit#replace#replace_all(arg)
    let word = edit#util#get_current_cursor_word()
    call edit#util#replace_text_batch(word, a:arg)
endfunction

" 在正常模式下替换文本
function! ReplaceTextInNormal()
    let s:reg_content = @"
    call edit#util#delete_current_word()
    call edit#util#write_text_at_current_row(s:reg_content)
    let @" = s:reg_content
endfunction

" 在可视模式下替换文本
function! ReplaceTextInVisual()
    call edit#util#write_text_at_current_row(s:reg_content)
    let @" = s:reg_content
endfunction

