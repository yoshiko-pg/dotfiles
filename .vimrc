" viとの互換をオフ
set nocompatible

" バックアップ作成
set backup
set backupdir=$HOME/\.vim_backup
set writebackup  " 上書き前にバックアップ作成
set undodir=$HOME/\.vim_backup

" バッファ
set hidden " バッファを保存しなくても他のバッファを表示できるようにする
set confirm " バッファが変更されているとき、エラーにせず保存するか確認を求める

" スワップファイルを作成する
set noswapfile
"set swapfile
"set directory=$HOME/\.vim_backup

" タイムアウト
set notimeout ttimeout ttimeoutlen=200 " キーコードはすぐtimeout、マッピングはtimeoutしない

" インデント設定
set cindent
set autoindent
set shiftwidth=2 " 自動インデントの空白の数
set expandtab
set smarttab  " 行頭にTabでshiftwidth分インデントする
set tabstop=2  " 画面上のTab幅
set shiftround " インデントをshiftwidthの幅に丸める

" エンコーディング関連
set encoding=utf-8     " vim内部で通常使用する文字エンコーディングを設定
set charconvert=utf-8    " 文字エンコーディングに使われるexpressionを定める
set fileencoding=utf-8    " バッファのファイルエンコーディングを指定
set fileencodings=utf-8,euc-jp,sjis " 既存ファイルを開く際の文字コード自動判別

"日本語設定
au BufNewFile,BufRead * set iminsert=0 "日本語入力をリセット
set imsearch=0

" 特殊文字表示設定
set list
set listchars=tab:»-,trail:-,extends:»,precedes:«,nbsp:%,eol:↲

" 操作
set backspace=indent,eol,start     " Backspaceの動作
set whichwrap=b,s,h,l,<,>,[,] " カーソルを行頭、行末で止まらないようにする
set wildmenu      " コマンドの補完候補を表示
"set helplang=ja,en    " ヘルプ検索で日本語を優先

" 検索設定
" set hlsearch " 検索結果強調-:nohで解除
" set incsearch " インクリメンタルサーチを有効
set ignorecase " 検索時に大文字・小文字を区別しない
set smartcase " 検索語に大文字小文字が混在している場合は区別する

" 補完設定
set infercase " 補完の際に大文字小文字を区別しない

" 見た目関連の設定
set t_Co=256 " 256色表示に対応
set ambiwidth=double " マルチバイト文字や記号でずれないようにする
set cmdheight=2   " コマンドラインの行数
set laststatus=2  " ステータスラインを表示する時
set cursorline " 現在行の表示
set number    " 行番号表示
set showtabline=2  " タブバーを常に表示
set ruler    " カーソルの現在地表示
set showmatch   " 括弧強調
set wrap    " はみ出しの折り返し
set textwidth=0 " 入力されているテキストの最大幅を無視
set formatoptions=q " 勝手に改行させない
syntax on   " 強調表示有効
colorscheme lucius
highlight Folded cterm=bold,underline ctermfg=4
set guifont=Ricty_for_Powerline:h13
set showcmd "タイプ途中のコマンドを画面最下行に表示
set scrolloff=5 " スクロールする時に下が見えるようにする

" カレントウィンドウにのみ罫線を引く
augroup cch
autocmd! cch
autocmd WinLeave * set nocursorline
autocmd WinEnter,BufRead * set cursorline
augroup END

" 音
set visualbell t_vb=

" クリップボード
if has('unnamedplus')
	set clipboard& clipboard+=unnamedplus
else
	set clipboard& clipboard+=unnamed,autoselect
endif

"コメントアウト
autocmd FileType * setlocal formatoptions-=ro

" 差分
set diffopt=filler,iwhite

" -で単語分割しない
" set isk+=-

"-------------------------------------------------------------------------------"
" Mapping
"-------------------------------------------------------------------------------"
" コマンド       ノーマルモード 挿入モード コマンドラインモード ビジュアルモード
" map /noremap           @            -              -                  @
" nmap / nnoremap        @            -              -                  -
" imap / inoremap        -            @              -                  -
" cmap / cnoremap        -            -              @                  -
" vmap / vnoremap        -            -              -                  @
" map! / noremap!        -            @              @                  -
"-------------------------------------------------------------------------------"

