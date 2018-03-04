
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
set shell=/bin/bash                 " Ensure bash is used for execution
set wildmode=list:longest,list:full " Ignore files in search
set wildignore+=*/tmp/*,env/*,.tmp,.nuxt,public_html,vendor,bower_components,*.so,*.swp,*.zip,*.pyc,*.db,*.sqlite,*.o,*.obj,.git,*.rbc,*/__pycache__/*,*/site-packages/*,node_modules,dist,build
set binary
set noeol                           " No automatic end of line additionS
set timeoutlen=1000 ttimeoutlen=0   " reduce timeout required for key to register
set hidden
set gdefault
"------------------------------------------------------------------------------
" VUNDLE CONFIG
"------------------------------------------------------------------------------
filetype off
set rtp+=$HOME/.vim/bundle/Vundle.vim   " Set the runtime path to include Vundle
call vundle#begin()                     " Initialize vundle
Plugin 'gmarik/vundle'                  " Let Vundle manage Vundle
Plugin 'scrooloose/nerdtree'            " Sidebar file tree
Plugin 'jlanzarotta/bufexplorer'        " Buffer explorer
Plugin 'terryma/vim-multiple-cursors'   " Add Sublime text style multiple cursors
Plugin 'ctrlpvim/ctrlp.vim'             " Quick file navigation
Plugin 'dyng/ctrlsf.vim'                " Sublime text style search window
Plugin 'vim-scripts/grep.vim'           " Grep search of files
Plugin 'mtth/scratch.vim'               " Quick scratch buffer
Plugin 'tpope/vim-commentary'           " Quickly comment lines out and in
Plugin 'tpope/vim-fugitive'             " Help formatting commit messages
Plugin 'tpope/vim-speeddating'          " Date formatting plugin
Plugin 'airblade/vim-gitgutter'         " Git changes status gutter
Plugin 'tpope/vim-surround'             " Quickly change surrounding braces/quotes etc
Plugin 'pangloss/vim-javascript'        " Javascript syntax highlighting
Plugin 'leafgarland/typescript-vim'     " Typescript syntax highlighting
Plugin 'prettier/vim-prettier'          " Pretty print autoformatting
Plugin 'kshenoy/vim-signature'          " Vim marks easier bindings and highlights
Plugin 'mxw/vim-jsx'                    " React jsx syntax
Plugin 'posva/vim-vue'                  " Vue file syntax highlighting
Plugin 'kchmck/vim-coffee-script'       " Coffeescript syntax highlighting
Plugin 'lumiliet/vim-twig'              " Twig template syntax highlighting
Plugin 'mattn/emmet-vim'                " Emmet html completion
Plugin 'editorconfig/editorconfig-vim'  " Allow editorconfig to maintain syntax settings
Plugin 'bmartel/vim-one'                " Customized take on atoms one dark
Plugin 'colepeters/spacemacs-theme.vim' " spacemacs theme!
Plugin 'jceb/vim-orgmode'               " Task manager
call vundle#end()                       " Complete vunde initialization

"" enable filetype detection
"" and indent detection (based on filetype)
filetype plugin indent on

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
" PRETTIER CONFIG
"------------------------------------------------------------------------------
let g:prettier#exec_cmd_async = 1
let g:prettier#autoformat = 0
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue PrettierAsync

"------------------------------------------------------------------------------
" JAVASCRIPT CONFIG
"------------------------------------------------------------------------------
let g:javascript_enable_domhtmlcss = 1
let g:jsx_ext_required = 0

"------------------------------------------------------------------------------
" TYPESCRIPT CONFIG
"------------------------------------------------------------------------------
let g:typescript_indent_disable = 1

"------------------------------------------------------------------------------
" NERDTREE CONFIG
"------------------------------------------------------------------------------
let NERDTreeQuitOnOpen = 1
let NERDTreeAutoDeleteBuffer = 1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1
let NERDTreeIgnore=['tmp$','\.tmp$','\.nuxt','env$','\.so$','\.swp$','\.zip$','\.pyc$','\.o$','\.obj$','\.git','\.rbc$','__pycache__','site-packages','node_modules','dist','build']

"------------------------------------------------------------------------------
" SCRATCH CONFIG
"------------------------------------------------------------------------------
let g:scratch_autohide = 1
let g:scratch_insert_autohide = 1

"------------------------------------------------------------------------------
" NETRW CONFIG
"------------------------------------------------------------------------------
" let g:netrw_banner = 0
" let g:netrw_liststyle = 3
" let g:netrw_browse_split = 4
" let g:netrw_altv = 1
" let g:netrw_winsize = 15
" let g:netrw_list_hide = &wildignore
" augroup ProjectDrawer
"   autocmd!
"   autocmd VimEnter * :Vexplore
" augroup END

"------------------------------------------------------------------------------
" CTRL-P CONFIG
"------------------------------------------------------------------------------
" ignore anything not tracked by git
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
let g:ctrlp_show_hidden = 1        " include hidden files in results
let g:ctrlp_working_path_mode = '' " stop setting git repo as root path
let g:ctrlp_map = '<leader>l'
let g:ctrlp_max_files = 0
let g:ctrlp_max_depth=10

"" The Silver Searcher
if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor
  unlet g:ctrlp_user_command
  let g:ctrlp_custom_ignore = {
    \ 'dir':  '\.git\|\.hg\|\.svn\|\.nuxt\|\.tmp\|env\|bower_components\|dist\|node_modules\|__pycache__\|site-packages\|project_files\|public_html\|storage',
    \ 'file': '\.exe$\|\.so$\|\.dll$\|\.pyc$' }
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  let g:ctrlp_use_caching = 0
endif

"" ripgrep
if executable('rg')
  set grepprg=rg\ --vimgrep
  unlet g:ctrlp_user_command
  let g:ctrlp_custom_ignore = {
    \ 'dir':  '\.git\|\.hg\|\.svn\|\.nuxt\|\.tmp\|env\|bower_components\|dist\|node_modules\|__pycache__\|site-packages\|project_files\|public_html\|storage',
    \ 'file': '\.exe$\|\.so$\|\.dll$\|\.pyc$|\.DS_STORE$' }
  let g:ctrlp_user_command = 'rg --files %s'
  let g:ctrlp_use_caching = 0
endif

"------------------------------------------------------------------------------
" VISUAL CONFIG
"------------------------------------------------------------------------------
syntax on                           " enable syntax highlighting
set number                          " enable line numbers
" colorscheme one                     " set color scheme
" set background=dark                 " assume a dark background
set ruler                           " show ruler in lower right
set hlsearch                        " highlight all search results
let loaded_matchparen=1             " turn off match paren highlighting
set list listchars=tab:\ \ ,trail:· " display tabs and trailing spaces

if (has("termguicolors"))
  set termguicolors
endif

set background=dark
colorscheme spacemacs-theme

set mousemodel=popup
set t_Co=256
" set cursorline
set guioptions=

if has("gui_running")
  if (match(system("uname -s"), "Darwin") != -1)
    set guifont=Envy\ Code\ R:h14
  else
    set guifont=Envy\ Code\ R\ 12
  end
end

if has("gui_mac") || has("gui_macvim")
  set transparency=0
end

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
let mapleader = "," " Use better map leader
let maplocalleader = "\\" " Use better map local leader

"" Change windows
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" "" Split windows: Just use the defaults C-w s|v
" noremap <leader>h :<C-u>split<CR>
" noremap <leader>v :<C-u>vsplit<CR>

"" Search in files
nmap     <leader>f <Plug>CtrlSFPrompt
vmap     <leader>f <Plug>CtrlSFVwordPath
vmap     <leader>F <Plug>CtrlSFVwordExec
nmap     <leader>n <Plug>CtrlSFCwordPath
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