
"------------------------------------------------------------------------------
"   .----. .-.   .-.  .--.  .----.  .---. .----..-.
"   | {}  }|  `.'  | / {} \ | {}  }{_   _}| {_  | |
"   | {}  }| |\ /| |/  /\  \| .-. \  | |  | {__ | `--.
"   `----' `-' ` `-'`-'  `-'`-' `-'  `-'  `----'`----'
" .-. .-..-..-.   .-. .---.  .----. .-. .-..----..-. .---.
" | | | || ||  `.'  |/  ___}/  {}  \|  `| || {_  | |/   __}
" \ \_/ /| || |\ /| |\     }\      /| |\  || |   | |\  {_ }
"  `---' `-'`-' ` `-' `---'  `----' `-' `-'`-'   `-' `---'
"------------------------------------------------------------------------------


"------------------------------------------------------------------------------
" GENERAL
" ------------------------------------------------------------------------------
set encoding=utf-8                  " Ensure encoding is UTF-8
set nocompatible                    " Disable Vi compatability
set binary
set noeol                           " No automatic end of line additions
set timeoutlen=1000 ttimeoutlen=0   " reduce timeout required for key to register
set hidden
set synmaxcol=128
syntax sync minlines=256

"------------------------------------------------------------------------------
" PlUGIN CONFIG
"------------------------------------------------------------------------------
call plug#begin( '~/.vim/plugged')

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-jedi'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' } " Sidebar file tree
Plug 'itchyny/lightline.vim'              " Status bar
Plug 'terryma/vim-multiple-cursors'       " Add Sublime text style multiple cursors
Plug 'easymotion/vim-easymotion'          " Quick movement within files
Plug 'brooth/far.vim'
Plug 'junegunn/fzf', { 'do': '~/.fzf/install --all' }
Plug 'junegunn/fzf.vim'                   " Quick fuzzy finder
Plug 'dyng/ctrlsf.vim'                    " Sublime text style search window
Plug 'SirVer/ultisnips'
Plug 'dyng/ctrlsf.vim'                    " Sublime text style search window
Plug 'bmartel/vim-snippets'               " Snippets!
Plug 'tpope/vim-commentary'               " Quickly comment lines out and in
Plug 'tpope/vim-fugitive'                 " Help formatting commit messages
Plug 'tpope/vim-surround'                 " Quickly change surrounding braces/quotes etc
Plug 'christoomey/vim-system-copy'        " Better control of buffer <-> clipboard
Plug 'christoomey/vim-sort-motion'        " Allows for quick line sorting
Plug 'tommcdo/vim-exchange'               " Text object swapping
Plug 'w0rp/ale'                           " Async Linter
Plug 'pangloss/vim-javascript'            " Javascript syntax highlighting
Plug 'posva/vim-vue'                    " Vue file syntax highlighting
Plug 'mattn/emmet-vim'                  " Emmet html completion
Plug 'editorconfig/editorconfig-vim'      " Allow editorconfig to maintain syntax settings
Plug 'kshenoy/vim-signature'              " Vim marks easier bindings and highlights
" Plug 'elmcast/elm-vim'                  " Elm syntax and helpers
" Plug 'leafgarland/typescript-vim'       " Typescript syntax highlighting
" Plug 'mxw/vim-jsx'                        " React jsx syntax
" Plug 'kchmck/vim-coffee-script'         " Coffeescript syntax highlighting
" Plug 'lumiliet/vim-twig'                " Twig template syntax highlighting
" Plug 'jceb/vim-orgmode'                 " Task manager
" Plug 'python-mode/python-mode', { 'branch': 'develop', 'for': 'python' } " Python ide
" Plug 'mustache/vim-mustache-handlebars' " Handlebars syntax
Plug 'bmartel/vim-one'                    " Customized take on atoms one dark
Plug 'NovaDev94/lightline-onedark'        " Onedark lightline theme

call plug#end()

"------------------------------------------------------------------------------
" FUNCTIONS
"------------------------------------------------------------------------------
"" Keep certain windows open when closing all others
function! OnlyAndNerdtree()
  let currentWindowID = win_getid()

  windo if win_getid() != currentWindowID && &filetype != 'nerdtree' && &filetype != 'org' | close | endif
  call win_gotoid(currentWindowID)
endfunction

command! Only call OnlyAndNerdtree()


"------------------------------------------------------------------------------
" DEOPLETE
"------------------------------------------------------------------------------
let g:deoplete#enable_at_startup = 1

"------------------------------------------------------------------------------
" EMMET CONFIG
"------------------------------------------------------------------------------
let g:user_emmet_expandabbr_key='<Tab>'

