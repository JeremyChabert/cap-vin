using API as service from '../../srv/services';


annotate service.Cepage @fiori.draft.enabled  @odata.draft.enabled;

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
  Facets                  : [{
    $Type  : 'UI.CollectionFacet',
    ID     : 'VinDetails',
    Label  : '{i18n>details}',
    Facets : [{
      $Type  : 'UI.ReferenceFacet',
      Label  : '{i18n>label}',
      Target : '@UI.FieldGroup#Description'
    }]
  }],
};
