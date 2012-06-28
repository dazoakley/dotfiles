set nocompatible                " be iMproved
filetype off                    " required for Vundle, turn on later

syntax on

" ui
set ruler                       " ruler
set noshowcmd
set nolazyredraw
set number                      " line numbers
" set relativenumber              " show RELATIVE line numbers
set autoindent                  " autoindent
set nostartofline
set cursorline
set showmatch
set virtualedit=block
set scrolloff=4                 " set how many lines to keep around the cursor
set encoding=utf-8
set cpoptions+=$                " show $ sign when changing
set mouse=a                     " enable the mouse in xterm
set history=1000                " how many lines of history to remember
set showmode                    " show the mode we're currently in
set laststatus=2                " status bar
set term=xterm-256color         " give me more colours
set showcmd                     " show (partial) command in the status line

let mapleader='\\'

" let's make it easy to edit this file (mnemonic for the key sequence is 'e'dit 'v'imrc)
nmap <silent> <Leader>ev :e $MYVIMRC<cr>

" and to source this file as well (mnemonic for the key sequence is 's'ource 'v'imrc)
nmap <silent> <Leader>sv :so $MYVIMRC<cr>

" Directories for swp files
set backupdir=~/.vim/backup
set directory=~/.vim/backup

" persistent undo
try
  set undodir=~/.vim/undo
  set undofile
catch /Unknown option/
  " For versions of Vim prior to 7.3.
endtry

" whitespace stuff
set nowrap                              " don't wrap lines
set shiftwidth=2                        " use indents of 2 spaces
set expandtab                           " tabs are spaces, not tabs
set tabstop=2                           " an indentation every four columns
set softtabstop=2                       " let backspace delete indent
set list listchars=tab:\ \ ,trail:·     " show indents as dots

" remove trailing whitespace automatically
autocmd BufWritePre * :%s/\s\+$//e

" searching
set hlsearch
set incsearch
set ignorecase
set smartcase
"This unsets the "last search pattern" register by hitting return
nnoremap <CR> :noh<CR><CR>

