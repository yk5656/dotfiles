. /usr/local/etc/profile.d/z.sh
alias ctags='/usr/local/Cellar/ctags/5.8/bin/ctags'

export LSCOLORS=gxfxxxxxcxxxxxxxxxgxgx
export LS_COLORS='di=01;36:ln=01;35:ex=01;32'
zstyle ':completion:*' list-colors 'di=36' 'ln=35' 'ex=32'

alias ls="ls -GF"

eval "$(rbenv init -)"

export LANG=ja_JP.UTF-8

autoload -U compinit
compinit

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt hist_ignore_dups     # ignore duplication command history list
setopt share_history        # share command history data

autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

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

# auto change directory
setopt auto_cd

# auto directory pushd that you can get dirs list by cd -[tab]
setopt auto_pushd

# command correct edition before each completion attempt
#setopt correct

# compacked complete list display
setopt list_packed

# no beep sound when complete list displayed
setopt nolistbeep

# 補完候補一覧でファイルの種別をマーク表示
setopt list_types

# 補完候補を一覧表示
setopt auto_list

setopt auto_param_slash      # ディレクトリ名の補完で末尾の / を自動的に付加し、次の補完に備える
setopt mark_dirs             # ファイル名の展開でディレクトリにマッチした場合 末尾に / を付加
setopt list_types            # 補完候補一覧でファイルの種別を識別マーク表示 (訳注:ls -F の記号)
setopt auto_menu             # 補完キー連打で順に補完候補を自動で補完
setopt auto_param_keys       # カッコの対応などを自動的に補完
setopt interactive_comments  # コマンドラインでも # 以降をコメントと見なす
setopt magic_equal_subst     # コマンドラインの引数で --prefix=/usr などの = 以降でも補完できる

# ディレクトリの最後のスラッシュを自動で削除する
setopt autoremoveslash

setopt complete_in_word      # 語の途中でもカーソル位置で補完
setopt always_last_prompt    # カーソル位置は保持したままファイル名一覧を順次その場で表示

## 補完候補のカーソル選択を有効に
zstyle ':completion:*:default' menu select=1

# / を単語の一部とみなさない記号の環境変数から削除
WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'

# 補完候補のメニュー選択で、矢印キーの代わりにhjklで移動出来るようにする。
zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char

# cdコマンド後にlsを自動実行
function chpwd() { ls -F }

# ^を押すと上の階層へ
# http://qiita.com/items/b01536fa63d9f8fadf4f
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


# tmux自動起動
# http://d.hatena.ne.jp/tyru/20100828/run_tmux_or_screen_at_shell_startup
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


