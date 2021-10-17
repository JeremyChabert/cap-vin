using API as service from '../../srv/services';


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
    Description    : {Value : description},
    ImageUrl       : 'sap-icon://lab',
  },
  SelectionFields         : [
    name,
  ],
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
      Label  : '{i18n>evolutionSuperficie}',
      ID     : 'SuperficieReferenceFacet',
      Target : 'to_superficies/@UI.PresentationVariant'
    },
  ]
};
    }
annotate service.Cepage with {
  description @UI.HiddenFilter;
  couleur     @UI.HiddenFilter;
};
annotate service.Superficie with @UI : {
  PresentationVariant     : {
    ID             : 'SuperficiePresVar',
    $Type          : 'UI.PresentationVariantType',
    Visualizations : ['@UI.LineItem',
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
  LineItem                : [
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
  ],
};