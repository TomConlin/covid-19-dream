#! /usr/bin/awk -f

# given a directory of files with headers 
# where columns are syntaticly coherent
# such that  `<tablename>_id` refers to 
# the primary key in the table named 'tablename'
# where the primary key is allways the table's name 
# with '_id' appended.
#
#Generate a list with:
# for f in <dir>/*; do echo ${f##*/}; head -1 $f|
#   tr ',' '\n' | grep -n . ; done > table-columns.list

# rough out a relational schema


BEGIN{
    FS=":"
}
# table
/^[a-z_]+*\.csv$/ {
    if(ddl)
        print ddl "\n);";
    table = substr($1, 1, length($1)-4)
    ddl = "create table " table "(" 
}

# key
/^[0-9]+:[a-z_]+_id$/{

    key = $2
    src = substr(key, 1, length(key)-3)
    if(src == table)  # primary key
        ddl = ddl "\n\t" key " unique not null primary key;"       
    else if(key)      # foreign key
        ddl = ddl ",\n\t" key " foreign key references " src "(" src "_id)"
}

# attribute
/^[0-9]+:[a-z_]+[^id_]{3}$/{
    FS=":"
    ddl = ddl ",\n\t" $2  
}
