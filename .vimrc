"------------------------------------------------------------------------------
"
" 基本設定
"
"------------------------------------------------------------------------------
set nocompatible                " vi互換をオフにしてvimのデフォルトの設定にする
set encoding=utf-8              " 文字コードをUTF-8にする
let mapleader=","               " <Leader>キーを「,」にする

" ファイル
set autoread                    " 他でファイルが更新された時に自動で再読み込み
set noswapfile                  " スワップファイルを作成しない
set nobackup                    " バックアップファイルを作成しない

" 外観
set title                       " タイトルを表示する
set number                      " 行番号を表示する
set laststatus=2                " ステータス行を常に表示する
set showcmd                     " 入力中のコマンドを画面の右下に表示する
set cmdheight=2                 " コマンドラインの高さを設定する
set wildmenu                    " コマンドラインの補完を有効にする

" テキスト表示
set nowrap                      " 長い行を折り返さない
set noshowmatch                 " 括弧入力時に対応する括弧に表示を移さない
set list                        " 不可視文字を表示する
set listchars=tab:>\ ,trail:_   " タブ文字「>」、行末の余分なスペース「_」
set textwidth=0                 " 文字入力中に勝手に改行しないようにする

" インデント
set noexpandtab                 " タブをスペースに変換しない
set ts=4 sw=4 sts=4             " タブの文字数
set autoindent                  " 自動的にインデントする

" 検索/移動
set nowrapscan                  " 最後まで検索した後、先頭から再度検索しない
set ignorecase                  " 小文字の場合は大文字小文字区別しないが、
set smartcase                   " 大文字が含まれる場合は大文字小文字区別する
set scrolloff=5                 " 画面の上下に数行余白を残してスクロールする
set whichwrap=b,s,h,l,<,>,[,]   " カーソルが行頭・行末で止まらないようにする
set history=100                 " 検索やコマンドの履歴の保存数

" ステータスライン
set statusline=%<[%n]%F%=\ %m%r%h%w%y%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}\ %l,%c\ %P


"
" OS別設定（トラブルシューティング）
"
if has("win32") || has("win64")
  " Windows用

  " Kaoriya版vimの場合、デフォルトの設定ファイルvimrc_example.vimを読み込む際に
  " textwidthが上書きされるので、その対策
  "autocmd FileType text setlocal textwidth=0

elseif has('mac')
  " Mac用

elseif has('unix')
  " UNIX用

  " Ubuntuで全角記号がうまく表示されない問題への対策
  set ambiwidth=double

  " Ubuntuでは、unnamedではなくunnamedplusじゃないとクリップボードに保存されなかった
  set clipboard=unnamedplus

endif


"
" カラー
"

" シンタックスのカラー表示を有効にする
syntax on

" カラースキーマ
colorscheme molokai
"colorscheme jellybeans
"colorscheme hybrid

" ステータスラインのカラーの設定（挿入モード時に色を変える）
highlight StatusLine guifg=#2E4340 guibg=#ccdc90 gui=none cterm=none ctermfg=black ctermbg=6
augroup InsertHook
autocmd!
autocmd InsertEnter * highlight StatusLine guifg=#ccdc90 guibg=#2E4340 gui=none cterm=none ctermfg=black ctermbg=3
autocmd InsertLeave * highlight StatusLine guifg=#2E4340 guibg=#ccdc90 gui=none cterm=none ctermfg=black ctermbg=6
augroup END




" キーマップ
"
"  コマンド       ノーマルモード 挿入モード コマンドラインモード ビジュアルモード
"  map/noremap           @            -              -                  @
"  nmap/nnoremap         @            -              -                  -
"  imap/inoremap         -            @              -                  -
"  cmap/cnoremap         -            -              @                  -
"  vmap/vnoremap         -            -              -                  @
"  map!/noremap!         -            @              @                  -
"

" 表示行単位で行移動する
noremap j gj
noremap k gk

" Ctrl+jでESC
inoremap <silent> <C-j> <esc>

" Yでカーソル位置から行末までコピー
nnoremap Y y$

