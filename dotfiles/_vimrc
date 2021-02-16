" Automatically Installs vim-plug
" https://github.com/junegunn/vim-plug
"
if empty(glob('$vim/vimfiles/autoload/plug.vim'))
  silent !curl -fLo $vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Specify a directory for plugins
"
call plug#begin('$vim/plugged')

" Misc plugins
"
Plug 'xolox/vim-shell'
Plug 'xolox/vim-misc'

" Writing
"
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'mzlogin/vim-markdown-toc'
" Plug 'vim-pandoc/vim-pandoc'
" Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'plasticboy/vim-markdown'
Plug 'tpope/vim-surround'
Plug 'easymotion/vim-easymotion'

" Couldn't get the below plugins to work correctly
" Using 'vim-pandoc-syntax' for MD highlighting
" Plug 'godlygeek/tabular'

" Fonts
"
Plug 'powerline/fonts'

" Themes
"
Plug 'joshdick/onedark.vim'
Plug 'sickill/vim-monokai'
Plug 'reedes/vim-colors-pencil'
Plug 'arcticicestudio/nord-vim'
Plug 'morhetz/gruvbox'

" Airline
" There is a bug in vim that crashes airline in terminal vim
" 
if has("gui_running")
    Plug 'bling/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    Plug 'enricobacis/vim-airline-clock'
endif

" Fuzzy finder
"
" Plug 'ctrlpvim/ctrlp.vim'

" Productivity
"
Plug 'scrooloose/nerdtree'

" Auto complete
" Has issues setting up. Not going to bother using right now
"
" Plug 'valloric/youcompleteme'

" Syntax and highlighting
"
Plug 'pprovost/vim-ps1'
Plug 'nathanaelkane/vim-indent-guides'

" Documentation
"
Plug 'vimwiki/vimwiki'

" Git
"
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" Initialize plugin system
"
call plug#end()

" Turn on plugins (instructed via instant-markdown.vim)
"
filetype plugin on

" Change vim wiki location
"
let g:vimwiki_list = [{'path': 'C:\Users\Zach2\mywiki'}]

" Other vimwiki settings not set
"
set nocompatible

" Help files key map
"
nmap <F4> :helptags $vim/vimfiles/doc

" Organize all Vim files into tmp directories. Reduces clutter
" 
set backup 
set backupdir^=$vim/tmpBackup//

set swapfile
set directory^=$vim/tmpSwap//

set undofile
set undodir^=$vim/tmpUndo//

" Set viminfo location to user directory 
"
set viminfo+=nc:~/_viminfo

" Disable Folding
" 
let g:vim_markdown_folding_disabled = 1

" Syntax Concealing
"
set conceallevel=2

" Markdown Syntax Settings
" Below changes [Link](URL) to [Link]
"
" let g:pandoc#syntax#conceal#urls = 1

" YouCompleteMe Setup
"
set encoding=utf-8

" Enable Soft Tab
"
set tabstop=8 softtabstop=4 expandtab shiftwidth=4 smarttab

" Indent Guide: Soft Tab
"  
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_start_level = 1
let g:indent_guides_guide_size = 1

" Indent Guides: Hard Tab
" Sets the 'tab' character to be seen as a '|' symbol
"
set listchars=tab:\|\ 
set list

" Highlight Line
"
set cursorline 
hi CursorLine term=bold cterm=bold guibg=Gray40

" Word Wrap
"
set wrap
set linebreak
set textwidth=0
set wrapmargin=0

" Font
"
set guifont=Consolas:h11

" Set Theme
"

syntax enable

" Helps the colors appear correctly in the terminal
"
if !has("gui_running")
    set termguicolors
endif

colorscheme gruvbox
hi Normal guibg=NONE ctermbg=NONE

" Spell Check
" The below code automatically turns on spell checking when entering 'Insert' mode 
" Use 'Ctrl-c' to enter 'Normal' mode with spell checking when in 'Insert' mode 
"
autocmd InsertEnter * setlocal spell spelllang=en_us
autocmd InsertLeave * setlocal nospell 

" Line Numbers
" 'number' shows line numbers
" 'relativenumber' shows the relative numbers from current position
" Setting both creates a hybrid mode
 
set number 
set relativenumber
autocmd InsertEnter * setlocal norelativenumber
autocmd InsertLeave * setlocal relativenumber

" Function for entering and leaving goyo
"
function! s:goyo_enter()
    colorscheme gruvbox
    set background=light
    let g:gruvbox_contrast_light = 'hard'
    let w:airline_disabled = 1
    set number
    set relativenumber 
    Limelight
endfunction

function! s:goyo_leave()
    if has ('gui_running')
        "Gvim Colors
        colorscheme gruvbox
        set background=dark
        Limelight!
    else
        "vim colors (terminal)
        colorscheme gruvbox
        let g:gruvbox_termcolors = '16'
    endif
endfunction

autocmd! User GoyoEnter nested call <SID>goyo_enter()
autocmd! User GoyoLeave nested call <SID>goyo_leave()

" Toolbars and Scrollbars
" Remove toolbars 
"
set guioptions-=m
set guioptions-=T

" Remove scrollbar
"
set guioptions-=r
set guioptions-=L

" Window Size
" Sets the size of the vim window
"
" set lines=40 columns=150

" Text Highlighting
" Turns on word highlighting
"
set hlsearch

" NERDTree Bookmarks
"
let g:NERDTreeBookmarksFile = "$vim\NERDTreeBookmarks"
map <F2> :NERDTree

" DEFAULT VIM SCRIPT ACTIONS

source $VIMRUNTIME/vimrc_example.vim

" Disabling 'mswin.wim' as it replaces many key bindings in GVIM
" with common windows keys like 'c-f' being 'find.'
" this is annoying and stupid. Though this also removes 'c-v' as paste
"
" source $VIMRUNTIME/mswin.vim

behave mswin

set diffexpr=MyDiff()
function! MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      if empty(&shellxquote)
        let l:shxq_sav = ''
        set shellxquote&
      endif
      let cmd = '"' . $VIMRUNTIME . '\diff"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
  if exists('l:shxq_sav')
    let &shellxquote=l:shxq_sav
  endif
endfunction

" End DEFAULT VIM SCRIPT ACTIONS
" ---
