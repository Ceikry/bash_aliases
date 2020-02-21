
#--------------------------------------------------
# git aliases
#--------------------------------------------------

alias amend='git commit --amend'                                      ## amend last commit
alias cdgit='toplevel'                                                ## jump to project top level folder
alias current='echo "$(git rev-parse --abbrev-ref HEAD 2>/dev/null)"' ## print current branch name
alias diff='gdiff'                                                    ## git diff
alias fetch='git fetch --all'                                         ## fetch all branches
alias gst='dashboard'                                                 ## print git dashboard
alias latest-sha='git rev-parse --verify HEAD'                        ## print latest commit sha
alias lb='lbranches'                                                  ## list branches
alias log='git log --graph --stat'                                    ## print full git log
alias previous-sha='git rev-parse --verify HEAD^1'                    ## print previous commit sha
alias repository-name='echo $(git remote get-url origin|sed -E "s/(http:\/\/|https:\/\/|git@)//"|sed -E "s/\.git$//"|tr ":" "/"|cut -d/ -f3)' ## print remote repository name
alias repository='echo "$(basename `git rev-parse --show-toplevel` 2>/dev/null)"' ## print current toplevel folder name
alias undo='git checkout -- .'                                                    ## remove all changes
alias what='git whatchanged -p --abbrev-commit --pretty=medium'                   ## print changes from every commit

