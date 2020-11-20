call plug#begin('~/.vim/plugged')
Plug 'airblade/vim-rooter'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'nvie/vim-flake8'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'mattn/emmet-vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'styled-components/vim-styled-components', { 'branch': 'develop' }
Plug 'morhetz/gruvbox'
Plug 'jiangmiao/auto-pairs'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'edkolev/tmuxline.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

" Highlights
let python_highlight_all=1

" Page Nav
map <Leader><Up> <C-U>
map <Leader><Down> <C-D>

" ################################ JS #########################################

" Insert semicolon at the end on <Leader>;
inoremap <leader>; <C-o>A;

" Emmet custom leader key
let g:user_emmet_leader_key=','

" ############################### Folding code ###############################

" Leader + f to fold, zo unfold
noremap <Leader>f vipzf

" ############################## FZF ###############################################

nnoremap <silent> <Space>f :GFiles<CR>
nnoremap <silent> <Space>w :Ag<CR>
nnoremap <silent> <Space>s :Snippets<CR>
nnoremap <silent> <Space>c :Commits<CR>

let g:fzf_layout = { 'window': { 'width': 0.85, 'height': 0.85 } }
let $FZF_DEFAULT_OPTS='--reverse'

nnoremap <Space>g :GBranches<CR>

" Vim Rooter
let g:rooter_patterns = ['package.json', '.git']

" ############################## AIRLINE/TMUX ######################################

" For tmuxline + vim-airline integration
let g:airline#extensions#tmuxline#enabled = 1

" Start tmuxline even without vim running
let airline#extensions#tmuxline#snapshot_file = "~/.tmux-status.conf"

" Airline theme
let g:airline_theme='gruvbox'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled=1
let g:airline#extensions#tabline#fnamode=':t'

" Tmuxline layout
let g:tmuxline_preset = {
      \'a'    : [' #S'],
      \'b'    : "﨟 #(uptime | cut -d' ' -f2)",
      \'win'  : ['#I', '#W'],
      \'cwin' : ['#I', '#W'],
      \'y'    : '#(ps a | wc -l)  ',
      \'z'    : ["#(free -m | awk 'FNR==2 {print $3}') MiB", "#(free -m | awk 'FNR==2 {print $2}') MiB  "],}

" Tmux color stuff
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

" Tmux Italics
let &t_ZH="\e[3m"
let &t_ZR="\e[23m"

set termguicolors

" ############################## COC #####################################
" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=500

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
    inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
    inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Code Action
nmap <leader>do <Plug>(coc-codeaction)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Renaming
nmap <leader>rr <Plug>(coc-rename)

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
let g:airline#extensions#coc#enabled = 1

" Mappings using CoCList:
" Show all diagnostics.
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
" nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
" nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

" Coc python correctly resolve root project directory
autocmd FileType python let b:coc_root_patterns = ['Pipfile']

" ###################################################################################
" 
" Don't deselect after identing
vnoremap < <gv
vnoremap > >gv

" Buffer cycling
nnoremap <silent> <C-Right> :bnext<CR>
nnoremap <silent> <C-Left>  :bprevious<CR>
nnoremap <silent> <C-]>    :bdelete<CR>

" Remember last cursor position
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" Tmux rename
if exists('$TMUX')
  autocmd BufEnter,FocusGained * call system("tmux rename-window " . expand("%:t"))
  autocmd VimLeave * call system("tmux rename-window zsh")
endif

" Gruvbox
let g:gruvbox_italic='1'

" Fix syntax highlighting for large files
autocmd BufEnter * syntax sync fromstart

" Settings
set nocompatible
set number
set encoding=utf-8
set tabstop=2
set softtabstop=2
set shiftwidth=2
set textwidth=80
set expandtab
set autoindent
set fileformat=unix
set mouse=a
set nomodeline
set background=dark
set clipboard+=unnamedplus
set autoread
set cursorline

syntax on
syntax sync fromstart
colorscheme gruvbox
