#!/bin/usr/env bash
#
# Makes less output syntax highlighted

export LESSOPEN="| /usr/share/source-highlight/src-hilite-lesspipe.sh %s"
# export LESS=" -R "
