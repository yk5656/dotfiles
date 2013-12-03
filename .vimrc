"colorscheme jellybeans
colorscheme molokai

"===========================================================================
"
" オプション
"
"===========================================================================
syntax on
let mapleader = ","	" <Leader>キーを「,」に変更
set nocompatible	" Vi互換をオフ

" ファイル
set encoding=utf-8	" デフォルトの文字コードをUTF-8にする
set autoread		" 他で書き換えられたら自動で読み直す
set nobackup		" バックアップ取らない
set noswapfile		" スワップファイル作らない

" 外観
set title			" タイトルを表示
set number			" 行番号を表示
set laststatus=2	" 常にステータス行を表示 (詳細は:he laststatus)
set ruler			" ルーラーを表示

" 検索/移動
set nowrapscan		" 検索をファイルの先頭へループしない
set ignorecase		" 小文字の検索で大文字も見つかるようにする
set smartcase		" 大文字を混ぜて検索した場合だけ大文字/小文字を区別する
set scrolloff=5		" スクロール時の余白確保
set whichwrap=b,s,h,l,<,>,[,]	" カーソルを行頭、行末で止まらないようにする

" テキスト表示
set wrap			" 長い行を折り返して表示 (nowrap:折り返さない)
set noshowmatch		" 括弧入力時に対応する括弧を表示
set list			" タブ文字、行末など不可視文字を表示する
set listchars=tab:>\ ,eol:$,trail:_		"不可視文字の表示文字列
set textwidth=0		" テキストの最大幅

" インデント
set tabstop=4		" ファイル内の <Tab> が対応する空白の数
set shiftwidth=4	" シフト移動幅
set autoindent		" 自動的にインデントする
set noexpandtab		" タブをスペースに展開しない

" コマンドライン
set cmdheight=2		" コマンドラインの高さ
set showcmd			" コマンドをステータス行に表示
set wildmenu		" コマンドライン補完するときに強化されたものを使う

" その他
set history=100		" コマンド・検索パターンの履歴数
"set clipboard=unnamed	" クリップボードをWindowsと連携
set clipboard=unnamedplus	" Ubuntuでクリップボードに保存されなかったので対応
set formatoptions+=mM	" テキスト挿入中の自動折り返しを日本語に対応させる
set backspace=indent,eol,start	" BSでインデントや改行を削除できるようにする
set statusline=%<[%n]%F%=\ %m%r%h%w%y%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}\ %l,%c\ %P 
set ambiwidth=double	"Ubuntuで全角記号がうまく表示されない問題への対策

"===========================================================================
"
" 自動コマンド
"
"===========================================================================

"入力モード時、ステータスラインのカラーを変更
augroup InsertHook
autocmd!
autocmd InsertEnter * highlight StatusLine guifg=#ccdc90 guibg=#2E4340
autocmd InsertLeave * highlight StatusLine guifg=#2E4340 guibg=#ccdc90
augroup END

"vimrc_exambpleで上書きされるのを防止
autocmd FileType text setlocal textwidth=0


"===========================================================================
"
" キーマップ
"
"===========================================================================
" コマンド       ノーマルモード 挿入モード コマンドラインモード ビジュアルモード
" map/noremap           @            -              -                  @
" nmap/nnoremap         @            -              -                  -
" imap/inoremap         -            @              -                  -
" cmap/cnoremap         -            -              @                  -
" vmap/vnoremap         -            -              -                  @
" map!/noremap!         -            @              @                  -
"-------------------------------------------------------------------------------

" 表示行単位で行移動するようにする
noremap j gj
noremap k gk

" ctrl+j/k/h/lでウィンドウを移動できるようにする
nmap <C-j> <C-w>j
nmap <C-k> <C-w>k
nmap <C-h> <C-w>h
nmap <C-l> <C-w>l

" Escの2回押しでハイライト消去
set hlsearch
nmap <Esc><Esc> :nohlsearch<CR>:ccl<CR><Esc>

" tagsジャンプの時に複数ある時は一覧表示
nnoremap <C-]> g<C-]> 

" Ctrl+nで次のバッファを表示、Ctrl+Pで前のバッファを表示
nnoremap <silent> <C-p> :bprevious<CR>
nnoremap <silent> <C-n> :bnext<CR>

" Ctrl+jでESC
inoremap <silent> <C-j> <esc>

" コマンドラインをEmacs風に編集する
cnoremap <C-A> <Home>
cnoremap <C-F> <Right>
cnoremap <C-B> <Left>

" .vimrc/.gvimrcの編集/反映
nnoremap <silent> <leader>ev :<C-u>edit $MYVIMRC<CR>
nnoremap <silent> <leader>eg :<C-u>edit $MYGVIMRC<CR>
nnoremap <silent> <leader>eV :<C-u>edit ~/.vimrc.local<CR>
nnoremap <silent> <leader>s :<C-u>source $MYVIMRC<CR>:<C-u>source $MYGVIMRC<CR>

" プラグイン関連
nnoremap :q<CR> :Bquit<CR>
nnoremap <silent> <leader>t :NERDTreeToggle<CR>
nnoremap <silent> <leader>f :NERDTreeFind<CR>
nnoremap <silent> <leader>l :TlistToggle<CR>
nnoremap <silent> <leader>p :CtrlP<CR>
nnoremap <silent> <leader>@ :CtrlPBufTag<CR>
nnoremap <silent> <leader>b :CtrlPBuffer<CR>
nnoremap <silent> <leader>g :Rgrep<CR>
"nnoremap <silent> <leader>h :<C-u>help<Space><C-r><C-w><Enter>	" カーソル下のキーワードをヘルプで引く

