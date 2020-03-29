" ==============================================================
" Author: chxuan <787280310@qq.com>
" Repository: https://github.com/chxuan/vim-edit
" Create Date: 2020-03-29
" License: MIT
" ==============================================================

" 旋转文本
function! edit#reverse#reverse_text()
    return ":call ReverseTextInNormal()\<cr>"
endfunction

function! ReverseTextInNormal()
    let word = edit#util#get_current_cursor_word()
    let text = edit#util#reverse(word)
    call edit#util#delete_current_word()
    call edit#util#write_text_at_current_row(text)
endfunction

