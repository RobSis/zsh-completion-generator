#!/usr/bin/env zsh

#date +%H:%M:%S.%N
# Parse getopt-style help texts for options
# and generate zsh(1) completion functions.
# http://github.com/RobSis/zsh-completion-generator

SCRIPT_SOURCE=$(/bin/readlink -f ${0%/*})
directory="$SCRIPT_SOURCE/completions"
# don't overwrite existing functions
fpath=($fpath $directory)

mkdir -p $directory

# which python to use
python=python

# define default programs here:
programs=( "cat" "nl" "tr" "df --help" )


for prg in "${programs[@]}"; do
    name=$prg
    help=--help
    if [[ $prg =~ " " ]]; then
        i=( "${(s/ /)prg}" )
        name=$i[1]
        if [ -n "$i[2]" ]; then
            help="$i[2]"
        fi
    fi

    test -f $directory/_$name ||\
        $name $help 2>&1 | $python $SCRIPT_SOURCE/help2comp.py $name > $directory/_$name || rm -f $directory/_$name
done

# or use function in shell:
gencomp() {
    if [ -z "$1" ]; then
        echo "Usage: gencomp program [--argument-for-help-text]"
        echo
        return 1
    fi

    help=--help
    if [ -n "$2" ]; then
        help=$2
    fi

    $1 $help 2>&1 | $python $SCRIPT_SOURCE/help2comp.py $1 > $directory/_$1 || ( rm -f $directory/_$1 &&\
        echo "No options found for '$1'." )
}
#date +%H:%M:%S.%N   # profiling info
