#!/bin/bash
{ rm -R "$*" && mkdir -p "$*"; } &> /dev/null
read -r -a RUN_ARGS < <(echo "$*" | tr '\n' ' ' | tr ',' ' ' | tr -s '[:space:]' )
{ 
    for field in "${RUN_ARGS[@]}";
    do 
        echo "\def\\$field{}"
    done; 
    echo "\input{main.tex}"
} > "$*/_main.tex"
