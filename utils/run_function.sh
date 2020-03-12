#!/bin/bash

function=$(basename $0)
dir=$(dirname $0)


if [[ -L $0 ]]; then
    if [[ -f $dir/environment.sh ]]; then
        (
            source $dir/environment.sh
            $function $@
        )
    else
        echo No environment file in \'$path\' >&2
        exit 3
    fi
else
    if [[ -n "$1" ]]; then
        if [[ -f ./environment.sh ]]; then
            (
                source ./environment.sh
                $@
            )
        else
            echo No environment file in \'$path\' >&2
            exit 3
        fi
    else
        echo Usage: $(basename $0) function [ args ] >&2
        exit 3
    fi
fi
