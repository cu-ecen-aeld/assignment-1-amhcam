#!/bin/bash

# Accepts the following runtime arguments: the first argument is a path to a directory on the filesystem, referred to below as filesdir; the second argument is a text string which will be searched within these files, referred to below as searchstr
filesdir=$1
searchstr=$2

# Exits with return value 1 error and print statements if any of the parameters above were not specified
if [ -z "$filesdir" ]; then
    echo "Error: filesdir not specified"
    exit 1
fi

if [ -z "$searchstr" ]; then
    echo "Error: searchstr not specified"
    exit 1
fi
# Exits with return value 1 error and print statements if filesdir does not represent a directory on the filesystem
if [ ! -d "$filesdir" ]; then
    echo "Error: filesdir does not represent a directory on the filesystem"
    exit 1
fi


num_files=$(find $filesdir -type f | wc -l)
num_lines=0
for file in $(find $filesdir -type f); do
    num_lines=$((num_lines + $(grep -c $searchstr $file)))
done


# Prints a message "The number of files are X and the number of matching lines are Y" where X is the number of files in the directory and all subdirectories and Y is the number of matching lines found in respective files, where a matching line refers to a line which contains searchstr (and may also contain additional content).
echo "The number of files are $num_files and the number of matching lines are $num_lines"
