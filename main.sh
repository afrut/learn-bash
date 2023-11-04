#!/bin/bash

# Define a function
some_func() {
    echo "$1 received in some_func"
}

# Run all commands in envars in this script
source envars

# Print the contents of the MSG environment variable to console
echo $MSG

# Print something to console without newline
printf "I'm alive\n"

# pwd gets the path of the current directory
# $() takes the output of a command stores it in a variable
# Store the path of the current directory in CWD
CWD=$(pwd)

# Set some more variables
PLAY_AREA="./playarea"
FILE_NAME="foo.txt"
FILE="$PLAY_AREA/$FILE_NAME"

# Create a file foo.txt in the playarea directory
touch $FILE

# List directory contents of playarea
echo "./playarea contains:"
ls playarea

# Navigate into playarea directory, delete foo.txt and return to this directory
cd playarea
rm foo.txt
cd $CWD

# Call a script with an argument
./script_args.sh "What should I do now?"

# Run a script that is now in PATH without using ./, but using shebang
shebang

# Call a function and store its return in a variable
RET=$(some_func foo)
echo "Return is $RET"

# Check if a file exists, regardless of file type.
if test -e "./playarea"; then
    echo "./playarea exists."
else
    echo "./playarea does not exist."
fi

# Check if a regular file exists. playarea is a directory.
if test -f "./playarea"; then
    echo "./playarea exists."
else
    echo "./playarea does not exist."
fi

# Check if a regular file exists. playarea/foo.txt is a file.
if test -f "./playarea/foo.txt"; then
    echo "./playarea/foo.txt exists."
else
    echo "./playarea/foo.txt does not exist."
fi

# Write content to a file
echo "some content" > $FILE

# Append content to file
echo "some more content" >> $FILE

# Print contents of file to console
cat $FILE

# Add multi-line content to a file
cat << EOF >> $FILE
even more content line 1
even more content line 2
even more content line 3
EOF
cat $FILE

# Store multi-line content in a variable as a single line
MULTILINE=$(cat << \
EOF
word1
word2
word3
EOF
)
echo $MULTILINE
