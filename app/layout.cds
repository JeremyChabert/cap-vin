using API as service from '../srv/services';

/*-------------------
* Vin
*-------------------*/

annotate service.Vin with @(UI : {
  SelectionPresentationVariant #SPVPath : {
    $Type               : 'UI.SelectionPresentationVariantType',
    SelectionVariant    : {
      $Type : 'UI.SelectionVariantType',
      ID    : 'SV',
    },
    PresentationVariant : {
      $Type           : 'UI.PresentationVariantType',
      RequestAtLeast  : [
        name,
        annee,
        color.name,
        igp,
        aoc,
        degre,
        volume,
        garde,
        criticality,
        type,
      ],
      SelectionFields : [
        name,
        annee,
        color_code,
        type
      ],
      Visualizations  : ['@UI.LineItem', ],
      SortOrder       : [
        {
          $Type    : 'Common.SortOrderType',
          Property : name,
        },
        {
          $Type    : 'Common.SortOrderType',
          Property : annee,
        },
      ],
    },
  },
  HeaderInfo                            : {
    Title          : {
      $Type : 'UI.DataField',
      Value : name,
    },
    TypeName       : '{i18n>vin}',
    TypeNamePlural : '{i18n>vins}',
    Description    : {Value : annee},
    ImageUrl       : 'sap-icon://lab',
  },
  FilterFacets                          : [{
    Label  : '{i18n>label}',
    $Type  : 'UI.ReferenceFacet',
    Target : '@UI.FieldGroup#Labels',
  }, ],
  LineItem                              : [
    {
      Value             : name,
      ![@UI.Importance] : #High
    },
    {
      Value             : annee,
      ![@UI.Importance] : #High
    },
    {Value : type},
    {
      Value : color.name,
      Label : '{i18n>color}',
    },
    {Value : igp},
    {Value : aoc},
    {Value : prix},
    {Value : degre},
    {Value : volume},
    {
      $Type             : 'UI.DataField',
      Criticality       : criticality,
      Label             : '{i18n>retentionstatus}',
      Value             : status,
      ![@UI.Importance] : #High
    },
    {
      Value : modifiedAt,
      ![@UI.Hidden]
    },
    {
      Value : createdAt,
      ![@UI.Hidden]
    },
    {
      Value : modifiedBy,
      ![@UI.Hidden]
    },
    {
      Value : createdBy,
      ![@UI.Hidden]
    },
    {
      Value : criticality,
      ![@UI.Hidden]

    },
    {
      Value : garde,
      ![@UI.Hidden]
    },
    {
      Value : color_code,
      ![@UI.Hidden]
    }
  ],
  SelectionFields                       : [
    name,
    annee,
    color_code,
    igp,
    aoc,
  ],
  HeaderFacets                          : [
    {
      $Type  : 'UI.ReferenceFacet',
      Target : '@UI.FieldGroup#Details',
    },
    {
      $Type  : 'UI.ReferenceFacet',
      Target : '@UI.FieldGroup#Conservation',
    },
  ],
  FieldGroup #Description               : {Data : [
    {
      $Type : 'UI.DataField',
      Value : name
    },
    {
      $Type : 'UI.DataField',
      Value : annee
    }
  ]},
  FieldGroup #Details                   : {Data : [
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
  FieldGroup #Conservation              : {Data : [
    {
      $Type : 'UI.DataField',
      Value : garde
    },
    {
      $Type             : 'UI.DataField',
      Criticality       : criticality,
      Value             : status,
      ![@UI.Importance] : #High
    }
  ]},
  FieldGroup #Labels                    : {Data : [

    {
      $Type : 'UI.DataField',
      Value : igp
    },
    {
      $Type : 'UI.DataField',
      Value : aoc
    }
  ]},
  FieldGroup #Price                     : {Data : [

    {
      $Type : 'UI.DataField',
      Value : prix
    },
    {
      $Type : 'UI.DataField',
      Value : volume
    }
  ]},
  FieldGroup #DateData                  : {Data : [
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
  Facets                                : [
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
      Target : 'to_cepages/@UI.PresentationVariant#Vins'
    }
  ],
});

