" Toby Thurston -- 12 Mar 2010
:syntax enable
:set autoindent 
:set autowrite 
:set hidden
:set expandtab
:set switchbuf=usetab
:set shiftwidth=4 
:set tabstop=4 
:set number 
:set nowrap
:set nocompatible
:set directory=$TMPDIR
:set backspace=indent,eol,start
:set ruler
:set showcmd
:set hlsearch  
:set wig=*.pdf,*.toc,*.aux,*.log,*.out,*.doc,*.docx,*.ppt,*.pptx,*.xls,*.xlsx

:command! -nargs=0 Rpn  pyf ~/Numerical-macros-for-VIM/maynard.py
:command! -nargs=0 -range Calc <line1>,<line2> pyf ~/Numerical-macros-for-VIM/maynard.py
:command! -nargs=0 Mcl  pyf ~/python/make_crossword_line.py

:iab <expr> tet "Toby Thurston -- " . strftime("%d %b %Y")
:inoremap <D-3> #

:let maplocalleader = "§"
:nnoremap <leader>ev :vsplit $MYVIMRC<cr>
:nnoremap <leader>sv :source $MYVIMRC<cr>

:nnoremap <leader>vv :!open -a Skim %:r.pdf<cr><cr>

function! Clean_PDF_text()
    %s/ﬀ/ff/g
    %s/ﬁ/fi/g
    %s/ﬂ/fl/g
    %s/ﬃ/ffi/g
    %s/ﬄ/ffl/g
    %s/β/$\\beta$/g
    %s/γ/$\\gamma$/g
    %s/ρ/$\\rho$/g
    %s/σ/$\\sigma$/g
    %s/–/--/g
    %s/−/-/g
endfunction

:nnoremap <leader>ct :call Clean_PDF_text()<cr>

:command! -nargs=* -range=% Table    <line1>,<line2>!python3 ~/python-tabulate/tabulate.py <q-args>
:command! -nargs=* -range=% Tbl      <line1>,<line2>!python3 ~/python-tabulate/tabulate.py <q-args>
:command! -nargs=0 -range=% Shuffle  <line1>,<line2>!perl ~/perl/shuffle.pl 
:command! -nargs=0 -range=% Reverse  <line1>,<line2>!perl ~/perl/reverse.pl
:command! -nargs=? -range   Splitat  <line1>,<line2>!rexx ~/rexx/splitat.rex <q-args>
:command! -nargs=? -range=% Joinwith <line1>,<line2>!rexx ~/rexx/joinwith.rex <q-args>
:command! -nargs=0 -range=% Invert   <line1>,<line2>!rexx ~/rexx/invert.rex
:command! -nargs=0  Date .!rexx ~/rexx/date_assistant.rex

:command! -nargs=0 -range=% Maketexlist <line1>,<line2>!perl ~/perl/make_tex_list.pl

:command! -nargs=* -range  Drk <line1>,<line2>!rexx ~/rexx/drk.rex <q-args>

:command! -nargs=0 -range=% Random execute ':'.Urndm(<line1>,<line2>)

autocmd FileType text setlocal textwidth=72
autocmd FileType tex  setlocal textwidth=84

autocmd BufLeave,FocusLost * silent! wall 

filetype plugin on 
filetype indent on

au BufNewFile,BufRead *.list   setf packagelist

au BufNewFile,BufRead *.mp     setf mp 
au BufNewFile,BufRead *.mp     set suffixesadd=.mp
au BufNewFile,BufRead *.mp     set path=.,/Users/toby/Library/texmf/metapost,/usr/local/texlive/2014/texmf-dist/metapost/**

au BufNewFile,BufRead *.py     set makeprg=pylint\ --reports=n\ --output-format=parseable\ %:p
au BufNewFile,BufRead *.py     set errorformat=%f:%l:\ %m

au BufNewFile,BufRead *.asy    setfiletype asy

au BufNewFile * silent! 0r ~/.vim/skeleton/template.%:e

:au BufWritePre *.html exe "norm mz"|exe '%s/\(<!-- DATE -->\).\{-\}[0-2]\d:[0-5]\d/\1'.strftime("%a %e %b %Y %H:%M")."/e"|norm `z

autocmd BufWritePre *.go :normal gg=G
autocmd Filetype go setl expandtab tabstop=4 softtabstop=4 shiftwidth=4 noautoindent
autocmd Filetype go set equalprg=gofmt

" Calendar support 
let g:calendar_monday = 1

map <F10> :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>

" get Pathogen going
"
execute pathogen#infect()
