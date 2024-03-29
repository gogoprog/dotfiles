" Vundle
set nocompatible
filetype off
set rtp+=~/.vim/bundle/vundle

" Plugins
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
" Plugin 'MarcWeber/vim-addon-mw-utils'
" Plugin 'tomtom/tlib_vim'
Plugin 'scrooloose/nerdtree'
Plugin 'altercation/vim-colors-solarized'
Plugin 'spf13/vim-colors'
" Plugin 'tpope/vim-surround'
" Plugin 'tpope/vim-repeat'
" Plugin 'rhysd/conflict-marker.vim'
Plugin 'jiangmiao/auto-pairs'
let g:AutoPairs={'{':'}'}
" Plugin 'terryma/vim-multiple-cursors'
Plugin 'mg979/vim-visual-multi'
" Plugin 'vim-scripts/sessionman.vim'
" Plugin 'matchit.zip'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
" Plugin 'powerline/fonts'
" Plugin 'bling/vim-bufferline'
Plugin 'easymotion/vim-easymotion'
" Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'flazz/vim-colorschemes'
" Plugin 'mbbill/undotree'
" Plugin 'nathanaelkane/vim-indent-guides'
" Plugin 'vim-scripts/restore_view.vim'
" Plugin 'mhinz/vim-signify'
" Plugin 'tpope/vim-abolish.git'
" Plugin 'osyo-manga/vim-over'
" Plugin 'kana/vim-textobj-user'
" Plugin 'kana/vim-textobj-indent'
" Plugin 'gcmt/wildfire.vim'
Plugin 'w0rp/ale'
Plugin 'tpope/vim-fugitive'
" Plugin 'mattn/webapi-vim'
" Plugin 'mattn/gist-vim'
" Plugin 'scrooloose/nerdcommenter'
Plugin 'tpope/vim-commentary'
" Plugin 'godlygeek/tabular'
" Plugin 'Shougo/neosnippet'
" Plugin 'Shougo/neosnippet-snippets'
" Plugin 'honza/vim-snippets'
" Plugin 'beyondwords/vim-twig'
" Plugin 'elzr/vim-json'
" Plugin 'groenewege/vim-less'
Plugin 'pangloss/vim-javascript'
" Plugin 'briancollins/vim-jst'
" Plugin 'kchmck/vim-coffee-script'
" Plugin 'hail2u/vim-css3-syntax'
" Plugin 'gorodinskiy/vim-coloresque'
" Plugin 'tpope/vim-haml'
" Plugin 'mattn/emmet-vim'
" Plugin 'tpope/vim-rails'
" Plugin 'rust-lang/rust.vim'
" Plugin 'tpope/vim-markdown'
" Plugin 'spf13/vim-preview'
" Plugin 'tpope/vim-cucumber'
" Plugin 'cespare/vim-toml'
" Plugin 'quentindecock/vim-cucumber-align-pipes'
" Plugin 'saltstack/salt-vim'
" Plugin 'OmniSharp/omnisharp-vim'
Plugin 'tpope/vim-dispatch'
Plugin 'leafgarland/typescript-vim'
Plugin 'mileszs/ack.vim'
" Plugin 'Valloric/YouCompleteMe'
Plugin 'tabnine/YouCompleteMe'
" Plugin 'codota/tabnine-vim'
set rtp+=~/.oh-my-zsh/custom/plugins/fzf
Plugin 'junegunn/fzf.vim'
Plugin 'mechatroner/minimal_gdb'
Plugin 'justinmk/vim-sneak'
Plugin 'tpope/vim-sleuth'
Plugin 'chaoren/vim-wordmotion'
Plugin 'gogoprog/vim-executer'
Plugin 'gogoprog/vim-makefile-manager'
Plugin 'tikhomirov/vim-glsl'
Plugin 'alemigliardi/vim-combo'
Plugin 'luochen1990/rainbow'
Plugin 'jeroenbourgois/vim-actionscript'

call vundle#end()            " required
filetype plugin indent on    " required

" Custom
let project_root = getcwd()
let $PROJECT_ROOT = getcwd()

set autoread
au CursorHold,CursorHoldI * checktime
set updatetime=100

if exists('$TMUX')
    let &t_SI = "\<Esc>Ptmux;\<Esc>\e[5 q\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\e[2 q\<Esc>\\"
    autocmd BufReadPost,FileReadPost,BufNewFile,BufEnter * call system("tmux rename-window \"vim [" . expand("%:p") . "]\"")
