" Vim filetype plugin file
" Language:	Rexx
" Maintainer:	Toby Thurston toby@cpan.org
" Last Change:  25 Jan 2010
" URL:		http://www.wildfire.dircon.co.uk/vim/ftplugin

if exists("b:did_ftplugin") | finish | endif
let b:did_ftplugin = 1

setlocal formatoptions+=crq
setlocal keywordprg=rexxdoc

setlocal commentstring=/*\ %s*/

setlocal makeprg=rexx\ -c\ %\ /dev/null
setlocal shiftwidth=2
