#! /usr/bin/env bash

function pbp_digest() {
    local options=$1

    if [ $(abcli_option_int "$options" help 0) == 1 ]; then
        local options="dryrun,init,push"
        abcli_show_usage "pbp digest [$options]" \
            "digest pbp."
        return
    fi

    local do_dryrun=$(abcli_option_int "$options" dryrun 0)
    local do_init=$(abcli_option_int "$options" init 0)
    local do_push=$(abcli_option_int "$options" push 0)

    abcli_eval dryrun=$do_dryrun \
        python3 -m pbp digest \
        --digest_filename $abcli_path_git/assets/digest.yaml \
        --source_path $abcli_path_git/pbp \
        --destination_filename $abcli_path_git/pbp/.abcli/pbp_digest.sh \
        "${@:2}"

    [[ "$do_init" == 1 ]] &&
        abcli_init pbp

    if [[ "$do_push" == 1 ]]; then
        abcli_git push \
            pbp \
            accept_no_issue \
            "$(python3 -m pbp version) digest"
    else
        abcli_git pbp status
    fi
}
