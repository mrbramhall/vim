" {{{ Basic

set nocompatible           " vim not vi
filetype plugin indent on  " plugins and indents for certain filetypes
cd $HOME                   " start vim in user home directory

" }}}
" {{{ UI Config

set encoding=utf-8              " utf-8 encoding
set scrolloff=3                 " offset when scrolling
set number                      " number lines
set relativenumber              " number the lines relative to each other
set numberwidth=5               " width of number column
set history=1000                " long command-line history
set showcmd                     " show most recent Vim command
set showmode                    " show mode (example: -- INSERT --)
set nocursorline                " horizontal cursor line off
set hidden                      " non-visible buffers continue in background
set backspace=indent,eol,start  " backspace works the way it should
set wrap                        " wrap lines visually within windows
set wildmenu                    " auto-completion activated by <TAB>
set lazyredraw                  " redraw the screen only when needed
set showmatch                   " matching braces will be highlighted
set matchtime=0                 " time to show matching brace
set colorcolumn=73,80           " keeps lines from getting too long
set nomodeline                  " do not read modelines (dangerous)
set laststatus=2                " statusline appears all the time

" custom statusline
set statusline=JESUS\ IS\ LORD!\  " praise ye the LORD!
set statusline+=%.40F             " name of file (no path)
set statusline+=\                 " separator
set statusline+=%y                " filetype flag
set statusline+=\                 " separator
set statusline+=%m                " modified flag
set statusline+=\                 " separator
set statusline+=%r                " read-only flag
set statusline+=\                 " separator
set statusline+=%w                " preview window flag
set statusline+=%=                " switch to right side
set statusline+=%l                " current line number
set statusline+=,                 " separator
set statusline+=%c                " column number
set statusline+=\ \               " separator
set statusline+=%p%%              " line-wise percentage through file
set statusline+=\                 " spacer

" platform-dependent configurations
if has("win32") || has("win16")
    set clipboard=unnamed     " Vim shares clipboard with Windows system
else
    set clipboard=unnamedplus " Vim shares clipboard with X Window system
endif

" }}}
" {{{ Plugins

" Pathogen
execute pathogen#infect()

" TagsList
nnoremap <f5> :TlistToggle<cr>

" Gundo
nnoremap <f6> :GundoToggle<cr>
let g:gundo_width = 40
let g:gundo_preview_height = 15
let g:gundo_preview_bottom = 0
let g:gundo_right = 0
let g:gundo_help = 0
let g:gundo_map_move_older = "j"
let g:gundo_map_move_newer = "k"
let g:gundo_close_on_revert = 0
let g:gundo_auto_preview = 1
let g:gundo_playback_delay = 60

" NERDTree
nnoremap <c-n> :NERDTreeToggle<cr>

" CtrlP
let g:ctrlp_switch_buffer = 0

" Indent Guides
let g:indent_guides_enable_on_vim_startup = 0

" UltiSnips
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
let g:UltiSnipsEditSplit = "vertical"

" }}}
" {{{ Functions

" strips trailing whitespace + saves cursor position
fun! <SID>StripTrailingWhitespaces() " {{{
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun " }}}

" }}}
" {{{ Folds

set foldenable         " enable folds
set foldlevelstart=10  " nothing open by default
set foldnestmax=2      " no more than this many nested folds

" toggle folds with space
nnoremap <space> za

" NOTE: fold method is set differently for different filetypes

" }}}
" {{{ Looks

syntax enable                      " turn on syntax processing
set guioptions-=m                  " turn off menu gui
set guioptions-=T                  " turn off toolbar gui
set guioptions-=r                  " turn off right scroll bar
set guioptions-=L                  " turn off left scroll bar

" Windows vs. Linux font
if has("win32") || has("win16")
    set guifont=Courier_New:h10:cANSI
else
    set guifont=Monospace\ 10
endif

" gVim vs. Vim colorscheme
if has('gui_running')
    colorscheme hemisu                 " gVim colorscheme
    set background=light
else
    colorscheme 256-grayvim            " need this for some reason
    colorscheme hemisu                 " Vim colorscheme
    set background=light
endif

" }}}
" {{{ Spaces, Tabs, Indents

set tabstop=4       " spaces per tab visually
set softtabstop=4   " spaces per tab actually
set expandtab       " tabs are spaces
set shiftwidth=4    " spaces per indent
set autoindent      " the indent from one line is carried to the next
set cindent         " automatic indentation for certain filetypes

" }}}
" {{{ Searching

set incsearch   " search as the term is typed
set hlsearch    " hightlight matches
set ignorecase  " ignore case in searching
set smartcase   " if search is lowercase, ignore case, otherwise pay attention

" }}}
" {{{ Movement

" move between splits within Vim easier
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" move up and down by visual lines
nnoremap j gj
nnoremap k gk

" H and L are used to move to the beginning and end of lines, respectively
nnoremap H 0
nnoremap L $

" }}}
" {{{ Operator-Pending Mappings

