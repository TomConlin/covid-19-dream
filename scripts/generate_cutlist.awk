#!/usr/bin/gawk -f
# generate_cutlist.awk 

# ex:
# generate_cutlist.awk constant_columns_tocut.tab table-columns.list > cutlist.sourceme

#  generate a "cutlist" from a list to cut
#   "constant_columns_tocut.tab"
#       (grep "[^0-9]1$" db_tab_col_meta.tab.orig |  cut -f 1,2 )
# where we find useless tables and column nanes to cut
#
# and the full indexed names list 
#    "table-columns.list"   
#       (for f in *.csv ; do echo $f; head -1 $f| tr ',' '\n' | grep -n . ;done)
# where we can get file (table) name and index of column name
#
# want: 
# cut -f ... data/synthetic_data/${table}.csv > data/filtered/${table}.csv
# where this script fills in the '...'
 

BEGIN{}

NR==FNR { cut[$1,$2]++ }

NR!=FNR && /^[^0-9]/ {  # table names don't begin with numbers
    FS=":"
    if(table){
        keep = substr(keep, 1, length(keep)-1)
        print "cut -d',' -f'" keep "' data/synthetic_data/"table ".csv > data/filtered/"table".csv"
    }
    keep = ""
    table = substr($1, 1, length($1)-4)
}

NR!=FNR && /^[0-9]+:[a-z_]+/{  # column names begin with a numeric index
    if(!((table SUBSEP $2) in cut))
        keep = keep $1 ","
    # else print "DROP " $2  " in " table "> /dev/stderr"
}
END{
    keep = substr(keep, 1, length(keep)-1)
    print "cut -d',' -f'" keep "' data/synthetic_data/"table ".csv > data/filtered/"table".csv"
}

