set nocompatible          " Use Vim defaults
set nobackup              " Keep no backup file, use something modern
set ruler                 " Show cursorposition
set showmode              " Show current mode.
set showcmd               " Show (partial) commands in status line.
set modelines=2           " Enable Modelines
set showmatch             " Show matching brackets
set matchpairs+=<:>       " Add pointy brackets to matchpairs
set viminfo='20,\"50,h    " Read/write a .viminfo file, don't store more
                          " Than 50 lines of registers
call pathogen#infect()    " Make use of pathogen
filetype plugin indent on " file type and plugin indention
set title                 " set Terminals Title.
set nostartofline         " don't jump cursor around. Stay in one column
set vb t_vb=              " turn the bell off. 
let mapleader = ","       " my custom mappings are introduced by ',' 
set autowrite             " Save before :make :suspend, etc 
set encoding=utf-8        " use utf-8 as default encoding. 

" Whitespace
                          " Allow backspacing over everything in insert mode
set backspace=indent,eol,start 
set wrap                  " Enable line Wrapping
set linebreak             " Wrap at word
set tabstop=4             " Tabwidth
set shiftwidth=4          " Indention 
set softtabstop=4         " Make sure all tabs are 4 spaces 
set expandtab             " Expand tabs to spaces
set smarttab              " Backspace at the beginning of Line removes indention

" Searching
set incsearch             " Incremental search. Search while typing.
set ignorecase            " Searches are case insensitive
set smartcase             " Unless they contain at least one capital letter.

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
    syntax enable
    set hlsearch          " highlight search
endif

if has('gui_running')
    set background=light
else
    set background=dark
endif

" friendly color scheme
set t_Co=16
colorscheme solarized


" Window management
" split window vertically with <leader> v
nmap <leader>v :vsplit<CR> <C-w><C-w>
" split window horizontally with <leader> s
nmap <leader>s :split<CR> <C-w><C-w>
" Switch between windows with <leader> w
nmap <leader>w <C-w><C-w>_

nmap <leader>d :r !date +\%Y-\%m-\%d<CR>




if has("autocmd")
    " Don't write backups and don't use autoindent for mutt-files.
    " Oh, and no title please.
    " I'm not sure if I should leave this in. Have not been using 
    " mutt for ages.
    au BufNewFile,BufRead ~/tmp/mutt*  set tw=72 nobackup noai notitle

    " Makefiles have real Tabs
    au FileType make set noexpandtab

    " Don't write backup files for files in '/tmp'
    au BufNewFile,BufWrite /tmp/* set nobackup

    " Don't write backup files for svn-commits.
    au BufNewFile,BufWrite svn-commit.tmp set nobackup 

    " In text files, always limit the width of text to 78 characters
    au BufNewFile,BufRead *.txt set tw=79 

    " When editing perlfiles use smartindent 
    au FileType perl set cindent
    au FileType perl set cinwords+=elsif,foreach,sub,unless,until
    au FileType perl set cinoptions&

    " Keybindings special to perl
    au FileType perl nnoremap <silent> <leader>t :%!perltidy -q<CR>
    au FileType perl vnoremap <silent> <leader>t :!perltidy -q<CR>
    au FileType perl set makeprg=perl\ -c\ %\ $* 
    au FileType perl set errorformat=%f:%l:%m
    au FileType perl vmap <leader>c :s/^/#/gi<CR> :nohl <CR>
    au FileType perl vmap <leader>C :s/^#//gi<CR> :nohl <CR>
    au FileType perl noremap <leader>h :!perldoc <cword> <bar><bar> perldoc -f <cword> <cword><cr> 


endif " has("autocmd")

" Bind autocompletion to Ctrl-Space, as known from Netbeans. If 
" omnicompletion does not find a match, fall back to keyword completion.   
inoremap <expr> <C-Space> pumvisible() \|\| &omnifunc == '' ?
            \ "\<lt>C-n>" :
            \ "\<lt>C-x>\<lt>C-o><c-r>=pumvisible() ?" .
            \ "\"\\<lt>c-n>\\<lt>c-p>\\<lt>c-n>\" :" .
            \ "\" \\<lt>bs>\\<lt>C-n>\"\<CR>"
imap <C-@> <C-Space>



" My mappings
map <F5> :set number<CR>     " Turn on linenumbers.
map <F4> :nohl<CR>           " Turn off the highliting of the search.
map <F6> :set nonumber<CR>   " Turn off linenumbers.

" Press Space to turn off highlighting and clear any message already
" displayed.
:noremap <silent> <Space> :silent noh<Bar>echo<CR>

" perl-stuff

" handle package names in variables differently from the rest of the 
" variable name 
let perl_scope_want_variables = 1

" syntax color complex things like @{${"foo"}}
let perl_extended_vars = 1

" Perl includes POD 
let perl_include_pod = 1

let perl_want_scope_in_variables = 1

" Java-Stuff. 
let java_highlight_all=1
let java_highlight_functions="style"
let java_allow_cpp_keywords=1

" XML-Related
let xml_use_xhtml = 1

" IMPORTANT: grep will sometimes skip displaying the file name if you
" " search in a singe file. This will confuse latex-suite. Set your grep
" " program to alway generate a file-name.
set grepprg=grep\ -nH\ $*

" Prevents Vim 7.0 from setting filetype to 'plaintex'
let g:tex_flavor='latex'


if filereadable(expand("~/.vimrc-local"))
      source ~/.vimrc-local
endif
