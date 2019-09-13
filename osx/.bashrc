# show git branch + colorize
# curl -L https://raw.github.com/git/git/master/contrib/completion/git-prompt.sh > ~/.bash_git
source ~/.bash_git

font() {
    local esc="\033"
    case $# in
        2)
            echo "\[${esc}[${1};5;${2}m\]"
        ;;
        3)
            echo "\[${esc}[${2};${1};5;${3}m\]"
        ;;
        4)
            echo "\[${esc}[${2};${3};${1};5;${4}m\]"
        ;;
        5)
            echo "\[${esc}[${2};${3};${4};${1};5;${5}m\]"
        ;;
        6)
            echo "\[${esc}[${2};${3};${4};${5};${1};5;${6}m\]"
        ;;
        *)
            echo "\[${esc}[0m\]"
        ;;
    esac
}

set_prompt() {
    # Background & Foreground
    local bg="48"
    local fg="38"

    # Colours -- https://en.wikipedia.org/wiki/ANSI_escape_code see "8-bit"
    local black="16"
    local blue="27"
    local cyan="51"
    local green="118"
    local orange="202"
    local purple="201"
    local red="9"
    local white="15"
    local yellow="11"
    local light_blue="87"

    # Controls
    local blink_off="25"
    local blink_on="5"
    local bold="1"
    local dim="2"
    local inverse_off="27"
    local inverse_on="7"
    local normal="22"
    local reset="0"
    local transparent="8"
    local underline_off="24"
    local underline_on="4"

    local cwd="\W"
    local date="\d"
    local host="\h"
    local pwd="\w"
    local shell="\s"
    local time="\t"
    local user="\u"

    local git_info=$(__git_ps1)
    if [[ ${git_info} ]]; then
        git_info="$(font ${fg} ${light_blue})${git_info}$(font)"
    fi

    PS1="$(font ${fg} ${white})${user}@$(font ${fg} ${white})${host}$(font) "
    PS1+="$(font ${fg} ${green})${pwd}${git_info}$(font)"
    PS1+="\n$(font ${fg} ${white})\$$(font) "

    # Ensure \n after cat command: https://unix.stackexchange.com/a/60469/288238
    shopt -s promptvars
    PS1='$(printf "%$((COLUMNS-1))s\r")'$PS1
}

GIT_PS1_SHOWUPSTREAM="auto"     # '<' behind, '>' ahead, '<>' diverged, '=' no difference
GIT_PS1_SHOWDIRTYSTATE=1        # staged '+', unstaged '*'
GIT_PS1_SHOWSTASHSTATE=1        # '$' something is stashed
GIT_PS1_SHOWUNTRACKEDFILES=1    # '%' untracked files

PROMPT_COMMAND=set_prompt

# git aliases

alias gs="git_status"
alias gch="git_checkout"
alias gb="git_checkout_branch"
alias gaa="git_add_all"
alias gcom="git_commit"
alias gpl="git_pull"
alias gpsh="git_push"
alias gdf="git_diff"
alias gdfc="git_diff_to_be_commited"
alias gm="git_merge"
alias gl="git_log"
alias gmnd="git_amend"
alias glc="git_last_commit"

git_last_commit() {
  git diff HEAD^ HEAD
}

git_amend() {
  git commit --amend --no-edit
}

git_status() { 
  git status "$@"
}

git_checkout() { 
    git checkout "$@"
}

git_checkout_branch() {
  if [ -z "$1" ]; then
    git branch
  elif [$2 && [${$1:0:1} == "-"] ]; then
    git branch "$@"
  elif [ -z "$2" ]; then
    git checkout -b "$1"
  fi
}
  
git_add_all() { 
  git add -A 
}

git_commit() {
  git commit -m "$1"
}

git_pull() {
  git pull "$@"
}

git_push() {
  git push "$@"
}

git_diff() {
  git --no-pager diff
}

git_diff_to_be_commited() {
  git diff --cached
}

git_merge() {
  git merge "$1"
}

git_log() {
  git log --pretty=oneline -10
}