" ctrl+j/k/h/lでウィンドウを移動
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l


" Escの2回押しでハイライト消去
set hlsearch
nnoremap <Esc><Esc> :nohlsearch<CR>:ccl<CR><Esc>

" Ctrl+nで次のバッファを表示、Ctrl+Pで前のバッファを表示
nnoremap <silent> <C-p> :bprevious<CR>
nnoremap <silent> <C-n> :bnext<CR>

" ちょっとだけEmacs風にする
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-f> <Right>
cnoremap <C-b> <Left>
cnoremap <C-d> <Del>
inoremap <C-a> <Home>
inoremap <C-e> <End>
inoremap <C-b> <Left>
inoremap <C-f> <Right>
inoremap <C-d> <Del>
"inoremap <C-n> <Down>
"inoremap <C-p> <Up>




" .vimrc/.gvimrcの編集/反映
nnoremap <silent> <leader>ev :<C-u>edit $MYVIMRC<CR>
nnoremap <silent> <leader>eg :<C-u>edit $MYGVIMRC<CR>
"nnoremap <silent> <leader>eV :<C-u>edit ~/.vimrc.local<CR>
if has('gui_running')
nnoremap <silent> <leader>er :<C-u>source $MYVIMRC<CR>:<C-u>source $MYGVIMRC<CR>
else
nnoremap <silent> <leader>er :<C-u>source $MYVIMRC<CR>
endif


"
" ファイルタイプ
"
"filetype plugin on
"filetype indent on
autocmd FileType ruby  setlocal sw=2 sts=2 ts=2 et
autocmd FileType eruby setlocal sw=2 sts=2 ts=2 et
"autocmd FileType perl       setlocal sw=4 sts=4 ts=4 et
"autocmd FileType php        setlocal sw=4 sts=4 ts=4 et
"autocmd FileType html       setlocal sw=2 sts=2 ts=2 et



"------------------------------------------------------------------------------
"
" プラグイン
"
"------------------------------------------------------------------------------
filetype off

" tagsジャンプの時に複数ある時は一覧表示
nnoremap <C-]> g<C-]> 

" ctags生成
nnoremap <leader>c :!ctags -R<CR>

" プラグイン関連
nnoremap :q<CR> :Bquit<CR>
nnoremap <silent> <leader>t :NERDTreeToggle<CR>
nnoremap <silent> <leader>T :NERDTreeFind<CR>
nnoremap <silent> <leader>f :NERDTreeFind<CR>
nnoremap <silent> <leader>l :TlistToggle<CR>
nnoremap <silent> <leader>L :TlistOpen<CR>
nnoremap <silent> <leader>p :CtrlP<CR>
nnoremap <silent> <leader>@ :CtrlPBufTag<CR>
nnoremap <silent> <leader>b :CtrlPBuffer<CR>
nnoremap <silent> <leader>, :CtrlPMRUFiles<CR>
nnoremap <silent> <leader>g :Rgrep<CR>
"nnoremap <silent> <leader>h :<C-u>help<Space><C-r><C-w><Enter>	" カーソル下のキーワードをヘルプで引く

" vim-over
nnoremap <silent> <Leader>r :OverCommandLine<CR>%s/
vnoremap <silent> <Leader>r :OverCommandLine<CR>s/

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

Bundle 'gmarik/vundle'
Bundle 'yk5656/vim-bquit'
Bundle 'The-NERD-tree'
Bundle 'taglist.vim'
Bundle 'grep.vim'
Bundle 'kien/ctrlp.vim'


"Bundle 'buftabs'
"Bundle 'surround.vim'
"Bundle 'gcmt/wildfire.vim'

"Bundle 'scrooloose/syntastic'

"Bundle 'fuenor/qfixgrep'
"Bundle 'QuickBuf'
"Bundle 'terryma/vim-multiple-cursors'
"Bundle 'rking/ag.vim'

"Bundle 'osyo-manga/vim-over'
"Bundle 'LeafCage/yankround.vim'

"Bundle 'rhysd/clever-f.vim'
"let g:clever_f_ignore_case = 1

