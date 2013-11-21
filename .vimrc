set nocompatible          " Use Vim defaults
" Setting up Vundle - the vim plugin bundler
let vundle_installed=1
let vundle_readme=expand('~/.vim/bundle/vundle/README.md')
if !filereadable(vundle_readme)
    echo "Installing Vundle.."
    echo ""
    silent !mkdir -p ~/.vim/bundle
    silent !git clone https://github.com/gmarik/vundle ~/.vim/bundle/vundle
    let vundle_installed=0
endif
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'
" colorscheme of choice
Bundle 'altercation/vim-colors-solarized' 
" close opened parantheses and '"
Bundle 'spf13/vim-autoclose'
Bundle 'tpope/vim-surround'
" make repetition work well with plugins
Bundle 'tpope/vim-repeat'
" Fancier status line
Bundle 'bling/vim-airline'
" Fancy file management
Bundle 'kien/ctrlp.vim'
" Visualization of modified files for git and svn (better than gitgutter)
Bundle 'mhinz/vim-signify'
" Completion on steroids
Bundle 'Shougo/neocomplcache.vim'
" Snipets
Bundle 'Shougo/neosnippet'
" Honza's snippets 
Bundle 'honza/vim-snippets'
" use tagbar if ctags is available
if executable('ctags')
    Bundle 'majutsushi/tagbar'
endif

if vundle_installed == 0
    echo "Installing Bundles, please ignore key map error messages"
    echo ""
    :BundleInstall
endif

filetype plugin indent on " file type and plugin indention

set nobackup              " Keep no backup file, use version control
set modelines=2           " Enable modelines in files
set matchpairs+=<:>       " Add pointy brackets to matchpairs
set viminfo='20,\"50,h    " Read/write a .viminfo file, don't store more
                          " Than 50 lines of registers

set title                 " set Terminals Title.
set nostartofline         " don't jump cursor around. Stay in one column
set vb t_vb=              " turn the bell off. 
set autowrite             " Save before :make :suspend, etc 
set encoding=utf-8        " use utf-8 as default encoding. 
let mapleader = ","       " my custom mappings are introduced by ',' 

" Whitespace
                          " Allow backspacing over everything in insert mode
set backspace=indent,eol,start
set wrap                  " Enable line Wrapping
set autoindent            " take indent for new line from previous line
set linebreak             " Wrap at word
set tabstop=4             " Tabwidth
set shiftwidth=4          " Indention 
set softtabstop=4         " Make sure all tabs are 4 spaces 
set expandtab             " Expand tabs to spaces
set smarttab              " Backspace at beginning of line removes indention

" Searching
set incsearch             " Incremental search. Search while typing.
set ignorecase            " Searches are case insensitive
set smartcase             " Unless they contain at least one capital letter.
set hlsearch              " highlight search

" neocomplcache configuration
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" limit number of completions to 15
let g:neocomplcache_max_list = 15
" use smart case
let g:neocomplcache_enable_smart_case = 1
" enable camelcase completion
let g:neocomplcache_enable_camel_case_completion = 1
" enable underbar completion
let g:neocomplcache_enable_underbar_completion = 1

" Define keyword.
if !exists('g:neocomplcache_keyword_patterns')
    let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns._ = '\h\w*'
" Highlight first canidate
let g:neocomplcache_enable_auto_select = 1

inoremap <expr><C-l> neocomplcache#complete_common_string()
inoremap <expr><C-h> neocomplcache#smart_close_popup().“\<C-h>”
inoremap <expr><BS> neocomplcache#smart_close_popup().“\<C-h>”
" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
    \ "\<Plug>(neosnippet_expand_or_jump)"
    \: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
    \ "\<Plug>(neosnippet_expand_or_jump)"
    \: "\<TAB>"

autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
    let g:neocomplete#sources#omni#input_patterns = {}
endif

" CtrlP configuration
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\.git$\|\.svn$',
    \ 'file': '\.so$\|\.pyc$\|\.jar$' }

let g:ctrlp_user_command = {
    \ 'types': {
    \ 1: ['.git', 'cd %s && git ls-files . --cached --exclude-standard --others'],
    \ },
    \ 'fallback': 'find %s -type f'
\ }

" Ctags 
set tags=./tags;/,~/.vimtags
" Make tags placed in .git/tags file available in all levels of a repository
let gitroot = substitute(system('git rev-parse --show-toplevel'), '[\n\r]', '', 'g')
if gitroot != ''
    let &tags = &tags . ',' . gitroot . '/.git/tags'
endif

" Tagbar
nnoremap <silent> <leader>tt :TagbarToggle<CR>

" Signify configuration
let g:signify_vcs_list = [ 'git', 'svn' ]
let g:signigy_diffoptions = { 'git': '-w', }
" mapping
let g:signify_mapping_next_hunk = '<leader>gj'
let g:signify_mapping_prev_hunk = '<leader>gk'

" User Interface
syntax enable             " Syntax highlight on.
set cursorline            " Highlight the line the cursor's in
set showcmd               " Show (partial) commands in status line.
set ruler                 " Show cursorposition
set showmatch             " Show matching brackets
set wildmenu              " Show lists instead of just completing
set laststatus=2          " Always show a status line
set noshowmode            " Get rid of default mode indicator

if has('gui_running')
    set background=light
    set linespace=1
else
    set background=dark
endif


if filereadable(expand('~/.vim/bundle/vim-colors-solarized/colors/solarized.vim'))
    let g:solarized_termcolors=256
    let g:solarized_termtrans=1
    let g:solarized_contrast="high"
    let g:solarized_visibility="high"
    color solarized
    " Make signcolumn look better.
    highlight SignColumn ctermbg=235 guibg=#eee8d5
endif


let g:airline_left_sep='›'  " Slightly fancier than '>'
let g:airline_right_sep='‹' " Slightly fancier than '<'

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


" My mappings
map <F5> :set number<CR>     " Turn on linenumbers.
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
