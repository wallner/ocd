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
" make repetition work well with plugins
Bundle 'tpope/vim-repeat'
" handle surroundings
Bundle 'tpope/vim-surround'
" proper git integration
Bundle 'tpope/vim-fugitive'
" use <c-a>/ <c-x> on dates
Bundle 'tpope/vim-speeddating'
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
Bundle 'Shougo/neosnippet-snippets'
" vim module
Bundle 'rodjek/vim-puppet'
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
let mapleader=","         " my custom mappings are introduced by ','

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
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'
" Highlight first canidate
let g:neocomplcache_enable_auto_select = 1
" Don't have the window popup automatically
let g:neocomplcache_disable_auto_complete = 15
inoremap <expr><C-l> neocomplcache#complete_common_string()
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



" Cache completion on ctrl-space in insert mode
function! Auto_complete_string()
    if pumvisible()
        return "\<C-n>"
    else
        return "\<C-x>\<C-u>"
    end
endfunction

inoremap <expr> <Nul> Auto_complete_string()
inoremap <expr> <C-Space> Auto_complete_string()

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

" Tagbar and switch to that window.
nnoremap <silent> <leader>tt :TagbarToggle<CR><C-w><C-w>

" Signify configuration
let g:signify_vcs_list = [ 'git', 'svn' ]
let g:signigy_diffoptions = { 'git': '-w', }
" mapping
let g:signify_mapping_next_hunk = '<leader>gj'
let g:signify_mapping_prev_hunk = '<leader>gk'

" The following configuration causes the buffers to be written to disk.
let g:signify_update_on_bufenter = 1
let g:signify_update_on_focusgained = 1
let g:signify_cursorhold_normal = 2000

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
    set guifont=Source\ Code\ Pro\ 12
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


let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
if !exists('g:airline_symbols')
      let g:airline_symbols = {}
endif
let g:airline_symbols.space = "\ua0"

" Window management
" split window vertically with <leader> v
nmap <leader>v :vsplit<CR> <C-w><C-w>
" split window horizontally with <leader> s
nmap <leader>s :split<CR> <C-w><C-w>
" Switch between windows with <leader> w
nmap <leader>w <C-w><C-w>_

if has("autocmd")
    " Don't use autoindent for mutt-files and don't set the title.
    " I'm not sure if I should keep this. Have not been using
    " mutt for ages.
    au BufNewFile,BufRead ~/tmp/mutt*  set tw=72 noai notitle

    " Makefiles have real Tabs
    au FileType make set noexpandtab

    " In text files, always limit the width of text to 79 characters
    au BufNewFile,BufRead *.txt,*markdown,*md,*asciidoc set tw=78

endif " has("autocmd")


" My mappings
map <F5> :set number<CR>     " Turn on linenumbers.
map <F6> :set nonumber<CR>   " Turn off linenumbers.

" Press Space to turn off highlighting and clear any message already
" displayed.
:noremap <silent> <Space> :silent noh<Bar>echo<CR>

" XML-Related
let xml_use_xhtml = 1

" IMPORTANT: grep will sometimes skip displaying the file name if you
" " search in a singe file. This will confuse latex-suite. Set your grep
" " program to alway generate a file-name.
set grepprg=grep\ -nH\ $*

" Prevents Vim 7 from setting filetype to 'plaintex'
let g:tex_flavor='latex'


if filereadable(expand("~/.vimrc-local"))
      source ~/.vimrc-local
endif
