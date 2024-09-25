@AbapCatalog.sqlViewName: 'ZCDSMETADATA'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Analytics.dataExtraction: {
  enabled: true
}
@EndUserText.label: 'Metadata for CDSViews'
define view Z_CdsViewsMetadata as
select
  sq.ddlname as cds_view_name,
  sq.objectname as sql_view_name,
  ddddlsrct.ddtext as description,
  tadir.devclass as cds_package,
  tdevc.component as application_component,
  raw_names.strucobjn_raw as cds_view_name_raw,
  a_dc.value as analytics_data_category,
  om_dc.value as object_model_data_category,
  view_type.value as view_type,
  service_quality.value as service_quality,
  dataclass.value as dataclass,
  case
    when language_dependent_text.value is not null then 1
    else 0
  end as is_language_dependent_text,
  case
    when cdsexen.viewname is not null then 1
    else 0
  end as extraction_supported,
  case
    when cdsexen.isDeltaSupported = 'true' then 1
    else 0
  end as delta_is_supported
from
  ddldependency as sq
  join tadir on (sq.ddlname = tadir.obj_name and tadir.object = 'DDLS')
  join dd02b raw_names on (raw_names.strucobjn = sq.ddlname and raw_names.as4local = 'A')
  join tdevc on (tadir.devclass = tdevc.devclass and tadir.object = 'DDLS')
  left outer join ddddlsrct on (ddddlsrct.ddlname = sq.ddlname and ddddlsrct.as4local = 'A' and ddddlsrct.ddlanguage = 'E')
  left outer join ddheadanno a_dc on (a_dc.strucobjn = sq.ddlname and (a_dc.name = 'ANALYTICS.DATACATEGORY'))
  left outer join ddheadanno om_dc on (om_dc.strucobjn = sq.ddlname and (om_dc.name = 'OBJECTMODEL.DATACATEGORY'))
  left outer join ddheadanno view_type on (view_type.strucobjn = sq.ddlname and view_type.name = 'VDM.VIEWTYPE')
  left outer join ddheadanno service_quality on (service_quality.strucobjn = sq.ddlname and service_quality.name = 'OBJECTMODEL.USAGETYPE.SERVICEQUALITY')
  left outer join ddheadanno dataclass on (dataclass.strucobjn = sq.ddlname and dataclass.name = 'OBJECTMODEL.USAGETYPE.DATACLASS')
  left outer join ddheadanno language_dependent_text on (language_dependent_text.strucobjn = sq.ddlname and language_dependent_text.name like 'OBJECTMODEL.SUPPORTEDCAPABILITIES%' and language_dependent_text.value = '#LANGUAGE_DEPENDENT_TEXT')
  left outer join DHCDC_AUTH_CdsExtrctnEnabled cdsexen on (cdsexen.viewname = sq.ddlname) 
where
  sq.objecttype = 'VIEW'
  and sq.state = 'A'
