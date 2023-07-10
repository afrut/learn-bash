#!/bin/bash
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
PLAYAREA="./playarea"

# Create a file foo.txt in the playarea directory
touch $PLAYAREA/foo.txt

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

