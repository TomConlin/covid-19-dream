/*  gen_db_tab_col_meta.sql

    Generate metadata on all columns in a Sqlite database
        table name
        column name
        column datatype
        column count
        column unique count

    For inspiration see:
    https://sqlite.org/pragma.html

    SELECT * FROM sqlite_master WHERE type = 'table';
    type|name|tbl_name|rootpage|sql
    
    SELECT * FROM pragma_table_info(("person"));  -- person is some tab name in your DB
    cid|name|type|notnull|dflt_value|pk
    
    cid might be usable as column number
    including nullable could be useful in some cases


call as:

.read gen_db_tab_col_meta.sql

results found in:

db_tab_col_meta.tab

*/

.headers off
.once 'db_tab_col_meta_generated.sql'
SELECT 'select '||
    ''''||m.name||''''||','|| 
    ''''||p.name||''''||','||  
    ''''||p.type||''''||',count(' || 
    p.name || '),count(distinct ' || 
    p.name || ') from ' || 
    m.name || ';'
  FROM sqlite_master m
  LEFT OUTER JOIN pragma_table_info((m.name)) p ON m.name <> p.name
WHERE m.type = 'table' 
  and m.name is not NULL 
  and p.name is not NULL
  and p.type is not NULL
 ORDER BY m.name, p.cid
;
.mode tabs
.output 'db_tab_col_meta.tab'
select 'table','column', 'datatype', 'count', 'unique';
.read 'db_tab_col_meta_generated.sql'
.output stdout


