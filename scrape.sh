#!/bin/bash

# Finds all pages of given type
index     () { echo './pages/index.php' ; }
colleges  () { find -regex './pages/[^/]*\.htm' ; }
schedules () { find -regex './pages/[^/]*/[^/]*\.htm' ; }
subjects  () { find -regex './pages/[^/]*/[^/]*/[^/]*\.htm' ; }
courses   () { find -regex './pages/[^/]*/[^/]*/[^/]*/[^/]*\.htm' ; }

# Parent files for given types
college_parents  () { index ; }
schedule_parents () { colleges ; }
subject_parents  () { schedules ; }
course_parents   () { subjects ; }

# Greppers for links of given types
ag_college  () { ./utils/simple_ag.sh '(?<=href=").*?cx_col.+?.html?(?=")' $@ ; }
ag_schedule () { ./utils/simple_ag.sh '(?<=href=")cx_s_.+?.html?(?=")'     $@ ; }
ag_subject  () { ./utils/simple_ag.sh '(?<=href=")cx_sb_.+?.html?(?=")'    $@ ; }
ag_course   () { ./utils/simple_ag.sh '(?<=href=")cx[^_].+?.html?(?=")'    $@ ; }

# Top-level update function
update () {
    local type=$1
    local mock=$2

    generate_commands $1 |
        (if [[ $mock == "" ]]; then parallel; else cat; fi)
}

# Generates mkdir & wget commands from parent files for a specific type
generate_commands () {
    local type=$1

    if [[ $type == "index" ]]
    then
        # Index is just a single wget, into ./pages/index.php
        echo "mkdir -p ./pages; wget 'http://www.drps.ed.ac.uk/19-20/index.php' -O 'pages/index.php'"
    elif [[ $type == "college" ]]
    then
        # Colleges come as hardlinks, must be put in top-level, ./pages
        ag_${type} $(${type}_parents) |
            sed -E '''
s/(https?:\/\/.+)\/(.+\.htm)/mkdir -p .\/pages; wget \1\/\2 -O .\/pages\/\2/
            '''
    else
        # All other types can be converted in a general fashion
        ag_${type} $(${type}_parents) |
            sed -E '''
s/(.+)\.htm:(.+)/mkdir -p \1; wget http:\/\/www.drps.ed.ac.uk\/19-20\/dpt\/\2 -O \1\/\2/
            '''
    fi
}

# Utility functions - gets items of interest from `generate_commands`
extract_urls      () { cut -d ' ' -f 5 ; }
extract_filenames () { cut -d ' ' -f 7 ; }

$@
