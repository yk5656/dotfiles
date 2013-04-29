#===========================================================================
# 基本
#===========================================================================
export PAGER=lv						# PAGER
export LANG=ja_JP.UTF-8				# LANG 設定

# その他
setopt NO_beep						# ビープ音を鳴らさないようにする
setopt prompt_subst					# エスケープシーケンスを通すオプション
setopt transient_rprompt			# コマンドを実行するときに右プロンプトを消す。他の端末等にコピペするときに便利。
setopt interactive_comments			# コマンドラインでも # 以降をコメントと見なす

#setopt auto_cd						# ディレクトリ名を入力するとそこに移動出来る。
# setopt glog_dots					# ドットファイルにマッチさせるために先頭に'.'を付ける必要がなくなる。
setopt correct						# コマンドのスペルミスを指摘
setopt multios						#  複数のリダイレクトやパイプなど、必要に応じて tee や cat の機能が使われる
setopt brace_ccl					# {a-c} を a b c に展開する機能を使えるようにする
setopt extended_glob				# ファイル名で , ~, ^ の 3 文字を正規表現として扱う
setopt auto_resume					# サスペンド中のプロセスと同じコマンド名を実行した場合はリジュームする
setopt rm_star_silent				#  rm * などの際、本当に全てのファイルを消して良いかの確認しないようになる
setopt short_loops					#  for, repeat, select, if, function などで簡略文法が使えるようになる
# setopt xtrace						#  コマンドラインがどのように展開され実行されたかを表示するようになる
setopt autoremoveslash				# ディレクトリの最後のスラッシュを自動で削除する
# setopt chase_links				# シンボリックリンクは実体を追うようになる

WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'	# / を単語の一部とみなさない記号の環境変数から削除
function chpwd() { ls -F }			# cdコマンド後にlsを自動実行

# apt-getやdpkgなどのキャッシュ
if [ -d ~/.zsh/cache ]; then
zstyle ':completion:*' use-cache yes
zstyle ':completion:*' cache-path ~/.zsh/cache
fi

 
#===========================================================================
# 色
#===========================================================================
# 色の読み込み
autoload -Uz colors
colors
    
# 色の定義
local DEFAULT=$'%{e[m%}'$
local RED=$'%{e[1;31m%}'$
local GREEN=$'%{e[1;32m%}'$
local YELLOW=$'%{e[1;33m%}'$
local BLUE=$'%{e[1;34m%}'$
local PURPLE=$'%{e[1;35m%}'$
local LIGHT_BLUE=$'%{e[1;36m%}'$
local WHITE=$'%{e[1;37m%}'$

# 'dircolors -p'で出力されるものに手を加えて保存したものを読み込んでる。
if [ -f ~/.dir_colors ]; then
eval `dircolors -b ~/.dir_colors`
fi

#===========================================================================
# 補完
#===========================================================================
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}	# 補完候補もLS_COLORSに合わせて色づけ。

# 自動補完
autoload -Uz compinit
compinit

setopt always_last_prompt			# 補完のときプロンプトの位置を変えない
setopt list_packed					# 補完候補を表示するときに出来るだけ詰めて表示。
# setopt complete_aliases			# aliasを展開して補完。
setopt auto_list					# 補完候補が複数ある時に、一覧表示する
setopt list_types					#  auto_list の補完候補一覧で、ls -F のようにファイルの種別をマーク表示
setopt auto_menu					# 補完キー（Tab, Ctrl+I) を連打するだけで順に補完候補を自動で補完する
setopt magic_equal_subst			# コマンドラインの引数で --prefix=/usr などの = 以降でも補完できる
setopt auto_param_keys				# カッコの対応などを自動的に補完する
setopt complete_in_word				# 語の途中でもカーソル位置で補完

# コマンドにsudoを付けてもきちんと補完出来るようにする。Ubuntuだと/etc/zsh/zshrcで設定されている。
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin
 
# 大文字・小文字を区別しないで補完出来るようにするが、大文字を入力した場合は区別する。
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
   
# zstyleによる補完設定
zstyle ':completion:*' verbose yes
zstyle ':completion:*' completer _expand _complete _match _prefix _approximate _list _history
zstyle ':completion:*:messages' format $YELLOW'%d'$DEFAULT
zstyle ':completion:*:warnings' format $RED'No matches for:'$YELLOW' %d'$DEFAULT
zstyle ':completion:*:descriptions' format $YELLOW'completing %B%d%b'$DEFAULT
zstyle ':completion:*:corrections' format $YELLOW'%B%d '$RED'(errors: %e)%b'$DEFAULT
zstyle ':completion:*:options' description 'yes'
# グループ名に空文字列を指定すると，マッチ対象のタグ名がグループ名に使われる。
# したがって，すべての マッチ種別を別々に表示させたいなら以下のようにする
zstyle ':completion:*' group-name ''