" H and L operate to the beginning and ending of current line, respectively
onoremap H 0
onoremap L $

" learn HL over 0$
onoremap 0 <nop>
onoremap $ <nop>

" }}}
" {{{ Windows & Tab Pages

" easier resizing of splits using CTRL and arrow keys
nnoremap <c-up> <c-w>+
nnoremap <c-down> <c-w>-
nnoremap <c-left> <c-w><
nnoremap <c-right> <c-w>>

" move through tab pages using tab and shift-tab
nnoremap <tab> :tabn<cr>
nnoremap <s-tab> :tabp<cr>

" }}}
" {{{ Leader Mappings

" <LEADER>
let mapleader=","

" unhighlight search terms
nnoremap <leader><space> :nohlsearch<cr>

" fold top level of folds for current file
nnoremap <leader>f :%foldc<cr>

" run Python code (normal and visual mode)
noremap <leader>p :w !python<cr>

" replace selected Python code with output
vnoremap <leader>P :!python<cr>

" create a new tab page easier
nnoremap <leader>t :tabnew<cr>

" edit vimrc in a new tab page
nnoremap <leader>ve :vsplit $MYVIMRC<cr>

" source written vimrc
nnoremap <leader>vs :source $MYVIMRC<cr>

" access UltiSnips file for current filetype
nnoremap <leader>u :UltiSnipsEdit<cr>

" make mappings
nnoremap <leader>ma :!make all<cr>
nnoremap <leader>md :!make dev<cr>
nnoremap <leader>mv :!make valgrind<cr>
nnoremap <leader>mc :!make clean<cr>
nnoremap <leader>mt :!make tests<cr>
nnoremap <leader>mi :!sudo make install<cr>

" }}}
" {{{ Local Leader Mappings

" <LOCALLEADER>
let maplocalleader=";"

" *** See Autogroups for actual mappings ***

" }}}
" {{{ Misc Non-Leader Mappings

" remap the return to normal command
inoremap jk <Esc>

" increment/decrement numbers using +/-
nnoremap + <c-a>
nnoremap - <c-x>

" write current file easier
nnoremap W :w<cr>

" generate a newline below/above cursor using ENTER/SHIFT-ENTER
nnoremap <cr> o<esc>k
nnoremap <s-cr> O<esc>j

" mappings to upper-case current word
inoremap <c-u> <esc>viwUea
nnoremap <c-u> viwU

" execute current line or current line selection as Vim EX commands
nnoremap <f2> :execute getline(".")<cr>
vnoremap <f2> :<c-u>execute join(getline("'<","'>"),'<bar>')<cr>

" paste while in insert mode
inoremap <c-p> <esc>pa

" }}}
" {{{ Autogroups

augroup C_CPP " {{{

    autocmd!

    autocmd FileType c,cpp setlocal foldnestmax=2
    autocmd FileType c,cpp setlocal foldmethod=syntax
    autocmd FileType c,cpp silent! %foldc

    " abbreviations
    autocmd FileType c,cpp iabbrev printF printf

    autocmd FileType c,cpp nnoremap <buffer> <localleader>a :A<cr>

    " function declaration to definition
    autocmd FileType c,cpp nnoremap <buffer> <localleader>f A<bs><cr>{<cr>}<esc>O

augroup END " }}}
augroup Python " {{{

    autocmd FileType python setlocal foldmethod=indent
    autocmd FileType python silent! %foldc

    " keep Python indent levels when making a comment line
    autocmd FileType python inoremap <buffer> # X<c-h>#

augroup END " }}}
augroup Makefile " {{{

    autocmd!

    " use actual TAB chars in Makefile
    autocmd FileType make setlocal noexpandtab

augroup END " }}}
augroup Markdown " {{{

    autocmd!

    " set textwidth to 79 chars for autowrapping
    autocmd FileType markdown setlocal textwidth=79

augroup END " }}}
augroup Text " {{{

    autocmd!

    autocmd FileType text setlocal foldmethod=indent

augroup END " }}}
augroup CSS " {{{

    autocmd!

    autocmd FileType css setlocal foldmethod=marker foldmarker={,}
    autocmd FileType css silent! %foldc

augroup END " }}}
augroup Vim " {{{

    autocmd!

    autocmd FileType vim setlocal foldmethod=marker foldmarker={{{,}}}
    autocmd FileType vim silent! %foldc!

augroup END " }}}
augroup Other " {{{

    " welcome message
    autocmd VimEnter * echom "JESUS CHRIST IS LORD!"

    " remove trailing whitespace for certain filetypes
    autocmd FileType c,cpp,java,php,ruby,python autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()

augroup END " }}}

" }}}
" {{{ Backups

set nobackup   " turn off creation of backup files
set noswapfile " no more .swp file creation

" }}}
" {{{ Linux-Only

" write restricted file when forgot to open with sudo
cnoremap w!! w !sudo tee > /dev/null %

" }}}