"------------------------------------------------------------------------------
" SNIPPETS CONFIG
"------------------------------------------------------------------------------
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<C-j>"
let g:UltiSnipsJumpBackwardTrigger="<C-k>"

"------------------------------------------------------------------------------
" GREP CONFIG
"------------------------------------------------------------------------------
let Grep_Default_Options = '-IR'
let Grep_Skip_Files = '*.log *.db *.exe *.so *.dll *.pyc *.swp *.zip *.DS_STORE'
let Grep_Skip_Dirs = '.git .nuxt env __pycache__ node_modules bower_components public_html dist vendor bundle .tmp storage project_files site-packages'

"------------------------------------------------------------------------------
" EDITORCONFIG
"------------------------------------------------------------------------------
let g:EditorConfig_exclude_patterns = ['fugitive://.*']

"------------------------------------------------------------------------------
" ALE CONFIG
"------------------------------------------------------------------------------
let g:ale_fixers = {'javascript': ['prettier', 'eslint'], 'vue': ['prettier', 'eslint']}
let g:ale_fix_on_save = 0
let g:ale_linters_explicit = 1
" let g:prettier#autoformat = 0
" autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.graphql,*.md,*.vue PrettierAsync

"------------------------------------------------------------------------------
" JAVASCRIPT CONFIG
"------------------------------------------------------------------------------
let g:javascript_enable_domhtmlcss = 1
let g:jsx_ext_required = 0

"------------------------------------------------------------------------------
" ELM CONFIG
"------------------------------------------------------------------------------
let g:elm_setup_keybindings = 0

"------------------------------------------------------------------------------
" EASYMOTION CONFIG
"------------------------------------------------------------------------------
let g:EasyMotion_do_mapping = 0 " Disable default mappings

" Jump to anywhere you want with minimal keystrokes, with just one key binding.
" `s{char}{label}`
" nmap s <Plug>(easymotion-overwin-f)
" or
" `s{char}{char}{label}`
" Need one more keystroke, but on average, it may be more comfortable.
nmap s <Plug>(easymotion-overwin-f2)

" Turn on case insensitive feature
let g:EasyMotion_smartcase = 1

" JK motions: Line motions
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
"
"------------------------------------------------------------------------------
" NERDTREE CONFIG
"------------------------------------------------------------------------------
let NERDTreeQuitOnOpen = 0
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDTreeIgnore=['tmp$','\.tmp$','\.nuxt','env$','\.so$','\.swp$','\.zip$','\.pyc$','\.o$','\.obj$','\.git','\.rbc$','__pycache__','site-packages','node_modules','dist']
let g:NERDTreeMapOpenSplit = "s"
let g:NERDTreeMapOpenVSplit = "v"

"------------------------------------------------------------------------------
" FZF CONFIG
"------------------------------------------------------------------------------
set grepprg=rg\ --vimgrep
let g:rg_command = 'rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --color "always" '

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \ g:rg_command
  \ . <q-args>, 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

"------------------------------------------------------------------------------
" CTRLSF CONFIG
"------------------------------------------------------------------------------
let g:ctrlsf_search_mode = 'async'
let g:ctrlsf_winsize = '100%'
let g:ctrlsf_position = 'bottom'

"------------------------------------------------------------------------------
" VISUAL CONFIG
"------------------------------------------------------------------------------
set background=dark
colorscheme one
let g:lightline = {
      \ 'colorscheme': 'onedark',
      \ }
set ruler
set hlsearch
let loaded_matchparen=1
set list listchars=tab:\ \ ,trail:·

if (has("termguicolors"))
  set termguicolors
endif

set mousemodel=popup
let &t_Co=256
set nocursorline
set guioptions=

if &term =~ '256color'
  set t_ut=
endif

"" Disable visualbell
set noerrorbells visualbell t_vb=
if has('autocmd')
  autocmd GUIEnter * set visualbell t_vb=
endif

"" Disable the blinking cursor.
set gcr=a:blinkon0
set scrolloff=3

"------------------------------------------------------------------------------
" BEHAVIOUR
"------------------------------------------------------------------------------
autocmd BufWritePre * :%s/\s\+$//e " strip trailing whitespace on save
autocmd BufLeave * silent! wall    " save on lost focus

set backspace=indent,eol,start     " configure backspace behavior
set textwidth=120                  " set width of all text
set noswapfile                     " disable swap files
set nowb                           " disable writing backup

set smartcase                      " ignore case if lower, otherwise match case

set splitbelow                     " split panes on the bottom
set splitright                     " split panes to the right

