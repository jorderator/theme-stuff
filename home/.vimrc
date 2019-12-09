" All system-wide defaults are set in $VIMRUNTIME/archlinux.vim (usually just
" /usr/share/vim/vimfiles/archlinux.vim) and sourced by the call to :runtime
" you can find below.  If you wish to change any of those settings, you should
" do it in this file (/etc/vimrc), since archlinux.vim will be overwritten
" everytime an upgrade of the vim packages is performed.  It is recommended to
" make changes after sourcing archlinux.vim since it alters the value of the
" 'compatible' option.

" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages.
runtime! archlinux.vim

" If you prefer the old-style vim functionalty, add 'runtime! vimrc_example.vim'
" Or better yet, read /usr/share/vim/vim80/vimrc_example.vim or the vim manual
" and configure vim to your own liking!

" do not load defaults if ~/.vimrc is missing
"let skip_defaults_vim=1


" Download and install vim-plug if it is not already installed
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Plugin list:
call plug#begin('~/.vim/plugged')

Plug 'w0rp/ale'
Plug '/usr/bin/fzf'
Plug 'junegunn/fzf.vim'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'

call plug#end()


" Key mappings:
nmap <C-f> :Buffers<CR>
nmap <C-p> :Files<CR>
nmap <C-t> :TableFormat<CR>
vnoremap <C-C> :w !xclip -i -sel c<CR><CR>


" Status line stuff:
set laststatus=2

"  get the current amount of uncommited changes to the file, if in a git
"  repository
function! GitChanges()
	let l:diffOut = system("git diff --numstat " . @%)
	if diffOut || diffOut[0] == "0"
		let l:diffList = split(diffOut)
		let l:diffAmount = diffList[0] + diffList[1]
		return diffAmount? " | " . diffAmount : ""
	else
		return ""
	endif
endfunction

"  use {:so $VIMRUNTIME/syntax/hitest.vim} to get colour list
set statusline=%#DiffAdd#
set statusline+=\ %f
set statusline+=\ %r%m
set statusline+=\ %#ErrorMsg#%=
set statusline+=\ %p%%
set statusline+=\ \|\ %l\-%L
"set statusline+=%{GitChanges()}
set statusline+=\ 


" Other visual stuff:
set number
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }
