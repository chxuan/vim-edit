" ==============================================================
" Author: chxuan <787280310@qq.com>
" Repository: https://github.com/chxuan/vim-edit
" Create Date: 2020-03-29
" License: MIT
" ==============================================================

" 旋转文本
function! edit#reverse#reverse_text()
    let m = edit#util#get_current_mode()

    if m == "n"
        return ":call ReverseTextInNormal()\<cr>"
    elseif m == "V" || m == "v"
        return "d:call ReverseTextInVisual()\<cr>"
    endif
endfunction

" 在正常模式下旋转文本
function! ReverseTextInNormal()
    let word = edit#util#get_current_cursor_word()
    let text = edit#util#reverse(word)
    call edit#util#delete_current_word()
    call edit#util#write_text_at_current_row(text)
endfunction

" 在可视模式下旋转文本
function! ReverseTextInVisual()
    let text = @"
    let text = edit#util#reverse(text)
    call edit#util#write_text_at_current_row(text)
endfunction

