"PACKAGE MANAGER:
"---------------
set nocompatible
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Plugin 'gmarik/vundle'
filetype plugin indent on


"COPY/PASTE:
"-----------
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
"------
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


"STATUS BAR:
"-----------
Plugin 'vim-airline/vim-airline'


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
"Open file at same line last closed
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
  \| exe "normal! g'\"" | endif
endif


"FUNCTION BROWSER (TAGBAR):
"--------------------------
Plugin 'majutsushi/tagbar'
"List of functions in the current file using Tagbar plugin
map tb :TagbarToggle<CR>
"Make the cursor go to Tagbar window when it opens
let g:tagbar_autofocus = 1


"COPY/PASTE:
"-----------
"Switch between 'set paste' and 'set nopaste' by keying 'zxc'
set pastetoggle=zxc


"NEW LINE:
"---------
"Show newline characters as $ (dollar sign)
map nl :set list!<CR>


"FILE SEARCH:
"------------
Plugin 'kien/ctrlp.vim'
"Control P file search
set runtimepath^=~/.vim/bundle/ctrlp.vim
"Remove limit on how many files Control P can search
let g:ctrlp_max_files=0
"For large projects (https://github.com/kien/ctrlp.vim/issues/234#issuecomment-22992830)
let g:ctrlp_max_depth=40


"TEXT SEARCH:
"------------
"Makes Search Case Insensitive
set hlsearch
set ignorecase
set smartcase


"WHITESPACE:
"-----------
"Highlights extra whitespace at the end of a file (insert before color scheme)
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=gray guibg=gray
au InsertLeave * match ExtraWhitespace /\s\+$/


"COLOR SCHEME:
"-------------
Plugin 'altercation/vim-colors-solarized'
let g:solarized_termcolors=256
colorscheme solarized
set background=dark


"FILE BROWSER (NERDTREE):
"------------------------
"A better file browser
Plugin 'scrooloose/nerdtree'
"Makes NERDTree behave consistently across tabs
Plugin 'jistr/vim-nerdtree-tabs'
"Nicer formatting for tabs
Plugin 'mkitt/tabline.vim'
"allows NERDTree to open/close by typing 'n' then 't'
map nt :NERDTreeTabsToggle<CR>
"Start NERDtree when dir is selected (e.g. "vim .") and start NERDTreeTabs
let g:nerdtree_tabs_open_on_console_startup=2
"Add a close button in the upper right for tabs
let g:tablineclosebutton=1
"Automatically find and select currently opened file in NERDTree
let g:nerdtree_tabs_autofind=1


"INDENTATION:
"------------
"Highlights code for multiple indents without reselecting
vnoremap < <gv
vnoremap > >gv


"CODE COMPLETION:
"----------------
"Automatically finish quotes, brackets, parentheses, etc
Plugin 'jiangmiao/auto-pairs'
"Automatically close HTML elements
Plugin 'alvan/vim-closetag'
"Close tags for twig and php templates
let g:closetag_filetypes = 'html, twig, php'
"Popup autocompletion suggestions
Plugin 'Valloric/YouCompleteMe'
"Removes preview window that pops up
set completeopt-=preview
"Pull tags into YCM
let g:ycm_collect_identifiers_from_tags_files = 1


"CODE SNIPPETS:
"--------------
Plugin 'SirVer/ultisnips'
Plugin 'jimafisk/vim-snippets'
"Recognize Drupal 8 snippets
autocmd FileType php UltiSnipsAddFiletypes php-drupal8
"Allow pressing enter for Ultisnips when using YCM autocomplete
let g:ulti_expand_or_jump_res = 0
function! ExpandSnippetOrCarriageReturn()
  let snippet = UltiSnips#ExpandSnippetOrJump()
  if g:ulti_expand_or_jump_res > 0
    return snippet
  else
    return "\<CR>"
  endif
endfunction
inoremap <expr> <CR> pumvisible() ? "<C-R>=ExpandSnippetOrCarriageReturn()<CR>" : "\<CR>"


"JUMP TO DEFINITION:
"-------------------
"Gutentags creates ctags automatically
Plugin 'ludovicchabant/vim-gutentags'
"Do not create tags for the following file types
let g:gutentags_ctags_exclude = [
 \ '*.css',
 \ '*.html',
 \ '*.js',
 \ '*.json',
 \ '*.xml',
 \ '*.phar',
 \ '*.ini',
 \ '*.rst',
 \ '*.md',
 \ '*vendor/*/test*',
 \ '*vendor/*/Test*',
 \ '*vendor/*/fixture*',
 \ '*vendor/*/Fixture*',
 \ '*var/cache*',
 \ '*var/log*'
 \ ]
"Make Gutentags work with YCM
let g:gutentags_ctags_extra_args = ['--fields=+l']


"SYNTAX HIGHLIGHTING:
"--------------------
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
    autocmd BufRead,BufNewFile *.theme set filetype=php
    autocmd BufRead,BufNewFile *.lock set filetype=json
    autocmd BufRead,BufNewFile *.twig set filetype=html
  augroup END
endif
syntax on


"DEBUGGING:
"----------
Plugin 'joonty/vdebug'
let g:vdebug_features = { 'max_children': 256 }
let g:vdebug_options={}
let g:vdebug_options['break_on_open'] = 0
let g:vdebug_options["path_maps"] = {'/app': getcwd()}


"GIT (FUGITIVE):
"---------------
Plugin 'tpope/vim-fugitive'
map fgb :Gblame<CR>
map fgs :Gstatus<CR>
map fgl :Glog<CR>
map fgd :Gdiff<CR>
map fgc :Gcommit<CR>
map fga :Git add %:p<CR>


"CODE SNIFFER:
"-------------
Plugin 'vim-syntastic/syntastic'
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
