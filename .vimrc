set nocompatible          " Use Vim defaults
set autowrite			  " save before :make :suspend, etc 
set backup            	  " keep a backup file
set backspace=2           " allow backspacing over everything in insert mode
set ruler				  " show cursorposition
set showmode			  " Show current mode.
set showcmd 			  " Show (partial) command in status line.
set modelines=2			  " Enable Modelines
set showmatch			  " show matching brackets
set matchpairs+=<:>       " add pointy brackets to matchpairs
set viminfo='20,\"50,h	  " read/write a .viminfo file, don't store more
                          " than 50 lines of registers
set title				  " Set Terminals Title.
set nostartofline         " Don't jump cursor around. Stay in one column
set vb t_vb=              "  Turn the bell off. 
let mapleader = ","     " My custom mappings are introduced by ',' 

" Searching
set incsearch			  " Incremental search. Search while typing.
set ignorecase smartcase  " case insensitive search by default

" Press Space to turn off highlighting and clear any message already
" displayed.
:noremap <silent> <Space> :silent noh<Bar>echo<CR>


" Indention
set tabstop=4			 " Tabwidth
set shiftwidth=4 		 " indention 
set softtabstop=4		 " make sure all tabs are 4 spaces 
set expandtab            " Expand tabs to spaces
set smarttab             " Backspace at the beginning of Line removes indention



" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
	syntax on
	let highlight_balanced_quotes = 1
	let highlight_function_name = 2
	set hlsearch         " highlight search
endif

if has('gui_running')
	set background=light
else
    " friendly color scheme
    colorscheme ron
endif

" Window management
" split window vertically with <leader> v
nmap <leader>v :vsplit<CR> <C-w><C-w>
" split window horizontally with <leader> s
nmap <leader>s :split<CR> <C-w><C-w>
" Switch between windows with <leader> w
nmap <leader>w <C-w><C-w>_

" NERD Tree
let g:NERDTreeQuitOnOpen = 1
nmap <silent> <leader>n :NERDTreeToggle<CR>

" Line Wrapping
set wrap
set linebreak "Wrap at word

" Use utf-8 as default encoding. 
set encoding=utf-8
" This is vims default actually:
set fileencodings=ucs-bom,utf-8,latin1


if has("autocmd")
	" Don't write backups and don't use autoindent for mutt-files.
	" Oh, and no title please.
	au BufNewFile,BufRead ~/tmp/mutt*  set tw=72 nobackup noai notitle

	" Don't write backup files for files in '/tmp'
	au BufNewFile,BufWrite /tmp/* set nobackup

    " Don't write backup files for svn-commits.
    au BufNewFile,BufWrite svn-commit.tmp set nobackup 

	" In text files, always limit the width of text to 78 characters
	au BufNewFile,BufRead *.txt set tw=78 

	" When editing perlfiles use smartindent 
	au FileType perl set cindent
    au FileType perl set cinwords+=elsif,foreach,sub,unless,until
    au FileType perl set cinoptions&

    " Keybindings special to perl
    au FileType perl nnoremap <silent> <leader>t :%!perltidy -q<CR>
    au FileType perl vnoremap <silent> <leader>t :!perltidy -q<CR>
    au FileType perl set makeprg=perl\ -c\ %\ $* 
    au FileType perl set errorformat=%f:%l:%m
    au FileType perl vmap <leader>c :s/^/#/gi<Enter>
    au FileType perl vmap <leader>C :s/^#//gi<Enter>
    au FileType perl noremap <leader>h :!perldoc <cword> <bar><bar> perldoc -f <cword> <cword><cr> 

    " Makefiles have real Tabs
    au FileType make   set noexpandtab

endif " has("autocmd")

" Bind autocompletion to Ctrl-Space, as known from Netbeans. If 
" omnicompletion does not find a match, fall back to keyword completion.   
inoremap <expr> <C-Space> pumvisible() \|\| &omnifunc == '' ?
            \ "\<lt>C-n>" :
            \ "\<lt>C-x>\<lt>C-o><c-r>=pumvisible() ?" .
            \ "\"\\<lt>c-n>\\<lt>c-p>\\<lt>c-n>\" :" .
            \ "\" \\<lt>bs>\\<lt>C-n>\"\<CR>"
imap <C-@> <C-Space>



if version >=600
	filetype plugin indent on " Filetype 
else
	filetype on
endif

" My mappings
map <F5> :set number<CR>     " Turn on linenumbers.
map <F4> :nohl<CR>           " Turn off the highliting of the search.
map <F6> :set nonumber<CR>   " Turn off linenumbers.
map gg 1G                    " gg jumps to first line of buffer

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
