" Vim filetype plugin file
" Language:         MetaFont
" Maintainer:       Nikolai Weibull <now@bitwi.se>
" Latest Revision:  2016-09-18

if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1

let s:cpo_save = &cpo
set cpo&vim

let b:undo_ftplugin = "setl com< cms< fo< omnifunc<"
      \ . "| unlet! b:match_ignorecase b:match_words b:match_skip"

setlocal comments=:% commentstring=%\ %s formatoptions-=t formatoptions+=croql
setlocal omnifunc=syntaxcomplete#Complete

let s:mp_regex = {
      \ 'beginsection' : '^\s*\%(\%(\|var\|primary\|secondary\|tertiary\)def\|beginchar\)\>',
      \ 'endsection'   : '^\s*\%(enddef\|endchar\)\>',
      \ 'beginblock'   : '^\s*\%(begingroup\|if\|for\%(\|suffixes\|ever\)\)\>',
      \ 'endblock'     : '^\s*\%(endgroup\|fi\|endfor\)\>'
      \ }

function! s:move_around(count, what, flags, visual)
  if a:visual
    exe "normal! gv"
  endif
  call search(s:mp_regex[a:what], a:flags.'s') " 's' sets previous context mark
  for i in range(2, a:count)
    call search(s:mp_regex[a:what], a:flags)
  endfor
endfunction


" Move around macros.
nnoremap <silent><buffer> [[ :<C-U>call <SID>move_around(v:count1, "beginsection", "bW", v:false)<CR>
vnoremap <silent><buffer> [[ :<C-U>call <SID>move_around(v:count1, "beginsection", "bW", v:true)<CR>
nnoremap <silent><buffer> ]] :<C-U>call <SID>move_around(v:count1, "beginsection", "W",  v:false)<CR>
vnoremap <silent><buffer> ]] :<C-U>call <SID>move_around(v:count1, "beginsection", "W",  v:true)<CR>
nnoremap <silent><buffer> [] :<C-U>call <SID>move_around(v:count1, "endsection",   "bW", v:false)<CR>
vnoremap <silent><buffer> [] :<C-U>call <SID>move_around(v:count1, "endsection",   "bW", v:true)<CR>
nnoremap <silent><buffer> ][ :<C-U>call <SID>move_around(v:count1, "endsection",   "W",  v:false)<CR>
vnoremap <silent><buffer> ][ :<C-U>call <SID>move_around(v:count1, "endsection",   "W",  v:true)<CR>
nnoremap <silent><buffer> [{ :<C-U>call <SID>move_around(v:count1, "beginblock",   "bW", v:false)<CR>
vnoremap <silent><buffer> [{ :<C-U>call <SID>move_around(v:count1, "beginblock",   "bW", v:true)<CR>
nnoremap <silent><buffer> ]} :<C-U>call <SID>move_around(v:count1, "endblock",     "W",  v:false)<CR>
vnoremap <silent><buffer> ]} :<C-U>call <SID>move_around(v:count1, "endblock",     "W",  v:true)<CR>

if exists("loaded_matchit")
  let b:match_ignorecase = 0
  let b:match_words =
        \ '\<if\>:\<else\%[if]\>:\<fi\>,' .
        \ '\<for\%(\|suffixes\|ever\)\>:\<exit\%(if\|unless\)\>:\<endfor\>,' .
        \ '\<\%(\|var\|primary\|secondary\|tertiary\)def\>:\<enddef\>,' .
        \ '\<begingroup\>:\<endgroup\>,' .
        \ '\<beginchar\>:\<endchar\>'
  " Ignore comments and strings
  let b:match_skip = 'synIDattr(synID(line("."), col("."), 1), "name")
        \ =~? "mf\\(Comment\\|String\\)$"'
endif
let &cpo = s:cpo_save
unlet s:cpo_save