" w!! でスーパーユーザーとして保存（sudoが使える環境限定）
cmap w!! w !sudo tee > /dev/null %

" /{pattern}の入力中は「/」をタイプすると自動で「\/」が、
" ?{pattern}の入力中は「?」をタイプすると自動で「\?」が 入力されるようになる
" cnoremap <expr> / getcmdtype() == '/' ? '\/' : '/'
" cnoremap <expr> ? getcmdtype() == '?' ? '\?' : '?'

" 検索後にジャンプした際に検索単語を画面中央に持ってくる
nnoremap n nzz
nnoremap N Nzz
nnoremap * *zz
nnoremap # #zz
nnoremap g* g*zz
nnoremap g# g#zz

" j, k による移動を折り返されたテキストでも自然に振る舞うように変更
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

" C-dでdelete
inoremap <C-d> <Delete>

" vを二回で行末まで選択
vnoremap v $h

" .vimrcを開く
nnoremap <Space>.  :edit $MYVIMRC<CR>
" source ~/.vimrc を実行する。
nnoremap <Space>,  :source $MYVIMRC<CR>

" help
" nnoremap <C-h> :<C-u>h<Space>

" Escマッピング
inoremap <C-j> <Esc>
vnoremap <C-j> <Esc>

" <Tab> -> [Tag]
nnoremap [Tag] <Nop>
nmap     <Tab> [Tag]

" tabn 新しいタブを作る
map <silent> [Tag]n :tabnew<CR>
" tabc タブを閉じる
map <silent> [Tag]c :tabclose<CR>
" tabl 次のタブ
map <silent> [Tag]l :tabnext<CR>
map <silent> [Tag]<Right> :tabnext<CR>
" tabh 前のタブ
map <silent> [Tag]h :tabprevious<CR>
map <silent> [Tag]<Left> :tabprevious<CR>

"カレントウィンドウを新規タブで開き直す
if v:version >= 700
    nnoremap [Tag]t :call OpenNewTab()<CR>
    function! OpenNewTab()
        let f = expand("%:p")
        execute ":q"
        execute ":tabnew ".f
    endfunction
endif

" 進む、戻る
nnoremap [Tag]i <C-i>
nnoremap [Tag]o <C-o>

" URL上でC-lでブラウザオープン
nmap <C-l> <Plug>(openbrowser-open)

" Reset Highlight
nnoremap <Esc><Esc> :noh<CR>

" 開いたファイルのディレクトリに移動
au BufEnter * execute 'lcd ' fnameescape(expand('%:p:h'))

" <Space>:で文末に;
nnoremap <Space>: A;<Esc>

" C-gでフルパスを表示
nnoremap <C-g> 1<C-g>

