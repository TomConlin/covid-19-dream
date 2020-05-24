#!/usr/bin/gawk -f
# table-header2graphviz.awk
# scripts/table-header2graphviz.awk table-columns.list > syndat_schema.gv
#########################################################

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
    fk[table,$1]++
}

# property/attribute
/^[0-9]+:[a-z_]+/ && !/.*_id$/ {
    tab[table]++
    db[table,$1] = $2 
}

END {
    print "digraph \"" ARGV[1] "\" {\n\trankdir = \"LR\""

    print "\t# nodes" 
    for(t in tab){
        lab = t
        for(i=1;i<=tab[t];i++){
            col = db[t,i]
            if((t SUBSEP i) in fk)
                port =  "<" col "> "
            else
                port = ""
            lab = lab " | " port col
        }    
        print "\t" t "[\n\t\tlabel = \"" lab "\"\n\t\tshape = \"Mrecord\"\n\t];";
    }

    print "\t# directed edges  (foreign keys)"
    for(t in tab){
        for(i=1;i<=tab[t];i++){
            if(!((t SUBSEP i) in fk)) continue;
            col = db[t,i]
            src = substr(col, 1, length(col)-3)
            if((src != t) && (src in tab))
                print "\t" t ":" col " -> " src ":" src "_id;\n" 
        }     
    }

    print "\t# casual/tenous edges (shared keys for FKs to tables not included?)"
    for(t in tab){
        for(i=1;i<=tab[t];i++){
            if(!((t SUBSEP i) in fk)) continue;
            col = db[t,i]
            src = substr(col, 1, length(col)-3)
            if(!(src in tab)) {
                for(s in tab) {
                    # arbititrary may be worse than 'both' for graph layout infulence
                    if(s == t) continue;
                    for(j=1;j<=tab[s];j++)
                        if(col == db[s,j])                    
                            print "\t" t ":" col " -> " s ":" col " [color=\"gray\"];\n"
                } 
            }
        }     
    }
  

    print "\n}" 
}