# 補完候補を矢印キーなどで選択出来るようにする。'select=3'のように指定した場合は、補完候補が3個以上ある時に選択出来るようになる。
zstyle ':completion:*:default' menu select

# 補完候補のメニュー選択で、矢印キーの代わりにhjklで移動出来るようにする。
zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char


#===========================================================================
# 履歴
#===========================================================================
HISTFILE=~/.zsh/.zsh_histfile		# コマンド履歴を保存するファイル名。
HISTSIZE=10000						# 記憶される履歴の数。
SAVEHIST=100000						# 保存される履歴の数。

# rootは履歴を保存しない。
if [ $UID = 0 ]; then
unset HISTFILE
SAVEHIST=0
fi

setopt auto_pushd					# cd -[TAB] で以前移動したディレクトリの候補を提示
setopt pushd_ignore_dups			# auto_pushdで重複するディレクトリは記録しない
setopt share_history				# 履歴を複数端末間で共有する。
setopt append_history				# 複数の zsh を同時に使う時など history ファイルに上書きせず追加する
setopt hist_ignore_all_dups			# 重複するコマンドが記憶されるとき、古い方を削除する。
setopt hist_ignore_dups				# 直前のコマンドと同じ場合履歴に追加しない。
setopt hist_save_no_dups			# 重複するコマンドが保存されるとき、古い方を削除する。
setopt extended_history				# zsh の開始・終了時刻をヒストリファイルに書き込む
setopt hist_ignore_space			# コマンドラインの先頭がスペースで始まる場合ヒストリに追加しない
setopt hist_verify					# ヒストリを呼び出してから実行する間に一旦編集できる状態になる

# 履歴検索
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end


#===========================================================================
# エイリアス
#===========================================================================
alias ls="ls -GF"
#alias -g L='| $PAGER'
#alias -g G='| grep'
#alias -g V='| vim -R -'
#alias ll='ls -l'
#alias la='ls -a'
#alias lla='ls -al'


#===========================================================================
# 未整理
#===========================================================================
. /usr/local/etc/profile.d/z.sh
alias ctags='/usr/local/Cellar/ctags/5.8/bin/ctags'

export LSCOLORS=gxfxxxxxcxxxxxxxxxgxgx
export LS_COLORS='di=01;36:ln=01;35:ex=01;32'
zstyle ':completion:*' list-colors 'di=36' 'ln=35' 'ex=32'

eval "$(rbenv init -)"

autoload colors
colors
case ${UID} in
0)
    PROMPT="%B%{${fg[red]}%}%/#%{${reset_color}%}%b "
    PROMPT2="%B%{${fg[red]}%}%_#%{${reset_color}%}%b "
    SPROMPT="%B%{${fg[red]}%}%r is correct? [n,y,a,e]:%{${reset_color}%}%b "
    [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && 
        PROMPT="%{${fg[cyan]}%}$(echo ${HOST%%.*} | tr '[a-z]' '[A-Z]') ${PROMPT}"
    ;;
*)
    PROMPT="%{${fg[red]}%}%/%%%{${reset_color}%} "
    PROMPT2="%{${fg[red]}%}%_%%%{${reset_color}%} "
    SPROMPT="%{${fg[red]}%}%r is correct? [n,y,a,e]:%{${reset_color}%} "
    [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] && 
        PROMPT="%{${fg[cyan]}%}$(echo ${HOST%%.*} | tr '[a-z]' '[A-Z]') ${PROMPT}"
    ;;
esac



#===========================================================================
# ^を押すと上の階層へ
#===========================================================================
cdup() {
if [ -z "$BUFFER" ]; then
echo
cd ..
if type precmd > /dev/null 2>&1; then
precmd
fi
local precmd_func
for precmd_func in $precmd_functions; do
$precmd_func
done
zle reset-prompt
else
zle self-insert '^'
fi
}
zle -N cdup
bindkey '\^' cdup


#===========================================================================
# tmux自動起動
#===========================================================================
is_screen_running() {
	# tscreen also uses this varariable.
	[ ! -z "$WINDOW" ]
}
is_tmux_runnning() {
    [ ! -z "$TMUX" ]
}
is_screen_or_tmux_running() {
	is_screen_running || is_tmux_runnning
}
shell_has_started_interactively() {
	[ ! -z "$PS1" ]
}
resolve_alias() {
	cmd="$1"
	while \
		whence "$cmd" >/dev/null 2>/dev/null \
		&& [ "$(whence "$cmd")" != "$cmd" ]
	do
		cmd=$(whence "$cmd")
	done
	echo "$cmd"
}
if ! is_screen_or_tmux_running && shell_has_started_interactively; then
	for cmd in tmux tscreen screen; do
		if whence $cmd >/dev/null 2>/dev/null; then
			$(resolve_alias "$cmd")
			break
		fi
	done
fi


