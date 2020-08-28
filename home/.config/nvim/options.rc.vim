:command! UP call dein#remote_plugins()
:command! CH checkhelth
:command! Tnew tabnew | terminal

highlight! Normal ctermbg=NONE guibg=NONE
highlight! NonText ctermbg=NONE guibg=NONE
highlight! LineNr ctermbg=NONE guibg=NONE

set nobackup
set noswapfile
set autoread
set hidden

set number
set autoindent
set cursorline

set list
set listchars=tab:»-,trail:-,extends:»,precedes:«,nbsp:%,eol:$

set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set smarttab
set shiftround

set clipboard=unnamed

set textwidth=0
set conceallevel=0
set signcolumn=yes
set nomodeline

set matchpairs+=<:>
set showmatch

set ignorecase
set smartcase
set incsearch
set wrapscan
set hlsearch
nmap <Esc><Esc> :nohlsearch<CR><Esc>

