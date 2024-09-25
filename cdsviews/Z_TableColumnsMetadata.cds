@AbapCatalog.sqlViewName: 'ZTBLCOLMETADATA'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Analytics.dataExtraction: {
  enabled: true
}
@EndUserText.label: 'Table columns metadata' 
define view Z_TableColumnsMetadata as
select
  key colmetadata.tabname,
  key colmetadata.fieldname,
  colmetadata.position,
  colmetadata.keyflag,
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
  txt.ddtext as description
from
  dd03l colmetadata
  join Z_TablesMetadata tm on (colmetadata.tabname = tm.table_name)
  left outer join dd04t txt on (
    colmetadata.rollname = txt.rollname
    and txt.ddlanguage = 'E'
    and txt.as4local = 'A'
  )
where
  colmetadata.as4local = 'A'
  and colmetadata.fieldname != '.INCLUDE'
  and colmetadata.fieldname not like '.INCLU-%'
