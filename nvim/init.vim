" === Plugins
function! PackInit() abort
  packadd minpac

  call minpac#init()
  call minpac#add('k-takata/minpac', {'type': 'opt'})
  call minpac#add('sheerun/vim-polyglot', {'type': 'opt'})
  call minpac#add('neoclide/coc.nvim', {'branch': 'release'})
  call minpac#add('jparise/vim-graphql')
  call minpac#add('jonsmithers/vim-html-template-literals')
  call minpac#add('fatih/vim-go')
  call minpac#add('vimwiki/vimwiki')
  call minpac#add('editorconfig/editorconfig-vim')
  call minpac#add('bmartel/vim-snippets')
  call minpac#add('tpope/vim-commentary')
  call minpac#add('tpope/vim-surround')
  call minpac#add('nvim-lua/plenary.nvim')
  call minpac#add('nvim-telescope/telescope.nvim', { 'branch': '0.1.x' })
  call minpac#add('dyng/ctrlsf.vim')
  call minpac#add('justinmk/vim-sneak')
  call minpac#add('bmartel/shades-of-purple.vim')
  call minpac#add('bmartel/vim-one')
  call minpac#add('artanikin/vim-synthwave84')
  call minpac#add('morhetz/gruvbox')
  call minpac#add('romainl/vim-dichromatic')
  call minpac#add('godlygeek/tabular')
  call minpac#add('plasticboy/vim-markdown')
  call minpac#add('github/copilot.vim')
  call minpac#add('iloginow/vim-stylus')
endfunction

command! PackUpdate call PackInit() | call minpac#update('', {'do': 'call minpac#status()'})
command! PackClean  call PackInit() | call minpac#clean()
command! PackStatus call PackInit() | call minpac#status()
command! -nargs=0 Prettier :CocCommand prettier.formatFile
" === /Plugins

" === Base Config
set iskeyword+=-                                 " treat dash separated words as a word text object"
set autoread                                     " reload on external file changes
set backspace=indent,eol,start                   " backspace behaviour
set clipboard=unnamed,unnamedplus                " enable clipboard
set encoding=utf8                                " enable utf8 support
set hidden                                       " hide buffers, don't close
set mouse=a                                      " enable mouse support
set nowrap                                       " disable wrapping
set number relativenumber                        " show line numbers
set textwidth=120                                " set width of all text
set wildmenu wildmode=longest:full,full          " wildmode settings
set splitbelow                                   " split panes on the bottom
set splitright                                   " split panes to the right
set formatoptions+=j                             " Delete comment character when joining commented lines

filetype plugin indent on                        " enable filetype detection
set listchars=eol:?,trail:?,tab:?\               " whitespace characters
set scrolloff=999                                " center cursor position vertically
set showbreak=?\                                 " Wrapping character
set showmatch                                    " show matching brackets
syntax on                                        " enable syntax highlightning

set laststatus=2
set autoindent expandtab                         " autoindentation & tabbing
set shiftwidth=2 softtabstop=2 tabstop=2         " 1 tab = 2 spaces

set hlsearch incsearch smartcase                 " search options

set nobackup noswapfile nowritebackup            " disable backup/swap files
set undofile undodir=~/.vim/undo undolevels=9999 " undo options

"set lazyredraw                                   " enable lazyredraw
set nocursorline                                 " disable cursorline
set ttyfast                                      " enable fast terminal connection
set updatetime=300                               " Faster completion
set timeoutlen=300                               " By default timeoutlen is 1000 ms

set termguicolors
let &t_ut=''
set background=dark
let g:one_allow_italics = 1
colorscheme one

set guifont=Operator\ Mono\ Book:h15
set guioptions-=m  "menu bar
set guioptions-=T  "toolbar
set guioptions-=r  "scrollbar right
set guioptions-=L  "scrollbar left
hi Comment gui=italic cterm=italic
hi htmlArg gui=italic cterm=italic
hi LineNr     ctermbg=NONE guibg=NONE
hi SignColumn ctermbg=NONE guibg=NONE
hi VertSplit ctermbg=NONE guibg=NONE

autocmd BufNewFile,BufRead *.prisma setfiletype graphql
autocmd BufNewFile,BufRead *.tsx set filetype=typescript.jsx
autocmd BufNewFile,BufRead *.rs call RemapFormatRust()
autocmd TermOpen * setlocal nonumber norelativenumber

