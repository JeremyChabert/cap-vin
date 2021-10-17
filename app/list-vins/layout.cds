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
  FieldGroup #DateData    : {Data : [
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
  Facets                  : [
    {
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
          Target : '@UI.FieldGroup#DateData'
        }
      ],

    },
    {
      $Type  : 'UI.ReferenceFacet',
      Label  : '{i18n>assemblage}',
      Target : 'to_cepages/@UI.LineItem#to_cepages'
    }
  ],
});

annotate service.Vin with @(UI.Identification : [{
  $Type : 'UI.DataField',
  Value : name
},
// {
// $Type  : 'UI.DataFieldForAction',
// Action : 'API.createAssemblage',
// Label  : '{i18n>createAssemblage}'
// }
]) {
  unit   @UI.Hidden;
  devise @UI.Hidden;
  prix   @UI.HiddenFilter
};

annotate service.Vin with @(
  UI.TextArrangement : #TextOnly,
  cds.odata.valuelist
);

annotate service.VinColor with {
  code @Common.Text : name  @Common.TextArrangement : #TextOnly
}

annotate service.Assemblage with @UI : {
  LineItem #to_cepages    : [
    {
      $Type : 'UI.DataField',
      Value : cepage_name,
      Label : '{i18n>cepage}'
    },
    {
      $Type : 'UI.DataField',
      Value : cepage.description,
      Label : '{i18n>cepage_description}'
    },
    {
      $Type : 'UI.DataField',
      Value : pourcent,
      Label : '{i18n>teneur}'
    }
  ],
  LineItem #to_vins       : [
    {
      $Type : 'UI.DataField',
      Value : vin.name,
      Label : '{i18n>name}'
    },
    {
      $Type : 'UI.DataField',
      Value : vin.annee,
      Label : '{i18n>millesime}'
    },
    {
      $Type : 'UI.DataField',
      Value : vin.degre,
      Label : '{i18n>teneur}'
    },
    {
      $Type : 'UI.DataField',
      Value : vin.type,
      Label : '{i18n>type}'
    }
  ],
  FieldGroup #Description : {Data : [
    {
      $Type : 'UI.DataField',
      Value : cepage.name
    },
    {
      $Type : 'UI.DataField',
      Value : cepage.description
    }
  ]},
  Facets                  : [{
    $Type  : 'UI.CollectionFacet',
    ID     : 'AssemblageDetails',
    Label  : '{i18n>details}',
    Facets : [{
      $Type  : 'UI.ReferenceFacet',
      Label  : '{i18n>label}',
      Target : '@UI.FieldGroup#Description'
    }]
  }],
};
