" plugins config {{{
" ultisnips config
let g:UltiSnipsExpandTrigger="<c-l>"
let g:UltiSnipsListSnippets="<c-k>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:UltiSnipsSnippetDirectories=["~/.config/nvim/plugged/vim-snippets/UltiSnips"]

" vim-gitgutter
"
if executable('ag')
	let g:gitgutter_grep_command = 'ag'
	set grepprg=ag\ --nogroup\ --nocolor
endif

" lightline config test
let g:lightline = {
			\ 'colorscheme': 'default',
			\ 'active': {
			\   'left': [ [ 'mode', 'paste' ],
			\             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
			\ },
			\ 'component_function': {
			\   'gitbranch': 'fugitive#head'
			\ },
			\ }

" nvim-r config
command RStart let oldft=&ft | set ft=r | exe 'set ft='.oldft | let b:IsInRCode = function("DefaultIsInRCode") | normal <LocalLeader>rf
let R_notmuxconf=1
let R_nvim_wd=1
let R_in_buffer = 0
let R_applescript = 0
let R_tmux_split = 1

" closetag config
" filenames like *.xml, *.html, *.xhtml, ...
" Then after you press <kbd>&gt;</kbd> in these files, this plugin will try to close the current tag.
let g:closetag_filenames = '*.html,*.xhtml,*.phtml'
" filenames like *.xml, *.xhtml, ...
" This will make the list of non closing tags self closing in the specified files.
let g:closetag_xhtml_filenames = '*.xhtml,*.jsx'

" integer value [0|1]
" This will make the list of non closing tags case sensitive (e.g. `<Link>` will be closed while `<link>` won't.)
let g:closetag_emptyTags_caseSensitive = 1

" Shortcut for closing tags, default is '>'
let g:closetag_shortcut = '>'

" Add > at current position without closing the current tag, default is ''
let g:closetag_close_shortcut = '<leader>>'

" ncm2 config
autocmd BufEnter * call ncm2#enable_for_buffer()
au TextChangedI * call ncm2#auto_trigger()

" }}}

" plugins' bindings {{{
" nvim-r bindings
vmap <Space> <Plug>RDSendSelection
nmap <Space> <Plug>RDSendLine

" fzf bindings
"
nnoremap <leader>f :Files<cr>
nnoremap <leader>b :Buffers<cr>

" fugitive bindings
"
nnoremap <leader>gs :Gstatus<cr>
nnoremap <leader>gf :Gfetch<cr>
nnoremap <leader>gp :Gpush<cr>
nnoremap <leader>gm :Gmerge<cr>
nnoremap <leader>gl :Glog<cr>
" }}}

" basic config {{{
syntax on
filetype plugin on

set encoding=utf-8
set foldmethod=indent
set path+=**,/usr/local/include
set nofoldenable
set bs=2

" backup options and locations {{{
set backupdir=~/.vim/tmp
set dir=~/.vim/tmp
set backup

" }}}
" set mouse all actions
set mouse=a
set tabpagemax=100
" auto refresh
set autowrite
set autoread
set wildmenu
set ruler         " show cursor position in bottom line
" y and d put stuff into system clipboard (so that other apps can see it)
set clipboard=unnamed,unnamedplus
set nowrap
set textwidth=0
set ttimeout
set timeoutlen=500
set ttimeoutlen=100 " timeout when keypress belong to any combos
set number

set cscopetag
set tags=tags;

" }}}

" quality of live improvement bindings {{{
" basic binding
let mapleader=' '
let maplocalleader='\\'

" map key for fast split-switching
" nmap <C-j> <C-w>j
" nmap <C-k> <C-w>k
" nmap <C-l> <C-w>l
" nmap <C-h> <C-w>h
nnoremap <leader>ei <ESC>:cope<CR>
nnoremap <leader>eo <ESC>:ccl<CR>
" }}}

" Tab related stuffs {{{
set shiftround    " when shifting non-aligned set of lines, align them to next tabstop
set smarttab
set noexpandtab
set smartindent

" visual mode indent stuffs
vnoremap <silent> <TAB> >gv
vnoremap <silent> <S-TAB> <gv

" " copy to system clipboard
nnoremap gy "+y
" copy to end of line
nnoremap Y y$
" " copy whole file to system clipboard
nnoremap gY gg"+yG
" }}}

" list stuff {{{
set listchars=tab:>-,trail:·
set list
" }}}

" Searching {{{
set incsearch
set hlsearch
set ignorecase    " default should ignore case
set smartcase     " use case sensitive if I use uppercase
" }}}

" autocompletion stuffs {{{
set completeopt=noinsert,menuone,noselect
set complete-=i
set complete+=t

" completion with tab
inoremap <silent><expr><CR>    pumvisible () ? "\<c-y>" : "\<CR>"
inoremap <silent><expr><TAB>   pumvisible () ? "\<C-n>" : "\<TAB>"
inoremap <silent><expr><S-TAB> pumvisible () ? "\<C-p>" : "\<S-TAB>"

" autocomplete insertmode mapping
inoremap ;f <c-x><c-f>
inoremap ;p <c-x><c-p>
inoremap ;o <c-x><c-o>
inoremap ;i <c-x><c-i>
inoremap ;s <c-x><c-s>
inoremap ;d <c-x><c-d>
inoremap ;t <c-x><c-]>
" }}}

" split and visual {{{
set lazyredraw
set splitbelow
set cmdheight=2

" }}}

" color settings {{{
if (has("termguicolors"))
	set termguicolors
	if &term =~# '^screen'
		let &t_8f = "\<Esc>[38:2:%lu:%lu:%lum"
		let &t_8b = "\<Esc>[48:2:%lu:%lu:%lum"
	endif
endif
if (&term =~ '256color')
	set t_ut=
endif

set bg=dark
" colorscheme jellybeans
" }}}

" grep stuffs {{{
if executable('ag')
	let grepprg='ag --vimgrep --nogreoup --nocolor'
endif
" }}}

" diff settings {{{ 
set diffopt+=algorithm:patience
" }}}

" {{{ autocommands groups
augroup programming
	au Filetype cpp setlocal tabstop=2 expandtab shiftwidth=2 smartindent foldmethod=syntax equalprg=clang-format\ \-style\=\"\{BasedOnStyle:\ google,\ IndentWidth\:\ 2\}\"
	au Filetype c setlocal tabstop=8 noexpandtab shiftwidth=8 smartindent foldmethod=syntax
	au Filetype vim setlocal foldmethod=marker
	au Filetype javascript setlocal foldmethod=marker expandtab tabstop=4 shiftwidth=4 smartindent
augroup END
" }}}
