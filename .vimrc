set nocompatible           " Use Vim defaults

" Some initial preparation
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


call plug#begin('~/.vim/plugged')
" colorscheme of choice
Plug 'altercation/vim-colors-solarized'
Plug 'spf13/vim-autoclose'     " close opened parantheses and '\"
Plug 'tpope/vim-repeat'        " make repetition work well with plugins
Plug 'tpope/vim-surround'      " handle surroundings
Plug 'tpope/vim-fugitive'      " proper git integration
Plug 'tpope/vim-speeddating'   " use <c-a>/<c-x> on dates
Plug 'vim-airline/vim-airline' " Fancy status line and themes for it
Plug 'vim-airline/vim-airline-themes' 
Plug 'airblade/vim-gitgutter'  " show diff in sign colum
Plug 'fatih/vim-go'            " Go development
Plug 'junegunn/fzf.vim'        " use fzf for file management
if executable('ctags')         " use tagbar if ctags is available
   Plug 'majutsushi/tagbar'
endif

if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

call plug#end()

set nobackup                   " Keep no backup file, use version control
set modelines=2                " Enable modelines in files
set matchpairs+=<:>            " Add pointy brackets to matchpairs
set viminfo='20,\"50,h         " Read/write a .viminfo file, don't store more
                               " Than 50 lines of registers
set viminfofile=~/.vim/viminfo " Store info under ~/.vim
set title                      " set Terminals Title.
set nostartofline              " don't jump cursor around. Stay in one column
set vb t_vb=                   " turn the bell off.
set autowrite                  " Save before :make :suspend, etc
set encoding=utf-8             " use utf-8 as default encoding.
set updatetime=100             " default updatetime 4000ms is not good
                               " for async update
let mapleader=","              " my custom mappings are introduced by ','
" Persistent Undo
if !isdirectory(glob('~/.vim/undodir'))
    call mkdir($HOME."/.vim/undodir","p")
endif
set undodir=~/.vim/undodir     " Store undo history in this directory
set undofile                   " Enable persistent undo

" Whitespace
set backspace=indent,eol,start " Backspacing over everything in insert mode
set wrap                       " Enable line Wrapping
set autoindent                 " take indent for new line from previous line
set linebreak                  " Wrap at word
set tabstop=4                  " Tabwidth
set shiftwidth=4               " Indention
set softtabstop=4              " Make sure all tabs are 4 spaces
set expandtab                  " Expand tabs to spaces
set smarttab                   " Backspace at line beginning removes indention

" Searching
set incsearch                  " Incremental search. Search while typing
set ignorecase                 " Searches are case insensitive
set smartcase                  " Unless they contain at least one capital letter
set hlsearch                   " highlight search

" Autocomplete and Snippets
let g:deoplete#enable_at_startup = 1
" disable autocomplete
let g:deoplete#disable_auto_complete = 1
if has("gui_running")
    inoremap <silent><expr><C-Space> deoplete#manual_complete()
else
    inoremap <silent><expr><C-@> deoplete#manual_complete()
endif
" UltiSnips config
inoremap <silent><expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

" Ctags
set tags=./tags;/,~/.vimtags
" Make tags placed in .git/tags file available in all levels of a repository
let gitroot = substitute(system('git rev-parse --show-toplevel'), '[\n\r]', '', 'g')
if gitroot != ''
    let &tags = &tags . ',' . gitroot . '/.git/tags'
endif

" Tagbar and switch to that window.
nnoremap <silent> <leader>tt :TagbarToggle<CR><C-w><C-w>

" User Interface
syntax enable             " Syntax highlight on.
set cursorline            " Highlight the line the cursor's in
set showcmd               " Show (partial) commands in status line.
set ruler                 " Show cursorposition
set showmatch             " Show matching brackets
set wildmenu              " Show lists instead of just completing
set laststatus=2          " Always show a status line
set noshowmode            " Get rid of default mode indicator


let g:solarized_termcolors=256
let g:solarized_termtrans=1
let g:solarized_visibility="high"
colorscheme solarized
" Make signcolumn look better.
highlight SignColumn ctermbg=235 guibg=#eee8d5

let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
if !exists('g:airline_symbols')
      let g:airline_symbols = {}
endif
let g:airline_symbols.space = "\ua0"
let g:airline_theme='solarized'
if has('gui_running')
    set background=light
    set linespace=1
else
    set background=dark
    let g:airline_solarized_bg='dark'
endif
" Window management
" split window vertically with <leader> v
nmap <leader>v :vsplit<CR> <C-w><C-w>
" split window horizontally with <leader> s
nmap <leader>s :split<CR> <C-w><C-w>
" Switch between windows with <leader> w
nmap <leader>w <C-w><C-w>_

if has("autocmd")
    " Makefiles have real Tabs
    au FileType make set noexpandtab
    " In text files, always limit the width of text to 78 characters
    au BufNewFile,BufRead *.txt,*markdown,*md,*asciidoc,*adoc set tw=78
    " Yaml uses tabsize of two
    au FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
    au BufNewFile,BufRead *.go set ft=go
endif " has("autocmd")

" My mappings
map <F5> :set number<CR>     " Turn on linenumbers.
map <F6> :set nonumber<CR>   " Turn off linenumbers.

" Press Space to turn off highlighting and clear any message already
" displayed.
:noremap <silent> <Space> :silent noh<Bar>echo<CR>

if filereadable(expand("~/.vimrc-local"))
      source ~/.vimrc-local
endif
