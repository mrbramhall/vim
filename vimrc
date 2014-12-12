" {{{ Basic

set nocompatible  " vim not vi
cd $HOME          " start vim in user home directory

" }}}
" {{{ UI Config

set number                      " number the lines
set numberwidth=5               " width of number column
set history=1000                " long command-line history
set showcmd                     " show most recent Vim command
set nocursorline                " horizontal cursor line off
set hidden                      " non-visible buffers continue in background
set backspace=indent,eol,start  " backspace works the way it should
set wrap                        " wrap lines visually within windows
set wildmenu                    " auto-completion activated by <TAB>
set lazyredraw                  " redraw the screen only when needed
set showmatch                   " matching braces will be highlighted
set matchtime=5                 " time to show matching brace
set colorcolumn=72,80           " keeps lines from getting too long
set nomodeline                  " do not read modelines (dangerous)
set clipboard=unnamed           " Vim shares clipboard with Windows system

" custom statusline
set statusline=Jesus\ is\ LORD!\  "  praise ye the LORD!
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
set statusline+=%%%p              " line-wise percentage through file

" }}}
" {{{ Plugins

" Pathogen
call pathogen#infect()  " enable Pathogen plugin manager
filetype plugin on      " enable filetype plugins

" TagsList mappings
nnoremap <f5> :TlistToggle<cr>

" NERDTree
nnoremap <c-n> :NERDTreeToggle<cr>

" CtrlP settings
let g:ctrlp_switch_buffer = 0

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
set foldnestmax=10     " no more than this many nested folds

" toggle folds with space
nnoremap <space> za

" NOTE: fold method is set differently for different filetypes

" }}}
" {{{ Looks

syntax enable                      " turn on syntax processing
set guifont=Courier_New:h10:cANSI  " gVim font
set guioptions-=m                  " turn off menu gui
set guioptions-=T                  " turn off toolbar gui
set guioptions-=r                  " turn off right scroll bar
set guioptions-=L                  " turn off left scroll bar

" gVim vs. Vim colorscheme
if has('gui_running')
    colorscheme hemisu                 " gVim colorscheme
    set background=light
else
    colorscheme default                " Vim colorscheme
endif

" }}}
" {{{ Spaces, Tabs, Indents

filetype indent on  " set indentation for different filetypes
set tabstop=4       " each tab is worth 4 spaces in length
set softtabstop=4   " set tabs to 4 spaces in length in editting
set expandtab       " tabs are spaces
set shiftwidth=4    " indents are 4 spaces
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

" create a new tab page easier
nnoremap <c-t> :tabnew<cr>

" move through tab pages using tab and shift-tab
nnoremap <tab> :tabn<cr>
nnoremap <s-tab> :tabp<cr>

" }}}
" {{{ Leader Mappings

" <LEADER>
let mapleader=","

" unhighlight search terms
nnoremap <leader><space> :nohlsearch<cr>

" edit vimrc in a new tab page
nnoremap <leader>ve :split $MYVIMRC<cr>

" source written vimrc
nnoremap <leader>vs :source $MYVIMRC<cr>

" run Python code (normal and visual mode)
noremap <leader>p :w !python<cr>

" replace selected Python code with output
vnoremap <leader>P :!python<cr>

" fold top level of folds for current file
nnoremap <leader>f :%foldc<cr>

" }}}
" {{{ Local Leader Mappings

" <LOCALLEADER>
let maplocalleader=";"

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
nnoremap <Cr> o<esc>k
nnoremap <s-cr> O<esc>j

" mappings to upper-case current word
inoremap <c-u> <esc>viwUea
nnoremap <c-u> viwUe

" execute current line or current line selection as Vim EX commands
nnoremap <f2> :execute getline(".")<cr>
vnoremap <f2> :<c-u>execute join(getline("'<","'>"),'<bar>')<cr>

" }}}
" {{{ Autogroups

augroup C " {{{

    autocmd!

    autocmd FileType c setlocal foldmethod=marker foldmarker={,}
    autocmd FileType c silent! %foldc

    autocmd FileType c iabbrev printF printf

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
augroup Text " {{{

    autocmd!

    autocmd FileType text setlocal foldmethod=indent

augroup END " }}}
augroup Vim " {{{

    autocmd!

    autocmd FileType vim setlocal foldmethod=marker foldmarker={{{,}}}
    autocmd FileType vim silent! %foldc!

augroup END " }}}
augroup Other " {{{

    " welcome message
    autocmd VimEnter * echom "Jesus Christ is LORD!"

    " remove trailing whitespace for certain filetypes
    autocmd FileType c,cpp,java,php,ruby,python autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()

augroup END " }}}

" }}}
" {{{ Backups

set nobackup   " turn off creation of backup files
set noswapfile " no more .swp file creation

" }}}