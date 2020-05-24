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


BEGIN { FS=":" }

# table
/^[a-z_]+*\.csv$/ {
    table = substr($1, 1, length($1)-4)
    tab[table]
}

# key
/^[0-9]+:[a-z_]+_id$/ {
    tab[table]++
    db[table,$1] = $2
    key[table,$1]++
}

# property/attribute
/^[0-9]+:[a-z_]+/ && !/.*_id$/ {
    tab[table]++
    db[table,$1] = $2 
}


END {
    # tables 
    for(t in tab){
        ddl = "DROP TABLE IF EXISTS " t ";\n"
        ddl = ddl "CREATE TABLE " t "(\n"
        con = ""
        for(i=1;i<=tab[t];i++){
            col = db[t,i]
            ddl = ddl"\t" col     
            if(((t SUBSEP i) in key)){
                src = substr(col, 1, length(col)-3)
                if(src in tab && src != t){
                    ddl = ddl " INTEGER NOT NULL"
                    con = con "\tFOREIGN KEY(" col ") REFERENCES " src " (" col "),\n"                
                }
                if(src == t)  # primary key?
                    ddl = ddl " INTEGER NOT NULL UNIQUE PRIMARY KEY"
            }
            ddl = ddl ",\n"    
        }
        if(con != ""){ 
            con = substr(con,1,length(con)-2)
            ddl = ddl con            
        }else{
            ddl = substr(ddl,length(ddl)-2)
        }
        print ddl "\n);" 
    }
}

