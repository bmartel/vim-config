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
set t_ZH=^[[3m
set t_ZR=^[[23m

"------------------------------------------------------------------------------
" PlUGIN CONFIG
"------------------------------------------------------------------------------
call plug#begin( '~/.config/nvim/plugged')

Plug 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' } " Sidebar file tree
Plug 'itchyny/lightline.vim'              " Status bar
Plug 'terryma/vim-multiple-cursors'       " Add Sublime text style multiple cursors
Plug 'easymotion/vim-easymotion'          " Quick movement within files
Plug 'SirVer/ultisnips'
Plug 'bmartel/vim-snippets'               " Snippets!
Plug 'tpope/vim-commentary'               " Quickly comment lines out and in
Plug 'tpope/vim-fugitive'                 " Help formatting commit messages
Plug 'tpope/vim-surround'                 " Quickly change surrounding braces/quotes etc
Plug 'christoomey/vim-system-copy'        " Better control of buffer <-> clipboard
Plug 'christoomey/vim-sort-motion'        " Allows for quick line sorting
Plug 'tommcdo/vim-exchange'               " Text object swapping
Plug 'pangloss/vim-javascript'            " Javascript syntax highlighting
Plug 'posva/vim-vue'                    " Vue file syntax highlighting
Plug 'mattn/emmet-vim'                  " Emmet html completion
Plug 'editorconfig/editorconfig-vim'      " Allow editorconfig to maintain syntax settings
Plug 'kshenoy/vim-signature'              " Vim marks easier bindings and highlights
Plug 'bmartel/vim-one'                    " Customized take on atoms one dark
Plug 'NovaDev94/lightline-onedark'        " Onedark lightline theme
" Plug 'elmcast/elm-vim'                  " Elm syntax and helpers
Plug 'leafgarland/typescript-vim'       " Typescript syntax highlighting
" Plug 'mxw/vim-jsx'                        " React jsx syntax
" Plug 'kchmck/vim-coffee-script'         " Coffeescript syntax highlighting
Plug 'lumiliet/vim-twig'                " Twig template syntax highlighting
" Plug 'jceb/vim-orgmode'                 " Task manager
" Plug 'python-mode/python-mode', { 'branch': 'develop', 'for': 'python' } " Python ide
" Plug 'mustache/vim-mustache-handlebars' " Handlebars syntax

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

function! CleanEmptyBuffers()
  let buffers = filter(range(1, bufnr('$')), 'buflisted(v:val) && empty(bufname(v:val)) && bufwinnr(v:val)<0 && !getbufvar(v:val, "&mod")')
  if !empty(buffers)
      exe 'bw ' . join(buffers, ' ')
  endif
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
let g:ale_fix_on_save = 1
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
" DENITE.NVIM CONFIG
"------------------------------------------------------------------------------
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
\ 'auto_resize': 1,
\ 'prompt': 'λ:',
\ 'direction': 'rightbelow',
\ 'winminheight': '10',
\ 'highlight_mode_insert': 'Visual',
\ 'highlight_mode_normal': 'Visual',
\ 'prompt_highlight': 'Function',
\ 'highlight_matched_char': 'Function',
\ 'highlight_matched_range': 'Normal'
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

"------------------------------------------------------------------------------
" COC.NVIM CONFIG
"------------------------------------------------------------------------------

" use <tab> for trigger completion and navigate to next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

"Close preview window when completion is done.
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

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
" Base2Tone Dark
" colorscheme Base2Tone_EveningDark
" colorscheme Base2Tone_MorningDark
" colorscheme Base2Tone_SeaDark
" colorscheme Base2Tone_SpaceDark
" colorscheme Base2Tone_EarthDark
" colorscheme Base2Tone_ForestDark
" colorscheme Base2Tone_DesertDark
" colorscheme Base2Tone_LakeDark
" colorscheme Base2Tone_MeadowDark
" colorscheme Base2Tone_DrawbridgeDark
" colorscheme Base2Tone_PoolDark
" colorscheme Base2Tone_HeathDark
" colorscheme Base2Tone_CaveDark

" Base2Tone Light
" set background=light
" colorscheme Base2Tone_EveningLight
" colorscheme Base2Tone_MorningLight
" colorscheme Base2Tone_SeaLight
" colorscheme Base2Tone_SpaceLight
" colorscheme Base2Tone_EarthLight
" colorscheme Base2Tone_ForestLight
" colorscheme Base2Tone_DesertLight
" colorscheme Base2Tone_LakeLight
" colorscheme Base2Tone_MeadowLight
" colorscheme Base2Tone_DrawbridgeLight
" colorscheme Base2Tone_PoolLight
" colorscheme Base2Tone_HeathLight
" colorscheme Base2Tone_CaveLight

set noshowmode
" let g:lightline = {
"       \ 'colorscheme': 'Base2Tone_Earth',
"       \ }
let g:lightline = {
      \ 'colorscheme': 'onedark',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'cocstatus', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'cocstatus': 'coc#status'
      \ },
      \ }
set ruler
set hlsearch
let loaded_matchparen=1
set list listchars=tab:\ \ ,trail:·

set termguicolors " Enable true color support.
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

" if (has("termguicolors"))
"   set termguicolors
" endif

set mousemodel=popup
set nocursorline
set guioptions=

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
set regexpengine=1
set laststatus=2
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2

let g:markdown_folding = 1
let g:markdown_enable_folding = 1

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

" set path-=/usr/include
" set wildcharm=<C-z>
" nnoremap <leader>eh :e **/*<C-z><S-Tab>
" nnoremap <leader>fh :find **/*<C-z><S-Tab>

" nmap     <leader>l :Files<CR>
" nmap     <leader>L :Rg<SPACE>
" nmap     <leader>fa :F<SPACE>
" nmap     <leader>Fa :Far<SPACE>
" nmap     <leader>R :Fardo<CR>
" nmap     <leader>U :Farundo<CR>

" nmap     <leader>ff <Plug>CtrlSFPrompt
" vmap     <leader>ff <Plug>CtrlSFVwordPath
" vmap     <leader>Ff <Plug>CtrlSFVwordExec
" nmap     <leader>fn <Plug>CtrlSFCwordPath
" nmap     <leader>fp <Plug>CtrlSFPwordPath
" nnoremap <leader>fo :CtrlSFOpen<CR>
" nnoremap <leader>ft :CtrlSFToggle<CR>
" inoremap <leader>ft <Esc>:CtrlSFToggle<CR>

" inoremap jj <Esc>

nmap ; :Denite buffer -split=floating -winrow=1<CR>
nmap <leader>l :Denite file/rec -split=floating -winrow=1<CR>
nnoremap <leader>f :<C-u>Denite grep:. -no-empty -mode=normal<CR>
nnoremap <leader>F :<C-u>DeniteCursorWord grep:. -mode=normal<CR>

" === coc.nvim === "
nmap <silent> <leader>dd <Plug>(coc-definition)
nmap <silent> <leader>dt <Plug>(coc-type-definition)
nmap <silent> <leader>dr <Plug>(coc-references)
nmap <silent> <leader>dj <Plug>(coc-implementation)


vmap <space>f  <Plug>(coc-format-selected)
nmap <space>f  <Plug>(coc-format)

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

"" Show buffer list/switch
nnoremap <silent> <leader>b :ls<CR>:e #

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
noremap <leader>ae :call CleanEmptyBuffers()<CR>

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