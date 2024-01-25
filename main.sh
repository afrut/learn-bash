#!/bin/bash

# Define a function
some_func() {
    echo "$1 received in some_func"
}

# Run all commands in envars in this script
source envars

echo "----------------------------------------"
echo "  Output to stdout"
echo "----------------------------------------"
# Print the contents of the MSG environment variable to console
echo $MSG

# Print something to console without newline
printf "I'm alive\n"

# Print with format specifiers
printf "%s %d\n" "hello" 1

# Single quotes vs double quotes. Single quotes are literal strings. Double
# quotes perform variable expansion.
echo 'Single quotes: ${PLAY_AREA}'
echo "Double quotes: ${PLAY_AREA}"

echo "----------------------------------------"
echo "  Working with files and directories"
echo "----------------------------------------"
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

# Redirect stdout and stderr to append to a file
ls -lt playarea &> "./playarea/redirected.txt"
ls -lt non_existent_dir &>> "./playarea/redirected.txt"

# Discard stdout and stderr
ls --help &> /dev/null

# -- signals the end of optional arguments
ls -- --help # fails because --help is interpreted as a directory name

# Returns the name of script, ie "./main.sh"
echo "${BASH_SOURCE[0]}"

# Execute a command after the successful execution of another
mkdir deleteme &&\
    echo "Hello, World!" > "./deleteme/deleteme_file.txt" &&\
    cat "deleteme/deleteme_file.txt"

# Recursively remove a directory
rm -rf deleteme

# Get the parent directory of a file
echo $(dirname "./playarea/foo.txt")

# Get the directory containing this script
#                                  "${BASH_SOURCE[0]}"                          # The name of this script
#                       dirname -- "${BASH_SOURCE[0]}"                          # The name of the directory containing this script
#             cd -- "$( dirname -- "${BASH_SOURCE[0]}" )"                       # Navigate into the directory containing this script
#             cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null          # Navigate into the directory containing this script and discard output
#             cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd   # After navigating into directory, get the current working directory
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd ) # Then store it in a variable

# Create an indexed array
iarray=("a" "b" "c" "d" "e")

# Access the second element of an indexed array
echo "${iarray[1]}"

# Echo all elements of an indexed array
echo "${iarray[@]}"

# Loop through an array
str=""
for letter in ${iarray[@]}; do
    # Concatenate strings
    str="${str}${letter}"
done
echo "${str}"

# Create an associative array in bash
declare -A aarray
aarray["a"]=1
aarray["b"]=2
aarray["c"]=3

# Access a value via key
echo "${aarray[b]}"

# Access all keys of an associative array
echo "${!aarray[@]}"

# Loop through all keys of an associative array and access their values
for k in ${!aarray[@]}; do
    echo "aarray[${k}] = ${aarray[${k}]}"
done

echo "---------- Walk the directory tree and return all files and directories ----------"
find playarea

echo "---------- Return only matching glob results ----------"
find playarea -name "foo*"

echo "---------- Inverse glob matching ----------"
find playarea ! -name "foo*"

echo "---------- Return only regular files ----------"
find playarea -type f

echo "---------- Return only directories ----------"
find playarea -type d

# {} is replaced by every output of find
# \; ends the arguments of -exec flag
echo "---------- Execute a command on each result ----------"
find playarea -type f -exec echo 'foo --- {} --- bar' \;

echo "---------- Execute one command with all results as arguments ----------"
find playarea -type f -exec echo {} + ;

# xargs converts output to stdout to command arguments
echo "---------- Execute a command on each result using xargs ----------"
find playarea -type f | xargs cat

# Get the 3rd column of a command's output. -F specifies the delimiter
printf "foo    bar    baz    qaz\nspam   ham    eggs   bacon\n" \
    | awk -F ' ' '{print $3}'

# Terminate the script with no errors
exit 0