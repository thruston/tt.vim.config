:nmap <silent> <localleader>b :call Tag_word("\\textbf{", "}")<CR>
:nmap <silent> <localleader>i :call Tag_word("\\textit{", "}")<CR>
:nmap <silent> <localleader>t :call Tag_word("\\texttt{", "}")<CR>
:nmap <silent> <localleader>m :call Tag_word("$", "$")<CR>
:nmap <silent> <localleader>x :call Tag_word("¬{","}")<CR>
:nmap <silent> <localleader>s :call Cycle_heading()<CR>

:nmap <D-1> :.!perl ~/perl/set_tex_heading.pl section<CR> 
:nmap <D-2> :.!perl ~/perl/set_tex_heading.pl subsection<CR> 
:nmap <D-3> :.!perl ~/perl/set_tex_heading.pl subsubsection<CR> 
:nmap <D-4> :.!perl ~/perl/set_tex_heading.pl paragraph<CR> 

func! Eatchar(pat)
      let c = nr2char(getchar(0))
      return (c =~ a:pat) ? '' : c
   endfunc

iabbr <silent> <localleader>b \textbf{}<Left><C-R>=Eatchar('\s')<CR>
iabbr <silent> <localleader>i \textit{}<Left><C-R>=Eatchar('\s')<CR>
iabbr <silent> <localleader>t \texttt{}<Left><C-R>=Eatchar('\s')<CR>

iabbr px $$\includegraphics[width=0.9\textwidth]{.pdf}$$<Left><Left><Left><Left><Left><Left><Left><C-R>=Eatchar('\s')<CR>

function! Tag_word(stag,etag)
    let s:line = getline('.')
    let [s:sl, s:start] = searchpos('\<','bnc')
    let [s:el, s:end]   = searchpos('\>','nc')
    let s:prefix = strpart(s:line,0,s:start-1)
    let s:word   = strpart(s:line,s:start-1,s:end-s:start)
    let s:suffix = strpart(s:line,s:end-1)
    " Normally we are adding tags, but if the prefix already ends with the
    " start-tag and the suffix already starts with the end tag, then we remove
    " them rather than keep in adding more and more of them
    let s:add_tags = 1
    if strpart(s:prefix,strlen(s:prefix)-strlen(a:stag)) ==# a:stag
        if strpart(s:suffix,0,strlen(a:etag)) ==# a:etag
            let s:add_tags = 0
        endif
    endif
    if s:add_tags
        let s:rc = setline('.', s:prefix . a:stag . s:word . a:etag . s:suffix)
        exe 'normal ' . strlen(a:stag) . 'l'
    else
        " go left first incase deletion shortens the line
        exe 'normal ' . strlen(a:stag) . 'h' 
        let s:prefix = strpart(s:prefix,0,strlen(s:prefix)-strlen(a:stag))
        let s:suffix = strpart(s:suffix,strlen(a:etag))
        let s:rc = setline('.', s:prefix . s:word . s:suffix)
    endif
endfunction    

function! Cycle_heading()
    let s:line = getline('.')
    if match(s:line,"^\\") < 0 
	let s:line = "\\section{" . s:line . "}"
	let s:rc = setline('.',s:line)
	normal 8l
    else
	let s:csname = matchstr(s:line,"^[^{]*")
	if s:csname == '\section'
	    let s:newcs = '\subsection'
	    let s:shift = '3l'
	elseif s:csname == '\subsection'
	    let s:newcs = '\subsubsection'
	    let s:shift = '3l'
	elseif s:csname == '\subsubsection'
	    let s:newcs = '\section'
	    let s:shift = '6h'
	else
	    let s:newcs = s:csname
	    let s:shift = 'hl'
	endif
	let s:text = matchstr(s:line,"{.*}$")
	let s:rc = setline('.',s:newcs . s:text)
	exe 'normal ' . s:shift
    endif 
endfunction
