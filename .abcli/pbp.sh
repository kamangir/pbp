#! /usr/bin/env bash

function bp() {
    pbp "$@"
}

function pbp() {
    local task=$(abcli_unpack_keyword $1 help)

    if [ $task == "help" ]; then
        pbp_digest "$@"

        local task
        for task in pylint pytest test; do
            pbp $task "$@"
        done

        if [ "$(abcli_keyword_is $2 verbose)" == true ]; then
            python3 -m pbp --help
        fi
        return
    fi

    local function_name=pbp_$task
    if [[ $(type -t $function_name) == "function" ]]; then
        $function_name "${@:2}"
        return
    fi

    if [ "$task" == "init" ]; then
        abcli_init pbp "${@:2}"

        [[ $(abcli_conda exists pbp) == 1 ]] &&
            conda activate pbp
        return
    fi

    if [[ "|pylint|pytest|test|" == *"|$task|"* ]]; then
        abcli_${task} plugin=pbp,$2 \
            "${@:3}"
        return
    fi

    if [ "$task" == "version" ]; then
        python3 -m pbp version "${@:2}"
        return
    fi

    python3 -m pbp \
        "$task" \
        "${@:2}"
}

abcli_source_path \
    $abcli_path_git/pbp/.abcli/tests

abcli_env dot load \
    plugin=pbp
abcli_env dot load \
    filename=pbp/config.env,plugin=pbp
