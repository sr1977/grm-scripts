#!/bin/bash

values=($(perl -ne 'print "$1\n" if /^  ([a-z-]+)/' /Users/sri01/workspace/orwell/ci-metadata.yaml | grep webui))


select word in "${values[@]}"; do
    echo ${values[$REPLY]}
    exit
done
