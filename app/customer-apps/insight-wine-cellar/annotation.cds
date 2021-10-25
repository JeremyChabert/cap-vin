using customer as service from '../../../srv/services';

annotate service.CellarAnalytics with @UI : {
  LineItem                               : [
    {
      $Type : 'UI.DataField',
      Value : name
    },

    {
      $Type : 'UI.DataField',
      Value : color
    },
    {
      $Type  : 'UI.DataFieldForAnnotation',
      Target : '@UI.DataPoint#Millesime'
    }
  ],
  DataPoint #Count                       : {
    $Type       : 'UI.DataPointType',
    Title       : 'Count',
    Value       : counter,
    ValueFormat : {$Type : 'UI.NumberFormat', },
  },
  DataPoint #Millesime                   : {
    $Type : 'UI.DataPointType',
    Title : 'Millesime',
    Value : millesime
  },
  Identification #VinPerCriticality      : [{
    $Type : 'UI.DataField',
    Value : status,
  },

  ],
  Identification #VinPerYear             : [{
    $Type : 'UI.DataField',
    Value : millesime,
  }, ],
  PresentationVariant #VinPerCriticality : {
    $Type          : 'UI.PresentationVariantType',
    GroupBy        : [status],
    Visualizations : ['@UI.Chart#VinPerCriticality', ],
  },
  PresentationVariant #VinPerColor       : {
    $Type          : 'UI.PresentationVariantType',
    GroupBy        : [color],
    Visualizations : ['@UI.Chart#VinPerCriticality', ],
  },
  PresentationVariant #VinPerYear        : {
    $Type          : 'UI.PresentationVariantType',
    GroupBy        : [millesime],
    Visualizations : ['@UI.Chart#VinPerYear', ],

  },
  Chart #VinPerColor                     : {
    $Type               : 'UI.ChartDefinitionType',
    ChartType           : #Donut,
    Title               : '{i18n>donutChartColorVin}',
    Dimensions          : ['color'],
    DimensionAttributes : [{
      $Type     : 'UI.ChartDimensionAttributeType',
      Dimension : 'color',
      Role      : #Category
    }],
    Measures            : ['quantity'],
    MeasureAttributes   : [{
      $Type   : 'UI.ChartMeasureAttributeType',
      Measure : 'quantity',
      Role    : #Axis1
    }]
  },
  Chart #VinPerRatings                   : {
    $Type               : 'UI.ChartDefinitionType',
    ChartType           : #Donut,
    Title               : '{i18n>donutChartColorVin}',
    Dimensions          : ['color'],
    DimensionAttributes : [{
      $Type     : 'UI.ChartDimensionAttributeType',
      Dimension : 'rating',
      Role      : #Category
    }],
    Measures            : ['quantity'],
    MeasureAttributes   : [{
      $Type   : 'UI.ChartMeasureAttributeType',
      Measure : 'quantity',
      Role    : #Axis1
    }]
  },
  Chart #VinPerNameQuantity              : {
    $Type               : 'UI.ChartDefinitionType',
    ChartType           : #Bar, 
    Title               : '{i18n>donutChartColorVin}',
    Dimensions          : [
      'name',
      'color'
    ],
    DimensionAttributes : [
      {
        $Type     : 'UI.ChartDimensionAttributeType',
        Dimension : 'name',
        Role      : #Category
      },
            {
        $Type     : 'UI.ChartDimensionAttributeType',
        Dimension : 'color',
        Role      : #Category2
      },
    ],
    Measures            : [
      'quantity',
    ],
    MeasureAttributes   : [
      {
        $Type   : 'UI.ChartMeasureAttributeType',
        Measure : 'quantity',
        Role    : #Axis1
      },
    ]
  },
  Chart #VinPerYearColor                 : {
    $Type               : 'UI.ChartDefinitionType',
    ChartType           : #Bar,
    Title               : '{i18n>donutChartColorVin}',
    Dimensions          : [
      'color',
      'millesime'
    ],
    DimensionAttributes : [
      {
        $Type     : 'UI.ChartDimensionAttributeType',
        Dimension : 'millesime',
        Role      : #Category
      },
      {
        $Type     : 'UI.ChartDimensionAttributeType',
        Dimension : 'color',
        Role      : #Category2
      }
    ],
    Measures            : ['quantity'],
    MeasureAttributes   : [{
      $Type   : 'UI.ChartMeasureAttributeType',
      Measure : 'quantity',
      Role    : #Axis1
    }]
  },
  Chart #VinPerYear                      : {
    $Type               : 'UI.ChartDefinitionType',
    ChartType           : #ColumnStacked,
    Title               : '{i18n>stackedColumnChartTypeYear}',
    Dimensions          : [
      categorie,
      color
    ],
    DimensionAttributes : [
      {
        $Type     : 'UI.ChartDimensionAttributeType',
        Dimension : categorie,
        Role      : #Series

      },
      {
        $Type     : 'UI.ChartDimensionAttributeType',
        Dimension : color,
        Role      : #Category
      }
    ],
    Measures            : [quantity],
    MeasureAttributes   : [{
      $Type   : 'UI.ChartMeasureAttributeType',
      Measure : quantity,
      Role    : #Axis1
    }]
  },
  Chart #VinPerCriticality               : {
    $Type               : 'UI.ChartDefinitionType',
    ChartType           : #Donut,
    Title               : '{i18n>donutChartStatusWine}',
    Dimensions          : [status],
    DimensionAttributes : [{
      $Type     : 'UI.ChartDimensionAttributeType',
      Dimension : status,
      Role      : #Category
    }],
    Measures            : [quantity],
    MeasureAttributes   : [{
      $Type   : 'UI.ChartMeasureAttributeType',
      Measure : quantity,
      Role    : #Axis1
    }]
  },
};
