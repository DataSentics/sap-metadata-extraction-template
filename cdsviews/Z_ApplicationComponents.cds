@AbapCatalog.sqlViewName: 'ZAPPCOMP'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Analytics.dataExtraction: {
  enabled: true
}
@EndUserText.label: 'Application Componenets'
define view Z_ApplicationComponents as
select
    key t.fctr_id as id,
    t.ariid,
    t.ps_posid as name,
    (length(t.ps_posid) - length(replace(t.ps_posid, '-', '')) ) as nesting_level,
    t.incomplete,
    txt.name as description
from
    df14l t
    left outer join df14t txt on (t.fctr_id = txt.fctr_id)
where
    t.as4local = 'A'
    and txt.as4local = 'A'
    and txt.langu = 'E'
