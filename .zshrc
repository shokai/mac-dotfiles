export LANG=ja_JP.UTF-8
zstyle ':completion:*:default' menu select=1
autoload -U compinit
setopt auto_cd
setopt auto_pushd
setopt correct
setopt extended_glob
setopt auto_remove_slash
setopt nolistbeep
setopt pushd_ignore_dups
RPROMPT="[%~]"
compinit

HISTFILE=$HOME/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt extended_history
setopt share_history

function history-all { history -E 1 }

typeset -A myabbrev
myabbrev=(
    "ll"    "| less"
    "lg"    "| grep"
)

if [ "$TERM" = "screen" ]; then
	chpwd () { echo -n "_`dirs`\\" }
	preexec() {
		emulate -L zsh
		local -a cmd; cmd=(${(z)2})
		case $cmd[1] in
			fg)
				if (( $#cmd == 1 )); then
					cmd=(builtin jobs -l %+)
				else
					cmd=(builtin jobs -l $cmd[2])
				fi
				;;
			%*)
				cmd=(builtin jobs -l $cmd[1])
				;;
			cd)
				if (( $#cmd == 2)); then
					cmd[1]=$cmd[2]
				fi
				;&
			    *)
	echo -n "k$cmd[1]:t\\"
	return
	;;
	esac

	local -A jt; jt=(${(kv)jobtexts})

	$cmd >>(read num rest
		cmd=(${(z)${(e):-\$jt$num}})
		echo -n "k$cmd[1]:t\\") 2>/dev/null
	}
	chpwd
fi

my-expand-abbrev() {
    local left prefix
    left=$(echo -nE "$LBUFFER" | sed -e "s/[_a-zA-Z0-9]*$//")
    prefix=$(echo -nE "$LBUFFER" | sed -e "s/.*[^_a-zA-Z0-9]\([_a-zA-Z0-9]*\)$/\1/")
    LBUFFER=$left${myabbrev[$prefix]:-$prefix}" "
}
zle -N my-expand-abbrev
bindkey     " "         my-expand-abbrev

#wideterm
precmd() {
    hostnam=${HOST##.*}     # wildcard, not regex!
    usernam=$(whoami)
    newPWD=${PWD}
    #   アクセサリをつけていく
    promptstr="--(${usernam}@${hostnam})-<mm/dd-hh:mm>---(${PWD})--"
    fillsize=$(( ${COLUMNS} - ${#promptstr} ))      # プロンプト幅を計算
    if [ $fillsize -ge 0 ]
    then
        fill=${(l.${fillsize}..-.)}
    else
        fill=""
        offset=$(( (${fillsize}*(-1)) + 4 ))
        newPWD="..."${newPWD[${offset},-1]}
    fi
}

termwide() {

    local GRAY=$'%{\e[1;30m%}'
    local LIGHT_GRAY=$'%{\e[0;37m%}'
    local WHITE=$'%{\e[1;37m%}'

    local LIGHT_BLUE=$'%{\e[1;36m%}'
    local YELLOW=$'%{\e[1;33m%}'
    local PURPLE=$'%{\e[1;35m%}'
    local GREEN=$'%{\e[1;32m%}'
    local BLUE=$'%{\e[1;34m%}'

    PROMPT=$YELLOW"-"$BLUE"-("$YELLOW"\${usernam}"$LIGHT_BLUE"@"$YELLOW"\${hostnam}"\
$BLUE")-<"$YELLOW"%D{%m}"$LIGHT_BLUE"/$YELLOW%D{%d}"$BLUE"-"\
$PURPLE"%D{%H}"$LIGHT_BLUE":"$PURPLE"%D{%M}"$BLUE">-"\
$YELLOW"-\${fill}"$BLUE"-("$YELLOW"\${newPWD}"$BLUE")-"$YELLOW"-"\
$'\n'\
$YELLOW"-"$BLUE"-["\
$YELLOW"%h"\
$BLUE"]"$WHITE"%#"\
$'%{\e[0m%} '

PROMPT2=$LIGHT_BLUE"-"$YELLOW"-"$YELLOW"-"$LIGHT_GRAY$'%{\e[0m%} '
}


case "${OSTYPE}" in
    freebsd*|darwin*)
        alias ls="ls -G -w"
        ;;
    linux*)
        alias ls="ls --color"
        ;;
esac

alias la="ls -a"
alias lf="ls -F"
alias ll="ls -l"
alias du="du -h"
alias df="df -h"


## terminal configuration
autoload -U colors
colors
PROMPT="%{$fg[green]%}%#%{$reset_color%} "

precmd () {
    PROMPT="%{%(?.$fg[green].$fg[red])%}%U$USER@%m%%%u%{$reset_color%} "
}

#unset LSCOLORS
case "${TERM}" in
    xterm)
        export TERM=xterm-color
        export LSCOLORS=gxfxcxdxbxegedabagacad
        ;;
    kterm)
        export TERM=kterm-color
    # set BackSpace control character
        stty erase
        ;;
    cons25)
        unset LANG
        export LSCOLORS=GxFxCxdxBxegedabagacad
        export LS_COLORS='di=01;34:ln=01;35:so=01;32:ex=01;31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
        zstyle ':completion:*' list-colors \
            'di=;34;1' 'ln=;35;1' 'so=;32;1' 'ex=31;1' 'bd=46;34' 'cd=43;34'
        ;;
