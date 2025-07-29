@AbapCatalog.viewEnhancementCategory: [ #NONE ]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'DATA SOURCE 1'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType: {
serviceQuality: #X,
sizeCategory: #S,
dataClass: #MIXED

}
define view entity z_i_datasource1 
 as select from zdatasource_1
{
    key  id          as Id,
         name1       as Name1,
         datasource1 as Datasource1
}
