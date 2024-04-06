#!/usr/bin/env fish

for statement in ~/Documents/Account\ Statements/*
    set -l statement_path (readlink -f $statement)
    set -l rand (random)
    set -l destination_path ~/Documents/Account\ Statements\ Backup/(echo (basename $statement) | sd 'txt' 'csv')
    
    echo -e "\n" + $statement + "\n"
    command cat $statement_path | 
    sd '\s+,' ',' | 
    sd ',\s+' ',' | 
    sd '^\s+' '' > /tmp/$rand

    if python ~/work/is_valid_csv.py /tmp/$rand
        cat /tmp/$rand | python ~/work/csv_date_formatter.py > $destination_path
    end
end
