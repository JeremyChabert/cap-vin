using retailer as service from '../srv/retailer';

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

annotate service.Vin with @Capabilities : {
  NavigationRestrictions : {
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

  },
  FilterRestrictions     : {
    Filterable              : true,
    NonFilterableProperties : [
      'ID',
      'unit',
      'volume',
      'orderEnabled',
      'withdrawFromSaleEnabled',
      'postGoodsEnabled'
    ]
  }
}
actions {
  postGoods               @(
    Core.OperationAvailable             : in.postGoodsEnabled,
    Common.SideEffects.TargetProperties : [
      'in/availability_code',
      'in/postGoodsEnabled',
      'in/withdrawFromSaleEnabled',
      'in/orderEnabled',
      'in/inStockQty',
      'in/orderQty'
    ],
  );
  withdrawFromSale        @(
    Core.OperationAvailable             : in.withdrawFromSaleEnabled,
    Common.SideEffects.TargetProperties : [
      'in/availability_code',
      'in/postGoodsEnabled',
      'in/withdrawFromSaleEnabled',
      'in/orderEnabled',
      'in/inStockQty',
      'in/orderQty'
    ],
  );
  order                   @(
    Core.OperationAvailable             : in.orderEnabled,
    Common.SideEffects.TargetProperties : [
      'in/availability_code',
      'in/postGoodsEnabled',
      'in/withdrawFromSaleEnabled',
      'in/orderEnabled',
      'in/inStockQty',
      'in/orderQty'
    ],
  );
};


using customer as customer from '../srv/customer';

annotate customer.Cave with @(Capabilities : {FilterRestrictions : {
  Filterable              : true,
  NonFilterableProperties : [
    'vin_ID',
    'comment'
  ]
}}) actions {
  addQty                    @(Common.SideEffects.TargetProperties : ['in/quantity', ], );
  withdrawQty               @(Common.SideEffects.TargetProperties : ['in/quantity', ], );
  addRating                 @(Common.SideEffects.TargetProperties : ['in/rating', ], );
  addComment                @(Common.SideEffects.TargetProperties : ['in/comment', ], );
};

annotate customer.Vin with @(Capabilities : {FilterRestrictions : {
  Filterable              : true,
  NonFilterableProperties : [
    'volume',
    'unit',
    'orderQty',
    'inStockQty',
    'devise_code',
    'availability_code'
  ]
}})
