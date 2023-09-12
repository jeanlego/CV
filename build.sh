#!/bin/bash

source ./setup.conf

ALLOWED_TYPES=(
    $(basename src/CV/*.tex .tex)
)



declare -a BUILD_MATRIX
for _types in "${BUILD_TYPES[@]}";
do
    if [ ! -f "src/CV/$_types.tex" ]; then
        echo "CV type $_types does not exist."
        exit 1
    fi

    # default no cover letters is also a type
    BUILD_MATRIX+=( "${_types}" )
    for _letter in "${COVER_LETTERS[@]}";
    do
        BUILD_MATRIX+=( "${_types},${_letter}" )
    done
done

echo "building ("
echo "${BUILD_MATRIX[@]}" | xargs -n1 | xargs -I{} echo "    {}"
echo ")"

sleep 2

rm -R ./build
declare -a PARALEL_MATRIX
for _types in "${BUILD_MATRIX[@]}";
do
    IFS=',' read -r -a ARGS < <(echo ${_types})
    TYPE="${ARGS[0]}CV"
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

    mkdir -p "./build/$NAME" &> /dev/null || /bin/true

    { 
        echo "\def\\$TYPE{}"
        [ "_${COVER_LETTER}" != "_" ] && [ -f "${COVER_LETTER}" ]  && echo "\def\\coverLetter{$COVER_LETTER}"
        echo "\input{src/CV/$_types}"
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