" カーソルキー
nnoremap [A <Up>
nnoremap [B <Down>
nnoremap [C <Right>
nnoremap [D <Left>
inoremap [A <Up>
inoremap [B <Down>
inoremap [C <Right>
inoremap [D <Left>

" ペースト
inoremap <C-v> <Esc>p<S-a>

" ,の後ろにスペース
inoremap , ,<Space>

" :cnext
nnoremap cn :cn<CR>

" 新しいバッファ
nnoremap [Tag]v :vsplit + enew<CR>

" バッファ同士での差分
nnoremap [Tag]d :windo diffthis<CR>


"-------------------------------------------------------------------------------"
" language
"-------------------------------------------------------------------------------"
" markdown
autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} set filetype=markdown
imap <Nul> <Esc><S-a><Space><Space><Esc>o
nmap <Nul> <S-a><Space><Space><Esc>
imap <C-Space> <S-Space><S-Space><CR>
nmap <C-Space> <S-a><Space><Space><Esc>


"-------------------------------------------------------------------------------"
" template
"-------------------------------------------------------------------------------"
autocmd BufNewFile *.html 0r ~/.vim/templates/template.html
autocmd BufNewFile *.php 0r ~/.vim/templates/template.php
autocmd BufNewFile gulpfile.js 0r ~/.vim/templates/gulpfile.js


"-------------------------------------------------------------------------------"
" Plugin
"-------------------------------------------------------------------------------"
filetype off
filetype plugin indent off

if has('vim_starting')
 set runtimepath+=~/.vim/bundle/neobundle.vim/
endif
call neobundle#rc(expand('~/.vim/bundle/'))
NeoBundle 'Shougo/neobundle.vim'

" カラースキーム、見た目
NeoBundle 'jonathanfilip/vim-lucius'
NeoBundle 'bling/vim-airline'

" ファイル移動
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neomru.vim'
NeoBundle 'Shougo/vimfiler'
NeoBundle 'Shougo/vimproc.vim', {
	\ 'build' : {
		\     'windows' : 'make -f make_mingw32.mak',
		\     'cygwin' : 'make -f make_cygwin.mak',
		\     'mac' : 'make -f make_mac.mak',
		\     'unix' : 'make -f make_unix.mak',
	\    },
\ }
NeoBundle 'Shougo/vimshell.vim'

" 補完、入力
NeoBundleLazy 'kana/vim-smartchr', '', 'loadInsert'
NeoBundleLazy 'kana/vim-smartinput', '', 'loadInsert'
NeoBundle 'Shougo/neocomplete.vim'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'tpope/vim-surround'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'kana/vim-textobj-user'
NeoBundle 'kana/vim-textobj-indent'
NeoBundle 'cohama/vim-smartinput-endwise'
NeoBundle 'vim-scripts/closetag.vim'
NeoBundle 'terryma/vim-multiple-cursors'
NeoBundle 'tyru/caw.vim'
NeoBundle 'rhysd/clever-f.vim'
NeoBundle 'thinca/vim-qfreplace'

" その他拡張
NeoBundle 'kana/vim-submode'
NeoBundle 'vim-scripts/vim-auto-save'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'tyru/open-browser.vim'
NeoBundle 'AtsushiM/search-parent.vim'
NeoBundle 'mattn/benchvimrc-vim'
NeoBundle 'haya14busa/incsearch.vim'
NeoBundle 'vim-scripts/renamer.vim'

" git
NeoBundle 'tpope/vim-fugitive'

"db
NeoBundle 'vim-scripts/dbext.vim'

" Ruby / Rails系
NeoBundle 'tpope/vim-rails'
NeoBundle 'basyura/unite-rails'

" Scheme
NeoBundle 'aharisu/vim_goshrepl'

" html系
NeoBundle 'mattn/emmet-vim'
NeoBundle 'slim-template/vim-slim'
NeoBundle 'digitaltoad/vim-jade'

" css系
NeoBundle 'AtsushiM/sass-compile.vim'
NeoBundle 'hail2u/vim-css3-syntax'
NeoBundle 'lilydjwg/colorizer'
NeoBundle 'wavded/vim-stylus'
NeoBundle 'groenewege/vim-less'
NeoBundle 'csscomb/vim-csscomb'

" javascript系
NeoBundle 'jelera/vim-javascript-syntax'
NeoBundle 'jiangmiao/simple-javascript-indenter'
NeoBundle 'nono/jquery.vim'
NeoBundle 'marijnh/tern_for_vim', {
  \ 'build': {
  \   'others': 'npm install'
  \}}
NeoBundle 'kchmck/vim-coffee-script'

" markdown
NeoBundle 'kannokanno/previm'

" その他言語
NeoBundle 'moro/vim-review'

" 外部サービス連携
NeoBundle 'moznion/hateblo.vim'

" Twitter
NeoBundle 'basyura/TweetVim'
NeoBundle 'mattn/webapi-vim'
NeoBundle 'basyura/twibill.vim'
NeoBundle 'h1mesuke/unite-outline'
NeoBundle 'basyura/bitly.vim'
NeoBundle 'Shougo/unite.vim'

filetype plugin indent on


" neocompleteを起動時に有効化する
"let g:neocomplete#enable_at_startup = 1

" 大文字を区切りとしたワイルドカードのように振る舞う機能
let g:neocomplete#enable_camel_case_completion = 1

" _区切りの補完を有効化
let g:neocomplete#enable_underbar_completion = 1

" 大文字が入力されるまで大文字小文字の区別を無視する
let g:neocomplete#smart_case = 1

"手動補完時に補完を行う入力数を制御
let g:neocomplete#manual_completion_start_length = 0
let g:neocomplete#caching_percent_in_statusline = 1
let g:neocomplete#enable_skip_completion = 1
let g:neocomplete#skip_input_time = '0.5'

inoremap <expr><CR> neocomplete#smart_close_popup()."\<CR>"
inoremap <expr><TAB> pumvisible()?"\<C-n>":"\<TAB>"


" neosnippet
" Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

let g:neosnippet#snippets_directory='~/.vim/bundle/neosnippet-snippets/neosnippets/'

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: "\<TAB>"

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif


" vimproc
if has('mac')
  let g:vimproc_dll_path = $VIMRUNTIME . '/autoload/vimproc_mac.so'
elseif has('win64')
  let g:vimproc_dll_path = $VIMRUNTIME . '/autoload/vimproc_win64.dll'
endif

" emmet
let g:user_emmet_expandabbr_key = '<c-e>'
let g:user_emmet_settings = {'lang': 'ja'}

" quickrun
nmap <Space>r <Leader>r
let g:quickrun_config = {'*': {'hook/time/enable': '1'},}
let g:quickrun_config['markdown'] = {
      \   'outputter': 'browser'
      \ }

" airline
"let g:airline_section_a = airline#section#create(['mode'])
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#tab_nr_type = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:Powerline_symbols = 'fancy'
let g:airline_left_sep = '⮀'
let g:airline_right_sep = '⮂'
let g:airline_linecolumn_prefix = '⭡'
let g:airline_branch_prefix = '⭠'
let g:airline#extensions#tabline#left_sep = '⮀'
let g:airline#extensions#tabline#left_alt_sep = '⮂'
let g:airline#extensions#readonly#symbol = '⭤ '

" GoshREPL
let g:neocomplete#keyword_patterns = {}
let g:neocomplete#keyword_patterns['gosh-repl'] = "[[:alpha:]+*/@$_=.!?-][[:alnum:]+*/@$_:=.!?-]*"
vmap <CR> <Plug>(gosh_repl_send_block)

" vim-submode
call submode#enter_with('winsize', 'n', '', '<C-w>>', '<C-w>>')
call submode#enter_with('winsize', 'n', '', '<C-w><', '<C-w><')
call submode#enter_with('winsize', 'n', '', '<C-w>+', '<C-w>-')
call submode#enter_with('winsize', 'n', '', '<C-w>-', '<C-w>+')
call submode#map('winsize', 'n', '', '>', '<C-w>>')
call submode#map('winsize', 'n', '', '<', '<C-w><')
call submode#map('winsize', 'n', '', '+', '<C-w>-')
call submode#map('winsize', 'n', '', '-', '<C-w>+')
"call submode#enter_with('changetab', 'n', '', '<Tab>h', 'gT')
"call submode#enter_with('changetab', 'n', '', '<Tab>l', 'gt')
"call submode#map('changetab', 'n', '', 'h', 'gT')
"call submode#map('changetab', 'n', '', 'l', 'gt')

" unite.vim
let g:unite_enable_start_insert = 1
nnoremap [unite] <Nop>
nmap <Space>u [unite]
nnoremap [unite]u  :<C-u>Unite -no-split<Space>
nnoremap <silent> [unite]f :<C-u>Unite<Space>file<CR>
nnoremap <silent> [unite]b :<C-u>Unite<Space>buffer<CR>
"nnoremap <silent> [unite]b :<C-u>Unite<Space>bookmark<CR>
nnoremap <silent> [unite]m :<C-u>Unite<Space>file_mru<CR>
nnoremap <silent> [unite]r :<C-u>UniteWithBufferDir file<CR>
nnoremap <silent> [unite]a :<C-u>UniteBookmarkAdd<CR>

nnoremap <silent> [unite]rm :<C-u>Unite<Space>rails/model<CR>
nnoremap <silent> [unite]rc :<C-u>Unite<Space>rails/controller<CR>
nnoremap <silent> [unite]rv :<C-u>Unite<Space>rails/view<CR>
nnoremap <silent> [unite]rh :<C-u>Unite<Space>rails/helper<CR>
nnoremap <silent> [unite]rl :<C-u>Unite<Space>rails/lib<CR>
nnoremap <silent> [unite]rd :<C-u>Unite<Space>rails/db<CR>
nnoremap <silent> [unite]rf :<C-u>Unite<Space>rails/config<CR>
nnoremap <silent> [unite]rs :<C-u>Unite<Space>rails/spec<CR>
nnoremap <silent> [unite]rb :<C-u>Unite<Space>rails/bundle<CR>
nnoremap <silent> [unite]raj :<C-u>Unite<Space>rails/javascript<CR>
nnoremap <silent> [unite]ras :<C-u>Unite<Space>rails/stylesheet<CR>

" VimFiler
let g:vimfiler_as_default_explorer = 1
let g:vimfiler_safe_mode_by_default = 0
nnoremap <Space>o :VimFilerBufferDir<CR>
nnoremap <Space>f :VimFiler -split -simple -winwidth=35 -no-quit<CR>

" Previm
let g:previm_open_cmd = ''
nnoremap [previm] <Nop>
nmap <Space>p [previm]
nnoremap <silent> [previm]o :<C-u>PrevimOpen<CR>
nnoremap <silent> [previm]r :call previm#refresh()<CR>

"sass
let g:sass_compile_cdloop = 5 " 編集したファイルから遡るフォルダの最大数
let g:sass_compile_auto = 0 " ファイル保存時に自動コンパイル（1で自動実行）
let g:sass_compile_file = ['scss', 'sass'] " 自動コンパイルを実行する拡張子
let g:sass_compile_cssdir = ['./', 'css', 'stylesheet'] " cssファイルが入っているディレクトリ名（前のディレクトリほど優先）
" コンパイル実行前に実行したいコマンドを設定
let g:sass_compile_beforecmd = "growlnotify -t 'sass-compile.vim' -m 'start sass compile.'"
" コンパイル実行後に実行したいコマンドを設定
let g:sass_compile_aftercmd = "growlnotify -t 'sass-compile.vim' -m ${sasscompileresult}"

" smartinput
" 括弧内のスペース
call smartinput#map_to_trigger('i', '<Space>', '<Space>', '<Space>')
call smartinput#define_rule({
            \   'at'    : '(\%#)',
            \   'char'  : '<Space>',
            \   'input' : '<Space><Space><Left>',
            \   })

call smartinput#map_to_trigger('i', '<BS>', '<BS>', '<BS>')
call smartinput#define_rule({
            \   'at'    : '( \%# )',
            \   'char'  : '<BS>',
            \   'input' : '<Del><BS>',
            \   })

call smartinput#define_rule({
            \   'at'    : '{\%#}',
            \   'char'  : '<Space>',
            \   'input' : '<Space><Space><Left>',
            \   })

call smartinput#define_rule({
            \   'at'    : '{ \%# }',
            \   'char'  : '<BS>',
            \   'input' : '<Del><BS>',
            \   })

