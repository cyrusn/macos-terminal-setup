#!/usr/bin/env bash

set list \
    "7B5JgR-LAyY" \
    "vlPTbFfhJIo"\
    "pvsiKZaHVmc" 

set location "/Desktop"

for id in $list
    youtube-dl --format mp4 -o "~/$location/%(title)s.%(ext)s" "https://www.youtube.com/watch?v="$id
end
    # youtube-dl --extract-audio --audio-format=m4a -o "~/$location/%(title)s.%(ext)s" "https://www.youtube.com/watch?v="$id
