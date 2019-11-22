#!/bin/bash
ag --group --nonumbers -o '(?<=Co-requisites</td>)<td[^>]*width="35%"[^>]*>[[:print:][:cntrl:]]*?</td>' $@ |
    ag -o '(\bcx\w+.htm\b|^$|\(|\)|\bOR\b|\bAND\b|\bRECOMMENDED\b|\bMUST\b)' |
    sed -E 's/^$/:/' | tr "\n:" " \n" | sed -E 's/\( \)//g'
echo ""