esac

# set terminal title including current directory
#
case "${TERM}" in
    kterm*|xterm*)
        precmd() {
            echo -ne "\033]0;${USER}@${HOST%%.*}:${PWD}\007"
        }
        export LSCOLORS=gxfxcxdxbxegedabagacad
        export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'
        zstyle ':completion:*' list-colors \
            'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'
        ;;
esac


#
# Show branch name in Zsh's right prompt
#
autoload -Uz VCS_INFO_get_data_git; VCS_INFO_get_data_git 2> /dev/null
function rprompt-git-current-branch {
    local name st color gitdir action
    if [[ "$PWD" =~ '/\.git(/.*)?$' ]]; then
        return
    fi
    name=$(git symbolic-ref HEAD 2>/dev/null | sed 's/^refs\/heads\///')
    if [[ -z $name ]]; then
        return
    fi
    gitdir=`git rev-parse --git-dir 2> /dev/null`
    action=`VCS_INFO_git_getaction "$gitdir"` && action="($action)"
    st=`git status 2> /dev/null`
    if [[ -n `echo "$st" | grep "^nothing to"` ]]; then
        color=%F{green}
    elif [[ -n `echo "$st" | grep "^nothing added"` ]]; then
        color=%F{yellow}
    elif [[ -n `echo "$st" | grep "^# Untracked"` ]]; then
        color=%B%F{red}
    else
        color=%F{red}
    fi
    echo "$color$name$action%f%b "
}
setopt prompt_subst
RPROMPT='[`rprompt-git-current-branch`%~]'

# emacs-git-diff-open の補完設定
_emacs_git_diff_open_completions() {
  # 引数が既に1つある場合は補完しない
  if (( CURRENT > 2 )); then
    return 0
  fi

  local -a branches
  branches=($(git branch --format='%(refname:short)'))
  _describe 'branches' branches
}
compdef _emacs_git_diff_open_completions emacs-git-diff-open

# direnv
eval "$(direnv hook zsh)"

#
# git worktree remove/move/lock/unlock で worktree 名を補完できるようにする
#
# 標準の __git_worktrees (/usr/share/zsh/5.9/functions/_git) は候補が絶対パスで、
# 先頭から絶対パスを打たない限りマッチしないため実質サジェストが効かない。
# ここでは main worktree (remove等の対象にできない) を除外し、worktree の
# ディレクトリ名を候補にする (一意なら git は末尾のパス要素だけで特定できる)。
__my_git_worktrees() {
  local -a records=( ${(ps.\n\n.)"$(_call_program directories git worktree list --porcelain)"} )
  local -a paths names hashes branches candidates descriptions
  local rec dir branch cand
  local -i i
  # 先頭レコードは main worktree なので除く
  for rec in ${records[2,-1]}; do
    dir=${${rec%%$'\n'*}#worktree }
    paths+=( $dir )
    names+=( ${dir:t} )
    hashes+=( ${${${"${(f)rec}"[2]}#HEAD }[1,9]} )
    branch=${${"${(f)rec}"[3]}#branch refs/heads/}
    if [[ $branch == detached ]]; then
      branches+=( '(detached HEAD)' )
    else
      branches+=( "[$branch]" )
    fi
  done
  (( $#paths )) || return 1
  for (( i = 1; i <= $#paths; i++ )); do
    # ディレクトリ名が他の worktree と重複する場合はフルパスで補完する
    cand=${names[i]}
    (( ${names[(Ie)$cand]} != ${names[(ie)$cand]} )) && cand=${paths[i]}
    candidates+=( $cand )
    descriptions+=( "$cand"$'\t'"${hashes[i]} ${branches[i]} ${paths[i]}" )
  done
  _wanted directories expl 'working tree' \
    compadd -M 'l:|=* r:|=*' -S ' ' -ld descriptions -a candidates
}

# _git 本体をロードし、worktree 補完の呼び出し先を上書き版に差し替える。
# __git_worktrees 自体はガードなしで再定義されるため、直接の上書きでは消される。
# zsh 更新で置換対象の文字列が見つからなくなった場合は標準の挙動のままになる。
if autoload -Uz +X _git 2>/dev/null; then
  functions[_git]=${functions[_git]/'__git_worktrees && ret=0'/'__my_git_worktrees && ret=0'}
fi
