"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Maintainer: Dexter.Yy <dexter.yy at gmail.com>
" Last Change: $LastChangedDate$ $Rev$
" Modified By: mios <peng.mios at gmail.com>
" Cheat Sheets: http://www.fprintf.net/vimCheatSheet.html
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" default
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible	" stops vim from behaving in a strongly vi -compatible way
set history=400		" keep 400 lines of command line history
if has('mouse')
  set mouse=a		" enable mouse in all mode
endif
set backspace=indent,eol,start	" allow backspace key works in normal way 
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch	" do incremental searching
call pathogen#infect()

let mapleader=","
let g:mapleader=","

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vundle
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" required
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle, required!
Bundle 'gmarik/vundle'

" My Bundles here

" <leader>/, e, o, go, t, h, v, q
Bundle 'mileszs/ack.vim'

  nmap <leader>/ :Ack 

" :Ag, e, o, go, t, h, v, q
Bundle 'rking/ag.vim'

" <c-p>, <c-j> and <c-k> to navigation in result panel
Bundle 'ctrlp.vim'
  let g:ctrlp_working_path_mode = ''
  let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git\|tmp'

" For SCSS
"Bundle 'JulesWang/css.vim'
"Bundle 'cakebaker/scss-syntax.vim'

" Ctrl+y,
Bundle 'Emmet.vim'

" :Gblame
Bundle 'tpope/vim-fugitive'

Bundle 'FuzzyFinder'

  """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  " FuzzyFinder setting
  """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  nmap <leader>fb :FufBuffer<cr>
  nmap <leader>ff :FufFile<cr>
  nmap <leader>fd :FufDir<cr>
  nmap <leader>fa :FufBookmark<cr>

" F2
Bundle 'jshint.vim'

  let g:jslint_neverAutoRun=1

Bundle 'L9'

" :Matrix
"Bundle 'matrix.vim--Yang'

" gf
Bundle 'rails.vim'

Bundle 'SirVer/ultisnips'

  "let g:UltiSnipsExpandTrigger="<tab>"
  let g:UltiSnipsJumpForwardTrigger="<tab>"
  let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
  let g:UltiSnipsSnippetDirectories=["ultisnips"]

Bundle 'Syntastic'
  let g:syntastic_error_symbol = '●'
  let g:syntastic_warning_symbol = '●'
  let g:syntastic_style_error_symbol = '»!'
  let g:syntastic_style_warning_symbol = '»'

  let g:syntastic_javascript_checkers = ['jshint']
  let g:syntastic_ruby_checkers = ['rubocop']

Bundle 'xolox/vim-misc'
Bundle 'xolox/vim-session'


  """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  " Session
  " :LL, :SS
  """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

  function! GetMySession(s)
    execute "OpenSession! ".a:s
  endfunction

  function! SetMySession(s)
    execute "SaveSession ".a:s
  endfunction

  " load and save session
  let g:session_autosave = 'no'
  let g:session_autoload = 'no'
  command! -nargs=? -bang SS call SetMySession("<args>") 
  command! -nargs=? -bang LL call GetMySession("<args>") 


" ,cc ,cu
Bundle 'The-NERD-Commenter'

Bundle 'The-NERD-tree'

  """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  " NERD Tree
  " ,nt
  """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

  let NERDTreeShowBookmarks=1
  let NERDTreeChDirMode=2
  nmap <silent> <leader>nt :NERDTree<cr> 


Bundle 'vimwiki'

  """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  " Vimwiki
  " ,ww ,wt
  """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

  let g:vimwiki_use_mouse = 1
  let g:vimwiki_list = [{'path': '~/Dropbox/vimwiki/',
  \ 'path_html': '~/Dropbox/vimwiki/html/',
  \ 'html_header': '~/Dropbox/vimwiki/template/header.tpl',}]


Bundle 'surround.vim'

" required!
filetype plugin indent on



" format lines to textwidth length
map Q gq	

inoremap <C-U> <C-G>u<C-U>

if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch	" highlight search words. :hls :nohls
endif

if has("autocmd")
  " detect filetype and auto load plugin from custom folders
  filetype plugin indent on
  " Define a autocmd group : vimrcEx
  augroup vimrcEx	
  " Delete all autocmd
  au!
  autocmd FileType text setlocal textwidth=78
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif
  augroup END
else
  " set autoindenting on
  " When insert a new line (type<CR> in Insert mode, o, O )
  " Vim will copy indents from current line.
  " If you did not type anything, you can type 
  " <Esc>, CTRL-O or <CR> or move cursor to other line :
  " Vim will delete all indents.
  set autoindent
endif " has("autocmd")

if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Platform
function! MySys()
	if has("win32") || has("win64")
    	return "windows"
	elseif has("mac")
		return "mac"
	else
    	return "linux"
	endif
endfunction

set encoding=utf-8
set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936

" Move Backup Files to ~/.vim/backups/
set backupdir=~/.vim/backups
set dir=~/.vim/backups
set nobackup 
"set nowritebackup 
set noswapfile

set shiftwidth=2
set tabstop=2
set nowrap
set wildmenu
set matchpairs=(:),{:},[:],<:>
"set whichwrap=b,s,<,>,[,]	" backspace, space, arrows auto move to next line
"set foldmethod=indent	" enable fold lines for indent
set wildignore+=node_modules,tmp/cache

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let macvim_skip_colorscheme=1
colorscheme yytextmate
"colorscheme solarized

if MySys() == "mac"
	"set guifont=TextMate_Regular:h13
	set guifont=Monaco:h12
	set guifontwide=Hei_Regular:h13
elseif MySys() == "linux"
	set guifont=Monospace
endif

