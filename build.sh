#!/bin/bash

source ./setup.conf

declare -a BUILD_MATRIX
for _types in "${BUILD_TYPES[@]}";
do
    # default no cover letters is also a type
    BUILD_MATRIX+=( "${_types}" )
    for _letter in "${COVER_LETTERS[@]}";
    do
        BUILD_MATRIX+=( "${_types},${_letter}" )
    done
done

case "_$@" in
    _|_all)
        ;;
    _*)
        # check if it exist
        if echo "${BUILD_MATRIX[@]}" | grep -E "$*"
        then
            BUILD_MATRIX=( "$*" )
        fi
        ;;
esac

echo "building ("
echo "${BUILD_MATRIX[@]}" | xargs -n1 | xargs -I{} echo "    {}"
echo ")"

declare -a PARALEL_MATRIX
for _types in "${BUILD_MATRIX[@]}";
do
    IFS=',' read -r -a ARGS < <(echo ${_types})
    TYPE="${ARGS[0]}"
    COVER_LETTER="${ARGS[1]}"

    # rebrand into something unique and readable
    COVER_LETTER_ID=$(basename "${COVER_LETTER}" .tex)
    COVER_LETTER_LOCATION=$(readlink -f "$(dirname "${COVER_LETTER}")")
    if [ "_${COVER_LETTER}" != "_" ] && [ -f "${COVER_LETTER}" ]
    then
        NAME="${TYPE},${COVER_LETTER_ID}"
    else
        NAME="${TYPE}"
    fi
    echo "setup $NAME"

    PARALEL_MATRIX+=( "${NAME}" )

    rm -R "./build/$NAME" &> /dev/null || /bin/true
    mkdir -p "./build/$NAME" &> /dev/null || /bin/true

    { 
        echo "\def\\$TYPE{}"
        [ "_${COVER_LETTER}" != "_" ] && [ -f "${COVER_LETTER}" ]  && echo "\def\\coverLetter{$COVER_LETTER}"
        echo "\input{$SOURCE}"
    } > "./build/$NAME/$NAME.tex"
    
    echo "
#!/bin/bash

rm ${OUTPUT_DIR}/$NAME.pdf
export TEXINPUTS=.:${PWD}:${COVER_LETTER_LOCATION}:$TEXINPUTS
export BIBINPUTS=${PWD}

set -xe

pushd ./build/$NAME/
latexmk ${LATEXMK_ARGS[*]} $NAME.tex
popd
mv ./build/$NAME/$NAME.pdf ${OUTPUT_DIR}

" > "./build/$NAME/build.sh"

done

# cleanup
rm ./*.pdf

echo ./build/*/build.sh | xargs -n1 | xargs -P "$(nproc --all)" -n1 -I {} /bin/bash {}
