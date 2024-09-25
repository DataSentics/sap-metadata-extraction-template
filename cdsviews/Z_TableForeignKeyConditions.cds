@AbapCatalog.sqlViewName: 'ZTBLFKCOND'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Table foreign key conditions'
define view Z_TableForeignKeyConditions as
select
    key tabname,
    key fieldname,
    key primpos,
    key as4vers,
    fortable,
    forkey,
    forstring
from
    dd05s
    join Z_TablesMetadata tm on (dd05s.tabname = tm.table_name)
where
    dd05s.as4local = 'A'
