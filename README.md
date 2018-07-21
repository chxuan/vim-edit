vim-edit: A text edit plugin for vim
===============================================

![][1]

## 安装
    
- `vim-plug`

    Plug 'chxuan/vim-edit'

- `Vundle`

    Plugin 'chxuan/vim-edit'

## 使用

- `:CopyText`

    拷贝文本到某个单词

- `:DeleteText`

    剪切文本到某个单词

- `:ChangeText`

    改写文本到某个单词

- `rr`

    当执行`yiw`、`diw`等命令操作文本后，在`normal`模式下执行`rr`命令，则会替换掉当前光标所在单词，在`visual`模式下执行`rr`命令，则会替换掉选中的文本。

- `:ReplaceTo`

    执行全局替换，目前只支持单个文件

## 参考配置

请将以下配置加到 `~/.vimrc`，如果不喜欢以下映射，可根据个人喜好更改。

    nnoremap Y :CopyText<cr>
    nnoremap D :DeleteText<cr>
    nnoremap C :ChangeText<cr>
    nnoremap <leader>r :ReplaceTo<space>


## License

This software is licensed under the [MIT license][2]. © 2018 chxuan


  [1]: https://raw.githubusercontent.com/chxuan/vim-edit/master/screenshots/vim-edit.gif
  [2]: https://github.com/chxuan/vim-edit/blob/master/LICENSE
