
"------------------------------------------------------------------------------
"           .----. .-.   .-.  .--.  .----.  .---. .----..-.
"           | {}  }|  `.'  | / {} \ | {}  }{_   _}| {_  | |
"           | {}  }| |\ /| |/  /\  \| .-. \  | |  | {__ | `--.
"           `----' `-' ` `-'`-'  `-'`-' `-'  `-'  `----'`----'
"           .-. .-..-..-.   .-. .---.  .----. .-. .-..----..-. .---.
"           | | | || ||  `.'  |/  ___}/  {}  \|  `| || {_  | |/   __}
"           \ \_/ /| || |\ /| |\     }\      /| |\  || |   | |\  {_ }
"            `---' `-'`-' ` `-' `---'  `----' `-' `-'`-'   `-' `---'
"------------------------------------------------------------------------------


"------------------------------------------------------------------------------
" GENERAL
"------------------------------------------------------------------------------
set encoding=utf-8            " Ensure encoding is UTF-8
set nocompatible              " Disable Vi compatability
set shell=/bin/bash           " Ensure bash is used for execution

"------------------------------------------------------------------------------
" VUNDLE CONFIG
"------------------------------------------------------------------------------
filetype off
set rtp+=$HOME/.vim/bundle/Vundle.vim   " Set the runtime path to include Vundle
call vundle#begin()                     " Initialize vundle
Plugin 'gmarik/vundle'                  " Let Vundle manage Vundle
Plugin 'ctrlpvim/ctrlp.vim'             " Quick file navigation
Plugin 'vim-scripts/grep.vim'           " Grep search of files
Plugin 'tpope/vim-commentary'           " Quickly comment lines out and in
Plugin 'tpope/vim-fugitive'             " Help formatting commit messages
Plugin 'tpope/vim-surround'             " Quickly change surrounding braces/quotes etc
Plugin 'tpope/vim-sleuth'               " Autodetect spaces/tabs
Plugin 'pangloss/vim-javascript'        " Javascript syntax highlighting
Plugin 'lumiliet/vim-twig'              " Twig template syntax highlighting
Plugin 'editorconfig/editorconfig-vim'  " Allow editorconfig to maintain syntax settings
Plugin 'bmartel/vim-one'                " Customized take on atoms one dark
call vundle#end()                       " Complete vunde initialization

"" enable filetype detection
"" and indent detection (based on filetype)
filetype plugin indent on

"------------------------------------------------------------------------------
" GREP CONFIG
"------------------------------------------------------------------------------
let Grep_Default_Options = '-IR'
let Grep_Skip_Files = '*.log *.db'
let Grep_Skip_Dirs = '.git node_modules'

"------------------------------------------------------------------------------
" EDITORCONFIG
"------------------------------------------------------------------------------
let g:EditorConfig_exclude_patterns = ['fugitive://.*']

"------------------------------------------------------------------------------
" JAVASCRIPT CONFIG
"------------------------------------------------------------------------------
let g:javascript_enable_domhtmlcss = 1

"------------------------------------------------------------------------------
" CTRL-P CONFIG
"------------------------------------------------------------------------------
" ignore anything not tracked by git
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
let g:ctrlp_show_hidden = 1        " include hidden files in results
let g:ctrlp_working_path_mode = '' " stop setting git repo as root path
let g:ctrlp_map = '<leader>l'

"" The Silver Searcher
if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  let g:ctrlp_use_caching = 0
endif

"" ripgrep
if executable('rg')
  set grepprg=rg\ --vimgrep
  let g:ctrlp_user_command = 'rg --files --hidden --follow --glob "!.git/*"'
  let g:ctrlp_use_caching = 0
endif

"------------------------------------------------------------------------------
" VISUAL CONFIG
"------------------------------------------------------------------------------
syntax on                           " enable syntax highlighting
colorscheme one                     " set color scheme
set background=dark                 " assume a dark background
set ruler                           " show ruler in lower right
set hlsearch                        " highlight all search results
let loaded_matchparen=1             " turn off match paren highlighting
set list listchars=tab:\ \ ,trail:· " display tabs and trailing spaces

set mousemodel=popup
set t_Co=256
set cursorline
set guioptions=egmrti

if has("gui_mac") || has("gui_macvim")
  set guifont=Envy\ Code\ R:h14
  set transparency=0 " disable transparency
endif

"------------------------------------------------------------------------------
" BEHAVIOUR
"------------------------------------------------------------------------------
autocmd BufWritePre * :%s/\s\+$//e " strip trailing whitespace on save
autocmd BufLeave * silent! wall    " save on lost focus

set autowrite                      " write before ':make' commands
set wildmenu                       " show possible completions on command line
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
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab

"" ignore files in search
set wildmode=list:longest,list:full
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.db,*.sqlite,*.o,*.obj,.git,*.rbc,__pycache__,node_modules

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
let mapleader = "," " Use better map leader

"" Change windows
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

"" Split windows
noremap <leader>h :<C-u>split<CR>
noremap <leader>v :<C-u>vsplit<CR>

"" Search in files
nnoremap <silent> <leader>f :Rgrep<CR>

"" Open file browser
nnoremap <silent> <leader>k :Ex<CR>

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
nnoremap <silent> <leader>b :Buffers<CR>

"" Buffer nav
noremap <leader>q :bp<CR>
noremap <leader>w :bn<CR>

"" Close buffer
noremap <leader>c :bd<CR>

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

"" Open a tab emit command with the path of the currently edited file path filled
noremap <leader>te :tabe <C-R>=expand("%:p:h") . "/" <CR>

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
