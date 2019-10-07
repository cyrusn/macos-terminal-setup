#!/bin/bash

echo "Installing python packages ..."
while read -r line; do
    pip3 install "$line"
done < "apps/pip.txt"
