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

"Vundle
set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'nvie/vim-flake8'
Plugin 'Lokaltog/vim-powerline'
Bundle 'taglist.vim'
call vundle#end()
filetype plugin indent on

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

"退出
nnoremap <Leader>s :w<CR>
nnoremap <Leader>w :wq!<CR>
nnoremap <Leader>e :call TitleDet()<CR>:wq!<CR>
nnoremap <Leader>q :q!<CR>

"对齐
nnoremap <Leader>i gg=G

"TAB相关
nnoremap <Leader>tn :tabn<CR>
nnoremap <Leader>tp :tabp<CR>
nnoremap <Leader>tc :tabc<CR>
nnoremap <Leader>to :tabo<CR>

"翻页
nnoremap <Leader>b <C-b>
nnoremap <Leader>n <C-f>

"切换窗口
nnoremap <Leader>l <C-w>l
nnoremap <Leader>h <C-w>h
nnoremap <Leader>j <C-w>j
nnoremap <Leader>k <C-w>k

"重做
nnoremap <Leader>u <C-r>

"取消查询结果高亮
nnoremap <Leader>/ :nohl<CR>

"垂直分割大小调整
nnoremap <silent> <Up> :res+5<CR>
nnoremap <silent> <Down> :res-5<CR>
nnoremap <silent> <Left> :vertical res-5<CR>
nnoremap <silent> <Right> :vertical res+5<CR>

"缓冲区切换
nnoremap <tab> :bp<CR>

"复制粘贴
vmap <Leader>c "+y
nnoremap <Leader>p "+P

"文件头尾跳转
nnoremap <CR> G
vmap <CR> G
nnoremap <BS> gg
vmap <BS> gg

"YouCompleteMe 快捷键
nnoremap <Leader>ff :YcmCompleter GoToDeclaration<CR>
nnoremap <Leader>fg :YcmCompleter GoToDefinition<CR>

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

"设置持久撤销
let $VIMTEMP = $VIMFILES.'/tmp'
if v:version >= 703
set undofile
set undodir=$VIMTEMP
set undolevels=1000 "maximum number of changes that can be undone
set undoreload=10000 "maximum number lines to save for undo on a buffer
endif

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

"Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0

"Taglist
let Tlist_Use_Right_Window = 1
let Tlist_File_Fold_Auto_Close = 1 
let Tlist_Show_One_File = 1
let Tlist_Sort_Type ='name' 
let Tlist_GainFocus_On_ToggleOpen = 1 
let Tlist_Exit_OnlyWindow = 1 
let Tlist_WinWidth = 32 
let Tlist_Ctags_Cmd ='/usr/local/Cellar/ctags/5.8_1/bin/ctags' 

"运行
map <Leader>r :call CR2()<cr>
func CR2()
    if &filetype=="cpp"
        exec "!g++ %<.cpp -o %< && ./%<"
    elseif &filetype=="c"
        exec "!gcc %<.c -o %< && ./%<"
    elseif &filetype=="python"
        exec "!python \"./%<.py\""
    endif
endfunc

function AddTitle()
    if &filetype=="cpp"
        let prefix = '//'
        let start = 0
    elseif &filetype=="c"
        let prefix = '//'
        let start = 0
    elseif &filetype=="python"
        let prefix = '#'
        call append(0,"#!/usr/bin/python")
        call append(1,"# coding: UTF-8")
        let start = 2
    else
        return
    endif
    call append(start,prefix." Author: David")
    call append(start+1,prefix." Email: youchen.du@gmail.com")
    call append(start+2,prefix." Created: ".strftime("%Y-%m-%d %H:%M"))
    call append(start+3,prefix." Last modified: ".strftime("%Y-%m-%d %H:%M"))
    call append(start+4,prefix." Filename: ".expand("%:t"))
    call append(start+5,prefix." Description:")
    echohl WarningMsg | echo "Successful in adding the copyright." | echohl None

endf

"更新最近修改时间和文件名

function UpdateTitle()
    if &filetype=="cpp"
        let prefix = '\/\/'
    elseif &filetype=="c"
        let prefix = '\/\/'
    elseif &filetype=="python"
        let prefix = '#'
    else
        return
    endif
    normal m'
    execute '/'.prefix.' Last modified:/s@:.*$@\=strftime(": %Y-%m-%d %H:%M")@'
    normal ''
    normal mk
    execute '/'.prefix.' Filename:/s@:.*$@\=": ".expand("%:t")@'
    execute "noh"
    normal 'k
    echohl WarningMsg | echo "Successful in updating the copy right." | echohl None
endfunction

function TitleDet()
    if &filetype=="cpp"
        let prefix = '\/\/'
    elseif &filetype=="c"
        let prefix = '\/\/'
    elseif &filetype=="python"
        let prefix = '#'
    else
        return
    endif
    let n=1
    "默认为添加
    while n < 10
        let line = getline(n)
        if line =~ '^'.prefix.'\sLast\smodified:\s*.*$'
            call UpdateTitle()
            return
        endif
        let n = n + 1
    endwhile
    call AddTitle()
endfunction


