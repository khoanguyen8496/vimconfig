" quality of live improvement bindings {{{
" basic binding
let mapleader=' '
let maplocalleader='\\'

nnoremap <leader>ei <ESC>:cope<CR>
nnoremap <leader>eo <ESC>:ccl<CR>
nmap <leader>w <ESC>:w<CR>
nmap <leader>m <ESC>:make!<CR>:cope<CR>
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

" For conceal markers.
if has('conceal')
	set conceallevel=2 concealcursor=niv
endif

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

" ale config {{{
let g:ale_enabled=0
let g:ale_linters = {'go': ['gopls']}
let g:ale_fixers = {'go': ['gofmt', 'goimports']}
" let g:ale_linters = {'go': []}
" let g:ale_fixers = {'go': []}
let g:ale_fix_on_save = 1
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0
let g:ale_lint_on_enter = 0
" nmap <leader>gd <Plug>(ale_go_to_definition)
" nmap <leader>gr <Plug>(ale_find_references)
" set omnifunc=ale#completion#OmniFunc
" }}}
"
"languageclient-nvim
let g:LanguageClient_serverCommands = {
\ 'go': ['gopls'],
\ }

" nvim-r config
" ncm2 config
" autocmd BufEnter * call ncm2#enable_for_buffer()
" au TextChangedI * call ncm2#auto_trigger()
" vim-go config {{{

" let g:go_code_completion_enabled = 0
" }}}
" deoplete config {{{
" let g:deoplete#enable_at_startup = 1
" let g:python3_host_prog='/usr/local/Cellar/python/3.7.6_1/bin/python3'

" augroup DeopleteConfig
" autocmd!
" autocmd VimEnter * call deoplete#custom#option({
" 	\ 'max_list': 50,
" 	\ 'auto_complete_delay': 100,
" 	\ 'smart_case': v:true,
" 	\ 'min_pattern_length': 3,
" 	\ 'yarp': v:true,
" 	\ 'skip_multibyte': v:true,
" 	\ 'skip_chars': ['(', ')', '<', '>'],
" 	\ 'sources': {
" 		\ '_': ['buffer', 'file'],
" 		\ 'go': ['ale']},
" 	\ })
" augroup END
" }}} deoplete
" }}}

" plugins' bindings {{{

" fzf bindings
"
nnoremap <leader>f :FZF<cr>
" nnoremap <leader>b :Buffers<cr>

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

" temporary disable to use mucomplete
" completion with tab
" inoremap <silent><expr><CR>    pumvisible () ? "\<c-y>" : "\<CR>"
" inoremap <silent><expr><TAB>   pumvisible () ? "\<C-n>" : "\<TAB>"
" inoremap <silent><expr><S-TAB> pumvisible () ? "\<C-p>" : "\<S-TAB>"

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
	nmap <buffer> <F5> <ESC>:set makeprg=make<CR>
	nmap <buffer> <F3> <ESC>:set makeprg=go\ build<CR>
	nmap <buffer> <F7> <ESC>:set makeprg=go\ run\ %<CR>
endfunction
function LC_maps()
	if has_key(g:LanguageClient_serverCommands, &filetype)
		nnoremap <buffer> <silent> K :call LanguageClient#textDocument_hover()<cr>
		nnoremap <buffer> <silent> gd :call LanguageClient#textDocument_definition()<CR>
		nnoremap <buffer> <silent> <F2> :call LanguageClient#textDocument_rename()<CR>
	endif
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
	au FileType * call LC_maps()
augroup END

" augroup file_events
" 	au BufWritePre *.go call PreHookGolang()
" augroup END
" }}}
