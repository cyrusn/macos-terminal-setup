#!/usr/bin/env bash

set list \
    "DTXGoyTygD0" \
    "Vsr5gpmmvhs" \
    "TmYvNtx_OqQ" \
    "9lnC9n5obus" \
    "j22AIr5KlTc" 

set location "~/Desktop"

for id in $list
    youtube-dl --extract-audio --audio-format=m4a -o "~/$location/%(title)s.%(ext)s" "https://www.youtube.com/watch?v="$id
end
