" ==============================================================
" Author: chxuan <787280310@qq.com>
" Repository: https://github.com/chxuan/vim-edit
" Create Date: 2018-07-17
" License: MIT
" ==============================================================

" 剪切文本
function! edit#delete#delete_text(tail, pos)
    call edit#util#erase_char_by_count(a:pos + 1)
    call edit#copy#copy_text(a:tail, a:pos)
endfunction

