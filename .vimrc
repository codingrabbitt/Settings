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





set autoindent

set cindent


set backspace=2

set nu

set background=dark

set nobackup

colorscheme molokai
let g:molokai_original = 1
let g:rehash256 = 1
set t_Co=256

set ts=4

set showmatch

let python_highlight_all=1

let mapleader="\<Space>"
nnoremap <Leader>s :w<CR>
nnoremap <Leader>w :wq<CR>
nnoremap <Leader>q :q!<CR>
nnoremap <Leader>i gg=G
nnoremap <Leader><Leader> a
nnoremap <CR> G
nnoremap <BS> gg

set guioptions-=l
set guioptions-=L
set guioptions-=r
set guioptions-=R
set guioptions-=m
set guioptions-=T
set ruler
set cursorline
set cursorcolumn
set hlsearch

if has("gui_gtk2")
set guifont=YaHei\ Consolas\ Hybrid\ 14
elseif has("gui_macvim")
set guifont=DejaVu_Sans_Mono:h14
elseif has("gui_win32")
set guifont=DejaVu_Sans_Mono:h14
end

syntax enable
syntax on
filetype indent on

set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4



map <f5> :call CR2()<cr>

func CR2()

if &filetype=="cpp"

	exec "!g++ %<.cpp -o %< && %<"

elseif &filetype=="c"

	exec "!gcc %<.c -o %< && %<"

elseif &filetype=="python"

	exec "!python \"%<.py\""

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





 



inoremap <tab> <C-p>
