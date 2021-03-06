" Config file for NeoVim

" Plugin Setup
call plug#begin('~/.config/nvim/plugged')

" Themeing / Appearance
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'itchyny/lightline.vim'
Plug 'ryanoasis/vim-devicons'

" Language Support
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
let g:coc_global_extensions = ['coc-emmet', 'coc-css', 'coc-html', 'coc-json', 'coc-prettier', 'coc-tsserver']
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'jiangmiao/auto-pairs'
Plug 'preservim/nerdcommenter'
let g:NERDSpaceDelims = 1
let g:NERDDefaultAlign = 'left'
let g:NERDTrimTrailingWhitespace = 1
let g:NERDToggleCheckAllLines = 1

" UI / UX
Plug 'preservim/nerdtree'
let g:NERDTreeShowHidden = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeIgnore = []
let g:NERDTreeStatusLine = ''
Plug 'maxbrunsfeld/vim-yankstack'

" Fuzzy Search
Plug 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins' }

call plug#end()

" Plugin Settings
" Lightline
let g:lightline = {
	\ 'colorscheme': 'one',
	\ }
" Coc.Nvim
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Misc. UI Settings
set showcmd
set number
set relativenumber
set ignorecase
set smartcase
set cursorline
set visualbell
set title
set virtualedit+=onemore
set formatoptions+=r
set clipboard+=unnamedplus
set mps+=':'
set mps+=":"
set mps+=<:>
set guifont=Monospace:h15
set tabstop=2
set shiftwidth=2

hi CursorLine cterm=bold ctermbg=8

" Mappings
nnoremap ^ 0
nnoremap 0 ^

" Leader Mappings
nnoremap <Space> <NOP>
let mapleader = " "
" NERDTree Commands
map <leader>f :NERDTreeToggle<CR>
" Vim-Yankstack Commands
map <leader>p <plug>yankstack_substitute_older_paste
map <leader>P <plug>yankstack_substitute_newer_paste
" Window/Split Navigation
map <leader>h :wincmd h<CR>
map <leader>j :wincmd j<CR>
map <leader>k :wincmd k<CR>
map <leader>l :wincmd l<CR>
" Remove Search Highlighting
map <leader>n :noh <CR>



" Denite Setup
" Source: https://github.com/ctaylo21/jarvis/blob/master/config/nvim/init.vim
" Note: I have added my own <Tab> and <S-Tab> mappings.

" Wrap in try/catch to avoid errors on initial install before plugin is available
try
" === Denite setup ==="
" Use ripgrep for searching current directory for files
" By default, ripgrep will respect rules in .gitignore
"   --files: Print each file that would be searched (but don't search)
"   --glob:  Include or exclues files for searching that match the given glob
"            (aka ignore .git files)
"
call denite#custom#var('file/rec', 'command', ['rg', '--files', '--glob', '!.git'])

" Use ripgrep in place of "grep"
call denite#custom#var('grep', 'command', ['rg'])

" Custom options for ripgrep
"   --vimgrep:  Show results with every match on it's own line
"   --hidden:   Search hidden directories and files
"   --heading:  Show the file name above clusters of matches from each file
"   --S:        Search case insensitively if the pattern is all lowercase
call denite#custom#var('grep', 'default_opts', ['--hidden', '--vimgrep', '--heading', '-S'])

" Recommended defaults for ripgrep via Denite docs
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'pattern_opt', ['--regexp'])
call denite#custom#var('grep', 'separator', ['--'])
call denite#custom#var('grep', 'final_opts', [])

" Remove date from buffer list
call denite#custom#var('buffer', 'date_format', '')

" Custom options for Denite
"   auto_resize             - Auto resize the Denite window height automatically.
"   prompt                  - Customize denite prompt
"   direction               - Specify Denite window direction as directly below current pane
"   winminheight            - Specify min height for Denite window
"   highlight_mode_insert   - Specify h1-CursorLine in insert mode
"   prompt_highlight        - Specify color of prompt
"   highlight_matched_char  - Matched characters highlight
"   highlight_matched_range - matched range highlight
let s:denite_options = {'default' : {
\ 'split': 'floating',
\ 'start_filter': 1,
\ 'auto_resize': 1,
\ 'source_names': 'short',
\ 'prompt': '/',
\ 'highlight_matched_char': 'QuickFixLine',
\ 'highlight_matched_range': 'Visual',
\ 'highlight_window_background': 'Visual',
\ 'highlight_filter_background': 'DiffAdd',
\ 'winrow': 1,
\ 'vertical_preview': 1
\ }}

