using {my.cave as cave} from '../db/schema';

service API {
  @cds.persistence.exists
  entity Vin        as projection on cave.Vin;

  entity Superficie as projection on cave.Superficie;
  entity Cepage     as projection on cave.Cepage;

  entity Assemblage as projection on cave.Assemblage {
    * , vin : redirected to Vin, cepage : redirected to Cepage
  };

  entity ColorCepage @(
    cds.redirection.target : false,
    odata.draft.enabled    : null,
    readonly
  )                 as projection on cave.ColorCepage;

  entity TypeBoisson @(
    cds.redirection.target : false,
    odata.draft.enabled    : null,
    readonly
  )                 as projection on cave.TypeBoisson;

  @readonly
  define view VinPerCepage as
    select from Assemblage {
      key cepage.name as name  : String,
      key count(
            vin.ID
          )           as count : Integer,

    }
    group by
      cepage.name
    order by
      name;

  @Aggregation : {ApplySupported : {
    $Type                : 'Aggregation.ApplySupportedType',
    PropertyRestrictions : true
  }, }
  define view OverviewVinColor as
    select from Vin {
          @Analytics : {
            Dimension : true
          }
      key color.name as color : String,
          @Analytics : {
            Measure : true
          }
          count(
            color.name
          )          as count : Integer,
    }
    group by
      color.name
    order by
      color;

  @Aggregation : {ApplySupported : {
    $Type                : 'Aggregation.ApplySupportedType',
    PropertyRestrictions : true
  }, }
  define view VinAnalytics as
    select from Vin {
      key ID,
          @Analytics : {
            Dimension : true
          }
          color.name as color     : String,
          @Analytics : {
            Dimension : true
          }
          type       as categorie : String,
          @Analytics : {
            Dimension : true
          }
          annee      as millesime,
          @Analytics : {
            Measure : true
          }
          count(
            color.name
          )          as count     : Integer
    }
    group by
      color.name,
      annee
    order by
      millesime,
      color;

  @Aggregation : {ApplySupported : {
    $Type                  : 'Aggregation.ApplySupportedType',
    PropertyRestrictions   : true,
    GroupableProperties    : [
      name,
      annee,
      superficie
    ],
    AggregatableProperties : [{
      $Type    : 'Aggregation.AggregatablePropertyType',
      Property : superficie,
    }, ],
  }, }
  define view SuperficieEvolution as
    select from Superficie {
      key to_cepage.name as name,
          @Analytics : {
            Dimension : true
          }
      key annee          as annee : String,
          @Analytics : {
            Measure : true
          }
          superficie
    }
    order by
      annee;

  annotate cave.Vin with @(
    odata.draft.enabled,
    Common : {SemanticKey : [ID]}
  );

  annotate cave.Vin with {
    name     @Common           : {
      ValueListWithFixedValues : false,
      ValueList                : {
        CollectionPath : 'Vin',
        Parameters     : [
          {
            $Type             : 'Common.ValueListParameterInOut',
            LocalDataProperty : 'name',
            ValueListProperty : 'name'
          },
          {
            $Type             : 'Common.ValueListParameterDisplayOnly',
            ValueListProperty : 'annee'
          },
          {
            $Type             : 'Common.ValueListParameterDisplayOnly',
            ValueListProperty : 'type'
          }
        ]
      }
    };

    type     @Common           : {
      ValueListWithFixedValues : false,
      ValueList                : {
        CollectionPath : 'TypeBoisson',
        Parameters     : [{
          $Type             : 'Common.ValueListParameterInOut',
          LocalDataProperty : 'type',
          ValueListProperty : 'ID'
        }]
      }
    };

    color    @Common           : {
      ValueListWithFixedValues : true,
      ValueList                : {
        CollectionPath : 'VinColor',
        Parameters     : [{
          $Type             : 'Common.ValueListParameterInOut',
          LocalDataProperty : 'color_code',
          ValueListProperty : 'code'
        }]
      }
    };

    currency @Common.ValueList : {
      CollectionPath  : 'Currencies',
      Label           : '',
      Parameters      : [
        {
          $Type             : 'Common.ValueListParameterInOut',
          LocalDataProperty : currency_code,
          ValueListProperty : 'code'
        },
        {
          $Type             : 'Common.ValueListParameterDisplayOnly',
          ValueListProperty : 'name'
        },
        {
          $Type             : 'Common.ValueListParameterDisplayOnly',
          ValueListProperty : 'descr'
        },
        {
          $Type             : 'Common.ValueListParameterDisplayOnly',
          ValueListProperty : 'symbol'
        }
      ],
      SearchSupported : true
    };
  };

  annotate cave.Assemblage with {
    cepage @Common : {ValueList : {
      $Type          : 'Common.ValueListType',
      CollectionPath : 'Cepage',
      Parameters     : [
        {
          $Type             : 'Common.ValueListParameterInOut',
          LocalDataProperty : cepage_name,
          ValueListProperty : 'name',
        },
        {
          $Type             : 'Common.ValueListParameterDisplayOnly',
          ValueListProperty : 'description',
        },
        {
          $Type             : 'Common.ValueListParameterDisplayOnly',
          ValueListProperty : 'couleur',
        },
      ],
    }, }
  };

  annotate cave.Cepage with @(
    odata.draft.enabled,
    Common : {SemanticKey : [name], },
  );

  annotate cave.Cepage with {
    description @UI.HiddenFilter;
    name        @Common : {
      ValueListWithFixedValues : false,
      ValueList                : {
        CollectionPath : 'Cepage',
        Parameters     : [
          {
            $Type             : 'Common.ValueListParameterInOut',
            LocalDataProperty : 'name',
            ValueListProperty : 'name',
          },
          {
            $Type             : 'Common.ValueListParameterDisplayOnly',
            ValueListProperty : 'couleur'
          }
        ]
      }
    };

    couleur     @(
      UI.HiddenFilter,
      Common : {
        ValueListWithFixedValues : true,
        ValueList                : {
          CollectionPath          : 'ColorCepage',
          DistinctValuesSupported : true,
          Parameters              : [{
            $Type             : 'Common.ValueListParameterInOut',
            LocalDataProperty : 'couleur',
            ValueListProperty : 'ID'
          }]
        }
      }
    );
  };
}
