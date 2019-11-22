#!/bin/bash
ag --nogroup --only-matching --filename --nonumbers '(?<=SCQF Credits</td>)\s*<td[^>]*width="35%"[^>]*>[[:print:][:cntrl:]]*?</td>' $@ |
    sed -E 's/\s*<td[^>]*>(.+)<\/td>/\1/' |
    tr ':' ' '
