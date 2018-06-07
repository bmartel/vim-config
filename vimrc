
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
"------------------------------------------------------------------------------
set encoding=utf-8                  " Ensure encoding is UTF-8
set nocompatible                    " Disable Vi compatability
set shell=/usr/local/bin/fish       " Ensure bash is used for execution
set binary
set noeol                           " No automatic end of line additions
set timeoutlen=1000 ttimeoutlen=0   " reduce timeout required for key to register
set hidden

"------------------------------------------------------------------------------
" PlUGIN CONFIG
"------------------------------------------------------------------------------
call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' } " Sidebar file tree
Plug 'terryma/vim-multiple-cursors'       " Add Sublime text style multiple cursors
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } " Quick fuzzy finder
Plug 'junegunn/fzf.vim'
Plug 'dyng/ctrlsf.vim'                    " Sublime text style search window
" Plug 'mtth/scratch.vim'                 " Quick scratch buffer
Plug 'SirVer/ultisnips'                   " Snippets!
Plug 'bmartel/vim-snippets'
Plug 'tpope/vim-commentary'               " Quickly comment lines out and in
Plug 'tpope/vim-fugitive'                 " Help formatting commit messages
Plug 'tpope/vim-surround'                 " Quickly change surrounding braces/quotes etc
Plug 'w0rp/ale'                           " Async Linter
Plug 'pangloss/vim-javascript'            " Javascript syntax highlighting
" Plug 'elmcast/elm-vim'                  " Elm syntax and helpers
" Plug 'leafgarland/typescript-vim'       " Typescript syntax highlighting
" Plug 'prettier/vim-prettier'            " Pretty print autoformatting
Plug 'kshenoy/vim-signature'              " Vim marks easier bindings and highlights
" Plug 'mxw/vim-jsx'                        " React jsx syntax
Plug 'posva/vim-vue'                    " Vue file syntax highlighting
" Plug 'kchmck/vim-coffee-script'         " Coffeescript syntax highlighting
" Plug 'lumiliet/vim-twig'                " Twig template syntax highlighting
Plug 'mattn/emmet-vim'                  " Emmet html completion
Plug 'editorconfig/editorconfig-vim'      " Allow editorconfig to maintain syntax settings
Plug 'bmartel/vim-one'                    " Customized take on atoms one dark
" Plug 'colepeters/spacemacs-theme.vim'   " spacemacs theme!
" Plug 'jceb/vim-orgmode'                 " Task manager
" Plug 'python-mode/python-mode', { 'branch': 'develop', 'for': 'python' } " Python ide
" Plug 'mustache/vim-mustache-handlebars' " Handlebars syntax

packadd matchit
call plug#end()                       " Complete vunde initialization

"" enable filetype detection
"" and indent detection (based on filetype)
filetype plugin indent on

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

fu! OpenTerminal()
 " open split windows on the bottom
 bottom split
 " resize the height of terminal windows to 15
 resize 15
 :terminal
endf

"------------------------------------------------------------------------------
" SNIPPETS CONFIG
"------------------------------------------------------------------------------
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<C-j>"
let g:UltiSnipsJumpBackwardTrigger="<C-k>"

"------------------------------------------------------------------------------
" PYTHON-MODE CONFIG
"------------------------------------------------------------------------------
set nofoldenable
let g:python3_host_prog = '/usr/local/bin/python3'

"------------------------------------------------------------------------------
" RUBY CONFIG
"------------------------------------------------------------------------------
let g:ruby_path = '~/.rbenv/versions/2.5.1/bin/ruby'
autocmd FileType ruby setlocal ts=2 sts=2 sw=2 foldmethod=manual norelativenumber nocursorline

"------------------------------------------------------------------------------
" ELM CONFIG
"------------------------------------------------------------------------------
let g:elm_format_autosave = 0
let g:elm_setup_keybindings = 0

"------------------------------------------------------------------------------
" ORGMODE CONFIG
"------------------------------------------------------------------------------
let g:org_agenda_files = ['~/Documents/tasks/*.org']

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
let g:ale_fix_on_save = 1
let g:ale_linters_explicit = 1
" let g:prettier#exec_cmd_async = 1
" let g:prettier#autoformat = 0
" autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.graphql,*.md,*.vue PrettierAsync

"------------------------------------------------------------------------------
" JAVASCRIPT CONFIG
"------------------------------------------------------------------------------
let g:javascript_enable_domhtmlcss = 1
let g:jsx_ext_required = 0

"------------------------------------------------------------------------------
" HANDLEBARS CONFIG
"------------------------------------------------------------------------------
let g:mustache_abbreviations = 1

"------------------------------------------------------------------------------
" TYPESCRIPT CONFIG
"------------------------------------------------------------------------------
let g:typescript_indent_disable = 1

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
" SCRATCH CONFIG
"------------------------------------------------------------------------------
let g:scratch_autohide = 1
let g:scratch_insert_autohide = 1

"------------------------------------------------------------------------------
" CTRLSF CONFIG
"------------------------------------------------------------------------------
let g:ctrlsf_ackprg='pt'
let g:ctrlsf_position = 'bottom'
let g:ctrlsf_winsize = '100%'

"------------------------------------------------------------------------------
" FZF CONFIG
"------------------------------------------------------------------------------
set grepprg=rg\ --vimgrep
let g:rg_command = 'rg --column --line-number --no-heading --fixed-strings --ignore-case --hidden --follow --color "always" '

