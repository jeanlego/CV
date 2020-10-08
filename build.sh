#!/bin/bash
OUTPUT="Jean-Philippe Legault"
MAIN_SRC="main.tex"

read -a RUN_ARGS < <(echo "$*" | tr '\n' ' ' | tr ',' ' ' | tr -s '[:space:]' )

rm -R "${RUN_ARGS[*]}"
mkdir -p "${RUN_ARGS[*]}" &> /dev/null || /bin/true
{ 
    for field in "${RUN_ARGS[@]}";
    do 
        echo "\def\\$field{}"
    done; 
    echo "\input{${MAIN_SRC}}"
} > "${RUN_ARGS[*]}/${OUTPUT}.tex"

export TEXINPUTS=.:${PWD}:$TEXINPUTS
export BIBINPUTS=${PWD}

pushd "${RUN_ARGS[*]}"
latexmk -gg -CF -f -cd -lualatex "${OUTPUT}.tex"