" Loop through denite options and enable them
function! s:profile(opts) abort
  for l:fname in keys(a:opts)
    for l:dopt in keys(a:opts[l:fname])
      call denite#custom#option(l:fname, l:dopt, a:opts[l:fname][l:dopt])
    endfor
  endfor
endfunction

call s:profile(s:denite_options)
catch
  echo 'Denite not installed. It should work after running :PlugInstall'
endtry

" === Denite shorcuts === "
"   ;         - Save buffer and Browser currently open buffers
"   <leader>S - Search current directory for occurences of given term and close window if no results
"   <leader>s - Search current directory for occurences of word under cursor
nmap ; :w \| Denite buffer<CR>
nnoremap <leader>S :<C-u>Denite grep:. -no-empty<CR>
nnoremap <leader>s :<C-u>DeniteCursorWord grep:.<CR>

" Denite Tab/S-Tab Wrapping Functions
function! s:down_wrap()
	if line('.') == line('$')
		normal! gg
	else
		normal! j
	endif
endfunction
function! s:up_wrap()
	if line('.') == 1
		normal! G
	else
		normal! k
	endif
endfunction

" Define mappings while in 'filter' mode
"   <C-o>         - Switch to normal mode inside of search results
"   <Esc>         - Exit denite window in any mode
"   <CR>          - Open currently selected file in any mode
"   <C-t>         - Open currently selected file in a new tab
"   <C-v>         - Open currently selected file a vertical split
"   <C-h>         - Open currently selected file in a horizontal split
"   <Tab>					- Select next file
"   <S-Tab>				- Select previous file
autocmd FileType denite-filter call s:denite_filter_my_settings()
function! s:denite_filter_my_settings() abort
  imap <silent><buffer> <C-o>
  \ <Plug>(denite_filter_quit)
  inoremap <silent><buffer><expr> <Esc>
  \ denite#do_map('quit')
  nnoremap <silent><buffer><expr> <Esc>
  \ denite#do_map('quit')
  inoremap <silent><buffer><expr> <CR>
  \ denite#do_map('do_action')
  inoremap <silent><buffer><expr> <C-t>
  \ denite#do_map('do_action', 'tabopen')
  inoremap <silent><buffer><expr> <C-v>
  \ denite#do_map('do_action', 'vsplit')
  inoremap <silent><buffer><expr> <C-h>
  \ denite#do_map('do_action', 'split')
	imap <silent><buffer> <Tab>
				\ <Plug>(denite_filter_quit):call <SID>down_wrap()<CR>i
	imap <silent><buffer> <S-Tab>
				\ <Plug>(denite_filter_quit):call <SID>up_wrap()<CR>i
endfunction

" Define mappings while in denite window
"   <CR>        - Opens currently selected file
"   q or <Esc>  - Quit Denite window
"   d           - Delete currenly selected file
"   p           - Preview currently selected file
"   <C-o> or i  - Switch to insert mode inside of filter prompt
"   <C-t>       - Open currently selected file in a new tab
"   <C-v>       - Open currently selected file a vertical split
"   <C-h>       - Open currently selected file in a horizontal split
"   <Tab>				- Select next file and return to filter mode
"   <S-Tab>			- Select previous file and return to filter mode
autocmd FileType denite call s:denite_my_settings()
function! s:denite_my_settings() abort
  nnoremap <silent><buffer><expr> <CR>
  \ denite#do_map('do_action')
  nnoremap <silent><buffer><expr> q
  \ denite#do_map('quit')
  nnoremap <silent><buffer><expr> <Esc>
  \ denite#do_map('quit')
  nnoremap <silent><buffer><expr> d
  \ denite#do_map('do_action', 'delete')
  nnoremap <silent><buffer><expr> p
  \ denite#do_map('do_action', 'preview')
  nnoremap <silent><buffer><expr> i
  \ denite#do_map('open_filter_buffer')
  nnoremap <silent><buffer><expr> <C-o>
  \ denite#do_map('open_filter_buffer')
  nnoremap <silent><buffer><expr> <C-t>
  \ denite#do_map('do_action', 'tabopen')
  nnoremap <silent><buffer><expr> <C-v>
  \ denite#do_map('do_action', 'vsplit')
  nnoremap <silent><buffer><expr> <C-h>
  \ denite#do_map('do_action', 'split')
	nmap <silent><buffer> <Tab> :call <SID>down_wrap()<CR>i
	nmap <silent><buffer> <S-Tab> :call <SID>up_wrap()<CR>i
endfunction
