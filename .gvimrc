"set guifont=Consolas:h14
:set guifont=Monaco:h12
:set pfn=Monaco:h9
:colorscheme thurston
"Pack my box with five dozen liquor jugs 1234567890  !@£$%^&*()[]{}
"Pack my box with five dozen liquor jugs 1234567890  !@£$%^&*()[]{}
"Pack my box with five dozen liquor jugs .,;:
:set lines=52 columns=120

:set guioptions=-t
:set guioptions=+e
:set vb t_vb=

macmenu Edit.Font.Bigger key=<nop>
imap <D-=> <C-O>:py3f ~/python-vim-proust/proust.py<CR>

nnoremap <D-8> /<C-R>=getline('.')<CR><CR>
noremap <D-]> :py3f ~/python/go_streetmap.py<CR>
"noremap <D-]> :pyf ~/python/go_google.py<CR>

nnoremap <D-j> :m .+1<CR>==
nnoremap <D-k> :m .-2<CR>==
inoremap <D-j> <Esc>:m .+1<CR>==gi
inoremap <D-k> <Esc>:m .-2<CR>==gi
vnoremap <D-j> :m '>+1<CR>gv=gv
vnoremap <D-k> :m '<-2<CR>gv=gv
