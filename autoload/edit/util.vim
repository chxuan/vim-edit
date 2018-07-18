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
        if a:str[i] == a:target
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
    let row_num = edit#util#get_current_row_num()
    for c in a:col
        call matchaddpos('VimEdit', [[row_num, c]])
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
