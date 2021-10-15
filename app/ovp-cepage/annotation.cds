using API as service from '../../srv/services';

annotate service.VinPerCepage with @UI : {
  LineItem             : [
    {
      $Type : 'UI.DataField',
      Value : name
    },
    {
      $Type  : 'UI.DataFieldForAnnotation',
      Target : '@UI.DataPoint#TaxAmount'
    }
  ],
  DataPoint #TaxAmount : {
    $Type : 'UI.DataPointType',
    Title : 'TaxAmount',
    Value : count
  }
};