call smartinput#define_rule({
            \   'at'    : '\[\%#\]',
            \   'char'  : '<Space>',
            \   'input' : '<Space><Space><Left>',
            \   })

call smartinput#define_rule({
            \   'at'    : '\[ \%# \]',
            \   'char'  : '<BS>',
            \   'input' : '<Del><BS>',
            \   })

call smartinput#map_to_trigger('i', '<CR>', '<CR>', '<CR>')
" 行末のスペースを削除する
call smartinput#define_rule({
            \   'at'    : ' \%#',
            \   'char'  : '<CR>',
            \   'input' : "<Esc>:call setline('.', substitute(getline('.'), '\\s\\+$', '', '')) <CR><S-a><CR>",
            \   })

" Ruby 文字列内変数埋め込み
call smartinput#map_to_trigger('i', '#', '#', '#')
call smartinput#define_rule({
            \   'at'       : '\%#',
            \   'char'     : '#',
            \   'input'    : '#{}<Left>',
            \   'filetype' : ['ruby', 'eruby', 'spec', 'slim'],
            \   'syntax'   : ['Constant', 'Special'],
            \   })

" Ruby ブロック引数 ||
call smartinput#map_to_trigger('i', '<Bar>', '<Bar>', '<Bar>')
call smartinput#define_rule({
            \   'at' : '\%({\|\<do\>\)\s*\%#',
            \   'char' : '|',
            \   'input' : '||<Left>',
            \   'filetype' : ['ruby', 'eruby', 'spec', 'slim'],
            \    })

