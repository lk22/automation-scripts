#!/bin/bash

DIR=$1
# This script is used to check the status of the git repository
# and display the status of the repository

# Check if the current directory is a git repository
# If it is not a git repository, then exit the script

# create array of dirty repositories

dirtyRepositories=()
cleanRepositories=()
cd
if [ -d ~/.logs ]; then
    echo "Logs directory exists"
else
    mkdir ~/.logs
fi

for dir in $DIR; do
    if [ -d $dir ]; then
        for repository in "$DIR"/*; do
            if [ -d $repository ]; then
                cd $repository
                
                if [ -d .git ]; then
                    echo "Checking status of $repository"
                    status=$(git status)

                    if [ $status == "nothing to commit, working tree clean" ]; then
                        cleanRepositories+=($repository) #adding clean repository to array
                    else
                        dirtyRepositories+=($repository) #adding dirty repository to array
                    fi
                fi
            fi
         done
         if [ ${#dirtyRepositories[@]} == 0 ]; then
             echo "No dirty repositories" | terminal-notifier -title "Git Status" -message "No dirty repositories" -sound default -timeout 100
         fi
    else
        echo "$dir is not a git repository"
    fi
done

echo "Dirty repositories: ${dirtyRepositories[@]}" | terminal-notifier -title "Dirty Repositories" -message "Dirty Repositories: ${dirtyRepositories[@]}" -sound default -timeout 100

cd 
