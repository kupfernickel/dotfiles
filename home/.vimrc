" release autogroup in MyAutoCmd
augroup MyAutoCmd
  autocmd!
augroup END

" add pyenv path
" let $PATH = "~/.pyenv/shims:".$PATH
function! IncludePath(path)
  " define delimiter depends on platform
  if has('win16') || has('win32') || has('win64')
    let delimiter = ";"
  else
    let delimiter = ":"
  endif

  let pathlist = split($PATH, delimiter)

  if isdirectory(a:path) && index(pathlist, a:path) == -1
    let $PATH=a:path.delimiter.$PATH
  endif
endfunction

call IncludePath(expand('~/.pyenv/shims'))

" Note: Skip initialization for vim-tiny or vim-small
if !1 | finish | endif

if has('vim_starting')
  if &compatible
    set nocompatible	" Be iMproved
  endif

  " Required:
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('~/.vim/bundle/'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

" My Bundles here:
" Refer to |:NeoBundle-examples|.
" Note: You don't set neobundle setting in .gvimrc!
NeoBundle 'Shougo/vimproc', {
  \ 'build': {
  \   'windows': 'tools\\update-dll-mingw',
  \   'cygwin': 'make -f make_cygwin.mak',
  \   'mac': 'make -f make_mac_mak',
  \   'linux': 'make',
  \   'unix': 'gmake'
  \   }
  \ }
NeoBundle 'Shougo/vimshell'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/unite-outline'
NeoBundle 'Shougo/neomru.vim'
NeoBundleLazy 'Shougo/vimfiler', {
      \ 'depends': [ 'Shougo/unite.vim' ],
      \ 'autoload': {
      \   'commands': [ 'VimFilerTab', 'VimFiler', 'VimFilerExplorer' ],
      \   'mappings': [ '<Plug>(vimfiler_switch)' ],
      \   'explorer': 1
      \   }
      \ }
NeoBundle 'tpope/vim-surround'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'tpope/vim-endwise'
NeoBundle 'tomtom/tcomment_vim'
NeoBundle 'nathanaelkane/vim-indent-guides'
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'Townk/vim-autoclose'
NeoBundle 'thinca/vim-template'
NeoBundle 'vim-scripts/Align'
NeoBundle 'vim-scripts/YankRing.vim'
NeoBundleLazy 'sjl/gundo.vim', {
      \ 'autoload': {
      \   'commands': [ 'GundoToggle' ],
      \   }
      \ }
NeoBundleLazy 'majutsushi/tagbar', {
      \ 'autoload': {
      \   'commands': [ 'TagbarToggle' ],
      \   },
      \ 'build': {
      \   'mac': 'brew install ctags',
      \   }
      \ }
NeoBundleLazy 'davidhalter/jedi-vim', {
      \ 'autoload': {
      \     'filetypes': [ 'python', 'python3', 'djangohtml' ],
      \   },
      \   'build': {
      \     'mac': 'pip install jedi',
      \     'unix': 'pip install jedi',
      \   }
      \ }
NeoBundleLazy 'lambdalisue/vim-pyenv', {
      \ 'depends': [ 'davidhalter/jedi-vim' ],
      \ 'autoload': { 'filetypes': [ 'python', 'python3' ] }
      \ }
NeoBundleLazy 'fatih/vim-go', {
      \ 'autoload': { 'filetypes': [ 'go' ] }
      \ }
NeoBundleLazy 'dgryski/vim-godef', {
      \ 'autoload': { 'filetypes': [ 'go' ] }
      \ }
NeoBundleLazy 'thinca/vim-quickrun', {
      \ 'autoload': {
      \   'mappings': [['nxo', '<Plug>(quickrun)']]
      \ } }

NeoBundle "osyo-manga/unite-quickfix"
NeoBundle "osyo-manga/shabadou.vim"
NeoBundle 'Shougo/vinarise.vim'
NeoBundle 'kien/rainbow_parentheses.vim'

NeoBundle 'rust-lang/rust.vim'
NeoBundleLazy 'racer-rust/vim-racer', {
      \ 'autoload': { 'filetypes': [ 'rust' ] }
      \ }


NeoBundle 'nanotech/jellybeans.vim'
NeoBundle 'tomasr/molokai'

if has('lua') && v:version >= 703 && has('patch885')
  NeoBundleLazy 'Shougo/neocomplete.vim', { 'autoload': { 'insert': 1 } }

  let g:neocomplete#enable_at_startup = 1
  let s:hooks = neobundle#get_hooks("neocomplete.vim")

  function! s:hooks.on_source(bundle)
    let g:acp_enableAtStartup = 0
    let g:neocomplete#enable_smart_case = 1
  endfunction
else
  NeoBundleLazy 'Shougo/neocomplcache.vim', { 'autoload': { 'insert': 1 } }

  let g:neocomplcache_enable_at_startup = 1
  let s:hooks = neobundle#get_hooks("neocomplcache.vim")

  function! s:hooks.on_source(bundle)
    let g:acp_enbaleAtStartup = 0
    let g:neocomplcache_enable_smart_case = 1
  endfunction
endif

call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck

" ----------------------------------------------------
" Vim settings
" ----------------------------------------------------
set termencoding=utf-8
set encoding=utf-8
set mouse=a
" set ttymouse=xtarm2
set pastetoggle=<C-e>

" ## Colors ##
set t_Co=256
syntax enable
"colorscheme jellybeans
colorscheme molokai
au BufRead,BufNewFile /etc/nginx/* set ft=nginx
au BufRead,BufNewFile /etc/php-fpm.conf set ft=php
au BufRead,BufNewFile /etc/php-fpm.d/* set syntax=dosini
highlight Normal ctermbg=none

" ## Files ##
set backupdir=$HOME/.vim/backup
set noswapfile
set hidden
set autoread

" ## Layout  ##
set notitle
set number
set showmatch
set ruler
set list
set nowrap
set scrolloff=10
set laststatus=2

" ## Edit ##
set tabstop=2
set shiftwidth=2
set autoindent
set smartindent
set expandtab
set smarttab
set shiftround
set whichwrap=b,s,h,l,<,>,[,]
set backspace=indent,eol,start

" ## Search ##
set ignorecase
set smartcase
set wrapscan
set incsearch
set hlsearch
nnoremap <ESC><ESC> :nohlsearch<CR>

" ## Shortcuts ##
nnoremap <Space>. :<C-u>tabedit $MYVIMRC<CR>

" ## Macros ##
" Turn off pastemode when leaving insert.
autocmd InsertLeave * set nopaste


" ----------------------------------------------------
" unite.vim settings
" ----------------------------------------------------
let g:unite_enable_start_insert = 1
let g:unite_source_history_yank_enable = 1
let g:unite_source_file_mru_limit = 200

nnoremap <silent> <C-u><C-y> :<C-u>Unite history/yank<CR>
nnoremap <silent> <C-u><C-b> :<C-u>Unite buffer<CR>
nnoremap <silent> <C-u><C-f> :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
nnoremap <silent> <C-u><C-r> :<C-u>Unite -buffer-name=register register<CR>
nnoremap <silent> <C-u><C-u> :<C-u>Unite file_mru buffer<CR>
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>

" ----------------------------------------------------
" vimfiler settings
" ----------------------------------------------------
nnoremap <Leader>e :VimFilerExplorer<CR>
" close vimfiler automatically when there are only vimfiler open
autocmd MyAutoCmd BufEnter * if (winnr('$') == 1 && &filetype ==# 'vimfiler') | q | endif
let s:hooks = neobundle#get_hooks('vimfiler')

function! s:hooks.on_source(bundle)
  let g:vimfiler_as_default_explorer = 1
  let g:vimfiler_enable_auto_cd = 1

  "let g:vimfiler_ignore_pattern = "\%(^\..*\|\.pyc$)"

  " vimfiler specific key mappings
  autocmd MyAutoCmd FileType vimfiler call s:vimfiler_settings()

  function! s:vimfiler_settings()
    " ^^ to go up
    nmap <buffer> ^^ <Plug>(vimfiler_switch_to_parent_directory)
    " use R to refresh
    nmap <buffer> R <Plug>(vimfiler_redraw_screen)
    " overwrite C-l
    nmap <buffer> <C-l> <C-w>l
  endfunction
endfunction

" ----------------------------------------------------
" vim-indent-guides settings
" ----------------------------------------------------
let g:indent_guides_enable_on_vim_startup = 1


" ----------------------------------------------------
" lightline.vim settings
" ----------------------------------------------------
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'mode_map': { 'c': 'NORMAL' },
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ]
      \   },
      \ 'component_function': {
      \   'modified': 'MyModified',
      \   'readonly': 'MyReadonly',
      \   'fugitive': 'MyFugitive',
      \   'filename': 'MyFilename',
      \   'fileformat': 'MyFileformat',
      \   'filetype': 'MyFiletype',
      \   'fileencoding': 'MyFileencoding',
      \   'mode': 'MyMode',
      \   }
      \ }

function! MyModified()
  return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! MyReadonly()
  return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? 'x' : ''
endfunction

function! MyFilename()
  return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
        \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
        \  &ft == 'unite' ? unite#get_status_string() :
        \  &ft == 'vimshell' ? vimshell#get_status_string() :
        \  '' != expand('%:t') ? expand('%:t') : '[No Name]') .
        \ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction

function MyFugitive()
  if &ft !~? 'vimfiler\|gundo' && exists("*fugitive#head")
    let _ = fugitive#head()
    return strlen(_) ? '@'._ : ''
  endif
  return ''
endfunction

function! MyFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! MyFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'unknown') : ''
endfunction

function! MyFileencoding()
  return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! MyMode()
  return winwidth(0) > 60 ? lightline#mode() : ''
endfunction

" ----------------------------------------------------
" vim-template settings
" ----------------------------------------------------
autocmd MyAutoCmd User plugin-template-loaded call s:template_keywords()

function! s:template_keywords()
  silent! %s/<+DATE+>/\=strftime('%Y-%m-%d')/g
  silent! %s/<+FILENAME+>/\=expand('%:r')/g
endfunction

autocmd MyAutoCmd User plugin-template-loaded
      \   if search('<+CURSOR+>')
      \|    silent! execute 'normal! "_da>'
      \|  endif


" ----------------------------------------------------
" Gundo.vim settings
" ----------------------------------------------------
nnoremap <Leader>g :GundoToggle<CR>


" ----------------------------------------------------
" TagBar settings
" ----------------------------------------------------
nnoremap <Leader>t :TagbarToggle<CR>


" ----------------------------------------------------
" vim-quickrun settings
" ----------------------------------------------------
nmap <Leader>q <Plug>(quickrun)
let s:hooks = neobundle#get_hooks('vim-quickrun')
nnoremap <expr><silent> <C-c> quickrun#is_running() ? quickrun#sweep_sessions() : "\<C-C>"

function! s:hooks.on_source(bundle)
  let g:quickrun_config = {
        \ "_": {
        \   "outputter/buffer/split": ":botright 8sp",
        \   "outputter/buffer/close_on_empty": 1
        \   }
        \ }
 endfunction


" ----------------------------------------------------
" jedi-vim settings
" ----------------------------------------------------
let s:hooks = neobundle#get_hooks('jedi-vim')
function! s:hooks.on_source(bundle)
  let g:jedi#auto_vim_vonfiguration = 0
  let g:jedi#popup_select_first = 0
  let g:jedi#rename_command = '<Leader>R'
  let g:jedi#goto_command = '<Leader>G'
endfunction


" ----------------------------------------------------
" Better Rainbow Parentheses settings
" ----------------------------------------------------
let g:rbpt_colorpairs = [
    \ ['brown',       'RoyalBlue3'],
    \ ['Darkblue',    'SeaGreen3'],
    \ ['darkgray',    'DarkOrchid3'],
    \ ['darkgreen',   'firebrick3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['darkred',     'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown',       'firebrick3'],
    \ ['gray',        'RoyalBlue3'],
    \ ['black',       'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['Darkblue',    'firebrick3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkcyan',    'SeaGreen3'],
    \ ['darkred',     'DarkOrchid3'],
    \ ['red',         'firebrick3'],
    \ ]
let g:rbpt_max = 16
let g:rbpt_loadcmd_toggle = 0
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces


" ----------------------------------------------------
" Rust-lang settings
" ----------------------------------------------------
let g:racer_cmd = '$HOME/.cargo/bin/racer'
let $RUST_SRC_PATH="$HOME/.rust/rustc-1.9.0/src"

