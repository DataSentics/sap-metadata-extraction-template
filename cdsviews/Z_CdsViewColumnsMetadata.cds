@AbapCatalog.sqlViewName: 'ZCDSCOLMETADATA'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Analytics.dataExtraction: {
  enabled: true
}
@EndUserText.label: 'CDSView columns metadata' 
define view Z_CdsViewColumnsMetadata as 
select
  key colmetadata.strucobjn,
  key colmetadata.fieldname,
  colmetadata.position,
  colmetadata.keyflag,
  colmetadata.rollname,
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
  colmetadata.fieldname_raw,
  names_mapping.tabname as table_name,
  names_mapping.fieldname as table_fieldname,
  names_mapping.rollchange,
  txt.ddtext as description
from
  dd03nd colmetadata
  join ddldependency vnm on (
    colmetadata.strucobjn = vnm.ddlname
    and vnm.objecttype = 'VIEW'
    and vnm.state = 'A'
  )
  join dd27s names_mapping on (
    vnm.objectname = names_mapping.viewname
    and colmetadata.fieldname = names_mapping.viewfield
    and colmetadata.as4local = names_mapping.as4local
    and (names_mapping.mcfieldid = '' or names_mapping.mcfieldid = '1') -- CDSViews with UNION ALL (P_RevenueAccountingItem) have multiple rows with the same fieldname
  )
  left outer join dd04t txt on (
    colmetadata.rollname = txt.rollname
    and txt.ddlanguage = 'E'
    and txt.as4local = 'A'
  )
