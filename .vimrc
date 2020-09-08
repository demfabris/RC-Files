call plug#begin('~/.vim/plugged')

" Plugin list
Plug 'nvie/vim-flake8'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'sheerun/vim-polyglot'
Plug 'mattn/emmet-vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'morhetz/gruvbox'
Plug 'jiangmiao/auto-pairs'
Plug 'ap/vim-css-color'
Plug 'edkolev/tmuxline.vim'
Plug 'HerringtonDarkholme/yats.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'stsewd/fzf-checkout.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'prettier/vim-prettier', { 'do': 'yarn install' }
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
call plug#end()

" ############################## PYTHON ########################################

" Run python code selection on popup bash
fu PyRun() range
    echo system('python -c ' . shellescape(join(getline(a:firstline, a:lastline), "\n")))
endf
noremap <S-L> :call PyRun()<CR>

fu JSRun() range
    echo system('node -p ' . shellescape(join(getline(a:firstline, a:lastline), "\n")))
endf
noremap <S-T> :call JSRun()<CR>

" Highlights
let python_highlight_all=1

" ################################ JS #########################################

" Insert semicolon at the end on <Leader>;
inoremap <leader>; <C-o>A;

" ################################ C ###########################################
map <leader>o :!gcc % -o builds/%< ; ./builds/%< <CR>

" Emmet custom leader key
let g:user_emmet_leader_key=','

" Folding code
" zf to fold, zo unfold
set foldmethod=manual

" Page Nav
map <Leader><Up> <C-U>
map <Leader><Down> <C-D>

" Clipboard stuff
noremap <Leader>c "+y
noremap <Leader>v "+p
set clipboard=unnamedplus

" ############################## FZF ###############################################

nnoremap <silent> <Space>f :Files<CR>
nnoremap <silent> <Space>w :Ag<CR>

let g:fzf_layout = { 'window': { 'width': 0.8, 'height': 0.8 } }

let $FZF_DEFAULT_OPTS='--reverse'
let $BAT_THEME='base16'

nnoremap <Space>g :GBranches<CR>

" ############################## AIRLINE/TMUX ######################################

" Airline stuff
" For tmuxline + vim-airline integration
let g:airline#extensions#tmuxline#enabled = 1
" Start tmuxline even without vim running
let airline#extensions#tmuxline#snapshot_file = "~/.tmux-status.conf"
" Airline theme
let g:airline_theme='gruvbox'
let g:airline_powerline_fonts = 1
" Tmuxline layout
let g:tmuxline_preset = {
      \'a'    : ['#S', '#W'],
      \'b'    : '﨟#(uptime | cut -d " " -f 4 | sed "s/\,//g") Up',
      \'c'    : ' #(whoami)',
      \'win'  : ['#I', '#W'],
      \'cwin' : ['#I', '#W'],
      \'x'    : '#(ps a | wc -l)  ',
      \'y'    : ["#(free -m | awk 'FNR==2 {print $3}') MiB", "#(free -m | awk 'FNR==2 {print $2}') MiB  "],
      \'z'    : "#H  "}

" Tmux color stuff
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
set background=dark
set termguicolors

" ############################# SNIPPETS ###########################################
" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)

" Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'

" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)

inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'


" ############################## AUTOCOMPLETION #####################################
" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=100

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

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

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
    autocmd!
    " Setup formatexpr specified filetype(s).
    autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
    " Update signature help on jump placeholder.
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current line.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}%{ObsessionStatus()} 
let g:airline#extensions#coc#enabled = 1

" Mappings using CoCList:
" Show all diagnostics.
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
" Renaming
nmap <leader>rr <Plug>(coc-rename)

" Status line integration
set statusline^=%{coc#status()}

" Coc python correctly resolve root project directory
autocmd FileType python let b:coc_root_patterns = ['*.pythonenv']


"Prettier setup
command! -nargs=0 Prettier :call CocAction('runCommand', 'prettier.formatFile')
let g:prettier#autoformat_require_pragma = 0

" ###################################################################################
" Don't deselect after identing
vnoremap < <gv
vnoremap > >gv

" Settings
set nocompatible
set number
set encoding=utf-8
set tabstop=2
set softtabstop=2
set shiftwidth=2
set textwidth=85
set expandtab
set autoindent
set fileformat=unix
set mouse=a
set nomodeline
syntax on
colorscheme gruvbox
