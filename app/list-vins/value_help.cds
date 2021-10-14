using API as service from '../../srv/services';


annotate service.Vin with {
  name     @Common           : {
    ValueList                : {
      CollectionPath : 'VinName',
      Parameters     : [{
        $Type             : 'Common.ValueListParameterInOut',
        LocalDataProperty : 'name',
        ValueListProperty : 'name'
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
}
