" quality of live improvement bindings {{{
" basic binding
let mapleader=' '
let maplocalleader='\\'

nnoremap <leader>ei <ESC>:cope<CR>
nnoremap <leader>eo <ESC>:ccl<CR>
nmap <leader>w <ESC>:w<CR>
nmap <leader>m <ESC>:make!<CR>:cope<CR>
map ]db /<<<<<<< HEAD<cr>
map [db ?<<<<<<< HEAD<cr>
map ]dm /=======<cr>
map [dm ?=======<cr>
map ]de />>>>>>><cr>
map [de ?>>>>>>><cr>
" }}}

" basic config {{{
syntax on
filetype plugin on

set encoding=utf-8
set foldmethod=indent
set path+=**,/usr/local/include,~/go/src
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
set scrolloff=1

set cscopetag
set tags+=~/.tags,tags

" }}}

" plugins config {{{
" ultisnips config
let g:UltiSnipsExpandTrigger="<c-l>"
let g:UltiSnipsListSnippets="<c-k>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
let g:UltiSnipsSnippetDirectories=["~/.config/nvim/plugged/vim-snippets/UltiSnips"]

" vim-gitgutter
"
" grep config {{{
if executable('ag')
	let g:gitgutter_grep_command = 'ag'
	set grepprg=ag\ --nogroup\ --nocolor
endif
if executable('rg')
	let g:gitgutter_grep_command = 'rg'
	set grepprg=rg\ --vimgrep
endif
nmap <leader><leader>g :grep! <cword><cr>
"}}}

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

" ale config {{{
let g:ale_linters = {'go': ['gopls']}
let g:ale_fixers = {'go': ['gofmt', 'goimports']}
let g:ale_fix_on_save = 1
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0
let g:ale_lint_on_enter = 0
nmap <leader>gd <Plug>(ale_go_to_definition)
nmap <leader>gr <Plug>(ale_find_references)
set omnifunc=ale#completion#OmniFunc
" }}}

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
" autocmd BufEnter * call ncm2#enable_for_buffer()
" au TextChangedI * call ncm2#auto_trigger()

" }}}

" plugins' bindings {{{

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
nnoremap gY mzgg"+yG'z
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

" split and visual {{{
set lazyredraw
set splitbelow
set splitright
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
colorscheme jellybeans
" }}}


" diff settings {{{ 
set diffopt+=algorithm:patience
" }}}


func FancyGoBinding()
	setlocal keywordprg=go\ doc
	nmap <buffer> <F4> <ESC>:set makeprg=golangci-lint\ run<CR>
	nmap <buffer> <F5> <ESC>:set makeprg=make<CR>
	nmap <buffer> <F6> <ESC>:set makeprg=GO111MODULE=off\  make<CR>
	nmap <buffer> <F3> <ESC>:set makeprg=go\ build<CR>
	nmap <buffer> <F7> <ESC>:set makeprg=go\ run\ %<CR>
endfunction
" {{{ autocommands groups
augroup programming
	au Filetype cpp setlocal tabstop=2 expandtab shiftwidth=2 smartindent foldmethod=syntax equalprg=clang-format\ \-style\=\"\{BasedOnStyle:\ google,\ IndentWidth\:\ 2\}\"
	au Filetype c setlocal tabstop=8 noexpandtab shiftwidth=8 smartindent foldmethod=syntax
	au Filetype vim setlocal foldmethod=marker
	au Filetype javascript setlocal foldmethod=marker expandtab tabstop=4 shiftwidth=4 smartindent
	au Filetype go setlocal tabstop=8 noexpandtab shiftwidth=8 colorcolumn=101 smartindent foldmethod=syntax keywordprg=go\ doc
	au Filetype go call FancyGoBinding()
	au FileType yaml setlocal tabstop=2 shiftwidth=2 smartindent expandtab
	au FileType xml setlocal tabstop=4 shiftwidth=4 smartindent expandtab
augroup END
" }}}

" {{{ defx mappings
" augroup khoa_defx_settings
" 	au FileType defx call DefxMapping()
" augroup END

" function! KhoaDefxTrigger()
" 	let MyColumns=winwidth(0)/3
" 	:Defx -split=vertical -direction=topleft -winwidth=MyColumns<cr>
" endfunction
" nnoremap <silent> - :Defx -split=vertical -direction=topleft -winwidth=35<cr>
" nnoremap <silent> <F3> :Defx -split=vertical -direction=topleft -winwidth=35 -toggle<cr>
" function! DefxMapping()
" 	" open stuffs
" 	nnoremap <silent><buffer><expr> <CR> defx#do_action('open_or_close_tree')
" 	nnoremap <silent><buffer><expr> v defx#do_action('open', 'vsplit')
" 	nnoremap <silent><buffer><expr> o defx#do_action('open', 'vsplit')
" 	nnoremap <silent><buffer><expr> s defx#do_action('open', 'split')

" 	" change vim cwd
" 	nnoremap <silent><buffer><expr> - defx#do_action('cd', '..')
" 	nnoremap <silent><buffer><expr> cd defx#do_action('change_vim_cwd')
" 	nnoremap <silent><buffer><expr> ! defx#do_action('execute_command')


" 	nnoremap <silent><buffer><expr> nd defx#do_action('new_directory')
" 	nnoremap <silent><buffer><expr> nf defx#do_action('new_file')
" 	nnoremap <silent><buffer><expr> d defx#do_action('remove')
" 	nnoremap <silent><buffer><expr> st defx#do_action('toggle_sort', 'time')
" 	nnoremap <silent><buffer><expr> q defx#do_action('quit')
" endfunction
" }}}