"" COC plugins
let g:coc_global_extensions = [
  \ 'coc-css',
  \ 'coc-emmet',
  \ 'coc-highlight',
  \ 'coc-html',
  \ 'coc-json',
  \ 'coc-snippets',
  \ 'coc-deno',
  \ 'coc-prisma',
  \ 'coc-eslint',
  \ 'coc-prettier',
  \ 'coc-tsserver'
\ ]

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
"" NetRW file list styles
let g:netrw_banner = 0
let g:netrw_liststyle = 1
let g:netrw_browse_split = 0
let g:netrw_altv = 1

"" Vim Sneak
let g:sneak#label = 1

"" Vim Wiki
let g:vimwiki_list = [{'path': '~/vimwiki/', 'nested_syntaxes': {'tsx': 'typescript.jsx', 'ts': 'typescript'}}]
"" \ 'syntax': 'markdown', 'ext': '.md'
function! RenameFile()
  let old_name = expand('%')
  let new_name = input('New file name: ', expand('%'), 'file')
  if new_name != '' && new_name != old_name
    exec ':saveas ' . new_name
    exec ':silent !rm ' . old_name
    redraw!
  endif
endfunction

function! RemapNetrw()
  nnoremap <buffer><leader>k :bd<CR>
endfunction

function! CRustFmt()
    exec ":silent !cargo fmt -- " . bufname("%")
endfunction

function! RemapFormatRust()
  nnoremap <leader>fp :call CRustFmt()<CR>
endfunction

augroup Netrw 
  autocmd!
  autocmd filetype netrw call RemapNetrw()
augroup END

" === /Base Config

" === Mappings
let mapleader=" "                               " leader key

nnoremap <leader># :g/\v^(#\|$)/d_<cr>|          " delete commented/blank lines
nnoremap <leader>d :w !diff % -<cr>|             " show diff
nnoremap <silent> <leader>id gg=G``<cr>|          " fix indentation
nnoremap <leader>rt :retab<cr>|                   " convert tabs to spaces
nnoremap <silent> <leader>ts :%s/\s\+$//e<cr>|    " trim whitespace
nnoremap <leader>tw :set wrap! wrap?<cr>|         " toggle wrapping

"" Vim Wiki
nmap <leader>vw <Plug>VimwikiIndex
nmap <leader>vq <Plug>VimwikiUISelect
nmap <leader>vt <Plug>VimwikiTabIndex
nmap <leader>vi <Plug>VimwikiDiaryIndex
nmap <leader>vd <Plug>VimwikiMakeDiaryNote
nmap <leader>vD <Plug>VimwikiTabMakeDiaryNote
nmap <leader>vy <Plug>VimwikiMakeYesterdayDiaryNote
nmap <leader>vm <Plug>VimwikiMakeTomorrowDiaryNote
nmap <leader>vc <Plug>Vimwiki2HTML
nmap <leader>vb <Plug>Vimwiki2HTMLBrowse
nmap <leader>vg <Plug>VimwikiDiaryGenerateLinks
nmap <leader>vl <Plug>VimwikiDeleteLink
nmap <leader>vr <Plug>VimwikiRenameLink

