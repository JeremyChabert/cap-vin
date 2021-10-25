using retailer as service from  '../srv/retailer';

annotate service.Cepage with @Capabilities : {NavigationRestrictions : {
  $Type                : 'Capabilities.NavigationRestrictionsType',
  RestrictedProperties : [{
    $Type              : 'Capabilities.NavigationPropertyRestriction',
    InsertRestrictions : {
      $Type      : 'Capabilities.InsertRestrictionsType',
      Insertable : false
    },
    DeleteRestrictions : {
      $Type     : 'Capabilities.DeleteRestrictionsType',
      Deletable : false
    },
    NavigationProperty : to_vins,
  }, ],

}, };

annotate service.Vin with @Capabilities : {NavigationRestrictions : {
  $Type                : 'Capabilities.NavigationRestrictionsType',
  RestrictedProperties : [{
    $Type              : 'Capabilities.NavigationPropertyRestriction',
    InsertRestrictions : {
      $Type      : 'Capabilities.InsertRestrictionsType',
      Insertable : true
    },
    UpdateRestrictions : {
      $Type                  : 'Capabilities.UpdateRestrictionsType',
      NonUpdatableProperties : ['to_cepages/cepage_name'],
    },

    NavigationProperty : to_cepages,
  }, ],

}, };
