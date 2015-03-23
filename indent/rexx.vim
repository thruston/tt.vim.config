" Vim indent file
" Language:    Rexx
" Maintainer:  Toby Thurston toby@cpan.org
" Last Change: 25 Jan 2010 

" Only load this indent file when no other was loaded.
if exists("b:did_indent")
  finish
endif
let b:did_indent = 1

setlocal indentexpr=GetRexxIndent()
setlocal indentkeys=!^F,o,O,=else,=end,=otherwise

" so we are going to be called on explicit Ctrl-F, 
" every <CR> or "o", every "O", every "else"
" then on "end" and "otherwise"

" Catch multiple instantiations
if exists("*GetRexxIndent")
  finish
endif

function GetRexxIndent()
    " at the beginning the current line number is in v:lnum
    if v:lnum == 1
	return 0
    endif 

    let s:prev_line_number = prevnonblank(v:lnum-1)
    let s:prev_line        = getline(s:prev_line_number)
    let s:prev_indent      = indent (s:prev_line_number)

    let s:line = getline(v:lnum)
    
    if s:line =~ '^\s*\%(otherwise\|end\)\>'
	return s:prev_indent - &sw
    elseif s:prev_line =~ '^\s*\%(if\|select\|otherwise\|do\)\>'
	return s:prev_indent + &sw
    else 
        return s:prev_indent
    endif
	
endfunction