" Tab completion
set wildmode=list:longest,list:full
set wildignore+=*.o,*.so,*.obj,*.class,*/.git/*,*/.hg/*,*/.svn/*
set complete-=i

" Visual
set showmatch                             " Show matching brackets.
set mat=5                                 " Bracket blinking.
set list
if has("gui_macvim")
  set guifont=Menlo:h12
else
  set guifont=Monospace\ 12
endif

" code folding
let perl_fold=1                           " perl folding
let ruby_fold=1                           " ruby folding
let javaScript_fold=1                     " javascript folding
let g:xml_syntax_folding=1                " xml folding
set foldmethod=syntax                     " fold using syntax checking
set foldnestmax=5                         " max detpth of folding
" code folding key-bindings:
" zo - Open the fold on the same line as the cursor
" zc - Close the fold that the cursor is inside
" zR - Open all folds
" zM - Close all folds

" remember last location in file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal g'\"" | endif
endif

" text wrapping
function s:setupWrapping()
  set wrap
  set wrapmargin=2
  set textwidth=78
  set colorcolumn=80
endfunction

" set text wrapping toggles
nmap  <Leader>w :set invwrap<CR>:set wrap?<CR>

" MacVIM shift+arrow-keys behavior (required in .vimrc)
let macvim_hig_shift_movement = 1

" ###########################################################
" SETTINGS FOR SPECIFIC FILE TYPES
" ###########################################################

function s:setupMarkup()
  call s:setupWrapping()

  " enable easy preview
  " map <buffer> <Leader>p :Hammer<CR>

  " Enable spell checking
  "
  " Here are the commands you need to know:
  "
  " ]s — move to the next mispelled word
  " [s — move to the previous mispelled word
  " zg — add a word to the dictionary
  " zug — undo the addition of a word to the dictionary
  " z= — view spelling suggestions for a mispelled word
  setlocal spell spelllang=en_gb
endfunction

" make uses real tabs
au FileType make set noexpandtab

" Set non-standard syntaxes
au BufRead,BufNewFile {Gemfile,Rakefile,Vagrantfile,Thorfile,config.ru} set ft=ruby
au BufRead,BufNewFile *.{rake,task} set ft=ruby
au BufRead,BufNewFile *.{erubis,erb} set ft=eRuby
au BufRead,BufNewFile *.html.erb set ft=eruby.html " TODO: figure out how to stop syntastic treating this as HTML!
au BufRead,BufNewFile *.json set ft=javascript
au BufRead,BufNewFile *.pp set ft=puppet
au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn} set ft=markdown
au BufRead,BufNewFile *.yml.* set ft=yaml
au BufRead,BufNewFile *.coffee set foldmethod=indent ft=coffee
au BufRead,BufNewFile *.mustache set foldmethod=indent ft=mustache

" md, markdown, and mk are markdown and define buffer-local preview
au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn} call s:setupMarkup()

" wrap text files
au BufRead,BufNewFile *.txt call s:setupWrapping()

" Perl - setup perltidy
autocmd BufRead,BufNewFile *.pl,*.plx,*.pm command! -range=% -nargs=* Tidy <line1>,<line2>!perltidy -pbp -l=100
autocmd BufRead,BufNewFile *.pl,*.plx,*.pm noremap <F5> :Tidy<CR>

" HTML/XML - setup tidying
autocmd BufRead,BufNewFile *.xml command! -range=% -nargs=* Tidy <line1>,<line2>!tidy --input-xml true --indent yes --wrap 10000 2>/dev/null
autocmd BufRead,BufNewFile *.html command! -range=% -nargs=* Tidy <line1>,<line2>!tidy --indent yes --wrap 10000 2>/dev/null

" ###########################################################
" PLUGINS
" ###########################################################

" plugins managed by Vundle (http://github.com/gmarik/vundle)
" to install: git clone http://github.com/gmarik/vundle.git ~/.vim/bundle/vundle

" vundle brief help
" :BundleList          - list configured bundles
" :BundleInstall(!)    - install(update) bundles
" :BundleSearch(!) foo - search(or refresh cache first) for foo
" :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Bundle command are not allowed..

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'

Bundle 'Lokaltog/vim-powerline'
Bundle 'sexy-railscasts'
Bundle 'altercation/vim-colors-solarized'
Bundle 'scrooloose/nerdtree'
Bundle 'ddollar/nerdcommenter'
Bundle 'scrooloose/syntastic'
Bundle 'Raimondi/delimitMate'
Bundle 'kien/ctrlp.vim'
Bundle 'ack.vim'
Bundle 'sontek/minibufexpl.vim'
Bundle 'tpope/vim-cucumber'
Bundle 'Rubytest.vim'
Bundle 'ctags.vim'
Bundle 'rails.vim'
Bundle 'kogent/vim-puppet'
Bundle 'pangloss/vim-javascript'
Bundle 'kchmck/vim-coffee-script'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-liquid'
Bundle 'VimClojure'
Bundle 'jpalardy/vim-slime'
Bundle 'dharanasoft/rtf-highlight'
Bundle 'greyblake/vim-preview'
Bundle 'juvenn/mustache.vim'

" all this for snipmate
Bundle 'MarcWeber/vim-addon-mw-utils'
Bundle 'tomtom/tlib_vim'
Bundle 'honza/snipmate-snippets'
Bundle 'garbas/vim-snipmate'

syntax on                       " enable syntax highlighting
filetype on                     " enable vim filetype detection
filetype plugin indent on       " load the plugin and indent settings for the detected filetype

if has('gui_running')
  " colorscheme sexy-railscasts
  set background=light
  colorscheme macvim
else
  colorscheme sahara
endif

" Syntastic
let g:syntastic_enable_signs=1                    " Use sign interface to mark errors
let g:syntastic_auto_loc_list=1                   " Error window auto closes when no errors, also auto opens when errors found
" let g:syntastic_check_on_open=1
" let g:syntastic_disabled_filetypes = ['eruby.html']

" Nerdtree
map <F2> :NERDTreeToggle<CR>

" delimitMate
let delimitMate_expand_space = 1                  " expand <space> inside empty delimiters
let delimitMate_expand_cr = 1                     " expand <cr> inside empty delimiters

" Rubytest
map <Leader>. <Plug>RubyTestRun                   " change from <Leader>t to <Leader>.

" RTF Highlight
let g:rtfh_theme = 'molokai'

" vim-preview
nmap <Leader>P :Preview<CR>

" ###########################################################
" CUSTOM MAPPINGS / COMMANDS
" ###########################################################

" Kill whitespace
command! KillWhitespace :normal :%s/ *$//g<cr><c-o><cr>

" Inserts the path of the currently edited file into a command
" Command mode: Ctrl+P
cmap <C-P> <C-R>=expand("%:p:h") . "/" <CR>

" Unimpaired configuration
" Bubble single lines
nmap <C-Up> [e
nmap <C-Down> ]e
" Bubble multiple lines
vmap <C-Up> [egv
vmap <C-Down> ]egv

