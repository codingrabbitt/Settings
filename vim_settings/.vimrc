" Make external commands work through a pipe instead of a pseudo-tty
"set noguipty

" You can also specify a different font, overriding the default font
"if has('gui_gtk2')
"  set guifont=Bitstream\ Vera\ Sans\ Mono\ 12
"else
"  set guifont=-misc-fixed-medium-r-normal--14-130-75-75-c-70-iso8859-1
"endif

" If you want to run gvim with a dark background, try using a different
" colorscheme or running 'gvim -reverse'.
" http://www.cs.cmu.edu/~maverick/VimColorSchemeTest/ has examples and
" downloads for the colorschemes on vim.org

" Source a global configuration file if available
if filereadable("/etc/vim/gvimrc.local")
  source /etc/vim/gvimrc.local
endif

source $VIMRUNTIME/vimrc_example.vim

source $VIMRUNTIME/mswin.vim

behave mswin



set diffexpr=MyDiff()

function MyDiff()

  let opt = '-a --binary '

  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif

  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif

  let arg1 = v:fname_in

  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif

  let arg2 = v:fname_new

  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif

  let arg3 = v:fname_out

  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif

  let eq = ''

  if $VIMRUNTIME =~ ' '

    if &sh =~ '\<cmd'

      let cmd = '""' . $VIMRUNTIME . '\diff"'

      let eq = '"'

    else

      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'

    endif

  else

    let cmd = $VIMRUNTIME . '\diff'

  endif

  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq

endfunction


set encoding=utf-8
set fileformat=unix

"对齐设置
set autoindent
set smartindent
set cindent


"配色主题设置
colorscheme molokai
let g:molokai_original = 1
let g:rehash256 = 1
set t_Co=256

"缩进相关设置
set expandtab
set shiftwidth=4
set tabstop=4
set backspace=2
set softtabstop=4


set laststatus=2
let python_highlight_all=1


"快捷键映射
let mapleader="\<Space>"
nnoremap <Leader>s :w<CR>
nnoremap <Leader>w :wq!<CR>
nnoremap <Leader>q :q!<CR>
nnoremap <Leader>i gg=G
nnoremap <Leader>tn :tabn<CR>
nnoremap <Leader>tp :tabp<CR>
nnoremap <Leader>tc :tabc<CR>
nnoremap <Leader>to :tabo<CR>
nnoremap <Leader>b <C-b>
nnoremap <Leader>n <C-f>
nnoremap <Leader>l <C-w>l
nnoremap <Leader>h <C-w>h
nnoremap <Leader>/ :nohl<CR>
nnoremap <silent> <Up> :vertical res+5<CR>
nnoremap <silent> <Down> :vertical res-5<CR>
nnoremap <silent> <Left> :bp<CR>
nnoremap <silent> <Right> :bn<CR>
vmap <Leader>c "+y
nnoremap <Leader>p "+P
nnoremap <CR> G
vmap <CR> G
nnoremap <BS> gg
vmap <BS> gg
"键盘映射-.python
nnoremap <Leader>z za
"YouCompleteMe 快捷键
nnoremap <Leader>ff :YcmCompleter GoToDeclaration<CR>
nnoremap <Leader>fg :YcmCompleter GoToDefinition<CR>
"inoremap <tab> <C-p>
"Syntastic检查 快捷键
nnoremap <Leader>cc :SyntasticCheck<CR>
nnoremap <Leader>cn :SyntasticToggleMode<CR>
"Taglist
nnoremap <Leader>tl :TlistToggle<CR>

"界面设置
set guioptions-=l
set guioptions-=L
set guioptions-=r
set guioptions-=R
set guioptions-=m
"set guioptions-=T
set ruler
set cursorline
set cursorcolumn
set hlsearch
set showmatch
set nobackup
set nu "行号

"字体设置
if has("gui_gtk2")
set guifont=YaHei\ Consolas\ Hybrid\ 14
elseif has("gui_macvim")
set guifont=DejaVu_Sans_Mono:h14
elseif has("gui_win32")
set guifont=DejaVu_Sans_Mono:h14
end

"插件设置
"pathogen
execute pathogen#infect()
syntax enable
syntax on
filetype on
filetype indent on
filetype plugin on

