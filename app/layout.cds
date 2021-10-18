using API as service from '../srv/services';

/*-------------------
* Vin
*-------------------*/

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
    {Value : igp},
    {Value : aoc},
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
      Value : igp
    },
    {
      $Type : 'UI.DataField',
      Value : aoc
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
      Target : 'to_cepages/@UI.LineItem#to_cepage'
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
  ID     @UI.Hidden  @UI.HiddenFilter;
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

/*-------------------
* Assemblage
*-------------------*/

annotate service.Assemblage with @UI : {
  LineItem #to_cepage     : [
    {
      $Type : 'UI.DataField',
      Value : cepage_name,
      Label : '{i18n>cepage}',
    },
    {
      $Type                   : 'UI.DataField',
      Value                   : cepage.description,
      Label                   : '{i18n>cepage_description}',
      ![@Common.FieldControl] : #ReadOnly,
    },
    {
      $Type                   : 'UI.DataField',
      Value                   : cepage.couleur,
      Label                   : '{i18n>couleur}',
      ![@Common.FieldControl] : #ReadOnly,
    },
    {
      $Type                   : 'UI.DataField',
      Value                   : pourcent,
      Label                   : '{i18n>teneur}',
      ![@Common.FieldControl] : #Optional,
    },
    {
      $Type                   : 'UI.DataField',
      Value                   : vin_ID,
      Label                   : '{i18n>vin_ID}',
      ![@Common.FieldControl] : #ReadOnly,
      ![@UI.Hidden],
    },
    {
      $Type                   : 'UI.DataField',
      Value                   : ID,
      Label                   : '{i18n>ID}',
      ![@Common.FieldControl] : #ReadOnly,
      ![@UI.Hidden],
    }
  ],
  FieldGroup #Description : {Data : [
    {
      $Type : 'UI.DataField',
      Value : cepage_name
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

/*-------------------
* Cepage
*-------------------*/

annotate service.Cepage with @UI : {
  SelectionVariant #Noir  : {
    $Type         : 'UI.SelectionVariantType',
    SelectOptions : [{
      $Type        : 'UI.SelectOptionType',
      PropertyName : couleur,
      Ranges       : [{
        $Type  : 'UI.SelectionRangeType',
        Sign   : #I,
        Option : #EQ,
        Low    : 'Noir',
      }]
    }],
    Text          : 'Noir'
  },
  SelectionVariant #Blanc : {
    $Type         : 'UI.SelectionVariantType',
    SelectOptions : [{
      $Type        : 'UI.SelectOptionType',
      PropertyName : couleur,
      Ranges       : [{
        $Type  : 'UI.SelectionRangeType',
        Sign   : #I,
        Option : #EQ,
        Low    : 'Blanc',
      }]
    }],
    Text          : 'Blanc'
  },
  HeaderInfo              : {
    Title          : {
      $Type : 'UI.DataField',
      Value : name,
    },
    TypeName       : '{i18n>cepage}',
    TypeNamePlural : '{i18n>cepages}',
    Description    : {Value : couleur},
    ImageUrl       : 'sap-icon://lab',
  },
  SelectionFields         : [name, ],
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
      Value : description
    },
    {
      $Type : 'UI.DataField',
      Value : couleur
    }
  ]},
  Facets                  : [
    {
      $Type  : 'UI.CollectionFacet',
      ID     : 'CepageDetails',
      Label  : '{i18n>details}',
      Facets : [{
        $Type  : 'UI.ReferenceFacet',
        Label  : '{i18n>description}',
        Target : '@UI.FieldGroup#Description'
      },

      ],
    },
    {
      $Type  : 'UI.ReferenceFacet',
      Label  : '{i18n>evolutionSuperficie}',
      ID     : 'SuperficieReferenceFacet',
      Target : 'to_superficies/@UI.PresentationVariant'
    },
  ]
};

/*-------------------
* Superficie
*-------------------*/

annotate service.Superficie with @UI : {
  PresentationVariant     : {
    ID             : 'SuperficiePresVar',
    $Type          : 'UI.PresentationVariantType',
    Visualizations : ['@UI.LineItem#to_superficie',
                                                    // '@UI.Chart'
                     ],

  },
  Chart                   : {
    $Type               : 'UI.ChartDefinitionType',
    ChartType           : #Line,
    Title               : 'Evolution',
    Description         : '',
    AxisScaling         : {$Type : 'UI.ChartAxisScalingType',

    },
    Measures            : [superficie],
    MeasureAttributes   : [{
      $Type     : 'UI.ChartMeasureAttributeType',
      Measure   : 'superficie',
      DataPoint : '@UI.DataPoint#superficie',
      Role      : #Axis1,
    }, ],
    Dimensions          : [annee],
    DimensionAttributes : [{
      $Type     : 'UI.ChartDimensionAttributeType',
      Dimension : 'annee',
      Role      : #Category,
    }, ],
  },
  DataPoint #superficie   : {
    $Type : 'UI.DataPointType',
    Value : 'superficie',
  },
  DataPoint #annee        : {
    $Type : 'UI.DataPointType',
    Value : 'annee',
  },
  LineItem #to_superficie : [
    {
      $Type : 'UI.DataField',
      Value : annee
    },
    {
      $Type : 'UI.DataField',
      Value : superficie
    }
  ],
};

annotate service.Superficie with {
  annee      @title : '{i18n>annee}';
  superficie @title : '{i18n>superficie}';
};
