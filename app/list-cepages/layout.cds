using API as service from '../../srv/services';
using from '../list-vins/layout';


annotate service.Cepage with @UI : {
  HeaderInfo              : {
    Title          : {
      $Type : 'UI.DataField',
      Value : name,
    },
    TypeName       : '{i18n>cepage}',
    TypeNamePlural : '{i18n>cepages}',
    Description    : {Value : description},
    ImageUrl       : 'sap-icon://lab',
  },
  LineItem                : [
    {
      $Type : 'UI.DataField',
      Value : name
    },
    {
      $Type : 'UI.DataField',
      Value : description
    },
    {
      $Type : 'UI.DataField',
      Value : to_vins.vin_ID
    }
  ],
  FieldGroup #Description : {Data : [
    {
      $Type : 'UI.DataField',
      Value : name
    },
    {
      $Type : 'UI.DataField',
      Value : description
    }
  ]},
  Facets                  : [
    {
      $Type  : 'UI.CollectionFacet',
      ID     : 'VinDetails',
      Label  : '{i18n>details}',
      Facets : [{
        $Type  : 'UI.ReferenceFacet',
        Label  : '{i18n>label}',
        Target : '@UI.FieldGroup#Description'
      },

      ],
    },
    {
      $Type  : 'UI.ReferenceFacet',
      Label  : '{i18n>label}',
      Target : 'to_vins/vin/@UI.LineItem'
    }
  ],
};