PS1="\[\e[38;5;75m\]\u@\h \[\e[38;5;113m\]\w \[\e[38;5;189m\]\$ \[\e[0m\]"

alias neofetch="fastfetch -c examples/13"

alias glog="git log --oneline -10"

ching(){
    echo "ac   : add, commit"
    echo "Usage: ac [commit_message]"
    echo
    echo "acp  : add, commit, push"
    echo "Usage: acp <branch_name> [commit_message]"
    echo
    echo "glog : log 10 previous commits with oneline"
    echo
    echo "iopp : init, add origin, pull, push"
    echo "Usage: iopp <remote_url> [commit_message]"
}

iopp() {

    if [[ $# -lt 1 || $# -gt 2 ]]; then
        echo "Usage: iopp <remote_url> [commit_message]"
        return 1
    fi

    remote_url="$1"
    commit_message="${2:-initialize Unity Project}"

    git init
    git branch -m main

    git remote add origin "$remote_url" 2>/dev/null || \
        git remote set-url origin "$remote_url"

    git pull origin main --allow-unrelated-histories

    git add .
    git commit -m "$commit_message"
    git push -u origin main

	echo
	echo 'Successfully Initialized the Repository !'
	echo
    git log --oneline -10

}

ac(){

    if [[$# -gt 1 ]]; then
        echo "Usage: ac [commit_message]"
        return 1
    fi

    local commit_message="${2:-Auto commit on $(date '+%Y-%m-%d %H:%M:%S')}"

    git add .

    # Only commit if there are changes
    if ! git diff --cached --quiet; then
        git commit -m "$commit_message"
    else
        echo "No changes to commit."
    fi

    echo
    echo "Committed !!"
    echo

    git log --oneline -10

}

acp() {

    if [[ $# -lt 1 || $# -gt 2 ]]; then
        echo "Usage: acp <branch_name> [commit_message]"
        return 1
    fi

    local branch_name="$1"
    local commit_message="${2:-Auto commit on $(date '+%Y-%m-%d %H:%M:%S')}"

    git add .

    # Only commit if there are changes
    if ! git diff --cached --quiet; then
        git commit -m "$commit_message"
    else
        echo "No changes to commit."
    fi

    git push origin "$branch_name"

    echo
    echo "Pushed !!"
    echo

    git log --oneline -10

}