" ブロックコメント
call smartinput#map_to_trigger('i', '*', '*', '*')
call smartinput#define_rule({
            \   'at'       : '\/\%#',
            \   'char'     : '*',
            \   'input'    : '**/<Left><Left>',
            \   })
call smartinput#define_rule({
            \   'at'       : '/\*\%#\*/',
            \   'char'     : '<Space>',
            \   'input'    : '<Space><Space><Left>',
            \   })
call smartinput#define_rule({
            \   'at'       : '/* \%# */',
            \   'char'     : '<BS>',
            \   'input'    : '<Del><BS>',
            \   })


" \s= を入力したときに空白を挟む
"call smartinput#map_to_trigger('i', '=', '=', '=')
"call smartinput#define_rule(
"    \ { 'at'    : '\s\%#'
"    \ , 'char'  : '='
"    \ , 'input' : '= '
"    \ })
"
"" でも連続した == となる場合には空白は挟まない
"call smartinput#define_rule(
"    \ { 'at'    : '=\s\%#'
"    \ , 'char'  : '='
"    \ , 'input' : '<BS>= '
"    \ })
"
"" でも連続した =~ となる場合には空白は挟まない
"call smartinput#map_to_trigger('i', '~', '~', '~')
"call smartinput#define_rule(
"    \ { 'at'    : '=\s\%#'
"    \ , 'char'  : '~'
"    \ , 'input' : '<BS>~ '
"    \ })
"
"" でも連続した => となる場合には空白は挟まない
"call smartinput#map_to_trigger('i', '>', '>', '>')
"call smartinput#define_rule(
"    \ { 'at'    : '=\s\%#'
"    \ , 'char'  : '>'
"    \ , 'input' : '<BS>> '
"    \ })

