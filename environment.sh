#!/bin/bash

function script_paths() {
    find ${GRM_SCRIPTS:?} -type f -name 'environment.sh' | while read; do
        dirname $REPLY
    done | tr '\n' :
}

