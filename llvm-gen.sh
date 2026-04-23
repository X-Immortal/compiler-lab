#!/usr/bin/env bash
set -euo pipefail

if [ "$#" -eq 0 ]; then
    echo "usage: bash llvm-gen.sh <file1.sy> [file2.sy ...]" >&2
    exit 1
fi

normalize_llvm_ir() {
    local ll_file="$1"

    sed -E -i \
        -e "s#^; ModuleID = '.*'#; ModuleID = 'module'#" \
        -e 's#^source_filename = ".*"#source_filename = "module"#' \
        -e '/^; Function Attrs: /d' \
        -e '/^target datalayout = /d' \
        -e '/^target triple = /d' \
        -e '/^attributes #[0-9]+ = /d' \
        -e '/^!llvm\.module\.flags = /d' \
        -e '/^!llvm\.ident = /d' \
        -e '/^![0-9]+ = /d' \
        -e 's/\bdso_local //g' \
        -e 's/\bnoundef //g' \
        -e 's/\bnsw\b//g' \
        -e 's/\bnuw\b//g' \
        -e 's/ #[0-9]+ \{/{/g' \
        -e 's/, align [0-9]+//g' \
        -e 's/, !llvm\.loop ![0-9]+//g' \
        -e 's/[[:space:]]+$//' \
        "$ll_file"

    perl -0pi -e '
        s/\)\{/) {/g;
        s/:  +;/: ;/g;
        s/ = ([[:alpha:]\.]+) {2,}/ = $1 /g;
        s/\n{3,}/\n\n/g;
    ' "$ll_file"
}

for f in "$@"; do
    c_file="${f%.sy}.c"
    ll_file="${f%.sy}.ll"
    cp "$f" "$c_file"
    clang -w -S -emit-llvm -fno-discard-value-names -O0 -g0 "$c_file" -o "$ll_file"
    normalize_llvm_ir "$ll_file"
    rm -f "$c_file"
done
