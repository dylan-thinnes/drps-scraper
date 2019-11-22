#!/bin/bash
ag --nogroup --only-matching --filename --nonumbers '(?<=Credit level \(Normal year taken\)</td>)\s*<td[^>]*width="35%"[^>]*>[[:print:][:cntrl:]]*?</td>' $@ |
    sed -E 's/^(.+\.htm):.*Level ([0-9]+).*$/\1 \2/'
