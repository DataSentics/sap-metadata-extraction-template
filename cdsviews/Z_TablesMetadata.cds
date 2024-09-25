@AbapCatalog.sqlViewName: 'ZTBLMETADATA'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Analytics.dataExtraction: {
  enabled: true
}
@EndUserText.label: 'Tables metadata'
define view Z_TablesMetadata as
select
    dd02l.tabname as table_name,
    tadir.devclass,
    tdevc.component,
    dd02l.tabclass,
    dd02l.contflag as delivery_class,
    dd02l.viewref as view_reference,
    txt.ddtext as description
from
    dd02l
    join tadir on (dd02l.tabname = tadir.obj_name and tadir.object = 'TABL')
    join tdevc on (tadir.devclass = tdevc.devclass) /* left join makes no difference here - tested */
    left outer join dd02t txt on (dd02l.tabname = txt.tabname)
where
    dd02l.as4local = 'A'
    and dd02l.tabclass != 'VIEW'
    and tadir.devclass != '$TMP'
    and dd02l.contflag != ''
    and dd02l.contflag != 'L' /* Table for storing temporary data */
    and dd02l.contflag != 'W' /* System table, contents transportable with own name range */
    and txt.as4local = 'A'
    and txt.ddlanguage = 'E'
