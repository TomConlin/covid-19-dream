#!/usr/bin/gawk -f
# tab-col-unq_to_po.awk

# selectivly output "tables:column" pairs
# in plausably dependent order for common column names
# use case is:
# eliminating unsupported foreign key orders
# for partal db dump with unspecified schema 
#
# tab-col-unq_to_po.awk
######################################################

{   tab[$1]++; 
    col[$2]++; 
    cnt[$1,$2]=$3
}
END {
    for(t in tab) {
        for(c in col) {
            if(col[c] < 2) continue;                    # must be unambigous
            if(!((t SUBSEP c) in cnt)) continue;        # nothing to see
            for(s in tab) {
                if(!((s SUBSEP c) in cnt)) continue;    # nothing to see
                if(cnt[s,c] > cnt[t,c])
                    print t":"c "\t" s ":" c
            }
        }
    }
}

#
# note: not putting case specific bits here so scary ugly preprocess  
#awk 'BEGIN{OFS="\t"}substr($2, (length($2)-2))=="_id"{t[$1];rt[NR]=$1;rc[NR]=$2;ru[NR]=$5;}END{for(i=1;i<=NR;i++){if(!(substr(rc[i],1,length(rc[i])-3) in t)) print rt[i],rc[i],ru[i]}}' db_tab_col_meta.tab | scripts/tab-col-unq_to_po.awk

#observation:value_as_concept_id	measurement:value_as_concept_id
#observation:unit_concept_id	measurement:unit_concept_id


