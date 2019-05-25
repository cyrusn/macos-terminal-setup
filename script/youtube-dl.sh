#!/usr/bin/env bash

list=(
    # Put the youtube video ids here
)

location='~/Desktop'

for item in ${list[@]}; do
    youtube-download "$item"
done