" erb <%  %>
call smartinput#map_to_trigger('i', '%', '%', '%')
call smartinput#define_rule({
            \   'at'    : '<\%#',
            \   'char'  : '%',
            \   'input' : '%%><Left><Left>',
            \   'filetype' : ['eruby'],
            \   })
call smartinput#define_rule({
            \   'at'    : '<%\%#%>',
            \   'char'  : '<Space>',
            \   'input' : '<Space><Space><Left>',
            \   'filetype' : ['eruby'],
            \   })
call smartinput#define_rule({
            \   'at'    : '<%\%#%>',
            \   'char'  : '=',
            \   'input' : '=<Space><Space><Left>',
            \   'filetype' : ['eruby'],
            \   })

" twig {%  %}
call smartinput#map_to_trigger('i', '%', '%', '%')
call smartinput#define_rule({
            \   'at'    : '{\%#',
            \   'char'  : '%',
            \   'input' : '%  %<Left><Left>',
            \   'filetype' : ['twig'],
            \   })

" {}の展開
call smartinput#map_to_trigger('i', '<CR>', '<CR>', '<CR>')
call smartinput#define_rule({
            \   'at'    : '{\%#}',
            \   'char'  : '<CR>',
            \   'input' : '<CR><Esc><S-o>',
            \   })
" <tag></tag>の展開
call smartinput#define_rule({
            \   'at'    : '>\%#<\/',
            \   'char'  : '<CR>',
            \   'input' : '<CR><Esc><S-o>',
            \   })

" end自動挿入
call smartinput_endwise#define_default_rules()

" coffee |) で改行したら->を自動で入れる
call smartinput#map_to_trigger('i', '<CR>', '<CR>', '<CR>')
call smartinput#define_rule({
            \   'at' : '\%#)',
            \   'char' : '<CR>',
            \   'input' : '<Esc><S-a><Space>-><CR>',
            \   'filetype' : ['coffee'],
            \    })

" Re:VIEW
call smartinput#define_rule({
            \   'at'    : '\/\/emlist\%#',
            \   'char'  : '<CR>',
            \   'input' : '{<CR><CR>//}<Esc>ki',
            \   'filetype' : ['review'],
            \   })
