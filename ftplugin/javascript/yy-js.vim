" javascript compile & debug tools 
" Maintainer: Dexter.Yy
" Mail:   dexter.yy@gmail.com
" Web:    http://www.limboy.com
" Version: 0.1
"
" Usage:
"

python << EOF
import os, vim

def jsDebug():
	pass

def jsInsertCode(code, cmt):
	nLine = int(vim.eval('line(".")'))
	strLine = vim.current.line
	strWhite = ""
	for char in strLine:
		if char == ' ' or char == "\t":
			strWhite += char
		else:
			break

	vim.current.buffer.append(
		"%(space)s%(code)s; %(cmt)s" 
		% {'space': strWhite, 'code': code, 'cmt': '// ' + cmt}, 
		nLine - 1)

def jsSetBreakpoint():
	jsInsertCode('debugger', 'Breakpoint')

vim.command('let b:myLogCount = 0')
def jsSetLog():
	vim.command('let b:myLogCount += 1')
	jsInsertCode('window.console.info("log: " + %s)' 
		% str(vim.eval('b:myLogCount')), 'log')

def jsRemoveAllDebug():
    nCurrentLine = int(vim.eval('line(".")'))
    nLines = []
    nLine = 1
    for strLine in vim.current.buffer:
        if (r'window.console.' == strLine.lstrip()[:15]
			or 'debugger;' == strLine.lstrip()[:9]) \
		   	and r'//' in strLine:
			nLines.append(nLine)
        nLine += 1
    nLines.reverse()
    for nLine in nLines:
        vim.command('normal %dG' % nLine)
        vim.command('normal dd')
        if nLine < nCurrentLine:
            nCurrentLine -= 1
    vim.command('normal %dG' % nCurrentLine)
    vim.command('let b:myLogCount = 0')

EOF

function! s:SetMyMake()
	let s:cpo_save = &cpo
	set cpo-=C
	setlocal makeprg=jshint\ %\ --config\ '$HOME/.jshintrc'\
	setlocal errorformat=%f:\ line\ %l\\,\ col\ %c\\,\ %m
	let &cpo = s:cpo_save
	unlet s:cpo_save
	let g:current_compiler = "jshint"
endfunction

function! MyJsMake()
	call MyJsLint()
	"!python $TUICOMPILER/tuicompiler.py % -n
	!python ~/bin/tuicompiler/tuicompiler.py % 
endfunction

function! MyJsLint()
	call s:SetMyMake()
	make
endfunction

function! MyFixStyle()
  call ModifyByFixJsStyle()
endfunction

function! ModifyByFixJsStyle()
  " save positions
  let pos = s:SavePositions()

  let tempfile = tempname() . '.js'
  silent call writefile(getbufline(bufname('%'), 1, '$'), tempfile)
  try
      " use fixjsstyle as filter
      silent! execute '!fixjsstyle --nojsdoc' tempfile

      1,$delete "_
      execute 'read' tempfile
      1delete "_

      " restore positions
      call s:RestorePositions(pos)
  catch
      echoerr v:exception
  finally
      call delete(tempfile)
  endtry
endfunction

function! MyJsSetBreakPoint()
	py jsSetBreakpoint()
endfunction

function! MyJsSetLog()
	py jsSetLog()
endfunction

function! MyJsRemoveBreakPoint()
	py jsRemoveAllDebug()
endfunction

" save cursor and screen positions
" pair up this function with s:RestorePositions
if !exists('*s:SavePositions')
    function s:SavePositions()
        " cursor pos
        let cursor = getpos('.')

        " screen pos
        normal! H
        let screen = getpos('.')

        return [screen, cursor]
    endfunction
endif

" restore cursor and screen positions
" pair up this function with s:SavePositions
if !exists('*s:RestorePositions')
    function s:RestorePositions(pos)
        " screen
        call setpos('.', a:pos[0])

        " cursor
        normal! zt
        call setpos('.', a:pos[1])
    endfunction
  endif

let b:myMake='MyJsMake'
let b:myLint='MyJsLint'
let b:myFixStyle='MyFixStyle'
let b:mySetBreakPoint='MyJsSetBreakPoint'
let b:mySetLog='MyJsSetLog'
let b:myRemoveBreakPoint='MyJsRemoveBreakPoint'
