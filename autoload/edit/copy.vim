" ==============================================================
" Author: chxuan <787280310@qq.com>
" Repository: https://github.com/chxuan/vim-edit
" Create Date: 2018-07-17
" License: MIT
" ==============================================================

" 拷贝文本
function! edit#copy#copy_text(tail, pos)
    let ret = edit#util#substr(a:tail, 0, a:pos + 1)
    let @" = ret
endfunction

