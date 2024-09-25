@AbapCatalog.sqlViewName: 'ZEXTRMETADATA'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Analytics.dataExtraction: {
  enabled: true
}
@EndUserText.label: 'Extractor metadata' 
define view Z_ExtractorsMetadata as
select
  roosource.oltpsource,
  roosource.extractor,
  roosource.exstruct,
  roosource.type,
  roosource.applnm,
  tadir.devclass,
  tdevc.component,
  roosource.delta,
  roosource.exmethod,
  roosource.virtcube,
  txt.ddtext as description
from
  roosource
  join tadir on (roosource.exstruct = tadir.obj_name and (tadir.object = 'TABL' or tadir.object = 'VIEW'))
  join tdevc on (tadir.devclass = tdevc.devclass) /* left join makes no difference here - tested */
  left outer join dd02t txt on (
    roosource.exstruct = txt.tabname
    and txt.as4local = 'A'
    and txt.ddlanguage = 'E'
  )
where
  roosource.objvers = 'A'