set anti
set linespace=4 
set number
set numberwidth=4
set equalalways		" all split windows use same size
set guitablabel=%N/\ %t\ %M

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" filetype and syntax
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:javascript_enable_domhtmlcss=1
let g:xml_use_xhtml = 1 "for xml.vim

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MacVim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if has("gui_macvim")

	set columns=171	" window width
	set lines=58	" window height
	winpos 52 42	" window position 

	let macvim_skip_cmd_opt_movement = 1
	let macvim_hig_shift_movement = 1

	set guioptions-=T "egmrt
	"set guioptions+=b 
	
	" set custom mvim shortkeys
	macm File.New\ Tab						key=<D-T>
	macm File.Save<Tab>:w					key=<D-s>
	macm File.Save\ As\.\.\.<Tab>:sav		key=<D-S>
	macm Edit.Undo<Tab>u					key=<D-z> action=undo:
	macm Edit.Redo<Tab>^R					key=<D-Z> action=redo:
	macm Edit.Cut<Tab>"+x					key=<D-x> action=cut:
	macm Edit.Copy<Tab>"+y					key=<D-c> action=copy:
	macm Edit.Paste<Tab>"+gP				key=<D-v> action=paste:
	macm Edit.Select\ All<Tab>ggVG			key=<D-A> action=selectAll:
	macm Window.Toggle\ Full\ Screen\ Mode	key=<D-F>
	macm Window.Select\ Next\ Tab			key=<D-}>
	macm Window.Select\ Previous\ Tab		key=<D-{>
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" autocmd
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" auto reload when modify gvimrc
autocmd! bufwritepost .gvimrc source ~/.gvimrc
autocmd! bufwritepost gvimrc source ~/.gvimrc


" Auto set pwd to the directory of current editing file
"autocmd BufRead * :lcd! %:p:h

" filetype
autocmd BufNewFile,BufRead *.haml setlocal ft=haml
autocmd BufNewFile,BufRead *.erb setlocal ft=haml
autocmd BufNewFile,BufRead *.styl setlocal ft=stylus

" language support
autocmd FileType html 		setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType haml 		setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType javascript setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4 textwidth=79
autocmd FileType css 		  setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2 textwidth=79
autocmd FileType scss 		setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2 textwidth=79
autocmd FileType stylus 	setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2 textwidth=79
autocmd FileType python 	setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4 textwidth=79
autocmd FileType ruby 		setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType vim 		  setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2

" for AutoComplPop
autocmd FileType html setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

autocmd FileType javascript noremap <buffer> <Leader>f :exe '0,$!js-beautify % --config ~/.jsbeautifyrc'<cr>
autocmd FileType html       noremap <buffer> <Leader>f :exe '0,$!html-beautify % --config ~/.htmlbeautifyrc'<cr>
autocmd FileType css        noremap <buffer> <Leader>f :exe '0,$!css-beautify % --config ~/.cssbeautifyrc'<cr>

au TabEnter * if exists("t:wd") | exe "cd" t:wd | endif 

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" commands
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! SetMyPath(s)
	execute "cd ~/workspace/".a:s
	:let t:wd = "~/workspace/".a:s
endfunction

command! -nargs=? -bang CC call SetMyPath("<args>")

" for make & debug

function! QFSwitch() " toggle quickfix window
	redir => ls_output
		execute ':silent! ls'
	redir END

	let exists = match(ls_output, "[Quickfix List")
	if exists == -1
		execute ':copen'
	else
		execute ':cclose'
	endif
endfunction

function! MyMake()
	exe 'call ' . b:myMake . '()'
endfunction

function! MyLint()
	exe 'call ' . b:myLint . '()'
endfunction

function! MyDebug()
	exe 'call ' . b:myDebug . '()'
endfunction

function! MySetBreakPoint()
	exe 'call ' . b:mySetBreakPoint . '()'
endfunction

function! MySetLog()
	exe 'call ' . b:mySetLog. '()'
endfunction

function! MyRemoveBreakPoint()
	exe 'call ' . b:myRemoveBreakPoint . '()'
endfunction

" Displaying status line always
set laststatus=2

" Custom status line
set statusline=%<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %r%{ShowProject()}%h

" Show working directory
function! ShowProject()
	return substitute(getcwd(), '/Users/mios/workspace/', '', '')
endfunction  



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" map
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

map <silent> <leader>rc :tabe ~/.vim/vimrc<cr>
map <leader>q :q<cr>

" for make & debug
"noremap <F2> <ESC>:call MyLint()<CR>
noremap <F2> <ESC>:JSHint<CR>
noremap <F3> :call MyDebug()<CR>
noremap <F4> :call MyMake()<CR>
noremap <F5> <ESC>:call QFSwitch()<CR>
" insert a new 'debugger;' line
noremap <F6> :call MySetBreakPoint()<CR>
" insert a 'console.log' line
noremap <F7> :call MySetLog()<CR>
" Remove all debugger and log lines
noremap <F8> :call MyRemoveBreakPoint()<CR>


nmap <tab> 		v>
nmap <s-tab> 	v<
vmap <tab> 		>gv 
vmap <s-tab> 	<gv

" map cmd to ctrl
if MySys() == "mac"
	map <D-y> <C-y>
	map <D-e> <C-e>
	map <D-f> <C-f>
	map <D-b> <C-b>
	map <D-u> <C-u>
	map <D-d> <C-d>
	map <D-w> <C-w>
	map <D-r> <C-r>
	map <D-o> <C-o>
	"map <D-i> <C-i>
	map <D-g> <C-g>
	map <D-a> <C-a>
	map <D-]> <C-]>
	cmap <D-d> <C-d>
	imap <D-e> <C-e>
	imap <D-y> <C-y>
endif