else
    let &t_SI = "\e[5 q"
    let &t_EI = "\e[2 q"
    let &titlestring = "vim [" . expand("%:p") . "]"
endif
let &t_SR = "\<Esc>[4 q"

set secure exrc " Application-specific .vimrc
set clipboard=unnamedplus " X11 Clipboard

let g:ackprg = 'cd $PROJECT_ROOT && ag --nogroup --nocolor --column --smart-case -f'

" Quickfix autoheight:
au FileType qf call AdjustWindowHeight(3, 20)
function! AdjustWindowHeight(minheight, maxheight)
  exe max([min([line("$"), a:maxheight]), a:minheight]) . "wincmd _"
endfunction

" Key mapping
map i <Up>
map k <Down>
map j <Left>
noremap h i
noremap <Space> <insert>
noremap <Space> i

nnoremap <c-s> :w<CR>
inoremap <c-s> <Esc>:w<CR>l
vnoremap <c-s> <Esc>:w<CR>

map f <Plug>(easymotion-bd-w)
map F :cd $PROJECT_ROOT <bar> Ack! <cword> 
map ] :cd $PROJECT_ROOT <bar> Ack! 
noremap <c-f> /
noremap E :NERDTreeFind<CR>
map <C-P> :cd $PROJECT_ROOT <bar> :call fzf#vim#files('.', fzf#vim#with_preview())<CR>

noremap <c-h> <c-i>
noremap <silent> { :wincmd w<CR>
nnoremap <silent> <c-i> :wincmd k<CR>
nnoremap <silent> <c-k> :wincmd j<CR>
nnoremap <silent> <c-j> :bp<CR>
nnoremap <silent> <c-l> :bn<CR>
map <C-W> :bd<CR>

autocmd FileType cs nnoremap <buffer> <C-]> :OmniSharpGotoDefinition<CR>
autocmd FileType cs nnoremap <buffer> <C-K> :OmniSharpCodeFormat<CR>
autocmd FileType json nnoremap <buffer> <C-K> :%!js-beautify -<CR><Esc><Esc><Esc>g;g;
autocmd FileType html nnoremap <buffer> <C-K> :%!js-beautify --type html -s 2 -<CR><Esc><Esc><Esc>g;g;
autocmd FileType javascript nnoremap <buffer> <C-K> :%!js-beautify --type js -<CR><Esc><Esc><Esc>g;g;
autocmd FileType scss nnoremap <buffer> <C-K> :%!js-beautify --type css -s 2 -<CR><Esc><Esc><Esc>g;g;
autocmd FileType css nnoremap <buffer> <C-K> :%!js-beautify --type css -s 2 -<CR><Esc><Esc><Esc>g;g;
autocmd FileType haxe nnoremap <buffer> <C-K> :%!astyle --mode=cs -A2 -f -U -Y -j -o -O -xe -xg -xL -S -s4 -xj -xt1 -xW -z2<CR><Esc><Esc><Esc>g;g;
autocmd FileType java nnoremap <buffer> <C-K> :%!astyle --mode=java -A2 -U -Y -j -o -O -xe -xg -xL -S -s4 -xj -xt1 -xW -z2<CR><Esc><Esc><Esc>g;g;
autocmd FileType lua nnoremap <buffer> <C-K> gg=Gg;g;
autocmd FileType xml nnoremap <buffer> <C-K> :%!xmllint --format --recover -<CR><Esc><Esc><Esc>g;g;
autocmd FileType typescript set errorformat=%.%#\ ERROR\ in\ %f(%l\\,%.%#
autocmd BufRead,BufNewFile *.fs set syntax=glsl
autocmd BufRead,BufNewFile *.vs set syntax=glsl


map  :Commentary<CR>
vmap <Tab> >gv
vmap <S-Tab> <gv

unmap <C-K>
map <C-K> :!clang-format -i %<CR><Esc><Esc><Esc>g;g;

