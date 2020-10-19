#!/bin/bash

declare -a REGEXES
declare -a FILES
OUTPUT_FILE=""

for _args in "$@"
do
    if [ "_${_args}" != "_" ]
    then
        IFS='=' read -r -a KV < <(echo $_args)
        if (( ${#KV[@]} == 2 ))
        then
            REGEXES+=( 
                "-e" 
                "s/[$][{]${KV[0]}[}]/${KV[1]}/g"
            )
        else
            if [ -f "$OUTPUT_FILE" ]
            then
                FILES+=( "$OUTPUT_FILE" )
            fi
            OUTPUT_FILE="${_args}"
        fi
    fi
done

echo "output is $OUTPUT_FILE"
rm $OUTPUT_FILE

for _files in "${FILES[@]}"
do
    cat "$_files" >> $OUTPUT_FILE
done

sed -i -r "${REGEXES[@]}" "$OUTPUT_FILE"