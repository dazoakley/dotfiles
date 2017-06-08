set nocompatible                " be iMproved
filetype off                    " required for Vundle, turn on later

" plugins managed by Vundle (http://github.com/gmarik/vundle)
" to install: git clone http://github.com/gmarik/vundle.git ~/.vim/bundle/vundle

" vundle brief help
" :PluginList          - list configured bundles
" :PluginInstall(!)    - install(update) bundles
" :PluginSearch(!) foo - search(or refresh cache first) for foo
" :PluginClean(!)      - confirm(or auto-approve) removal of unused bundles
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Plugin command are not allowed..

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
Plugin 'gmarik/vundle'

" general
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'altercation/vim-colors-solarized'
Plugin 'scrooloose/nerdtree'
Plugin 'ack.vim'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'nginx.vim'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
Plugin 'fholgado/minibufexpl.vim'
Plugin 'neomake/neomake'
Plugin 'godlygeek/tabular'
Plugin 'rodjek/vim-puppet'
Plugin 'hashivim/vim-hashicorp-tools'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'crazy-canux/icinga2.vim'
Plugin 'airblade/vim-gitgutter'

" markdown
Plugin 'dharanasoft/rtf-highlight'
Plugin 'greyblake/vim-preview'

" perl
Plugin 'rkitover/perl-vim-mxd'

" javascript
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'
Plugin 'jimmyhchan/dustjs.vim'
Plugin 'juvenn/mustache.vim'
Plugin 'kchmck/vim-coffee-script'
Plugin 'sbdchd/neoformat'

" ruby
Plugin 'tpope/vim-rails'
Plugin 'vim-ruby/vim-ruby'
Plugin 'tpope/vim-cucumber'
Plugin 'ngmy/vim-rubocop'

" scala
Plugin 'derekwyatt/vim-scala'

" go
Plugin 'fatih/vim-go'

" crystal
Plugin 'rhysd/vim-crystal'

filetype on
filetype plugin indent on       " load the plugin and indent settings for the detected filetype

" disable modelines
set nomodeline

" disable code folding
set nofoldenable

" set encoding so unicode listchars can be used
set encoding=utf-8

" highlight trailing whitespace
set list
set listchars=trail:·,tab:\|\·

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
set tabstop=2
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
" set cursorline
set showmatch
set virtualedit=block
set showtabline=0
set nowrap
set clipboard=unnamed

" vim-airline
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

let g:airline_powerline_fonts = 0
let g:airline_left_sep = '⮀'
let g:airline_left_alt_sep = '⮁'
let g:airline_right_sep = '⮂'
let g:airline_right_alt_sep = '⮃'
let g:airline_symbols.branch = '⭠'
let g:airline_symbols.readonly = '⭤'
let g:airline_symbols.linenr = '⭡'
let g:airline_symbols.space = "\ua0"

set background=light
colorscheme solarized

set mouse=a                     " enable the mouse in xterm
set history=1000                " how many lines of history to remember

" searching
set hlsearch
set incsearch
set showmatch

" speed up omnicomplete
set complete-=i

" This unsets the "last search pattern" register by hitting return
noremap <CR> :noh<CR><CR>

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

" leader
let mapleader = ","

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
set foldmethod=indent                     " indent folding
set foldnestmax=5                         " max detpth of folding
" code folding key-bindings:
" zo - Open the fold on the same line as the cursor
" zc - Close the fold that the cursor is inside
" zR - Open all folds
" zM - Close all folds

" remove trailing whitespace automatically
autocmd BufWritePre * :%s/\s\+$//e

let g:jsx_ext_required = 0 " Allow JSX in normal JS files

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
au BufRead,BufNewFile *.{rake,task,graph} set ft=ruby
au BufRead,BufNewFile *.{erubis,erb} set ft=eRuby
au BufRead,BufNewFile *.html.erb set ft=eruby.html " TODO: figure out how to stop syntastic treating this as HTML!
au BufRead,BufNewFile *.pp set ft=puppet
au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn} set ft=markdown
au BufRead,BufNewFile *.yml.* set ft=yaml
au BufRead,BufNewFile *.coffee set foldmethod=indent ft=coffee
au BufRead,BufNewFile *.mustache set foldmethod=indent ft=mustache
au BufNewFile,BufRead *.ejs set filetype=javascript

" md, markdown, and mk are markdown
au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn} call s:enableSpellCheck()
autocmd Filetype markdown setlocal spell textwidth=79

" Perl - setup perltidy
autocmd BufRead,BufNewFile *.pl,*.plx,*.pm command! -range=% -nargs=* Tidy <line1>,<line2>!perltidy -pbp -l=100
autocmd BufRead,BufNewFile *.pl,*.plx,*.pm noremap <F5> :Tidy<CR>

" HTML/XML - setup tidying
autocmd BufRead,BufNewFile *.xml command! -range=% -nargs=* Tidy <line1>,<line2>!tidy --input-xml true --indent yes --wrap 10000 2>/dev/null
autocmd BufRead,BufNewFile *.html command! -range=% -nargs=* Tidy <line1>,<line2>!tidy --indent yes --wrap 10000 2>/dev/null

" Yaml
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

" git commit messages
autocmd Filetype gitcommit setlocal spell textwidth=72

" vim-preview
nmap <Leader>P :Preview<CR>

" RTF Highlight
let g:rtfh_theme = 'solarized'

" Nerdtree
map <F2> :NERDTreeToggle<CR>

" NeoMake - a neovim alternative for syntastic that does async code linting
autocmd! BufReadPost,BufWritePost * Neomake
let g:neomake_serialize = 1
let g:neomake_serialize_abort_on_error = 1
let g:neomake_javascript_enabled_makers = ['eslint']
let g:neomake_javascript_eslint_exe = system('PATH=$(npm bin):$PATH && which eslint | tr -d "\n"')

" Neoformat - code formatter, run on save
augroup fmt
  autocmd!
  autocmd BufWritePre * Neoformat
augroup END

let g:neoformat_javascript_prettier = {
  \ 'exe': system('PATH=$(npm bin):$PATH && which prettier | tr -d "\n"'),
  \ 'args': ['--single-quote true', '--trailing-comma es5']
  \ }

" vim-commentary
autocmd FileType apache setlocal commentstring=#\ %s
autocmd FileType nginx setlocal commentstring=#\ %s

" ctrlp
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'

" ###########################################################
" CUSTOM MAPPINGS / COMMANDS
" ###########################################################

" Inserts the path of the currently edited file into a command
" Command mode: Ctrl+P
cmap <C-P> <C-R>=expand("%:p:h") . "/" <CR>

command JsonTidy execute "%! jq ."
