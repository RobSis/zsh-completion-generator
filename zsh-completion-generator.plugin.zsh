#!/usr/bin/env zsh

# date +%H:%M:%S.%N   # profiling info
# Parse getopt-style help texts for options
# and generate zsh(1) completion functions.
# http://github.com/RobSis/zsh-completion-generator

ZSH_COMPLETION_GENERATOR_SRCDIR=${0:A:h}
if [ -z $GENCOMPL_FPATH ]; then
    ZSH_COMPLETION_GENERATOR_DIR="$ZSH_COMPLETION_GENERATOR_SRCDIR/completions"
else
    ZSH_COMPLETION_GENERATOR_DIR="$GENCOMPL_FPATH"
fi
# don't overwrite existing functions
fpath=($fpath $ZSH_COMPLETION_GENERATOR_DIR)

# which python to use
local python
if [ -z $GENCOMPL_PY ]; then
    python=python
else
    python=$GENCOMPL_PY
fi
mkdir -p $ZSH_COMPLETION_GENERATOR_DIR

# define default programs here:
local programs
programs=( "cat" "nl" "tr" "df --help" )

for prg in "${programs[@]}"; do
    local name=$prg
    local help=--help
    if [[ $prg =~ " " ]]; then
        local i
        i=( "${(s/ /)prg}" )
        name=$i[1]
        if [ -n "$i[2]" ]; then
            help="$i[2]"
        fi
    fi

    test -f $ZSH_COMPLETION_GENERATOR_DIR/_$name ||\
        $name $help 2>&1 | $python $ZSH_COMPLETION_GENERATOR_SRCDIR/help2comp.py $name >\
            $ZSH_COMPLETION_GENERATOR_DIR/_$name || rm -f $ZSH_COMPLETION_GENERATOR_DIR/_$name
done

# or use function in shell:
gencomp() {
    if [ -z "$1" ]; then
        echo "Usage: gencomp program [--argument-for-help-text]"
        echo
        return 1
    fi

    local help=--help
    if [ -n "$2" ]; then
        help=$2
    fi

    $1 $help 2>&1 | $python $ZSH_COMPLETION_GENERATOR_SRCDIR/help2comp.py $1 >\
        $ZSH_COMPLETION_GENERATOR_DIR/_$1 || ( rm -f $ZSH_COMPLETION_GENERATOR_DIR/_$1 &&\
            echo "No options found for '$1'." )
}
# date +%H:%M:%S.%N   # profiling info
