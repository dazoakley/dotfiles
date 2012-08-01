set nocompatible                " be iMproved
filetype off                    " required for Vundle, turn on later

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
Bundle 'gmarik/vundle'

Bundle 'Lokaltog/vim-powerline'
Bundle 'scrooloose/nerdtree'
Bundle 'matchit.zip'
Bundle 'kien/ctrlp.vim'
Bundle 'ack.vim'
Bundle 'sontek/minibufexpl.vim'
Bundle 'tpope/vim-cucumber'
Bundle 'vim-ruby/vim-ruby'
Bundle 'nginx.vim'
Bundle 'kogent/vim-puppet'
Bundle 'pangloss/vim-javascript'
Bundle 'kchmck/vim-coffee-script'
Bundle 'tpope/vim-endwise'
Bundle 'tpope/vim-commentary'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-liquid'
Bundle 'tpope/vim-markdown'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-surround'
Bundle 'VimClojure'
Bundle 'jpalardy/vim-slime'
Bundle 'dharanasoft/rtf-highlight'
Bundle 'greyblake/vim-preview'
Bundle 'juvenn/mustache.vim'

filetype plugin indent on       " load the plugin and indent settings for the detected filetype

" disable modelines
set nomodeline

" disable code folding
set nofoldenable

" set encoding so unicode listchars can be used
set encoding=utf-8

" highlight trailing whitespace
set list listchars=trail:·,tab:>-

" backups and swapfiles
set nobackup
set noswapfile

try
  " persistent undo
  set undodir=~/.vim/undodir
  set undofile

  set colorcolumn=+1
catch /Unknown option/
  " For versions of Vim prior to 7.3.
endtry

" 2 spaces for tabs.
set autoindent
set smartindent
set softtabstop=2
set shiftwidth=2
set tabstop=4
set expandtab
set nosmarttab

" sensible backspace behaviour
set backspace=indent,eol,start

" use ack instead of grep
set grepprg=ack
set grepformat=%f:%l:%m

" ui
set ruler
set noshowcmd
set nolazyredraw
set number
set nostartofline
set cursorline
set showmatch
set virtualedit=block
set showtabline=2
set nowrap

if has("gui_macvim")
  set guifont=Menlo:h12
else
  set guifont=Monospace\ 12
endif

if has('gui_running')
  set background=light
  colorscheme macvim
else
  set background=dark
  colorscheme molokai
endif

set mouse=a                     " enable the mouse in xterm
set history=1000                " how many lines of history to remember
set term=xterm-256color         " give me more colors

" searching
set hlsearch
set incsearch
set showmatch

" tab completion for files
set wildmenu

" ignore certain standard directories
set wildignore+=*/vendor/bundler/*,*/.git/*,*/.hg/*,*/.bundle/*,*/vendor/cache/*,*/coverage/*,*.class,*.jar

" always show the status line
set laststatus=2

" colorscheme
set t_Co=256

" give a little breathing room when scrolling
set scrolloff=3

" allow buffers to be hidden without saving
set hidden

" so that things like rbenv Just Work
set shell=/bin/bash

" leader
let mapleader = "\\"

" no line numbers when exporting HTML
let g:html_number_lines = 0

" syntax highlighting
syntax on

" sensible backspace behaviour
set backspace=indent,eol,start

" use ack instead of grep
set grepprg=ack
set grepformat=%f:%l:%m

" MacVIM shift+arrow-keys behavior (required in .vimrc)
let macvim_hig_shift_movement = 1

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

" remove trailing whitespace automatically
autocmd BufWritePre * :%s/\s\+$//e

" ###########################################################
" SETTINGS FOR SPECIFIC FILE TYPES
" ###########################################################

function s:enableSpellCheck()
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

" md, markdown, and mk are markdown
au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn} call s:enableSpellCheck()

" Perl - setup perltidy
autocmd BufRead,BufNewFile *.pl,*.plx,*.pm command! -range=% -nargs=* Tidy <line1>,<line2>!perltidy -pbp -l=100
autocmd BufRead,BufNewFile *.pl,*.plx,*.pm noremap <F5> :Tidy<CR>

" HTML/XML - setup tidying
autocmd BufRead,BufNewFile *.xml command! -range=% -nargs=* Tidy <line1>,<line2>!tidy --input-xml true --indent yes --wrap 10000 2>/dev/null
autocmd BufRead,BufNewFile *.html command! -range=% -nargs=* Tidy <line1>,<line2>!tidy --indent yes --wrap 10000 2>/dev/null

" vim-preview
nmap <Leader>P :Preview<CR>

" RTF Highlight
let g:rtfh_theme = 'molokai'

" Nerdtree
map <F2> :NERDTreeToggle<CR>

" ###########################################################
" CUSTOM MAPPINGS / COMMANDS
" ###########################################################

" Inserts the path of the currently edited file into a command
" Command mode: Ctrl+P
cmap <C-P> <C-R>=expand("%:p:h") . "/" <CR>

