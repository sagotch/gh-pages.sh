#! /usr/bin/env sh
#
# gh-pages.sh - Automated documentation update.
#
# Author: Julien Sagot
# License: MIT
# Version: 0.1.0
# Homepage: http://github.com/sagotch/gh-pages.sh#README
#

set -e

# Usage printing.
_usage ()
{
    echo ' Usage:'
    echo '      docdir=d commitmsg="This message" gh_pages.sh'
    echo
    echo ' $docdir     Directory containing doc (gh-pages content).'
    echo '             Mandatory, no default.'
    echo ' $upstream   Upstream remote name. Default is "origin".'
    echo ' $commitmsg  Commit message. Default is "Updated documentation."'
    echo ' $branch     Branch. Default is "gh-pages".'
}

# Main wrapper.
_gh_pages ()
{
    # Variable tests and settings.
    if [ -z "$docdir" ] ; then _usage ; exit -1 ; fi
    if [ -z "$upstream" ] ; then upstream='origin' ; fi
    if [ -z "$commitmsg" ] ; then commitmsg='Updated documentation.' ; fi
    if [ -z "$branch" ] ; then branch='gh-pages' ; fi

    # Create a temporary directory
    tmp=$(mktemp -d)

    # Move documentation in temporary directory.
    mv "$docdir"/* "$tmp"

    # checkout to gh-pages branch. Create it if needed.
    if git fetch "$upstream" "$branch" ; then
	git checkout "$branch"
	git pull --rebase "$upstream" "$branch"
    elif git show-ref --verify --quiet refs/heads/"$branch" ; then
	git checkout "$branch"
    else
	git checkout --orphan "$branch"
    fi

    # Remove everything
    git rm -rf --ignore-unmatch .
    git clean -df

    # Move documentation from temporary directory to current one
    mv "$tmp"/* .

    # Add files to git, commit, push and go back to previous branch
    git add .
    git commit -m "$commitmsg"
    git push "$upstream" "$branch"
    git checkout -

    # Remove temporary folder
    rm -r "$tmp"
}

_gh_pages
