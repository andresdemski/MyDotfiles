set nocompatible
set wildmenu
let &t_Co=256
set term=screen-256color
filetype off                  " required

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'bling/vim-airline'
Plugin 'scrooloose/nerdtree'
Plugin 'bling/vim-bufferline'
Plugin 'edkolev/tmuxline.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'majutsushi/tagbar'
Plugin 'tpope/vim-commentary'
Plugin 'scrooloose/syntastic'
Plugin 'kien/ctrlp.vim'
" Plugin 'fholgado/minibufexpl.vim'
Plugin 'christoomey/vim-tmux-navigator'
" Plugin 'lrvick/Conque-Shell'
" Plugin 'Valloric/YouCompleteMe'
Plugin 'vim-scripts/Conque-GDB'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required


if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

" unicode symbols
let g:airline_left_sep = '▶'
let g:airline_right_sep = '◀'
let g:airline_symbols.crypt = '🔒'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.whitespace = 'Ξ'
" let g:airline#extensions#tabline#enabled = 1
let  g:tmuxline_powerline_separators = 0

set laststatus=2
set number
let g:airline_theme='luna'

" Borrar un caracter sin cambiar el default reg
noremap x "_x

" Save and paste faster using registers
vnoremap 11 "1y
vnoremap 22 "2y
vnoremap 33 "3y
vnoremap 44 "4y

noremap 1p "1p
noremap 2p "2p
noremap 3p "3p
noremap 4p "4p

vnoremap ý "+y
noremap ṕ "+p

" Repeat de macro @a
" noremap , @a
noremap <F2> :NERDTreeToggle<CR>
noremap <F3> :TagbarToggle<CR>
" noremap <F4> :MBEToggle<CR>
noremap <F5> :AirlineToggleWhitespace<CR>
noremap <F6> :SyntasticToggleMode<CR>
noremap <F7> :ConqueTerm bash<CR>
noremap <F10> :AirlineToggle<CR>
" noremap ¿ :CtrlPBuffer<CR>
noremap gn :bn!<CR>
noremap gp :bp!<CR>

" noremap <C-j>  O<Esc>
" noremap <C-/>  gc

" Search for selected text, forwards or backwards.
vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy?<C-R><C-R>=substitute(
  \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>


" Tab = 4 spaces

set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

" syntastic configuration
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:airline#extensions#tabline#enabled = 1
let g:airline_section_c = '%<%F%m %#__accent_red#%{airline#util#wrap(airline#parts#readonly(),0)}%#__restore__#'
let g:airline_section_x = '%{airline#util#wrap(airline#parts#filetype(),0)}'

" No autocomment
autocmd Filetype * set fo=q


autocmd Filetype vhdl call FT_vhdl() 



function FT_vhdl()
	setlocal tabstop=4
	setlocal shiftwidth=4
	if exists("+omnifunc")
		setlocal omnifunc=syntaxcomplete#Complete
	endif
	" setlocal makeprg=gmake
	setlocal errorformat=**\ Error:\ %f(%l):\ %m
	let g:vhdl_indent_genportmap=0
	map <buffer> <F4> :execute ':!vsim -c -do "run -all;exit" '.expand("%:t:r")<CR>
	" for taglist
	let g:tlist_vhdl_settings   = 'vhdl;d:package declarations;b:package bodies;e:entities;a:architecture specifications;t:type declarations;p:processes;f:functions;r:procedures;s:signals;v:variable'
	" command mappings for perl scripts
	:command! -nargs=1 -complete=file VHDLcomp r! ~/.vhdl/vhdl_comp.pl <args>
	:command! -nargs=1 -complete=file VHDLinst r! ~/.vhdl/vhdl_inst.pl <args>
	" environments
	imap <buffer> <C-e>e <Esc>bdwientity <Esc>pa is<CR>end entity ;<Esc>POport (<CR>);<Esc>O
	imap <buffer> <C-e>a <Esc>b"zdwiarchitecture <Esc>pa of <Esc>mz?entity<CR>wyw`zpa is<CR>begin<CR>end architecture ;<Esc>"zPO
	imap <buffer> <C-e>p <Esc>bywA : process ()<CR>begin<CR>end process ;<Esc>PO<+process body+><Esc>?)<CR>i
	imap <buffer> <C-e>g <Esc>bdwipackage <Esc>pa is<CR><BS>end package ;<Esc>PO    
	imap <buffer> <C-e>c case  is<CR>when <+state1+> =><CR><+action1+><CR>when <+state2+> =><CR><+action2+><CR>when others => null;<CR>end case;<Esc>6k$2hi
	imap <buffer> <C-e>i if  then<CR><+do_something+>;<CR>elsif <+condition2+> then<CR><+do_something_else+>;<CR>else<CR><+do_something_else+>;<CR>end if;<Esc>6k$4hi
	" shortcuts
	" imap <buffer> ,, <= 
	" imap <buffer> .. => 
	" imap <buffer> <C-s>i <Esc>:VHDLinst 
	" imap <buffer> <C-s>c <Esc>:VHDLcomp
	" " visual mappings
	" vmap <C-a> :!~/.vhdl/vhdl_align.py<CR>
	" vmap <C-d> :!~/.vhdl/vhdl_align_comments.py<CR>
	" " alt key mappings
	" imap <buffer> <M-i> <Esc>owhen 
	" abbreviations
	iabbr dt downto
	iabbr sig signal
	iabbr gen generate
	iabbr ot others
	iabbr sl std_logic
	iabbr slv std_logic_vector
	iabbr uns unsigned
	iabbr toi to_integer
	iabbr tos to_unsigned
	iabbr tou to_unsigned
	imap <buffer> I: I : in 
	imap <buffer> O: O : out 
endfunction

" Asm Config
autocmd Filetype asm set autoindent

autocmd FileType vhdl set commentstring=--%s

" CommentString for matlab 
"
autocmd FileType matlab set commentstring=%%s

colorscheme luna
highlight Normal ctermfg=grey ctermbg=black
