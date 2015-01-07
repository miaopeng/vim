""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Maintainer: mios <mios426@gmail.com>
" Cheat Sheets: http://www.fprintf.net/vimCheatSheet.html
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""
" default
"""""""""""
set nocompatible                " stops vim from behaving in a strongly vi -compatible way
set nomodeline
set history=400	                " keep 400 lines of command line history
set mouse=a	                    " enable mouse in all mode
set backspace=indent,eol,start	" allow backspace key works in normal way 
set ruler	                      " show the cursor position all the time
set showcmd  	                  " display incomplete commands
set incsearch	                  " do incremental searching

let mapleader=","
let g:mapleader=","

""""""""""""
" Vundle
""""""""""""
" required
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle, required!
Plugin 'gmarik/vundle'

" My Plugins here

" <leader>/, e, o, go, t, h, v, q
Plugin 'mileszs/ack.vim'

  nmap <leader>/ :Ack 

" :Ag, e, o, go, t, h, v, q
Plugin 'rking/ag.vim'

" <c-p>, <c-j> and <c-k> to navigation in result panel
Plugin 'ctrlp.vim'
  let g:ctrlp_working_path_mode = ''
  let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v[\/]\.(git|hg|svn)$\|node_modules$\|tmp$',
    \ 'file': '\.pyc$\|\.pyo$\|\.rbc$|\.rbo$\|\.class$\|\.o$\|\~$\DS_Store$'
    \ }
  nmap <leader>rf :CtrlPBuffer<cr>

" Ctrl+y,
Plugin 'Emmet.vim'

" :Gblame
Plugin 'tpope/vim-fugitive'

Plugin 'tpope/vim-haml'

" F2
Plugin 'jshint.vim'

  let g:jslint_neverAutoRun=0

Plugin 'L9'

Plugin 'itchyny/lightline.vim'

  """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  " LightLine settings
  """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  " Displaying status line always
  set laststatus=2

  " Custom status line
  "set statusline=%<%f\ %{SyntasticStatuslineFlag()}\ %h%m%r%=%-14.(%l,%c%V%)\ %r%{ShowProject()}%h

  let g:lightline = {
        \ 'active': {
        \   'left': [ [ 'mode', 'paste' ],
        \             [ 'projectname', 'readonly', 'filename', 'modified' ] ],
        \   'right': [ [ 'syntastic', 'lineinfo' ], ['percent'], [ 'fileformat', 'fileencoding', 'filetype' ] ]
        \ },
        \ 'inactive': {
        \   'left': [ [ 'mode' ],
        \             [ 'filename' ] ],
        \   'right': []
        \ },
        \ 'component': {
        \   'readonly': '%{&readonly?"x":""}',
        \ },
        \ 'component_function': {
        \   'mode': 'MyMode',
        \   'projectname': 'ProjectName',
        \   'filename': 'MyFilename'
        \ },
        \ 'component_expand': {
        \   'syntastic': 'SyntasticStatuslineFlag',
        \ },
        \ 'component_type': {
        \   'syntastic': 'error',
        \ }
        \ }

" gf
Plugin 'rails.vim'

Plugin 'SirVer/ultisnips'

  """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  " ultisnips settings
  """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

  "let g:UltiSnipsExpandTrigger="<tab>"
  let g:UltiSnipsJumpForwardTrigger="<tab>"
  let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
  let g:UltiSnipsSnippetDirectories=["ultisnips"]

  """""""""""
  " make YCM compatible with UltiSnips
  """""""""""

  function! g:UltiSnips_Complete()
      call UltiSnips#ExpandSnippet()
      if g:ulti_expand_res == 0
          if pumvisible()
              return "\<C-n>"
          else
              call UltiSnips#JumpForwards()
              if g:ulti_jump_forwards_res == 0
                 return "\<TAB>"
              endif
          endif
      endif
      return ""
  endfunction

  au BufEnter * exec "inoremap <silent> " . g:UltiSnipsExpandTrigger . " <C-R>=g:UltiSnips_Complete()<cr>"
  let g:UltiSnipsJumpForwardTrigger="<tab>"
  let g:UltiSnipsListSnippets="<c-e>"
  " this mapping Enter key to <C-y> to chose the current highlight item 
  " and close the selection list, same as other IDEs.
  " CONFLICT with some plugins like tpope/Endwise
  inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

Plugin 'Syntastic'
  let g:syntastic_always_populate_loc_list = 0 
  let g:syntastic_stl_format = '[%E{Err: %fe #%e}%B{, }%W{Warn: %fw #%w}]'
  "let g:syntastic_auto_loc_list = 1
  let g:syntastic_enable_balloons = 0 
  let g:syntastic_enable_highlighting = 0
  

  let g:syntastic_error_symbol = '●'
  let g:syntastic_warning_symbol = '●'
  let g:syntastic_style_error_symbol = '»!'
  let g:syntastic_style_warning_symbol = '»'

  let g:syntastic_javascript_checkers = ['jshint']
  let g:syntastic_ruby_checkers = ['rubocop']
  let g:syntastic_css_checkers = ['csslint']
  let g:syntastic_scss_checkers = ['scss_lint'] " gem install scss-lint
  let g:syntastic_haml_checkers = ['haml_lint']
  " let g:syntastic_debug = 19 " debug
  "
Plugin 'marijnh/tern_for_vim'

  """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  " tern_for_vim settings
  """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

  let g:tern_map_keys=1
  let g:tern_show_argument_hints = 'on_hold'

  " Documentation under cursor
  nmap <leader>td :TernDoc<cr> 

  " Browse documentation
  nmap <leader>tb :TernDocBrowse<cr> 

  " Type hints
  nmap <leader>tt :TernType<cr> 

  " Jump to definition
  nmap <leader>td :TernDef<cr>  

  " Jump to definition inside preview
  nmap <leader>tpd :TernDefPreview<cr>  

  " Definition in new split
  nmap <leader>tsd :TernDefSplit<cr>  

  " Definition in new tab
  nmap <leader>ttd :TernDefTab<cr>  

  " All reference under cursor
  nmap <leader>tr :TernRefs<cr>  

  " Rename variable
  nmap <leader>tR :TernRename<cr>


Plugin 'groenewege/vim-less'
Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-session'

" Ctrl+n
Plugin 'terryma/vim-multiple-cursors'

" Plugin 'mxw/vim-jsx'

  " let g:jsx_ext_required = 0

Plugin 'Valloric/YouCompleteMe'


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
Plugin 'The-NERD-Commenter'

  :set guioptions-=L
  let NERDSpaceDelims=1

Plugin 'The-NERD-tree'

  """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  " NERD Tree
  " ,nt
  """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

  let NERDTreeShowBookmarks=0
  let NERDTreeChDirMode=2
  let NERDTreeMinimalUI=1
  nmap <silent> <leader>nt :NERDTree<cr> 


Plugin 'vimwiki'

  """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  " Vimwiki
  " ,ww ,wt
  """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

  let g:vimwiki_use_mouse = 1
  let g:vimwiki_list = [{'path': '~/Dropbox/profile/vimwiki/',
  \ 'path_html': '~/Dropbox/profile/vimwiki/html/', "syntax": "markdown",
  \ 'html_header': '~/Dropbox/profile/vimwiki/template/header.tpl',}]


Plugin 'surround.vim'

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
set ar " auto read file

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let macvim_skip_colorscheme=1
colorscheme jellybeans

if MySys() == "mac"
	set guifont=Monaco:h12
elseif MySys() == "linux"
	set guifont=Monospace
endif

set anti
set linespace=4   " Line height
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

  " Cancel default shortkeys
	let macvim_skip_cmd_opt_movement = 1
	let macvim_hig_shift_movement = 1

	set guioptions-=T "egmrt
	"set guioptions+=b 

  " remove scrollbars
  set guioptions-=lrb
	
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" autocmd
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" auto reload when modify gvimrc
autocmd! bufwritepost vimrc source ~/.vim/vimrc

autocmd! bufwritepost *.js,*.rb,*.css,*.scss call s:syntastic()

" Auto set pwd to the directory of current editing file
"autocmd BufRead * :lcd! %:p:h

" filetype
autocmd BufNewFile,BufRead *.haml setlocal ft=haml
autocmd BufNewFile,BufRead *.erb setlocal ft=haml
autocmd BufNewFile,BufRead *.styl setlocal ft=stylus

" language support
autocmd FileType html 		setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType haml 		setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType javascript setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2 textwidth=79
autocmd FileType css 		  setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2 textwidth=79
autocmd FileType scss 		setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2 textwidth=79
autocmd FileType stylus 	setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2 textwidth=79
autocmd FileType python 	setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4 textwidth=79
autocmd FileType ruby 		setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType vim 		  setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType conf 		setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4

" for AutoComplPop
autocmd FileType html setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

autocmd FileType javascript noremap <buffer> <Leader>f :exe '0,$!js-beautify % --config ~/.jsbeautifyrc'<cr>
autocmd FileType html       noremap <buffer> <Leader>f :exe '0,$!html-beautify % --config ~/.htmlbeautifyrc'<cr>
autocmd FileType css        noremap <buffer> <Leader>f :exe '0,$!css-beautify % --config ~/.cssbeautifyrc'<cr>
autocmd FileType scss        noremap <buffer> <Leader>f :exe '0,$!css-beautify % --config ~/.cssbeautifyrc'<cr>

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

function! MyFixStyle()
	exe 'call ' . b:myFixStyle . '()'
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

function! MyModified()
  return &ft =~ 'help' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! MyReadonly()
  return &ft !~? 'help' && &readonly ? 'RO' : ''
endfunction

function! s:syntastic()
  SyntasticCheck
  call lightline#update()
endfunction

function! MyMode()
  let fname = expand('%:t')
  return fname == 'ControlP' ? 'CtrlP' :
        \ fname =~ 'NERD_tree' ? 'NERDTree' :
        \ winwidth(0) > 60 ? lightline#mode() : ''
endfunction

" Show working directory
function! ProjectName()
  return substitute(getcwd(), '/Users/mios/workspace/', '', '')
endfunction

function! MyFilename()
  let fname = expand('%:t')
  return fname == '__Tagbar__' ? g:lightline.fname :
      \ fname =~ 'NERD_tree' ? '' :
      \ ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
      \ ('' != fname ? fname : '[No Name]') .
      \ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" map
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

map <silent> <leader>rc :tabe ~/.vim/vimrc<cr>
map <leader>q :q<cr>

" for make & debug
"noremap <F2> <ESC>:call MyLint()<CR>
noremap <F2> <ESC>:JSHint<CR>
noremap <F3> :call MyFixStyle()<CR>
noremap <F4> :call MyMake()<CR>
noremap <F5> <ESC>:call QFSwitch()<CR>
" insert a new 'debugger;' line
noremap <F6> :call MySetBreakPoint()<CR>
" insert a 'console.log' line
noremap <F7> :call MySetLog()<CR>
" Remove all debugger and log lines
noremap <F8> :call MyRemoveBreakPoint()<CR>

noremap [[ :lp<CR>
noremap ]] :lne<CR>


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




