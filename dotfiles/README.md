# .dotfile
my dotfile setting


``` sh
#! /bin/bash

exclude=".git"

for file in ~/.dotfile; do
	if [${file} != ${exclude} ]; then
		ln -s ${file} ~/
	fi

done
```
