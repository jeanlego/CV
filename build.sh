#!/usr/bin/env bash

source ./setup.conf
PWD="$(pwd)"
ALLOWED_TYPES=()
for f in src/CV/*.tex; do
    ALLOWED_TYPES+=( "$(basename "$f" .tex)" )
done

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

rm -Rf ./build || true
declare -a PARALEL_MATRIX
for _types in "${BUILD_MATRIX[@]}";
do
    TYPE="${_types%%,*}CV"
    COVER_LETTER="${_types##*,}"
    # rebrand into something unique and readable
    COVER_LETTER_ID=$(basename "${COVER_LETTER}" .tex)
    COVER_LETTER_LOCATION=$(readlink -f "$(dirname "${COVER_LETTER}")")
    if [ "_${COVER_LETTER}" != "_" ] && [ -f "${COVER_LETTER}" ]
    then
        NAME="${TYPE}-${COVER_LETTER_ID}"
    else
        NAME="${TYPE}"
    fi
    echo "setup $NAME"

    PARALEL_MATRIX+=( "${NAME}" )

    mkdir -p "./build/$NAME" &> /dev/null || /bin/true

    { 
        echo "\def\\$TYPE{}"
        [ "_${COVER_LETTER}" != "_" ] && [ -f "${COVER_LETTER}" ]  && echo "\def\\coverLetter{$COVER_LETTER}"
        echo "\input{src/CV/${_types%%,*}}"
    } > "./build/$NAME/$NAME.tex"
    
    echo "
#!/usr/bin/env bash

export TEXINPUTS=.:${PWD}:${COVER_LETTER_LOCATION}:$TEXINPUTS
export BIBINPUTS=${PWD}

cd ./build/$NAME/
exec latexmk ${LATEXMK_ARGS[*]} $NAME.tex
" > "./build/$NAME/build.sh"

done

echo ./build/*/build.sh | xargs -n1 | xargs -P "$(nproc --all)" -I {} /bin/bash {}
rm ./*.pdf || true
cp ./build/*/*.pdf ./
