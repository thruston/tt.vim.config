" MetaPost indent file
" Language: MetaPost
" Maintainer: Eugene Minkovskii <emin@mccme.ru>"
" Last Change:  September 18, 2016

" Only load this indent file when no other was loaded.
if exists("b:did_indent")
  finish
endif
let b:did_indent = 1

setlocal indentexpr=GetMetaPostIndent()
setlocal indentkeys+==end,=else,=fi,=fill,0),0]

let b:undo_indent = "setl indentkeys< indentexpr<"

" Only define the function once.
if exists("*GetMetaPostIndent")
  finish
endif
let s:keepcpo= &cpo
set cpo&vim

function GetMetaPostIndent()
  let ignorecase_save = &ignorecase
  try
    let &ignorecase = 0
    return GetMetaPostIndentIntern()
  finally
    let &ignorecase = ignorecase_save
  endtry
endfunc

" Regexps {{{
" A line ends with zero or more spaces, possibly followed by a comment:
let s:eol = '\s*\%($\|%\)'

" Keywords opening blocks
let s:open_keyword =
      \ '\<if\>'
      \ . '\|\<else\>'
      \ . '\|\<elseif\>'
      \ . '\|\<for\>'
      \ . '\|\<forever\>'
      \ . '\|\<forsuffixes\>'
      \ . '\|\<begingroup\>'
      \ . '\|^\s*\<beginfig\>'
      \ . '\|^\s*\<beginchar\>'
      \ . '\|\<def\>'
      \ . '\|\<vardef\>'
      \ . '\|\<primarydef\>'
      \ . '\|\<secondarydef\>'
      \ . '\|\<tertiarydef\>'
      \ . '\|[([{]'.s:eol

" Keywords closing blocks
let s:close_keyword =
      \ '\<fi\>'
      \ . '\|\<else\%[if]\>'
      \ . '\|\<end\%(\|def\|for\|group\|fig\|char\)\>'
      \ . '\|^\s*[)\]}]'

" Commands that may span multiple lines and are ended by a semicolon.
" (To keep this list short, commands whose argument is not likely to be very
" long–so they are not likely to span more than one line–are not included).
let s:mp_command = '\('
      \ . '\<draw\>'
      \ . '\|\<fill\>'
      \ . '\|\<filldraw\>'
      \ . '\|\<undraw\>'
      \ . '\|\<unfill\>'
      \ . '\|\<unfilldraw\>'
      \ . '\|\<cutdraw\>'
      \ . '\|\<drawarrow\>'
      \ . '\|\<drawdblarrow\>'
      \ . '\|\<clip\>'
      \ . '\|\<addto\>'
      \ . '\|\<save\>'
      \ . '\|\<setbounds\>'
      \ . '\|\<message\>'
      \ . '\|\<errmessage\>'
      \ . '\|\<errhelp\>'
      \ . '\|\<fontmapline\>'
      \ . '\|\<pickup\>'
      \ . '\|\<show\>'
      \ . '\|\<special\>'
      \ . '\|\<write\>'
      \ . '\)'
" }}}

" Auxiliary functions {{{
if has('syntax_items')
  function! s:CommentOrString(l, c)
    return synIDattr(synID(a:l, a:c, 1), "name") =~ 'm[fp]\(Comment\|String\|TeX\%[Delim]\)$'
  endfunction
else
  function! s:CommentOrString(l, c)
    return v:false
  endfunction
endif