"" Toggle light/dark background
map <leader>x :let &background = ( &background == "dark"? "light" : "dark" )<CR>
map <leader>X :exec 'colorscheme' (g:colors_name ==# 'shades_of_purple') ? 'dichromatic' : 'shades_of_purple'<CR>

"" Rename current file
nnoremap <leader>rr :call RenameFile()<cr>

"" Delete current file
nnoremap <leader>rm :call delete(expand('%')) \| bdelete!<CR>

"" Clean search (highlight)
nnoremap <silent> <leader>h :noh<CR>

"" Reopen last closed buffer in vertical split
nnoremap <leader>rv :vs#<CR>

"" Reopen last closed buffer in vertical split
nnoremap <leader>rh :sp#<CR>

"" Show buffer list/switch
nnoremap <silent> <leader>b :ls<CR>:e #

"" Buffer nav
noremap <leader>bq :bp<CR>
noremap <leader>bp :bn<CR>

"" Close current buffer
noremap <leader>c :bd<CR>

"" Force Close current buffer
noremap <leader>C :bd!<CR>

"" Close all buffers
function! CleanEmptyBuffers()
  let buffers = filter(range(1, bufnr('$')), 'buflisted(v:val) && empty(bufname(v:val)) && bufwinnr(v:val)<0 && !getbufvar(v:val, "&mod")')
  if !empty(buffers)
      exe 'bw ' . join(buffers, ' ')
  endif
endfunction
noremap <leader>ac :%bd<CR>
noremap <leader>oc :%bd<CR><C-O>:bd#<CR>
noremap <leader>ae :call CleanEmptyBuffers()<CR>

noremap <leader>it :put =strftime('%s')<CR>

"" maintain Visual Mode after shifting > and <
vmap < <gv
vmap > >gv

"" move a  visual block up or down
xnoremap K :move '<-2<CR>gv-gv
xnoremap J :move '>+1<CR>gv-gv

"" search will center on the line it's found in.
nnoremap n nzzzv
nnoremap N Nzzzv

"" Change windows
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

"" Close all other windows
nmap <C-w>c :enew<bar>bd #<CR>

" save
nnoremap <silent> <C-s> :w<CR>
" quit
nnoremap <silent> <C-Q> :wq!<CR>
" control-c instead of escape
nnoremap <silent> <C-c> <Esc>
"" escape
inoremap jk <Esc>
inoremap kj <Esc>

" Better nav for omnicomplete
inoremap <expr> <c-j> ("\<C-n>")
inoremap <expr> <c-k> ("\<C-p>")
"
"" Move visual block
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

cnoremap <C-P> <C-R>=expand("%:p:h") . "/" <CR>

"" Set working directory
nnoremap <leader>. :lcd %:p:h<CR>

"" Create new file with the current path filled in
noremap <leader>mf :!touch <C-R>=expand("%:p:h") . "/" <CR>

"" Create new directory with the current path filled in
noremap <leader>md :!mkdir <C-R>=expand("%:p:h") . "/" <CR>

"" Open an edit command with the path of the currently edited file path filled in
noremap <leader>ef :e <C-R>=expand("%:p:h") . "/" <CR>

"" Tabs
nnoremap <A-n> :tabnew<CR>
nnoremap <A-c> :tabc<CR>
nnoremap <A-y> :tabe <C-R>=expand("%:p:h") . "/" <CR>
nnoremap <A-j> :tabn<CR>
nnoremap <A-k> :tabp<CR>
nnoremap <A-o> :tabo<CR>

" Terminal
nnoremap <leader>T :terminal<CR>
tnoremap <Esc> <C-\><C-n>
tnoremap <C-w>h <C-\><C-n><C-w>h
tnoremap <C-w>j <C-\><C-n><C-w>j
tnoremap <C-w>k <C-\><C-n><C-w>k
tnoremap <C-w>l <C-\><C-n><C-w>l

" NetRW file explorer
nnoremap <leader>k :Explore<CR>

"" Edit VIMRC
nmap <silent> <leader>ev :edit $MYVIMRC<CR>

"" Source VIMRC
nmap <silent> <leader>ee :source $MYVIMRC<CR>

"" Abbreviations
cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev Qall! qall!
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev WQ wq
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qall qall
" === /Mappings

" === Plugin Mappings
let $FZF_DEFAULT_COMMAND = 'rg --files'
let $FZF_DEFAULT_OPTS = '--reverse'
let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.8 } }
let g:ctrlsf_search_mode = 'async'
let g:ctrlsf_winsize = '50%'
let g:ctrlsf_position = 'left'
let g:ctrlsf_ackprg = 'rg'

"" CtrlSF - sublime text-esque global search and replace
nmap     <leader>ff <Plug>CtrlSFPrompt
vmap     <leader>ff <Plug>CtrlSFVwordPath
vmap     <leader>fF <Plug>CtrlSFVwordExec
nmap     <leader>fn <Plug>CtrlSFCwordPath
nmap     <leader>fp <Plug>CtrlSFPwordPath
nnoremap <leader>fo :CtrlSFOpen<CR>
nnoremap <leader>ft :CtrlSFToggle<CR>

"" Fuzzy match text in files
nnoremap <leader>sf <cmd>lua require('telescope.builtin').find_files()<cr>
"" Fuzzy match files
nnoremap <leader>sg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>sb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>sh <cmd>lua require('telescope.builtin').help_tags()<cr>

"" Format file with prettier
nnoremap <leader>fp :Prettier<CR>

vmap <leader>ls :sort /\/[A-z]/ <CR>
vmap <leader>lS :sort <CR>
vmap <leader>lh :!column -t -o ' '<CR>

inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
inoremap <silent><expr> <C-x><C-z> coc#pum#visible() ? coc#pum#stop() : "\<C-x>\<C-z>"
" remap for complete to use tab and <cr>
inoremap <silent><expr> <TAB>
    \ coc#pum#visible() ? coc#pum#next(1):
    \ <SID>check_back_space() ? "\<Tab>" :
    \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
inoremap <silent><expr> <c-space> coc#refresh()
" === /Plugin Mappings
