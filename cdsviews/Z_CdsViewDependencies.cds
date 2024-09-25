@AbapCatalog.sqlViewName: 'ZCDSDEPS'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Analytics.dataExtraction: {
  enabled: true
}
@EndUserText.label: 'CDSViews dependencies'
define view Z_CdsViewDependencies as
select
    parent_view.ddlname as parent_cdsview,
    child_view.ddlname as child_cdsview,
    dd26s.tabname as child_sqlname
from
    dd26s
    join ddldependency parent_view on (
        dd26s.viewname = parent_view.objectname
        and parent_view.objecttype = 'VIEW'
        and parent_view.state = 'A'
    )
    left outer join ddldependency child_view on (
        dd26s.tabname = child_view.objectname
        and child_view.objecttype = 'VIEW'
        and child_view.state = 'A'
    )
where
    dd26s.as4local = 'A' 
    and dd26s.tabname != 'DDDDLCHARTYPES'
    and dd26s.tabname != 'DDDDLNUMTYPES'
    and dd26s.tabname != 'DDDDLCURRTYPES'
    and dd26s.tabname != 'DDDDLDECTYPES'
    and dd26s.tabname != 'DDDDLQUANTYPES'
