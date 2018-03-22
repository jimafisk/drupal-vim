"PACKAGE MANAGER:
"---------------
set nocompatible
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Plugin 'gmarik/vundle'
Plugin 'Buffergator'
Plugin 'joonty/vdebug'
Plugin 'altercation/vim-colors-solarized'
Plugin 'scrooloose/nerdtree'
Plugin 'tpope/vim-fugitive'
Plugin 'vim-syntastic/syntastic'
Plugin 'pangloss/vim-javascript'
Plugin 'mkitt/tabline.vim'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'majutsushi/tagbar'

filetype plugin indent on


"COPY/PASTE
"----------
"Increases the memory limit from 50 lines to 1000 lines
:set viminfo='100,<1000,s10,h


"SOURCING:
"---------
"Automatically reloads .vimrc on write (w)
autocmd! bufwritepost .vimrc source %


"NUMBERING:
"----------
:set number


"MOUSE:
"----------
"Allow using mouse helpful for switching/resizing windows
set mouse+=a
if &term =~ '^screen'
  " tmux knows the extended mouse mode
  set ttymouse=xterm2
endif

"HIGHLIGHTING:
"-------------
" <Ctrl-l> redraws the screen and removes any search highlighting.
nnoremap <silent> <C-l> :nohl<CR><C-l>
" Highlight the current line the cursor is on
set cursorline


"SPACING:
"--------
"Set tabbing to 2 spaces (preferred indentation for PHP)
set tabstop=2
set softtabstop=2
set shiftwidth=2
set shiftround
set expandtab


"SHORTCUTS:
"----------
"Switch between 'set paste' and 'set nopaste' by keying 'zxc'
set pastetoggle=zxc
"Open file at same line last closed
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
  \| exe "normal! g'\"" | endif
endif
"List of functions in the current file using Tagbar plugin
map tb :TagbarToggle<CR>
"Make the cursor go to Tagbar window when it opens
let g:tagbar_autofocus = 1


"SEARCH:
"-------
"Makes Search Case Insensitive
set hlsearch
set ignorecase
set smartcase
"Control P file search
set runtimepath^=~/.vim/bundle/ctrlp.vim


"WHITESPACE:
"-----------
"Highlights extra whitespace at the end of a file in red
"Must be inserted before the color scheme
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=gray guibg=gray
au InsertLeave * match ExtraWhitespace /\s\+$/


"COLOR SCHEME:
"-------------
let g:solarized_termcolors=256
colorscheme solarized
set background=dark


"FILE BROWSER (NERDTREE):
"------------------------
"makes NERDTree close automatically if it's the last thing open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
"allows NERDTree to open/close by typing 'n' then 't'
map nt :NERDTreeTabsToggle<CR>
"Start NERDtree when dir is selected (e.g. "vim .") and start NERDTreeTabs
au VimEnter NERD_tree_1 enew | execute 'NERDTree '.argv()[0] | let g:nerdtree_tabs_open_on_console_startup=1
"Add a close button in the upper right for tabs
let g:tablineclosebutton=1


"INDENTATION:
"------------
"Easier moving of code blocks (keeps code highlighted for multiple indents
"without having to reselect)
vnoremap < <gv
vnoremap > >gv


"PHP:
"----
"Auto Completion (OmniCompletion)
autocmd FileType php set omnifunc=phpcomplete#CompletePHP


"DRUPAL:
"-------
"Makes vim recognize Drupal files as PHP syntax
if has("autocmd")
  " Drupal *.module and *.install files.
  augroup module
    autocmd BufRead,BufNewFile *.module set filetype=php
    autocmd BufRead,BufNewFile *.install set filetype=php
    autocmd BufRead,BufNewFile *.test set filetype=php
    autocmd BufRead,BufNewFile *.inc set filetype=php
    autocmd BufRead,BufNewFile *.profile set filetype=php
    autocmd BufRead,BufNewFile *.view set filetype=php
  augroup END
endif
syntax on
"IMPORTANT: You need to manually create a ctags file
"in order to jump to classes, methods, functions, etc.
"For help, see https://youtu.be/DPv_6zU0ZoQ
"TODO: Create ctags automatically
":set tags=~/.vim/tags/drupal


"DEBUGGING:
"----------
let g:vdebug_features = { 'max_children': 256 }


"GIT (FUGITIVE):
"---------------
map fgb :Gblame<CR>
map fgs :Gstatus<CR>
map fgl :Glog<CR>
map fgd :Gdiff<CR>
map fgc :Gcommit<CR>
map fga :Git add %:p<CR>


"CODE SNIFFER:
"-------------
let g:syntastic_php_phpcs_args="--standard=Drupal --extensions=php,module,inc,install,test,profile,theme"
if has('statusline')
  set laststatus=2
  " Broken down into easily includeable segments
  set statusline=%<%f\ " Filename
  set statusline+=%w%h%m%r " Options
  set statusline+=%{fugitive#statusline()} " Git Hotness
  set statusline+=\ [%{&ff}/%Y] " filetype
  set statusline+=\ [%{getcwd()}] " current dir
  set statusline+=%#warningmsg#
  set statusline+=%{SyntasticStatuslineFlag()}
  set statusline+=%*
  let g:syntastic_enable_signs=1
  set statusline+=%=%-14.(%l,%c%V%)\ %p%% " Right aligned file nav info
endif
