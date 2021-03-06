#!/usr/bin/env bash

set -u
set -o pipefail

unset CDPATH
# one-liner from http://stackoverflow.com/a/246128
# Determines absolute path of the directory containing
# the script.
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Let the user start this script from anywhere in the filesystem.


CONTINUUM_ROOT=$DIR/..
echo "Continuum root: $CONTINUUM_ROOT"
cd  $CONTINUUM_ROOT

# Run clang-format on cpp/hpp files
find ./src -not \( -path ./src/libs -prune \) -name '*pp' -print \
    | xargs clang-format -style=file -i

# Run clang-format on Java files
# find ./src -not \( -path ./src/libs -prune \) -name 'java' -print \
#     | xargs clang-format -style=file -i

find . -name '*.java' -print | xargs clang-format -style=file -i

# Run Python formatter
export PYTHONPATH=$CONTINUUM_ROOT/bin/yapf
find . -name '*.py' -print | egrep -v "yapf|ycm|googletest" \
    | xargs python $CONTINUUM_ROOT/bin/yapf/yapf -i

exit 0