filetype plugin indent on


"--------------------------------------
" NERDTree
"--------------------------------------
"let NERDTreeShowHidden		= 1
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
"let g:buftabs_only_basename=1		" バッファタブにパスを省略してファイル名のみ表示する
"let g:buftabs_in_statusline=1		" バッファタブをステータスライン内に表示する
"let g:buftabs_active_highlight_group="Visual"	" 現在のバッファをハイライト
"set laststatus=2	" ステータスラインを常に表示
" ステータスライン
"set statusline=%=\ [%{(&fenc!=''?&fenc:&enc)}/%{&ff}]\[%Y]\[%04l,%04v][%p%%]


"--------------------------------------
" CtrlP
"--------------------------------------
let g:ctrlp_map						= ''
let g:ctrlp_working_path_mode		= 0
let g:ctrlp_jump_to_buffer			= 2
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


" SuperTab like snippets behavior.
"imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
"\ "\<Plug>(neosnippet_expand_or_jump)"
"\: pumvisible() ? "\<C-n>" : "\<TAB>"
"smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
"\ "\<Plug>(neosnippet_expand_or_jump)"
"\: "\<TAB>"

" For snippet_complete marker.
"if has('conceal')
"  set conceallevel=2 concealcursor=i
"endif


" yunkround用の設定
"nmap p <Plug>(yankround-p)
"nmap P <Plug>(yankround-P)
"nmap gp <Plug>(yankround-gp)
"nmap gP <Plug>(yankround-gP)
"nmap <C-p> <Plug>(yankround-prev)
"nmap <C-n> <Plug>(yankround-next)

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




"Bundle 'vim-scripts/PDV--phpDocumentor-for-Vim'
"nnoremap <silent> <leader>d :call PhpDocSingle()<CR>
"
"let g:pdv_cfg_Type = "type"
"let g:pdv_cfg_Package = ""
"let g:pdv_cfg_Version = ""
"let g:pdv_cfg_Author = ""
"let g:pdv_cfg_Copyright = ""
"let g:pdv_cfg_License = ""



"Bundle 'Shougo/neocomplcache'
""Bundle 'Shougo/neosnippet.vim'
""Bundle 'Shougo/neosnippet-snippets'
"
"" neocomplcache用の設定
"let g:acp_enableAtStartup = 0
"let g:neocomplcache_enable_at_startup = 1
"let g:neocomplcache_enable_smart_case = 1
"let g:neocomplcache_max_list = 20
"let g:neocomplcache_auto_completion_start_length = 2
"let g:neocomplcache_enable_smart_case = 1
"let g:neocomplcache_manual_completion_start_length = 3
"inoremap <expr><TAB>   pumvisible() ? "\<C-n>" : "\<TAB>"

"" neosnippet用の設定
"" Plugin key-mappings.
"imap <C-k>     <Plug>(neosnippet_expand_or_jump)
"smap <C-k>     <Plug>(neosnippet_expand_or_jump)
"xmap <C-k>     <Plug>(neosnippet_expand_target)

"Bundle 'joonty/vdebug'
"
"let g:vdebug_options= {
"\    "port" : 9000,
"\    "server" : '192.168.56.6',
"\    "timeout" : 20,
"\    "on_close" : 'detach',
"\    "break_on_open" : 1,
"\    "ide_key" : '',
"\    "path_maps" : {},
"\    "debug_window_level" : 0,
"\    "debug_file_level" : 0,
"\    "debug_file" : "",
"\    "watch_window_style" : 'expanded',
"\    "marker_default" : '⬦',
"\    "marker_closed_tree" : '▸',
"\    "marker_open_tree" : '▾'
"\}

"Bundle 'vim-scripts/AutoComplPop'

"Bundle 'nishigori/increment-activator'
"let g:increment_activator_filetype_candidates = {
"  \   '_' : [
"  \     ['月', '火', '水', '木', '金', '土', '日'],
"  \   ],
"  \ }



"Bundle 'Shougo/unite.vim'
"let g:unite_enable_start_insert=1

"

