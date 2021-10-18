using API as service from '../srv/services';

annotate service.Vin with {
  name     @Common           : {
    ValueListWithFixedValues : false,
    ValueList                : {
      CollectionPath : 'Vin',
      Parameters     : [
        {
          $Type             : 'Common.ValueListParameterInOut',
          LocalDataProperty : 'name',
          ValueListProperty : 'name'
        },
        {
          $Type             : 'Common.ValueListParameterDisplayOnly',
          ValueListProperty : 'annee'
        },
        {
          $Type             : 'Common.ValueListParameterDisplayOnly',
          ValueListProperty : 'type'
        }
      ]
    }
  };

  type     @Common           : {
    ValueListWithFixedValues : false,
    ValueList                : {
      DistinctValuesSupported : true,
      CollectionPath          : 'Vin',
      Parameters              : [{
        $Type             : 'Common.ValueListParameterInOut',
        LocalDataProperty : 'type',
        ValueListProperty : 'type'
      }]
    }
  };

  color    @Common           : {
    ValueListWithFixedValues : true,
    ValueList                : {
      CollectionPath : 'VinColor',
      Parameters     : [{
        $Type             : 'Common.ValueListParameterInOut',
        LocalDataProperty : 'color_code',
        ValueListProperty : 'code'
      }]
    }
  };

  currency @Common.ValueList : {
    CollectionPath  : 'Currencies',
    Label           : '',
    Parameters      : [
      {
        $Type             : 'Common.ValueListParameterInOut',
        LocalDataProperty : currency_code,
        ValueListProperty : 'code'
      },
      {
        $Type             : 'Common.ValueListParameterDisplayOnly',
        ValueListProperty : 'name'
      },
      {
        $Type             : 'Common.ValueListParameterDisplayOnly',
        ValueListProperty : 'descr'
      },
      {
        $Type             : 'Common.ValueListParameterDisplayOnly',
        ValueListProperty : 'symbol'
      }
    ],
    SearchSupported : true
  };
};