" command! -bang -nargs=? -complete=dir Files
"   \ call fzf#vim#files(g:rg_command . <q-args>,
"   \   <bang>0 ? fzf#vim#with_preview('up:60%')
"   \           : fzf#vim#with_preview('right:50%:hidden', '?'),
"   \   <bang>0)

command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \ g:rg_command
  \ . <q-args>, 1,
  \   <bang>0 ? fzf#vim#with_preview('up:60%')
  \           : fzf#vim#with_preview('right:50%:hidden', '?'),
  \   <bang>0)

"------------------------------------------------------------------------------
" VISUAL CONFIG
"------------------------------------------------------------------------------
syntax on                           " enable syntax highlighting
set number                          " enable line numbers
set background=dark                 " assume a dark background
colorscheme one                     " set color scheme
" colorscheme spacemacs-theme
set ruler                           " show ruler in lower right
set hlsearch                        " highlight all search results
let loaded_matchparen=1             " turn off match paren highlighting
set list listchars=tab:\ \ ,trail:· " display tabs and trailing spaces

if (has("termguicolors"))
  set termguicolors
endif

set mousemodel=popup
set t_Co=256
" set cursorline
set guioptions=

if has("gui_running")
  if (match(system("uname -s"), "Darwin") != -1)
    set guifont=Envy\ Code\ R:h14
  else
    set guifont=Envy\ Code\ R\ 12
  endif
endif

if has("gui_mac") || has("gui_macvim")
  set transparency=0
endif

"------------------------------------------------------------------------------
" BEHAVIOUR
"------------------------------------------------------------------------------
autocmd BufWritePre * :%s/\s\+$//e " strip trailing whitespace on save
autocmd BufLeave * silent! wall    " save on lost focus

set autowrite                      " write before ':make' commands
set wildmenu                       " show possible completions on command line
set wildmode=full
set backspace=indent,eol,start     " configure backspace behavior
set textwidth=80                   " set width of all text

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

"" Disable visualbell
set noerrorbells visualbell t_vb=
if has('autocmd')
  autocmd GUIEnter * set visualbell t_vb=
endif

" Use system clipboard
set clipboard^=unnamed,unnamedplus

if &term =~ '256color'
  set t_ut=
endif

"" Disable the blinking cursor.
set gcr=a:blinkon0
set scrolloff=3

"------------------------------------------------------------------------------
" MAPPINGS
"------------------------------------------------------------------------------
let mapleader      = ','
let maplocalleader = ','

"" Save file
noremap <leader>s :update<CR>

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
" noremap <leader>h :<C-u>split<CR>
" noremap <leader>v :<C-u>vsplit<CR>

"" Search in files
nmap     <leader>l :Files<CR>
nmap     <leader>L :Rg<SPACE>
nmap     <leader>f <Plug>CtrlSFPrompt
vmap     <leader>f <Plug>CtrlSFVwordPath
vmap     <leader>F <Plug>CtrlSFVwordExec
" nmap     <leader>n <Plug>CtrlSFCwordPath
nmap     <leader>p <Plug>CtrlSFPwordPath
nnoremap <leader>of :CtrlSFOpen<CR>
nnoremap <leader>tf :CtrlSFToggle<CR>
inoremap <leader>tf <Esc>:CtrlSFToggle<CR>

nnoremap <silent> <leader>rr :cfdo %s//g<LEFT><LEFT>
nnoremap <silent> <leader>ru :cfdo update

"" Open file browser
" nnoremap <silent> <leader>k :Vexplore<CR>
nnoremap <C-w>t :NERDTreeToggle<Enter>
nnoremap <C-w>T :NERDTreeFind<CR>

"" search will center on the line it's found in.
nnoremap n nzzzv
nnoremap N Nzzzv

"" Clean search (highlight)
nnoremap <silent> <leader><space> :noh<CR>

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

"" Copy/Cut/Paste
noremap YY "+y<CR>
noremap <leader>p "+gP<CR>
noremap XX "+x<CR>

if has('macunix')
  " pbcopy for OSX copy/paste
  vmap <C-x> :!pbcopy<CR>
  vmap <C-c> :w !pbcopy<CR><CR>
endif

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

" Orgmode
nnoremap <leader>op :60vsplit ~/Documents/tasks/personal.org<CR>
nnoremap <leader>oh :60vsplit ~/Documents/tasks/home.org<CR>
nnoremap <leader>ow :60vsplit ~/Documents/tasks/work.org<CR>

" Terminal
nnoremap <leader>T :call OpenTerminal()<CR>
tnoremap <Esc> <C-\><C-n>
tnoremap <C-w>h <C-\><C-n><C-w>h
tnoremap <C-w>j <C-\><C-n><C-w>j
tnoremap <C-w>k <C-\><C-n><C-w>k
tnoremap <C-w>l <C-\><C-n><C-w>l

" Elm
nnoremap <leader>nm :ElmMake<CR>
nnoremap <leader>nf :ElmFormat<CR>
nnoremap <leader>nb :ElmMakeMain<CR>
nnoremap <leader>nt :ElmTest<CR>
nnoremap <leader>nr :ElmRepl<CR>
nnoremap <leader>ne :ElmErrorDetail<CR>
nnoremap <leader>nd :ElmShowDocs<CR>
nnoremap <leader>nw :ElmBrowse<CR>

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
nnoremap <leader>gi :Gblame<CR>

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