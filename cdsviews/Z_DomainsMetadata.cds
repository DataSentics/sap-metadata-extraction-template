@AbapCatalog.sqlViewName: 'ZDOMMETADATA'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Analytics.dataExtraction: {
  enabled: true
}
@EndUserText.label: 'All domname values with descriptions'
define view Z_DomainsMetadata as
select
    domname,
    valpos,
    domvalue_l as value,
    ddtext as description
from
    dd07t
where
    ddlanguage = 'E'
