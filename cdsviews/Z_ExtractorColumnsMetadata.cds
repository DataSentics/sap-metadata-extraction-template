@AbapCatalog.sqlViewName: 'ZEXTRCOLMETADATA'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Analytics.dataExtraction: {
  enabled: true
}
@EndUserText.label: 'Extractor columns metadata' 
define view Z_ExtractorColumnsMetadata as
select
  key roosource.oltpsource,
  key colmetadata.fieldname,
  colmetadata.position,
  keys_fix.keyflag,
  colmetadata.rollname,
  colmetadata.mandatory,
  colmetadata.checktable,
  colmetadata.inttype,
  colmetadata.intlen,
  colmetadata.reftable,
  colmetadata.precfield,
  colmetadata.reffield,
  colmetadata.datatype,
  colmetadata.leng,
  colmetadata.decimals,
  colmetadata.domname,
  roosfield.selection,
  txt.ddtext as description
from
  dd03l colmetadata
  join roosource on (roosource.exstruct = colmetadata.tabname and roosource.objvers = 'A')
  join roosfield on (
    roosfield.oltpsource = roosource.oltpsource
    and roosfield.field = colmetadata.fieldname
    and roosfield.objvers = roosource.objvers
  )
  left outer join dd03l keys_fix on (
    roosource.extractor = keys_fix.tabname
    and keys_fix.fieldname = colmetadata.fieldname
    and keys_fix.keyflag = 'X'
  )
  left outer join dd04t txt on (
    colmetadata.rollname = txt.rollname
    and txt.ddlanguage = 'E'
    and txt.as4local = 'A'
  )
where
  colmetadata.fieldname <> '.INCLUDE'
  and colmetadata.fieldname <> '.INCLU--AP'
  and colmetadata.fieldname <> '.INCLU-_R'
