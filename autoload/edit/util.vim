" ==============================================================
" Author: chxuan <787280310@qq.com>
" Repository: https://github.com/chxuan/vim-edit
" Create Date: 2018-07-17
" License: MIT
" ==============================================================

" 获得当前行号
function! edit#util#get_current_row_num()
    return line(".")
endfunction

" 获得当前行文本
function! edit#util#get_current_row_text()
    return getline(".")
endfunction

" 获取当前光标到行末的文本
function! edit#util#get_text_to_row_tail()
    execute "normal! y$"
    return @"
endfunction

" 获得子字符串
function! edit#util#substr(str, start, count)
    return strpart(a:str, a:start, a:count)
endfunction

" 查找字符,返回所有下标
function! edit#util#find_char(str, target)
    let idx = []

    for i in range(0, len(a:str) - 1)
        if a:str[i] ==# a:target
            call add(idx, i)
        endif
    endfor

    return idx
endfunction

" 从命令行获取一个字符
function! edit#util#getchar(...)
    let mode = get(a:, 1, 0)
    while 1
        " Workaround for https://github.com/osyo-manga/vital-over/issues/53
        try
            let char = call("getchar", a:000)
        catch /^Vim:Interrupt$/
            let char = 3 " <C-c>
        endtry
        " Workaround for the <expr> mappings
        if string(char) !=# "\x80\xfd`"
            return mode == 1 ? !!char : type(char) == type(0) ? nr2char(char) : char
        endif
    endwhile
endfunction

" 显示语法高亮
function! edit#util#show_highlight(col)
    execute 'highlight! link Conceal' 'VimEdit'

    setlocal conceallevel=2
    setlocal concealcursor=ncv

    let row_num = edit#util#get_current_row_num()
    for i in range(0, len(a:col) - 1)
        call matchaddpos('Conceal', [[row_num, a:col[i]]], 10, -1, {'conceal': nr2char(97 + i)})
    endfor
endfunction

" 清除语法高亮
function! edit#util#clean_highlight()
    call clearmatches()
endfunction

" 删除多个字符
function! edit#util#erase_char_by_count(count)
    for i in range(1, a:count)
        execute "normal! x"
    endfor
endfunction

" 进入插入模式
function! edit#util#enter_insert_mode()
    call feedkeys('i', 'n')
endfunction

" 获取当前模式
function! edit#util#get_current_mode()
    return mode()
endfunction

" 删除当前单词
function! edit#util#delete_current_word()
    execute "normal! diw"
endfunction

" 当前行写入文本
function! edit#util#write_text_at_current_row(text)
    execute "normal! i" . a:text
endfunction

" 获取光标下的单词
function! edit#util#get_current_cursor_word()
    return expand("<cword>")
endfunction

" 批量替换文本
function! edit#util#replace_text_batch(src, target)
    execute ':%s/\<' . a:src . '\>/' . a:target . '/g'
endfunction
