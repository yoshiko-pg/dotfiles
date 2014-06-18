# 環境変数
export LANG=ja_JP.UTF-8

# 色を使用出来るようにする
autoload -Uz colors
colors
export CLICOLOR=1
eval $(/usr/local/bin/gdircolors ~/Dropbox/app/Terminal/solarized/dircolors-solarized-master/dircolors.ansi-universal)
export LSCOLORS=ExFxBxDxCxegedabagacad
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
alias ls='/usr/local/bin/gls --color=auto'

# ヒストリの設定
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000

# プロンプト
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git svn
zstyle ':vcs_info:*' max-exports 6 # formatに入る変数の最大数
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' formats '%b@%r' '%c' '%u'
zstyle ':vcs_info:git:*' actionformats '%b@%r|%a' '%c' '%u'
setopt prompt_subst
function vcs_echo {
	local st branch color
	STY= LANG=en_US.UTF-8 vcs_info
	st=`git status 2> /dev/null`
	if [[ -z "$st" ]]; then return; fi
	branch="$vcs_info_msg_0_"
	if   [[ -n "$vcs_info_msg_1_" ]]; then color=${fg[green]} #staged
	elif [[ -n "$vcs_info_msg_2_" ]]; then color=${fg[red]} #unstaged
	elif [[ -n `echo "$st" | grep "^Untracked"` ]]; then color=${fg[blue]} # untracked
	else color=${fg[cyan]}
	fi
	echo "%{$color%}(%{$branch%})%{$reset_color%}" | sed -e s/@/"%F{yellow}@%f%{$color%}"/
}

DEFAULT='$'
ERROR='%F{red}$%f'

DEFAULT=$'\U1F411 ' # ひつじ
#ERROR=$'\U1F40D '	# ヘビ
ERROR=$'\U1F363 '	# スシ

#DEFAULT=$'\U1F363 '	# スシ
#ERROR=$'\U1F356 '	# 肉

#DEFAULT=$'\U1F4AC ' # ふきだし
#ERROR=$'\U274C '	# バツ

PROMPT=$'
%F{yellow}[%~]%f `vcs_echo`
%(?.${DEFAULT}.${ERROR}) '


# 単語の区切り文字を指定する
autoload -Uz select-word-style
select-word-style default
# ここで指定した文字は単語区切りとみなされる
# / も区切りと扱うので、^W でディレクトリ１つ分を削除できる
zstyle ':zle:*' word-chars " /=;@:{},|"
zstyle ':zle:*' word-style unspecified

########################################
# 補完
# zsh-completions
fpath=(/usr/local/share/zsh-completions $fpath)

# 補完機能を有効にする
autoload -U compinit
compinit -u

# 補完で小文字でも大文字にマッチさせる
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# ../ の後は今いるディレクトリを補完しない
zstyle ':completion:*' ignore-parents parent pwd ..

# sudo の後ろでコマンド名を補完する
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
                   /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin

# ps コマンドのプロセス名補完
zstyle ':completion:*:processes' command 'ps x -o pid,s,args'

# コマンド名の修正
setopt correct

########################################
# オプション
# 日本語ファイル名を表示可能にする
setopt print_eight_bit

# beep を無効にする
setopt no_beep
setopt nolistbeep

# フローコントロールを無効にする
setopt no_flow_control

# '#' 以降をコメントとして扱う
setopt interactive_comments

# ディレクトリ名だけでcdする
setopt auto_cd

# cd したら自動的にpushdする
setopt auto_pushd
# 重複したディレクトリを追加しない
setopt pushd_ignore_dups

# = の後はパス名として補完する
setopt magic_equal_subst

# 同時に起動したzshの間でヒストリを共有する
setopt share_history

# 同じコマンドをヒストリに残さない
setopt hist_ignore_all_dups

# ヒストリファイルに保存するとき、すでに重複したコマンドがあったら古い方を削除する
setopt hist_save_nodups

# スペースから始まるコマンド行はヒストリに残さない
setopt hist_ignore_space

# ヒストリに保存するときに余分なスペースを削除する
setopt hist_reduce_blanks

# 補完候補が複数あるときに自動的に一覧表示する
setopt auto_menu

# 高機能なワイルドカード展開を使用する
#setopt extended_glob

########################################
# キーバインド
bindkey -v

# ^R で履歴検索をするときに * でワイルドカードを使用出来るようにする
bindkey '^R' history-incremental-pattern-search-backward

autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end

bindkey "^J" history-beginning-search-backward
bindkey "^K" history-beginning-search-forward

########################################
# エイリアス

alias la='ls -a'
alias ll='ls -l'
alias lla='ls -la'

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

alias mkdir='mkdir -p'

# git
alias g='git'

# bundle
alias bi='bundle install'
alias bu='bundle update'
alias bug='bundle upgrade'
alias be='bundle exec'

# sudo の後のコマンドでエイリアスを有効にする
alias sudo='sudo '

# カスタム移動系
alias d='cd ~/Dropbox;'
alias dt='cd ~/Desktop;'
alias site='cd ~/Dropbox/site/;'
alias sand='cd ~/Dropbox/site/sandbox/;'
alias gh='cd ~/Dropbox/site/github/;'
alias blog='cd ~/Dropbox/other/blog/;'

# 現在のディレクトリで新しいタブ
alias t='~/Dropbox/app/script/createTabAtCurrentDir.applescript'

# テンプレートからrails new
alias rnew='rails new$1 -m https://github.com/yoshiko-pg/rails_slim_template/raw/master/rails_slim_template.rb'
alias rnewslim='rails new$1 -m https://github.com/yoshiko-pg/rails_slim_template/raw/master/rails_slim_mini.rb'

# グローバルエイリアス
alias -g L='| less'
alias -g G='| grep'

# alias C で標準出力をクリップボードにコピーする
# mollifier delta blog : http://mollifier.hatenablog.com/entry/20100317/p1
if which pbcopy >/dev/null 2>&1 ; then
    # Mac
    alias -g C='| pbcopy'
elif which xsel >/dev/null 2>&1 ; then
    # Linux
    alias -g C='| xsel --input --clipboard'
elif which putclip >/dev/null 2>&1 ; then
    # Cygwin
    alias -g C='| putclip'
fi

# macvim
export PATH="/Applications/MacVim.app/Contents/MacOS:$PATH"
alias vim=/Applications/MacVim.app/Contents/MacOS/Vim
alias vi=vim

# rbenv
eval "$(rbenv init - zsh)"

# zaw.zsh
function mkcd(){mkdir -p $1 && cd $1}
source /Users/maasa/zsh_plugin/zaw/zaw.zsh
bindkey '^h' zaw-history

# postgresql
PATH="/Applications/Postgres.app/Contents/Versions/9.3/bin:$PATH"

# rails
export RAILS_ENV=development
