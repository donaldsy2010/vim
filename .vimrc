set number
set helplang=cn
set ai      
set bs=2
set showmatch
set autoread
set autoindent
set pastetoggle=<F9>
set mouse=a 
"donald
set ruler
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}   "状态行显示的内容   
hi Comment ctermfg =cyan


syntax on
set smartindent

"tab
set tabstop=4
set expandtab
set shiftwidth=4

" line
set cursorline
set hls

set nocompatible              " be iMproved, required
set encoding=utf-8

filetype plugin indent on     " required

autocmd BufRead,BufNewFile *.html.erb setlocal filetype=eruby

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'tpope/vim-rails.git'
Bundle 'git@github.com:scrooloose/nerdtree.git'
Bundle 'git@github.com:Raimondi/delimitMate.git'
Bundle 'hallison/vim-markdown'
Bundle 'git@github.com:kien/ctrlp.vim.git'
Bundle 'msanders/snipmate.vim'
Bundle 'Lokaltog/vim-powerline'

" Powerline
"set guifont=PowerlineSymbols\ for\ Powerline
"set nocompatible
"set laststatus=2
"set t_Co=256
"let g:Powerline_symbols = 'fancy'
"let Powerline_symbols='compatible'

" NEADTree
autocmd vimenter * if !argc() | NERDTree | endif
map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" CtrlP
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'

autocmd BufNewFile *.cpp,*.[ch],*.sh,*.java exec ":call SetTitle()" 
""定义函数SetTitle，自动插入文件头 
func SetTitle() 
	"如果文件类型为.sh文件 
	if &filetype == 'sh' 
		call setline(1,"\#########################################################################") 
set ruler
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}   "状态行显示的内容   
        call append(line("."),   " > Copyright (C)".strftime("%Y")."All rights reserved" )
		call append(line(".")+1, "\# File Name: ".expand("%:t")) 
		call append(line(".")+2, "\# Author: donald") 
		call append(line(".")+3, "\# Created Time: ".strftime("%Y/%m/%d/ %R:%S")) 
        call append(line(".")+4, "\# details:")
		call append(line(".")+5, "\#########################################################################") 
		call append(line(".")+6, "\#!/bin/bash") 
		call append(line(".")+7, "") 
	else 
		call setline(1, "/*===========================================") 
        call append(line("."),   "  > Copyright (C)".strftime("%Y")."All rights reserved" )
		call append(line(".")+1, "  > File Name: ".expand("%:t")) 
		call append(line(".")+2, "  > Author: Donald") 
		call append(line(".")+3, "  > Created Time: ".strftime("%Y/%m/%d/ %R:%S")) 
        call append(line(".")+4, "  > details:")
		call append(line(".")+5, "=============================================*/") 
		call append(line(".")+6, "")
	endif   
""	if &filetype == 'cpp'
"""		call append(line(".")+6, "#include<iostream>")
"		call append(line(".")+7, "using namespace std;")
"		call append(line(".")+8, "")
"	endif
"	if &filetype == 'c'
"		call append(line(".")+6, "#include<stdio.h>")
"		call append(line(".")+7, "")
"	endif
	"	if &filetype == 'java'
	"		call append(line(".")+6,"public class ".expand("%"))
	"		call append(line(".")+7,"")
	"	endif
	"新建文件后，自动定位到文件末尾
	autocmd BufNewFile * normal G
endfunc
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"键盘命令
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

nmap <leader>w :w!<cr>
nmap <leader>f :find<cr>

" 映射全选+复制 ctrl+a
map <C-A> ggVG
map! <C-A> <Esc>ggVGY
map <F12> gg=G
" 选中状态下 Ctrl+c 复制
vmap <C-c> "+y
"去空行  
nnoremap <F2> :g/^\s*$/d<CR> 
"比较文件  
nnoremap <C-F2> :vert diffsplit 
"新建标签  
map <M-F2> :tabnew<CR>  
"列出当前目录文件  
map <F3> :tabnew .<CR>  
"打开树状文件目录  
map <C-F3> \be  
"C，C++ 按F5编译运行
map <F5> :call CompileRunGcc()<CR>
func! CompileRunGcc()
	exec "w"
	if &filetype == 'c'
		exec "!g++ % -o %<"
		exec "! ./%<"
	elseif &filetype == 'cpp'
		exec "!g++ % -o %<"
		exec "! ./%<"
	elseif &filetype == 'java' 
		exec "!javac %" 
		exec "!java %<"
	elseif &filetype == 'sh'
		:!./%
	elseif &filetype == 'py'
		exec "!python %"
		exec "!python %<"
	endif
endfunc
"C,C++的调试
map <F8> :call Rungdb()<CR>
func! Rungdb()
	exec "w"
	exec "!g++ % -g -o %<"
	exec "!gdb ./%<"
endfunc
