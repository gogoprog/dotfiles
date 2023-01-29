" Vundle
set nocompatible
filetype off

call plug#begin()

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'VundleVim/Vundle.vim'
Plug 'scrooloose/nerdtree'
Plug 'altercation/vim-colors-solarized'
Plug 'spf13/vim-colors'
Plug 'jiangmiao/auto-pairs'
let g:AutoPairs={'{':'}'}
Plug 'mg979/vim-visual-multi'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'easymotion/vim-easymotion'
Plug 'flazz/vim-colorschemes'
Plug 'w0rp/ale'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'pangloss/vim-javascript'
Plug 'OmniSharp/omnisharp-vim'
Plug 'tpope/vim-dispatch'
Plug 'leafgarland/typescript-vim'
Plug 'mileszs/ack.vim'
Plug 'mechatroner/minimal_gdb'
Plug 'justinmk/vim-sneak'
Plug 'tpope/vim-sleuth'
Plug 'chaoren/vim-wordmotion'
Plug 'gogoprog/vim-executer'
Plug 'gogoprog/vim-makefile-manager'
Plug 'tikhomirov/vim-glsl'
Plug 'alemigliardi/vim-combo'
Plug 'luochen1990/rainbow'
Plug 'jeroenbourgois/vim-actionscript'
" Plug 'codota/tabnine-nvim', { 'do': './dl_binaries.sh' }
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'
Plug 'hrsh7th/nvim-cmp'
Plug 'tzachar/cmp-tabnine', { 'do': './install.sh' }

call plug#end()
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

" set secure exrc " Application-specific .vimrc
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

nnoremap <c-s> :w!<CR>
inoremap <c-s> <Esc>:w!<CR>l
vnoremap <c-s> <Esc>:w!<CR>

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

map <S-F3> :ExecuterSelectExecutable<CR>
map <F5> :ExecuterRun<CR>

map <F17> :MMInteractiveSelect<CR>
map <S-F5> :MMInteractiveSelect<CR>
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


" lua << EOF
" require('tabnine').setup({
"   disable_auto_comment=true,
"   accept_keymap="<Tab>",
"   debounce_ms = 300,
"   suggestion_color = {gui = "#808080", cterm = 244}
" })
" EOF

lua << EOF
local cmp = require'cmp'

cmp.setup({
   snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      end,
    },
   mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        ["<Tab>"] = cmp.mapping(function(fallback)
              if cmp.visible() then
                cmp.select_next_item()
              else
                fallback()
              end
            end, { "i", "s" }),
            }),
  sources = {
  { name = 'cmp_tabnine' },
  },
})

local tabnine = require('cmp_tabnine.config')

tabnine:setup({
  max_lines = 1000,
  max_num_results = 20,
  sort = true,
  run_on_every_keystroke = true,
  snippet_placeholder = '..',
  ignored_file_types = {
  },
  show_prediction_strength = false
})
EOF

if findfile('.vimrc', '.') != ""
  exec "source .vimrc"
endif
