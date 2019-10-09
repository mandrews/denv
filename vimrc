set noswapfile             " disable auto .swp

set modeline               " reads and adjusts vim to modelines
set number

" ----------------------------------------------------------------------------
"  Tabs and Indentation
" ----------------------------------------------------------------------------
set autoindent             " automatic indent new lines
set smartindent            " be smart about it
set wrap                   " wrap lines by default
set softtabstop=2
set shiftwidth=2
set tabstop=4
set expandtab              " expand tabs to spaces
set smarttab

" ----------------------------------------------------------------------------
"  Buffers
" ----------------------------------------------------------------------------
set hidden          	   " allows cross buffer undo's!!!
set noautowrite     	   " do not autowrite buffers
set clipboard=unnamed

" ----------------------------------------------------------------------------
"  Macros
" ----------------------------------------------------------------------------
" leader
let mapleader = ","

" fast buffer switching
nmap <Leader><TAB> :bnext <CR>
nmap <Leader><S-TAB> :bprev <CR>

" remove extra white space
map <Leader>w :%s/\s\+$//e<CR>

" reload
nmap <Leader>s :source $HOME/.vimrc<CR>

" ----------------------------------------------------------------------------
"  Vundle
" ----------------------------------------------------------------------------
" git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
" run :BundleInstall
filetype off
set nocompatible
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'gmarik/Vundle.vim'

" solarized theme
Plugin 'git://github.com/altercation/vim-colors-solarized.git'

" tabular
Plugin 'git://github.com/godlygeek/tabular.git'

" git (vim-fugative)
Plugin 'git://github.com/tpope/vim-fugitive.git'

" ack
Plugin 'git://github.com/mileszs/ack.vim.git'
" noremap <Leader>a :Ack! <cword><CR>

" rails
Plugin 'git://github.com/tpope/vim-rails.git'

" rails tests
Plugin 'git://github.com/jgdavey/tslime.vim.git'
Plugin 'git://github.com/jgdavey/vim-turbux.git'

" matchit
Plugin 'git://github.com/vim-scripts/ruby-matchit.git'

Bundle 'kana/vim-fakeclip'
call vundle#end()

" ----------------------------------------------------------------------------
"  Plugin Configuration
" ----------------------------------------------------------------------------

" solarized theme
syntax enable
set background=dark
colorscheme solarized

" tabular
if exists(":Tabularize")
  nmap <Leader>a= :Tabularize /=<CR>
  vmap <Leader>a= :Tabularize /=<CR>
  nmap <Leader>a: :Tabularize /:\zs<CR>
  vmap <Leader>a: :Tabularize /:\zs<CR>
endif
" rails tests
nnoremap <Leader>vv :Rview<CR>
nnoremap <Leader>cc :Rcontroller<CR>

" ----------------------------------------------------------------------------
"  Filetypes
" ----------------------------------------------------------------------------
filetype plugin indent on

augroup file_extensions
  au BufNewFile,BufRead *.hql set filetype=hql
augroup end

augroup commenting
  autocmd!
  " comment
  autocmd FileType vim map ,# :s/^/"/<CR>
  autocmd FileType ruby,python,perl,sh,zsh,maple map ,# :s/^/#/<CR>
  autocmd FileType haml map ,# :s/^/-#/<CR>
  autocmd FileType java,c,cpp map ,# :s/^/\/\//<CR>
  autocmd FileType tex,matlab map ,# :s/^/%/<CR>
  autocmd FileType java,c,cpp vmap #^ "zdi/*<CR><C-R>z*/<CR><ESC>
  " uncomment
  autocmd FileType ruby,python,perl,sh,zsh,maple map ,$ :s/^#//<CR>
  autocmd FileType haml map ,$ :s/^-#//<CR>
  autocmd FileType tex,matlab map ,$ :s/^%//<CR>
  autocmd FileType c,cpp vmap #$ s/^\/\*|\*\///<CR>
augroup end


"
" Clipper
"
nnoremap <leader>y :call system('nc host.docker.internal 8377', @0)<CR>
