@AbapCatalog.sqlViewName: 'ZEXTRCOMP'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Analytics.dataExtraction: {
  enabled: true
}
@EndUserText.label: 'Extractor Componenets'
define view Z_ExtractorComponents as
select
    key t.hier,
    key t.applnm,
    t.name,
    t.parent,
    t.child,
    t.next_appl,
    txt.txtlg as description
from
    rodsappl t
    left outer join rodsapplt txt on (
        t.hier = txt.hier
        and t.objvers = txt.objvers
        and t.applnm = txt.applnm
    )
where
    t.objvers = 'A'
    and txt.langu = 'E'
