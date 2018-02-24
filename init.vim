"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" dein.vim 基本設定 http://qiita.com/delphinus35/items/00ff2c0ba972c6e41542
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" プラグインが実際にインストールされるディレクトリ
let s:dein_dir = expand('~/.cache/dein')
" dein.vim 本体
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" dein.vim がなければ github から落としてくる
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

" 設定開始
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  " プラグインリストを収めた TOML ファイル
  let s:toml      = '~/.config/nvim/dein.toml'

  " TOML を読み込み、キャッシュしておく
  call dein#load_toml(s:toml,      {'lazy': 0})

  " 設定終了
  call dein#end()
  call dein#save_state()
endif

" もし、未インストールものものがあったらインストール
if dein#check_install()
  call dein#install()
endif
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""
" 全角スペースの表示
""""""""""""""""""""""""""""""
function! ZenkakuSpace()
  highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=darkgray
  endfunction

  if has('syntax')
    augroup ZenkakuSpace
    autocmd!
    autocmd ColorScheme * call ZenkakuSpace()
    autocmd VimEnter,WinEnter,BufRead * let w:m1=matchadd('ZenkakuSpace', '　')
    augroup END
    call ZenkakuSpace()
endif
""""""""""""""""""""""""""""""
" 最後のカーソル位置を復元する
""""""""""""""""""""""""""""""
if has("autocmd")
  autocmd BufReadPost *
  \ if line("'\"") > 0 && line ("'\"") <= line("$") |
  \   exe "normal! g'\"" |
  \ endif
endif
""""""""""""""""""""""""""""""
" シンタックスチェック
""""""""""""""""""""""""""""""
let g:ale_sign_column_always = 1
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 0
let g:ale_sign_error = '🔥'
let g:ale_sign_warning = '🌧'
highlight clear ALEErrorSign
highlight clear ALEWarningSign
""""""""""""""""""""""""""""""
" for Markdown
""""""""""""""""""""""""""""""
au BufRead,BufNewFile *.md set filetype=markdown
command Po PrevimOpen
""""""""""""""""""""""""""""""
" open_broser
""""""""""""""""""""""""""""""
nmap Bo <Plug>(openbrowser-smart-search)
vmap Bo <Plug>(openbrowser-smart-search)
""""""""""""""""""""""""""""""
" vimgrep & quickfix
""""""""""""""""""""""""""""""
autocmd QuickFixCmdPost *grep* cwindow
nnoremap [q :cprevious<CR>   " 前へ
nnoremap ]q :cnext<CR>       " 次へ
nnoremap [Q :<C-u>cfirst<CR> " 最初へ
nnoremap ]Q :<C-u>clast<CR>  " 最後へ

" Auto-close quickfix window
augroup QfAutoCommands
  autocmd!
  autocmd WinEnter * if (winnr('$') == 1) &&
    \ (getbufvar(winbufnr(0), '&buftype')) == 'quickfix'
    \ | quit | endif
augroup END
""""""""""""""""""""""""""""""
" Gitgutter
nnoremap <silent> ,gg :<C-u>GitGutterToggle<CR>
nnoremap <silent> ,gh :<C-u>GitGutterLineHighlightsToggle<CR>
""""""""""""""""""""""""""""""
" ビュー自動保存/復元 (折りたたみ)
autocmd BufWinLeave ?* silent! mkview
autocmd BufWinEnter ?* silent! loadview
""""""""""""""""""""""""""""""
" lightline
let g:lightline = { 'colorscheme': 'wombat' }
""""""""""""""""""""""""""""""
" quickhl
nmap <Space>h <Plug>(quickhl-manual-this)
xmap <Space>h <Plug>(quickhl-manual-this)
nmap <Space>H <Plug>(quickhl-manual-reset)
xmap <Space>H <Plug>(quickhl-manual-reset)
""""""""""""""""""""""""""""""

set encoding=utf-8
set t_Co=256
colorscheme desert
syntax on

" 検索結果をハイライトさせない
set nohlsearch

" 字下げ文字=2
set tabstop=2
set shiftwidth=2

" タブ->半角スペース
set expandtab

" タブ可視化
set list

" カーソル位置表示
set ruler

" ウィンドウ枠にタイトル表示
set title

" ファイル名補完設定
set wildmenu
set wildmode=longest,full

" 対応する括弧表示
set showmatch
set matchpairs& matchpairs+=<:>
set matchtime=1

" 長文表示
set display=lastline

" キーバインド
" yy -> Y
" ESC -> jj
nnoremap Y y$
inoremap jj <Esc>

" インサートモード時にバックスペースを使う
set backspace=indent,eol,start

" alias 最終ヤンクをペースト d x での上書き回避
noremap PP "0p

" alias クッリプボードにヤンク
vnoremap cy "*y

" ビジュアルモード 連続インデント対応
vnoremap > >gv
vnoremap < <gv

" 表示上の行移動をデフォルトにする
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k

autocmd InsertLeave * set nopaste
