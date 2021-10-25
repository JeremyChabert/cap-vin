using {my.cave as cave} from '../db/schema';

service retailer @(
  path     : '/retailer',
  requires : 'authenticated-user'
) {

  @odata.draft.enabled
  entity Vin @(restrict : [
    {
      grant : 'READ',
      to    : 'authenticated-user'
    },
    {
      grant : '*',
      to    : 'admin'
    }
  ])                as projection on cave.Vin;

  entity Superficie as projection on cave.Superficie;

  @odata.draft.enabled
  entity Cepage     as projection on cave.Cepage;

  entity Region     as projection on cave.Region;

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
    $Type                  : 'Aggregation.ApplySupportedType',
    AggregatableProperties : [
      {
        $Type    : 'Aggregation.AggregatablePropertyType',
        Property : prix,
      },
      {
        $Type    : 'Aggregation.AggregatablePropertyType',
        Property : counter
      },
    ],
    GroupableProperties    : [
      millesime,
      color,
      categorie,
      status
    ],
    PropertyRestrictions   : false,
  }, }
  define view VinAnalytics as
    select from Vin {
      key ID,
          name,
          devise,
          @Analytics           : {
            Dimension : true
          }
          @Aggregation.default : #COUNT_DISTINCT
          color.name  as color     : String,
          @Analytics           : {
            Dimension : true
          }
          @Aggregation.default : #COUNT_DISTINCT
          type        as categorie : String,
          @Analytics           : {
            Dimension : true
          }
          @Aggregation.default : #COUNT_DISTINCT
          annee       as millesime,
          @Analytics           : {
            Measure : true
          }
          @Aggregation.default : #SUM
          prix,
          @Analytics           : {
            Measure : true
          }
          @Aggregation.default : #SUM
          1           as counter   : Integer,
          @Analytics           : {
            Dimension : true
          }
          status.name as status    : String,
    }
    order by
      millesime,
      color;

  annotate VinAnalytics with @readonly;


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

  annotate Vin with @(Common : {SemanticKey : [ID]});

  annotate Vin with {
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
    region   @Common           : {
      ValueListWithFixedValues : false,
      ValueList                : {
        CollectionPath : 'Region',
        Parameters     : [
          {
            $Type             : 'Common.ValueListParameterInOut',
            LocalDataProperty : 'region_subregion',
            ValueListProperty : 'subregion',
          },
          {
            $Type             : 'Common.ValueListParameterDisplayOnly',
            ValueListProperty : 'region'
          },
          {
            $Type             : 'Common.ValueListParameterOut',
            ValueListProperty : 'country_code',
            LocalDataProperty : 'region/country_code',
          }
        ]
      }
    };
  };

  annotate Assemblage with {
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
          ValueListProperty : 'color',
        },
      ],
    }, }
  };

  annotate Cepage with @(Common : {SemanticKey : [name], }, );

  annotate Cepage with {
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
            ValueListProperty : 'color'
          }
        ]
      }
    };

    color       @(
      UI.HiddenFilter,
      Common : {
        ValueListWithFixedValues : true,
        ValueList                : {
          CollectionPath          : 'ColorCepage',
          DistinctValuesSupported : true,
          Parameters              : [{
            $Type             : 'Common.ValueListParameterInOut',
            LocalDataProperty : 'color',
            ValueListProperty : 'ID'
          }]
        }
      }
    );
  };

};

service customer @(
  path     : '/customer',
  requires : 'authenticated-user'
) {

  @readonly
  entity Vin    as projection on cave.Vin actions {
    action addToMyCave @(requires : 'customer')(quantity : Integer not null  @Common.Label : '{i18n>quantity}');
  };

  @readonly
  entity Region as projection on cave.Region;

  entity Cave                                      @(restrict : [{
    grant : '*',
    to    : 'customer',
    where : 'createdBy = $user'
  }, ])         as projection on cave.Cave actions {
    action withdrawQty(quantity : Integer not null @Common.Label : '{i18n>quantity}');
    action addQty(quantity :      Integer not null @Common.Label : '{i18n>quantity}');
    action addRating(rating :     Decimal(2, 1)    @(assert.range : [
      0.0,
      5.0
    ])                                             @Common.Label : '{i18n>rating}');
    action addComment(comment :   String not null  @Common.Label : '{i18n>comment}');
  };

  annotate Cave with @(Common : {SemanticKey : [ID]});

  @Aggregation : {ApplySupported : {
    $Type                  : 'Aggregation.ApplySupportedType',
    PropertyRestrictions   : true,
    GroupableProperties    : [
      name,
      millesime,
      categorie,
      color,
      status
    ],
    AggregatableProperties : [
      {
        $Type    : 'Aggregation.AggregatablePropertyType',
        Property : name,
      },
      {
        $Type    : 'Aggregation.AggregatablePropertyType',
        Property : millesime,
      },
      {
        $Type    : 'Aggregation.AggregatablePropertyType',
        Property : categorie,
      },
      {
        $Type    : 'Aggregation.AggregatablePropertyType',
        Property : color,
      },
      {
        $Type    : 'Aggregation.AggregatablePropertyType',
        Property : status,
      }
    ],
  }, }
  define view CellarAnalytics @(restrict : [{
    grant : 'READ',
    to    : 'customer',
    where : 'createdBy = $user'
  }]) as
    select from Cave {
      key ID,
          @Analytics           : {
            Dimension : true
          }
          rating,
          @Analytics           : {
            Measure : true
          }
          quantity,
          @Analytics           : {
            Dimension : true
          }
          vin.name,
          vin.devise,
          @Analytics           : {
            Dimension : true
          }
          @Aggregation.default : #COUNT_DISTINCT
          vin.color.name  as color     : String,
          @Analytics           : {
            Dimension : true
          }
          @Aggregation.default : #COUNT_DISTINCT
          vin.type        as categorie : String,
          @Analytics           : {
            Dimension : true
          }
          @Aggregation.default : #COUNT_DISTINCT
          vin.annee       as millesime,
          @Analytics           : {
            Measure : true
          }
          @Aggregation.default : #SUM
          vin.prix,
          @Analytics           : {
            Measure : true
          }
          @Aggregation.default : #SUM
          1               as counter   : Integer,
          @Analytics           : {
            Dimension : true
          }
          vin.status.name as status    : String,
          createdBy
    }
    order by
      millesime,
      color;
}
