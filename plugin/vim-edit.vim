" ==============================================================
" Author: chxuan <787280310@qq.com>
" Repository: https://github.com/chxuan/vim-edit
" Create Date: 2018-07-15
" License: MIT
" ==============================================================

if exists("g:vim_edit_loaded")
    finish
endif

let g:vim_edit_loaded = 1

command! -nargs=0 CopyText call <sid>copy_text()

highlight default VimEdit ctermfg=red ctermbg=NONE cterm=bold,underline guifg=red guibg=NONE gui=bold,underline

" 当前行文本
let s:row_text = ""
" 高亮字符
let s:hi_char = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]

" 拷贝文本
function! s:copy_text()
    echo "Target key: "
    let c = <sid>getchar()

    call <sid>clean_highlight()

    let s:row_text = <sid>get_current_row_text()
    let tail = <sid>get_text_to_row_tail()
    let idx = <sid>find_char(tail, c)
    " echo idx

    if empty(idx)
        echo "Not found target key:" . c
        return
    endif

    let col = <sid>get_col_num(idx, len(s:row_text) - len(tail))

    let hi_text = <sid>get_highlight_text(col)
    " echo ret
    
    call <sid>delete_current_row()
    call <sid>write_text_at_current_row(hi_text . "\n")
    execute "normal! =2="

    " let row_num = <sid>get_current_row_num()
    " for c in col
    "     call matchaddpos('VimEdit', [[row_num, c]])
    " endfor

    " let pos = <sid>find(text, c)
    " let ret = <sid>substr(text, 0, pos + 1)
    " let @" = ret

    " call matchaddpos('VimEdit', [[6, 6]])
endfunction

" 从命令行获取一个字符
function! s:getchar(...)
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

" 获取当前光标到行末的文本
function! s:get_text_to_row_tail()
    execute "normal! y$"
    return @"
endfunction

" 查找字符,返回所有下标
function! s:find_char(str, target)
    let idx = []

    for i in range(0, len(a:str) - 1)
        if a:str[i] == a:target
            call add(idx, i)
        endif
    endfor

    return idx
endfunction

" 获取列号
function! s:get_col_num(idx, diff)
    let col = []
    
    for i in a:idx
        call add(col, i + 1 + a:diff)
    endfor
    
    return col
endfunction

" 获取高亮的文本
function! s:get_highlight_text(col)
    let text = ""
    let pos = 0

    for i in range(0, len(s:row_text) - 1)
        if <sid>is_contain_list(a:col, i + 1)
            let text = text . s:hi_char[pos]
            let pos += 1
        else
            let text = text . s:row_text[i]
        endif
    endfor

    return text
endfunction

" 获得子字符串
function! s:substr(str, start, count)
    return strpart(a:str, a:start, a:count)
endfunction

" 清除语法高亮
function! s:clean_highlight()
    call clearmatches()
endfunction

" 获得当前行号
function! s:get_current_row_num()
    return line(".")
endfunction

" 获得当前行文本
function! s:get_current_row_text()
    return getline(".")
endfunction

" 判断列表包含
function! s:is_contain_list(list, target)
    for val in a:list
        if val == a:target
            return 1
        endif
    endfor

    return 0
endfunction

" 删除当前行
function! s:delete_current_row()
    execute "normal! dd"
endfunction

" 在当前行写入文本
function! s:write_text_at_current_row(text)
    execute "normal! i" . a:text
endfunction

