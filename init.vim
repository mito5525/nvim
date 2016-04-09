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
" 癒し設定
""""""""""""""""""""""""""""""
set laststatus=2
set statusline=%F%m%r%h%w[%{&ff}]%=%{g:NyanModoki()}(%l,%c)[%P]
let g:nyan_modoki_select_cat_face_number = 4
let g:nayn_modoki_animation_enabled= 1
""""""""""""""""""""""""""""""
" シンタックスチェック
""""""""""""""""""""""""""""""
let g:syntastic_enable_signs=1
let g:syntastic_auto_loc_list=2
let g:syntastic_mode_map = { 'mode': 'passive',
            \ 'passive_filetypes': ['ruby'] }
let g:syntastic_ruby_checkers = ['rubocop']

command Sc SyntasticCheck
""""""""""""""""""""""""""""""
" for Markdown
""""""""""""""""""""""""""""""
au BufRead,BufNewFile *.md set filetype=markdown
command Po PrevimOpen
""""""""""""""""""""""""""""""
" open_broser
""""""""""""""""""""""""""""""
let g:netrw_nogx = 1 " disable netrw's gx mapping.
nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-search)
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