"" indentation, spaces only, convert tabs
set autoindent
set smartindent
set smarttab
set lazyredraw
set laststatus=2
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2

"------------------------------------------------------------------------------
" MAPPINGS
"------------------------------------------------------------------------------
let mapleader      = ','
let maplocalleader = ','

"" Change windows
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

"" Close all other windows
nmap <C-w>o :Only<CR>
nmap <C-w>c :enew<bar>bd #<CR>

"" Resize windows: Use defaults ctrl-w <|> -|+
"" Split windows: Just use the defaults C-w s|v

"" Search in files
nmap     <leader>l :Files<CR>
nmap     <leader>L :Rg<SPACE>
nmap     <leader>fa :F<SPACE>
nmap     <leader>Fa :Far<SPACE>
nmap     <leader>R :Fardo<CR>
nmap     <leader>U :Farundo<CR>

nmap     <leader>ff <Plug>CtrlSFPrompt
vmap     <leader>ff <Plug>CtrlSFVwordPath
vmap     <leader>Ff <Plug>CtrlSFVwordExec
nmap     <leader>fn <Plug>CtrlSFCwordPath
nmap     <leader>fp <Plug>CtrlSFPwordPath
nnoremap <leader>fo :CtrlSFOpen<CR>
nnoremap <leader>ft :CtrlSFToggle<CR>
inoremap <leader>ft <Esc>:CtrlSFToggle<CR>

inoremap jj <Esc>

"" Open file browser
" nnoremap <silent> <leader>k :Vexplore<CR>
nnoremap <C-w>t :NERDTreeToggle<Enter>
nnoremap <C-w>T :NERDTreeFind<CR>

"" search will center on the line it's found in.
nnoremap n nzzzv
nnoremap N Nzzzv

"" Clean search (highlight)
nnoremap <silent> <leader><space> :noh<CR>

"" Fix Emmet
imap <expr> <tab> emmet#expandAbbrIntelligent("\<tab>")

"" Edit VIMRC
nmap <silent> <leader>ev :edit $MYVIMRC<CR>

"" Source VIMRC
nmap <silent> <leader>ee :source $MYVIMRC<CR>

"" Toggle light/dark background
map <leader>x :let &background = ( &background == "dark"? "light" : "dark" )<CR>

"" Delete current file
nnoremap <leader>rm :call delete(expand('%')) \| bdelete!<CR>

"" Reopen last closed buffer in vertical split
nnoremap <leader>rv :vs#<CR>

"" Reopen last closed buffer in vertical split
nnoremap <leader>rh :sp#<CR>

"" Show buffer list
nnoremap <silent> <leader>b :buffers<CR>

"" Buffer nav
noremap <leader>q :bp<CR>
noremap <leader>w :bn<CR>

"" Close current buffer
noremap <leader>c :bd<CR>

"" Force Close current buffer
noremap <leader>C :bd!<CR>

"" Close all buffers
noremap <leader>ac :%bd<CR>
noremap <leader>oc :%bd<CR><C-O>:bd#<CR>

"" Vmap for maintain Visual Mode after shifting > and <
vmap < <gv
vmap > >gv

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

"" Open a tab edit command with the path of the currently edited file path filled
noremap <leader>te :tabe <C-R>=expand("%:p:h") . "/" <CR>

" Terminal
nnoremap <leader>T :terminal<CR>
tnoremap <Esc> <C-\><C-n>
tnoremap <C-w>h <C-\><C-n><C-w>h
tnoremap <C-w>j <C-\><C-n><C-w>j
tnoremap <C-w>k <C-\><C-n><C-w>k
tnoremap <C-w>l <C-\><C-n><C-w>l

" Git
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gC :Gcommit -v -q<CR>
nnoremap <leader>gP :Git push<CR>
nnoremap <leader>ga :Gcommit --ammend<CR>
nnoremap <leader>gt :Gcommit -v -q %<CR>
nnoremap <leader>gd :Gvdiff<CR>
nnoremap <leader>gg :Ggrep
nnoremap <leader>gl :Glog<CR>
nnoremap <leader>gp :Git pull<CR>
nnoremap <leader>gc :Git checkout<Space>
nnoremap <leader>gb :Git branch<Space>
nnoremap <leader>ge :Gedit<CR>
nnoremap <leader>gr :Gread<CR>
nnoremap <leader>gw :Gwrite<CR><CR>
nnoremap <leader>go :Gbrowse<CR>
nnoremap <leader>gm :Gmerge<CR>
nnoremap <leader>gB :Gblame<CR>

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