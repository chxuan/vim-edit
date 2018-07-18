" ==============================================================
" Author: chxuan <787280310@qq.com>
" Repository: https://github.com/chxuan/vim-edit
" Create Date: 2018-07-17
" License: MIT
" ==============================================================

" 改写文本
function! edit#change#change_text(tail, pos)
    call edit#delete#delete_text(a:tail, a:pos)
    call edit#util#enter_insert_mode()
endfunction

