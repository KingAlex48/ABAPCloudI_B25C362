@AbapCatalog.viewEnhancementCategory: [ #NONE ]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'DATA SOURCE 1'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType: {
serviceQuality: #X,
sizeCategory: #S,
dataClass: #MIXED

}
define view entity z_i_datasource2 
 as select from zdatasource_2
{
    key  id          as Id,
         name2       as Name2,
         datasource2 as Datasource2
}