annotate service.Vin with @(UI.Identification : [{
  $Type : 'UI.DataField',
  Value : name
}, ]) {
  ID          @UI.Hidden  @UI.HiddenFilter;
  unit        @UI.Hidden;
  devise      @UI.Hidden;
  prix        @UI.HiddenFilter;
  criticality @UI.HiddenFilter;
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
  PresentationVariant #Cepages : {
    ID              : 'idCepagesPresVar',
    $Type           : 'UI.PresentationVariantType',
    Visualizations  : ['@UI.LineItem#Cepages'],
    SelectionFields : [
      vin.annee,
      vin.name
    ]
  },
  PresentationVariant #Vins    : {
    ID              : 'idVinsPresVar',
    $Type           : 'UI.PresentationVariantType',
    Visualizations  : ['@UI.LineItem#Vins'],
    SelectionFields : [cepage_name],
    SortOrder       : [{
      $Type    : 'Common.SortOrderType',
      Property : cepage_name,
    }, ],

  },
  LineItem #Cepages            : [
    {
      Value                   : vin.name,
      ![@Common.FieldControl] : #ReadOnly,
    },
    {
      Value                   : vin.annee,
      ![@Common.FieldControl] : #ReadOnly,
    },
    {
      Value                   : vin.type,
      ![@Common.FieldControl] : #ReadOnly,
    },
    {
      Value                   : vin.igp,
      ![@Common.FieldControl] : #ReadOnly,
    },
    {
      Value                   : vin.aoc,
      ![@Common.FieldControl] : #ReadOnly,
    },
    {
      Value                   : vin.prix,
      ![@UI.Hidden],
      ![@Common.FieldControl] : #ReadOnly,
    },
    {
      Value                   : vin.degre,
      ![@Common.FieldControl] : #ReadOnly,
    },
    {
      Value                   : vin.volume,
      ![@UI.Hidden],
      ![@Common.FieldControl] : #ReadOnly,
    }
  ],
  LineItem #Vins               : [
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
      Value                   : cepage.color,
      Label                   : '{i18n>color}',
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
  FieldGroup #Description      : {Data : [
    {
      $Type : 'UI.DataField',
      Value : cepage_name
    },
    {
      $Type : 'UI.DataField',
      Value : cepage.description
    }
  ]},
  Facets                       : [{
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
      PropertyName : color,
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
      PropertyName : color,
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
    Description    : {Value : color},
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
      Value : color
    }
  ]},
  Facets                  : [
    {
      $Type  : 'UI.CollectionFacet',
      ID     : 'CepageDetails',
      Label  : '{i18n>details}',
      Facets : [{
        $Type  : 'UI.ReferenceFacet',
        Target : '@UI.FieldGroup#Description'
      },

      ],
    },
    {
      $Type  : 'UI.ReferenceFacet',
      Label  : '{i18n>evolutionSuperficie}',
      ID     : 'SuperficieReferenceFacet',
      Target : 'to_superficies/@UI.PresentationVariant#to_superficies'
    },
    {
      $Type  : 'UI.ReferenceFacet',
      Label  : '{i18n>Vins}',
      ID     : 'CepageVins',
      Target : 'to_vins/@UI.PresentationVariant#Cepages'
    }
  ]
};

/*-------------------
* Superficie
*-------------------*/

annotate service.Superficie with @UI : {
  HeaderInfo                          : {
    TypeName       : '{i18n>superficie}',
    TypeNamePlural : '{i18n>superficies}',
    ImageUrl       : 'sap-icon://lab',
  },
  PresentationVariant #to_superficies : {
    $Type          : 'UI.PresentationVariantType',
    SortOrder      : [{
      $Type      : 'Common.SortOrderType',
      Descending : true,
      Property   : annee,
    }, ],
    Visualizations : ['@UI.LineItem#to_superficies']
  },
  Chart #evolution                    : {
    $Type               : 'UI.ChartDefinitionType',
    ChartType           : #Line,
    Title               : 'Evolution',
    Description         : '',
    AxisScaling         : {$Type : 'UI.ChartAxisScalingType',

    },
    Measures            : [superficie],
    MeasureAttributes   : [{
      $Type   : 'UI.ChartMeasureAttributeType',
      Measure : 'superficie',
      Role    : #Axis1,
    }, ],
    Dimensions          : [annee],
    DimensionAttributes : [{
      $Type     : 'UI.ChartDimensionAttributeType',
      Dimension : 'annee',
      Role      : #Category,
    }, ],
  },
  DataPoint #superficie               : {
    $Type : 'UI.DataPointType',
    Value : 'superficie',
  },
  DataPoint #annee                    : {
    $Type : 'UI.DataPointType',
    Value : 'annee',
  },
  LineItem #to_superficies            : [
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