" Find the first non-comment non-blank line before the current line.
function! s:PrevNonBlankNonComment(lnum)
  let l:lnum = prevnonblank(a:lnum - 1)
  while (getline(l:lnum) =~# '^\s*%')
    let l:lnum = prevnonblank(l:lnum - 1)
  endwhile
  return l:lnum
endfunction

" We use a simple heuristics to test whether a line should cause the
" indentation of the next line to increase: count the "opening tags" (if, for,
" def, ...) in the line, count the "closing tags" (endif, endfor, ...) in the
" line and compute the difference. If the result is positive, then the next
" line should likely be indented. Note that `else` and `elseif` appear in both
" groups, so they are (almost) irrelevant, with the exception of a leading
" `else[if]`, which is counted as an opening tag, but not as a closing tag (so
" that, for instance, a single `else:` will indent the following line).
"
" Example:
"
"     forsuffixes $=a,b: if x.$ = y.$ : draw else: fill fi
"       " This line will be indented because |{forsuffixes,if,else}| > |{else,fi}|
"     endfor
"
" Returns true if the line contains unbalanced open/close keywords; returns
" false otherwise. The second argument is the line number.
function! s:UnbalancedKeywords(line, lnum)
  let [o, i] = [0, 0]
  while i >= 0
    let i = match(a:line, s:open_keyword, i)
    if i >= 0
      if !s:CommentOrString(a:lnum, i)
        let o += 1
      endif
      let i += 1
    endif
  endwhile
  let c = 0
  " Do not count a leading else[if] as a closing tag
  let i = match(a:line, '^\s*\zs\<else\%[if]\>') + 1
  while i >= 0
    let i = match(a:line, s:close_keyword, i)
    if i >= 0
      if !s:CommentOrString(a:lnum, i)
        let c += 1
      endif
      let i += 1
    endif
  endwhile
  return o > c
endfunction

" Similar to match(), but skips strings and comments.
" line: a String
" lnum: the line number
function! s:ValidMatch(line, lnum, pat)
  let i = 0
  while i >= 0
    let i = match(a:line, a:pat, i)
    if i >= 0
      if !s:CommentOrString(a:lnum, i)
        return i
      endif
      let i += 1
    endif
  endwhile
  return i
endfunction

" Like s:ValidMatch(), but returns the position of the last ("rightmost") match.
function! s:LastValidMatch(line, lnum, pat)
  let i = 0
  let last_found = -1
  while i >= 0
    let i = match(a:line, a:pat, i)
    if i >= 0
      if !s:CommentOrString(a:lnum, i)
        let last_found = i
      endif
      let i += 1
    endif
  endwhile
  return last_found
endfunction

function! s:DecreaseIndentOnClosingTag(curr_indent)
  let cur_text = getline(v:lnum)
  if cur_text =~# '^\s*\%('.s:close_keyword.'\)'
    return max([a:curr_indent - shiftwidth(), 0])
  endif
  return a:curr_indent
endfunction
" }}}

" Main function {{{
" Note: Every rule of indentation in MetaPost is very subjective. We might
" get creative, but things get murky very soon (there are too many corner
" cases). So, we provide a means for the user to decide what to do when this
" script doesn't get it. We use a simple idea: use '%>' and '%<' to
" explicitly control indentation. The '<' and '>' symbols may be repeated
" many times (e.g., '%>>' will cause the next line to be indented twice).
"
" By using '%>...' and '%<...', the indentation the user wants is preserved
" by commands like gg=G, even if it does not follow this script's rules.
"
" Example:
"
"    shiftwidth=4
"    def foo =
"        makepen(subpath(T-n,t) of r %>
"            shifted .5down %>
"                --subpath(t,T) of r shifted .5up -- cycle) %<<
"        withcolor black
"    enddef
"
" The default indentation of the previous example would be:
"
"    def foo =
"        makepen(subpath(T-n,t) of r
"        shifted .5down
"        --subpath(t,T) of r shifted .5up -- cycle)
"        withcolor black
"    enddef
"
" Personally, I prefer the latter, but anyway...
"
function! GetMetaPostIndentIntern()
  " This is the reference line relative to which the current line is
  " indented (but see below).
  let lnum = s:PrevNonBlankNonComment(v:lnum)

  " At the start of the file use zero indent.
  if lnum == 0
    return 0
  endif

  let prev_text = getline(lnum)

  " First of all, check for user-defined overrides
  let i = strlen(matchstr(prev_text, '%>\+')) - 1
  if i > 0
    return indent(lnum) + i * shiftwidth()
  endif

  let i = strlen(matchstr(prev_text, '%<\+')) - 1
  if i > 0
    return max([indent(lnum) - i * shiftwidth(), 0])
  endif

  " Keywords opening blocks cause indentation to kick in
  if s:UnbalancedKeywords(prev_text, lnum)
    return s:DecreaseIndentOnClosingTag(indent(lnum) + shiftwidth())
  endif

  " Unterminated commands cause indentation to kick in
  if s:ValidMatch(prev_text, lnum, s:mp_command) >= 0 " Does the line contain a command?
    if match(prev_text, ';'.s:eol) < 0 " Is the line unterminated?
      return indent(lnum) + shiftwidth()
    else
      return s:DecreaseIndentOnClosingTag(indent(lnum))
    endif
  endif

  " Deal with the special case of a command spanning multiple lines. If the
  " current reference line L ends with a semicolon, search backwards for
  " another semicolon or a command. If a command is found first, its line is
  " used as the reference line for indenting the current line instead of L.
  "
  "  Example:
  "
  "  if cond:
  "    draw if a: z0 else: z1 fi
  "        shifted S
  "        scaled T;      % L
  "
  "    for i = 1 upto 3:  % <-- Current line: this gets the same indent as `draw ...`
  "
  " NOTE: we get here if and only if L does not contain a command.
  "
  if match(prev_text, ';'.s:eol) >= 0 " L ends with a semicolon
    let cmd_lnum = s:PrevNonBlankNonComment(lnum)
    while cmd_lnum > 0
      let prev_text = getline(cmd_lnum)
      let sc_pos = s:LastValidMatch(prev_text, cmd_lnum, ';')
      let cmd_pos = s:LastValidMatch(prev_text, cmd_lnum, s:mp_command)
      if cmd_pos > sc_pos
        let lnum = cmd_lnum
        break
      elseif sc_pos > cmd_pos
        break
      endif
      let cmd_lnum = s:PrevNonBlankNonComment(cmd_lnum)
    endwhile
  endif

  return s:DecreaseIndentOnClosingTag(indent(lnum))
endfunction
" }}}
"
" vim:sw=2:fdm=marker