function ToggleHeaderUnit()
  let name = expand("%:r")
  let extension = expand("%:e")
  if (extension == "vs")
    let new_file = name . ".fs"
    if filereadable(new_file)
      :execute ":e " . new_file
    end
  elseif (extension == "fs")
    let new_file = name . ".vs"
    if filereadable(new_file)
      :execute ":e " . new_file
    end
  elseif (extension == "hpp" || extension == "h")
    let new_file = name . ".cpp"
    if filereadable(new_file)
      :execute ":e " . new_file
    else
      let new_file = name . ".c"
      if filereadable(new_file)
        :execute ":e " . new_file
      endif
    endif
  else
    let new_file = name . ".h"
    if filereadable(new_file)
      :execute ":e " . new_file
    else
      let new_file = name . ".hpp"
      if filereadable(new_file)
        :execute ":e " . new_file
      endif
    endif
  endif
endfunction

map o :call ToggleHeaderUnit()<CR>

map <F2> :cp<CR>
map <F3> :cc<CR>
map <F4> :cn<CR>


map [28~ :ExecuterSelectExecutable<CR>:ExecuterSelectWorkingDirectory<CR>
map [1;2R :ExecuterSelectExecutable<CR>:ExecuterSelectWorkingDirectory<CR>
map <F5> :ExecuterRun<CR>

map [31~ :MMInteractiveSelect<CR>
map [15;2~ :MMInteractiveSelect<CR>
map <F7> :MMMake<CR>

map <F9> :MinGDBToggleBP<CR>

function OpenExternal()
  :execute ":silent !qtcreator -client %:p:" . line('.')
  :redraw!
endfunction

map <F10> :call OpenExternal()<CR>

" Delete without yank
nnoremap DD "_dd
vnoremap DD "_dd
xnoremap p pgvy

" Settings
set showmode                    " Display the current mode
set cursorline
set lazyredraw
highlight clear SignColumn      " SignColumn should match background
highlight clear LineNr          " Current line number row will have same background color in relative mode

set backspace=indent,eol,start  " Backspace for dummies
set linespace=0                 " No extra spaces between rows
set number                      " Line numbers on
set ruler
set showmatch                   " Show matching brackets/parenthesis
set incsearch                   " Find as you type search
set hlsearch                    " Highlight search terms
set winminheight=0              " Windows can be 0 line high
set wildmenu                    " Show list instead of just completing
set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.
set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too
set scrolljump=8                " Lines to scroll when cursor leaves screen
set scrolloff=5                 " Minimum lines to keep above and below cursor
set nofen
set background=dark
set t_Co=256                    " Fix color with tmux
set mouse=a
set mousehide
set title
set list
set listchars=tab:›\ ,trail:•,extends:#,nbsp:. " Highlight problematic whitespace
set noswapfile

set nowrap                      " Do not wrap long lines
set autoindent                  " Indent at the same level of the previous line
set shiftwidth=4                " Use indents of 4 spaces
set expandtab                   " Tabs are spaces, not tabs
set tabstop=4                   " An indentation every four columns
set softtabstop=4               " Let backspace delete indent
set nojoinspaces                " Prevents inserting two spaces after punctuation on a join (J)
set splitright                  " Puts new vsplit windows to the right of the current
set splitbelow                  " Puts new split windows to the bottom of the current

set hidden                      " Allow unsaved modified buffers
set autowrite                   " Required by auto completion

set timeoutlen=10

syntax on

let g:solarized_termcolors=256
let g:solarized_termtrans=1
let g:solarized_contrast="normal"
let g:solarized_visibility="normal"
color solarized             " Load a colorscheme

highlight LineNr ctermfg=grey ctermbg=none

let g:airline#extensions#tabline#enabled = 1

let g:ycm_confirm_extra_conf=0
let g:ycm_extra_conf_globlist=['~/.vim/*']
let g:ycm_show_diagnostics_ui = 0

let g:AutoPairsMultilineClose=0

let g:ale_linters = { 'cpp': ['clangtidy', 'clangd'] }
" let g:ale_linters = { 'cpp': ['clangtidy'] }

" let g:ale_cpp_clangd_options = '-std=c++20'
let g:ale_cpp_clangtidy_extra_options = '--extra-arg=-std=c++20'

function SetupALE()
  if findfile('compile_commands.json', '.') != ""
    autocmd FileType cpp map  :ALEGoToDefinition<CR>
    autocmd FileType h map  :ALEGoToDefinition<CR>
    autocmd FileType hpp map  :ALEGoToDefinition<CR>
  endif
endfunction

call SetupALE()

command! SetupALE :call SetupALE()

command! CloseOthers %bd|e#|bd#

let g:rainbow_active = 1

let g:VM_maps = {}
let g:VM_maps['i'] = '<Space>'

