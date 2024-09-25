@AbapCatalog.sqlViewName: 'ZTBLFK'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Table foreign keys'
define view Z_TableForeignKeys as
select
    key dd08l.tabname,
    key dd08l.fieldname,
    key dd08l.as4vers,
    dd08l.checktable,
    dd08l.frkart,
    dd08l.clasfield,
    dd08l.clasvalue,
    dd08l.cardleft,
    dd08l.card,
    dd08l.checkflag,
    dd08l.arbgb,
    dd08l.msgnr,
    dd08l.noinherit,
    dd08t.ddtext as description
from
    dd08l
    join Z_TablesMetadata tm on (dd08l.tabname = tm.table_name)
    left outer join dd08t on (
        dd08l.tabname = dd08t.tabname
        and dd08l.fieldname = dd08t.fieldname
        and dd08l.as4vers = dd08t.as4vers
        and dd08t.ddlanguage = 'E'
        and dd08t.as4local = 'A'
    )
where
    dd08l.as4local = 'A'