" vim-over
nnoremap <silent> <Leader>r :OverCommandLine<CR>%s/
vnoremap <silent> <Leader>r :OverCommandLine<CR>s/

" ctags生成
nnoremap <leader>c :!ctags -R<CR>


" ファンクションキー割り当て
" ヘルプ
"nnoremap <F1> K
" 再帰Grep
"nnoremap <silent> <F3> :Rgrep<CR>
" 前回の検索結果
"nnoremap <silent> <F4> :ToggleQFixWin<CR>
"map <F6> <ESC>:TMiniBufExplorer<CR>		" タブ表示切替
"nnoremap <F8> :source %<CR>				" vimrcを再読み込み
"map <F11> <ESC>:set nowrap<CR>				" 折り返しをやめる
"nnoremap <silent> <F12> :TlistToggle<CR>	" タグリスト


"===========================================================================
"
" プラグイン
"
"===========================================================================
filetype off

"--------------------------------------
" Vundle
"--------------------------------------
if has("win32") || has("win64")
  set rtp+=~/vimfiles/vundle/
  call vundle#rc('~/vimfiles/bundle/')
else
  set rtp+=~/.vim/bundle/vundle/
  call vundle#rc()
endif

Bundle 'yk5656/vim-bquit'
Bundle 'gmarik/vundle'
Bundle 'The-NERD-tree'
Bundle 'taglist.vim'
Bundle 'buftabs'
Bundle 'kien/ctrlp.vim'

Bundle 'grep.vim'
"Bundle 'fuenor/qfixgrep'
"Bundle 'QuickBuf'
"Bundle 'terryma/vim-multiple-cursors'
"Bundle 'rking/ag.vim'

Bundle 'osyo-manga/vim-over'

filetype plugin indent on


"--------------------------------------
" NERDTree
"--------------------------------------
let NERDTreeShowHidden		= 1
let NERDTreeShowBookmarks	= 1			" ツリーにブックマークも表示
let NERDTreeChDirMode		= 2			" ブックマーク選択時、カレントディレクトリも変更
let NERDTreeMapActivateNode	='<space>'	" スペースで開閉できるようにする
let NERDTreeIgnore=['\.$', '\.\.$']
"let NERDTreeIgnore = ['\.cvs$']
" 最後に残ったウィンドウがNERDTREEのみのときはvimを閉じる
"autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif


"--------------------------------------
" taglist
"--------------------------------------
let Tlist_Use_Right_Window	= 1		" 右側に表示
let Tlist_Show_One_File		= 1		" 常に一つしか表示しない
let g:tlist_php_settings = 'php;f:function'
"let Tlist_Ctags_Cmd			= '/usr/local/bin/ctags'


"--------------------------------------
" buftabs
"--------------------------------------
let g:buftabs_only_basename=1		" バッファタブにパスを省略してファイル名のみ表示する
let g:buftabs_in_statusline=1		" バッファタブをステータスライン内に表示する
let g:buftabs_active_highlight_group="Visual"	" 現在のバッファをハイライト
set laststatus=2	" ステータスラインを常に表示
" ステータスライン
"set statusline=%=\ [%{(&fenc!=''?&fenc:&enc)}/%{&ff}]\[%Y]\[%04l,%04v][%p%%]


"--------------------------------------
" CtrlP
"--------------------------------------
let g:ctrlp_map						= ''
let g:ctrlp_working_path_mode		= 0
let g:ctrlp_by_filename				= 1
let g:ctrlp_max_height				= 20
let g:ctrlp_extensions				= ['tag']
let g:ctrlp_match_window_reversed	= 0
let g:ctrlp_prompt_mappings = {
  \ 'PrtSelectMove("j")':   ['<c-n>', '<down>'],
  \ 'PrtSelectMove("k")':   ['<c-p>', '<up>'],
  \ 'PrtHistory(-1)':       ['<c-j>'],
  \ 'PrtHistory(1)':        ['<c-k>'],
  \ }


"--------------------------------------
" grep
"--------------------------------------
let Grep_Default_Filelist = '*.txt *.html *.css *.js *.php *.ctp'
let Grep_Skip_Dirs = '.svn .git'
let Grep_Skip_Files = 'tags *.jpg *.jpeg *.png *.gif *.exe *.swf *.swp *.bak'
let Grep_Default_Options = '-i'
"let QFix_Height = 40
"let QFix_PreviewEnable = 0
""let Grep_Path = 'c:/cygwin/bin/grep.exe'
"let Grep_Find_Path = 'c:/cygwin/bin/find.exe'
"let Grep_Xargs_Path = 'c:/cygwin/bin/xargs.exe'
""let Grep_Path = 'c:/GnuWin32/bin/grep.exe'
""let Grep_Find_Path = 'c:/GnuWin32/bin/find.exe'
""let Grep_Xargs_Path = 'c:/GnuWin32/bin/xargs.exe'
""let Grep_Default_Filelist = '*.cgi, *.css, *.ctp, *.htm, *.html, *.java, *.js, *.php, *.sql, *.xml'
"let Grep_Find_Use_Xargs = 0
""let Grep_Cygwin_Find = 1 
"let Grep_Shell_Quote_Char = '"'
"let Grep_Cygwin_Find = 1



"===========================================================================
"
" その他
"
"===========================================================================

" 独自シンタックスの設定
"au BufNewFile,BufRead *.txt setf mine	"setfだと反映されない
au BufNewFile,BufRead *.txt set filetype=mine


" ローカルのvimrcを読み込む
if filereadable(expand('~/.vimrc.local'))
  source ~/.vimrc.local
endif
