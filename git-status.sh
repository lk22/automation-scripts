#!/bin/bash

# This script is used to check the status of the git repository
# and display the status of the repository

# Check if the current directory is a git repository
# If it is not a git repository, then exit the script

# TODO: add terminal notifier message depending on any repositories that are not up to date
#purpose of this script is to check the status of the git repository and display the status of the repository and to be runned automatically every 5 minutes

# create array of dirty repositories
dirtyRepositories=()
cleanRepositories=()
repositoryDirectories=(
    "/projects/",
    "/Applications/MAMP/htdocs/dxl-v2/wp-content/plugins"
)

cycleThroughRepositories() {
    for repository in "$1"; do
        cd $repository
        # if [ -d ".git" ]; then
        #     # check if the repository is dirty
        #     # if [ -n "$(git status --porcelain)" ]; then
        #     #     # add the repository to the dirtyRepositories array
        #     #     dirtyRepositories+=($repository)
        #     # else
        #     #     # add the repository to the cleanRepositories array
        #     #     cleanRepositories+=($repository)
        #     # fi
        # fi
    done
}

# loop through the directories and check the status of the git repository
for dir in "${repositoryDirectories[@]}"; do
    
    # check if the directory is a git repository
    if [ -d $dir ]; then
    
        if [ -d .git ]; then
            echo "Git repository found"
            git status
            # check if the repository is dirty
            if [ $? -eq 0 ]; then
                echo "Git repository is clean"
                cleanRepositories+=($dir)
                cycleThroughRepositories $dir
            else
                echo "Git repository is dirty"
                dirtyRepositories+=($dir)
            fi
        else 
            cycleThroughRepositories $dir
        fi
    fi
done

if [ ${#dirtyRepositories[@]} -gt 0 ]; then
    echo "${dirtyRepositories[@]} Dirty repositories found" | terminal-notifier -title "Git Status" -message "Dirty repositories found ${dirtyRepositories[0]}" -sound default -timeout 2000
else
    echo "No dirty repositories found"
fi

# if [ ${dirtyRepositories[@]} > 0 ]; then
#     echo "Dirty repositories: ${dirtyRepositories[@]}" | terminal-notifier -title "Dirty Repositories" -message "Dirty Repositories: ${dirtyRepositories[@]}" -sound default -timeout 2000
# else 
#     echo "No dirty repositories" | terminal-notifier -title "Git Status" -message "Dirty repositories" -sound default -timeout 100
# fi

# for dir in $DIR; do
#     if [ -d $dir ]; then
#         for repository in "$DIR"/*; do
            
#             if [ -d $repository ]; then
#                 cd $repository
#                 if [ -d .git ]; then

#                     echo "Checking status of $repository"
#                     status=$(git status)
#                     if [ $status = "nothing to commit, working tree clean" ]; then
#                         cleanRepositories+=($repository) #adding clean repository to array
#                     else
#                         dirtyRepositories+=($repository) #adding dirty repositorto array
#                         echo $dirtyRepositories
#                     fi
#                 fi
#             else 
#                 echo "$repository is not a directory"
#             fi
#          done
#          if [ ${#dirtyRepositories[*]} > 0]; then
#              echo "No dirty repositories" | terminal-notifier -title "Git Status" -message "No dirty repositories" -sound default -timeout 100
#          else 
#              echo "Dirty repositories: ${#dirtyRepositories}" | terminal-notifier -title "Git Status" -message "Dirty repositories: ${#dirtyRepositories[@]}" -sound default -timeout 100
#          fi
#     else
#         echo "$dir is not a git repository"
#     fi
# done

# if [ ${dirtyRepositories[@]} > 0 ]; then
#     echo ${dirtyRepositories[@]}
#     echo "Dirty repositories: ${dirtyRepositories[@]}" | terminal-notifier -title "Dirty Repositories" -message "Dirty Repositories: ${dirtyRepositories[@]}" -sound default -timeout 100
# else 
#     echo "No dirty repositories" | terminal-notifier -title "Git Status" -message "Dirty repositories" -sound default -timeout 100
# fi

cd 
