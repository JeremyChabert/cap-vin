using API as service from '../../srv/services';

annotate service.VinPerCepage with @UI : {
  LineItem         : [
    {
      $Type : 'UI.DataField',
      Value : name
    },
    {
      $Type  : 'UI.DataFieldForAnnotation',
      Target : '@UI.DataPoint#Count'
    }
  ],
  DataPoint #Count : {
    $Type : 'UI.DataPointType',
    Title : 'Count',
    Value : count
  }
};

annotate service.OverviewVinColor with @UI : {
  LineItem         : [
    {
      $Type : 'UI.DataField',
      Value : color
    },
    {
      $Type  : 'UI.DataFieldForAnnotation',
      Target : '@UI.DataPoint#Count'
    }
  ],
  DataPoint #Count : {
    $Type : 'UI.DataPointType',
    Title : 'Count',
    Value : count
  },
  Chart            : {
    $Type               : 'UI.ChartDefinitionType',
    ChartType           : #Donut,
    Title               : '{i18n>donutChartTypeVin}',
    Dimensions          : ['color'],
    DimensionAttributes : [{
      $Type     : 'UI.ChartDimensionAttributeType',
      Dimension : 'color',
      Role      : #Category
    }],
    Measures            : ['count'],
    MeasureAttributes   : [{
      $Type   : 'UI.ChartMeasureAttributeType',
      Measure : 'count',
      Role    : #Axis1
    }]
  },
};


annotate service.VinAnalytics with @UI : {
  LineItem             : [
    {
      $Type : 'UI.DataField',
      Value : color
    },

    {
      $Type  : 'UI.DataFieldForAnnotation',
      Target : '@UI.DataPoint#Count'
    },
    {
      $Type  : 'UI.DataFieldForAnnotation',
      Target : '@UI.DataPoint#Millesime'
    }
  ],
  DataPoint #Count     : {
    $Type : 'UI.DataPointType',
    Title : 'Count',
    Value : count
  },
  DataPoint #Millesime : {
    $Type : 'UI.DataPointType',
    Title : 'Millesime',
    Value : millesime
  },
  Chart                : {
    $Type               : 'UI.ChartDefinitionType',
    ChartType           : #ColumnStacked,
    Title               : '{i18n>donutChartTypeVin}',
    Dimensions          : [
      'color',
      'millesime'
    ],
    DimensionAttributes : [
      {
        $Type     : 'UI.ChartDimensionAttributeType',
        Dimension : 'color',
        Role      : #Series

      },
      {
        $Type     : 'UI.ChartDimensionAttributeType',
        Dimension : 'millesime',
        Role      : #Category
      }
    ],
    Measures            : ['count'],
    MeasureAttributes   : [{
      $Type   : 'UI.ChartMeasureAttributeType',
      Measure : 'count',
      Role    : #Axis1
    }]
  },
};