"Github
autocmd Filetype gitcommit setlocal spell textwidth=80

"NERDtree
" 使用 NERDTree 插件查看工程文件。设置快捷键，速记：file list
nmap <Leader>fl :NERDTreeToggle<CR>
" 设置NERDTree子窗口宽度
let NERDTreeWinSize=32
" 设置NERDTree子窗口位置
let NERDTreeWinPos="right"
" 显示隐藏文件
let NERDTreeShowHidden=1
" NERDTree 子窗口中不显示冗余帮助信息
let NERDTreeMinimalUI=1
" 删除文件时自动删除文件对应 buffer
let NERDTreeAutoDeleteBuffer=1


"Emmet
let g:user_emmet_install_global=0
autocmd FileType html,css,php EmmetInstall
let g:user_emmet_next_key='<C-y>y'
let g:user_emmet_prev_key='<C-y>t'

"Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0

"Taglist
let Tlist_Use_Right_Window = 1  "让taglist窗口出现在Vim的右边
let Tlist_File_Fold_Auto_Close = 1 "当同时显示多个文件中的tag时，设置为1，可使taglist只显示当前文件tag，其它文件的tag都被折叠起来。
let Tlist_Show_One_File = 1 "只显示一个文件中的tag，默认为显示多个
let Tlist_Sort_Type ='name' "Tag的排序规则，以名字排序。默认是以在文件中出现的顺序排序
let Tlist_GainFocus_On_ToggleOpen = 1 "Taglist窗口打开时，立刻切换为有焦点状态
let Tlist_Exit_OnlyWindow = 1 "如果taglist窗口是最后一个窗口，则退出vim
let Tlist_WinWidth = 32 "设置窗体宽度为32，可以根据自己喜好设置
let Tlist_Ctags_Cmd ='/usr/local/Cellar/ctags/5.8_1/bin/ctags' "这里比较重要了，设置ctags的位置，不是指向MacOS自带的那个，而是我们用homebrew安装的那个


map <f5> :call CR2()<cr>

func CR2()

if &filetype=="cpp"

	exec "!g++ %<.cpp -o %< && ./%<"

elseif &filetype=="c"

	exec "!gcc %<.c -o %< && ./%<"

elseif &filetype=="python"

	exec "!python \"./%<.py\""

endif

endfunc



map <f2> :call Running()<cr>

func Running()

exec "!g++ %<.cpp -o %< && %< <input.txt"

endfunc





map <F12> :call TitleDet()<cr>'s

function AddTitle()

    call append(0,"/*")

    call append(1,"# Author: David - youchen.du@gmail.com")

    call append(2,"# QQ : 449195172")

    call append(3,"# Last modified:    ".strftime("%Y-%m-%d %H:%M"))

    call append(4,"# Filename:     ".expand("%:t"))

    call append(5,"# Description: ")

    call append(6,"*/")

    echohl WarningMsg | echo "Successful in adding the copyright." | echohl None

endf

"更新最近修改时间和文件名

function UpdateTitle()

    normal m'

    execute '/# *Last modified:/s@:.*$@\=strftime(":\t%Y-%m-%d %H:%M")@'

    normal ''

    normal mk

    execute '/# *Filename:/s@:.*$@\=":\t\t".expand("%:t")@'

    execute "noh"

    normal 'k

    echohl WarningMsg | echo "Successful in updating the copy right." | echohl None

endfunction

"判断前10行代码里面，是否有Last modified这个单词，

"如果没有的话，代表没有添加过作者信息，需要新添加；

"如果有的话，那么只需要更新即可

function TitleDet()

    let n=1

    "默认为添加

    while n < 10

        let line = getline(n)

        if line =~ '^\#\s*\S*Last\smodified:\S*.*$'

            call UpdateTitle()

            return

        endif

        let n = n + 1

    endwhile

    call AddTitle()

endfunction

"Vundle
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'mattn/emmet-vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'scrooloose/syntastic'
Plugin 'vim-scripts/indentpython'
Plugin 'nvie/vim-flake8'
Plugin 'Lokaltog/vim-powerline'
Bundle 'taglist.vim'
call vundle#end()
filetype plugin indent on