call smartinput#define_rule({
            \   'at'    : '\/\/list\%#',
            \   'char'  : '<CR>',
            \   'input' : '[][]{<CR><CR>//}<Esc>ki',
            \   'filetype' : ['review'],
            \   })
call smartinput#define_rule({
            \   'at'    : '\/\/image\%#',
            \   'char'  : '<CR>',
            \   'input' : '[][]{<CR><CR>//}<Esc>ki',
            \   'filetype' : ['review'],
            \   })
call smartinput#define_rule({
            \   'at'    : 'col\%#',
            \   'char'  : '<CR>',
            \   'input' : '<BS><BS><BS>===[column] <CR><CR><CR>===[/column]<Esc>kkk<S-a>',
            \   'filetype' : ['review'],
            \   })

" javascript
call smartinput#map_to_trigger('i', '<CR>', '<CR>', '<CR>')
call smartinput#define_rule({
            \   'at' : 'fn\%#',
            \   'char' : '<CR>',
            \   'input' : '<BS>unction<Space>()<Space>{<CR>}<Esc>O'
            \    })
call smartinput#define_rule({
            \   'at' : '=\%#',
            \   'char' : '<CR>',
            \   'input' : '<BS>()<Space>=><Space>'
            \    })

" Simple-Javascript-Indenter
let g:SimpleJsIndenter_BriefMode = 2
let g:SimpleJsIndenter_CaseIndentLevel = -1

" Syntax file for jQuery
au BufRead,BufNewFile jquery.*.js set ft=javascript syntax=jquery

" Syntastic
nnoremap <Space>c :<C-u>SyntasticCheck<CR>
let g:syntastic_check_on_open=0 "ファイルを開いたときはチェックしない
let g:syntastic_check_on_save=1 "保存時にはチェック
let g:syntastic_auto_loc_list=1 "エラーがあったら自動でロケーションリストを開く
let g:syntastic_loc_list_height=6 "エラー表示ウィンドウの高さ
set statusline+=%#warningmsg# "エラーメッセージの書式
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_javascript_checkers = ['jshint']
let g:syntastic_mode_map = {
      \ 'mode': 'active',
      \ 'active_filetypes': ['ruby', 'javascript'],
      \ 'passive_filetypes': ['html']
      \ }
"エラー表示マークを変更
let g:syntastic_enable_signs=1
let g:syntastic_error_symbol='✖︎'
let g:syntastic_error_symbol='✘'
let g:syntastic_warning_symbol='⚠'

" fugitive.vim
nnoremap [fugitive] <Nop>
nmap <Space>g [fugitive]
nnoremap [fugitive]s  :<C-u>Gstatus<CR>
nnoremap [fugitive]w  :<C-u>Gwrite<CR>
nnoremap [fugitive]c  :<C-u>Gcommit<CR>
nnoremap [fugitive]e  :<C-u>Gedit<CR>
nnoremap [fugitive]dd  :<C-u>Gdiff<CR>
nnoremap [fugitive]dv  :<C-u>Gvdiff<CR>
nnoremap [fugitive]ds  :<C-u>Gsdiff<CR>
nnoremap [fugitive]l  :<C-u>Glog<CR>
nnoremap [fugitive]m  :<C-u>Gmove<Space>
nnoremap [fugitive]r  :<C-u>Gremove<CR>
nnoremap [fugitive]g  :<C-u>Ggrep 
nnoremap [fugitive]b  :<C-u>Gblame w<CR>

" matchit
runtime macros/matchit.vim

" closetag.vim
:let g:closetag_html_style=1

" TweetVim
nnoremap [tweetvim] <Nop>
nmap <Space>t [tweetvim]
nnoremap <silent> [tweetvim]h :<C-u>TweetVimHomeTimeline<CR>
nnoremap <silent> [tweetvim]m :<C-u>TweetVimMentions<CR>
nnoremap <silent> [tweetvim]t :<C-u>TweetVimSay<CR>
nnoremap <silent> [tweetvim]c :<C-u>TweetVimCurrentLineSay<CR>
nnoremap <silent> [tweetvim]s :<C-u>TweetVimSearch 

" caw.vim (コメントアウト)
nmap <Leader>c <Plug>(caw:i:toggle)
vmap <Leader>c <Plug>(caw:i:toggle)

" incsearch.vim
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)
