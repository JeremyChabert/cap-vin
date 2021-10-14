using API as service from '../../srv/services';

annotate service.Vin with @(UI : {
  HeaderInfo              : {
    Title          : {
      $Type : 'UI.DataField',
      Value : name,
    },
    TypeName       : '{i18n>vin}',
    TypeNamePlural : '{i18n>vins}',
    Description    : {Value : annee},
    ImageUrl       : 'sap-icon://lab',
  },
  LineItem                : [
    {Value : name},
    {Value : annee},
    {Value : type},
    {Value : color.name},
    {Value : IGP},
    {Value : AOC},
    {Value : prix},
    {Value : degre},
    {Value : volume}
  ],
  SelectionFields         : [
    name,
    annee,
    color_code,
    type
  ],
  HeaderFacets            : [{
    $Type             : 'UI.ReferenceFacet',
    Target            : '@UI.FieldGroup#Details',
    ![@UI.Importance] : #Medium,
  }],
  FieldGroup #Description : {Data : [
    {
      $Type : 'UI.DataField',
      Value : name
    },
    {
      $Type : 'UI.DataField',
      Value : annee
    }
  ]},
  FieldGroup #Details     : {Data : [
    {
      $Type : 'UI.DataField',
      Value : type
    },
    {
      $Type : 'UI.DataField',
      Value : color_code
    },
    {
      $Type : 'UI.DataField',
      Value : degre
    }
  ]},
  FieldGroup #Labels      : {Data : [

    {
      $Type : 'UI.DataField',
      Value : IGP
    },
    {
      $Type : 'UI.DataField',
      Value : AOC
    }
  ]},
  FieldGroup #Price       : {Data : [

    {
      $Type : 'UI.DataField',
      Value : prix
    },
    {
      $Type : 'UI.DataField',
      Value : volume
    }
  ]},
  FieldGroup #Admin       : {Data : [
    {
      $Type : 'UI.DataField',
      Value : createdBy
    },
    {
      $Type : 'UI.DataField',
      Value : modifiedBy
    },
    {
      $Type : 'UI.DataField',
      Value : createdAt
    },
    {
      $Type : 'UI.DataField',
      Value : modifiedAt
    }
  ]},
  Facets                  : [{
    $Type  : 'UI.CollectionFacet',
    ID     : 'VinDetails',
    Label  : '{i18n>details}',
    Facets : [
      {
        $Type  : 'UI.ReferenceFacet',
        Label  : '{i18n>label}',
        Target : '@UI.FieldGroup#Labels'
      },
      {
        $Type  : 'UI.ReferenceFacet',
        Label  : '{i18n>prix}',
        Target : '@UI.FieldGroup#Price'
      },
      {
        $Type  : 'UI.ReferenceFacet',
        Label  : '{i18n>temporalData}',
        Target : '@UI.FieldGroup#Admin'
      }
    ]
  }],
});

annotate service.Vin with @(UI.Identification : [{
  $Type : 'UI.DataField',
  Value : name
}]) {
  ID     @UI.Hidden  @UI.HiddenFilter;
  unit   @UI.Hidden;
  devise @UI.Hidden;
  prix   @UI.HiddenFilter
};

annotate service.Vin with @(
  UI.TextArrangement : #TextOnly,
  cds.odata.valuelist
);
