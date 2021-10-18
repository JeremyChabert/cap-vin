using {my.cave as cave} from '../db/schema';

service API {
  entity Vin        as projection on cave.Vin;
  entity Superficie as projection on cave.Superficie;
  entity Cepage     as projection on cave.Cepage;
  entity Assemblage as projection on cave.Assemblage;

  define view VinName as
    select from Vin distinct {
      key name
    };

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

  define view CepageColor as
    select from Cepage distinct {
      key couleur : String
    };

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
      annee
}

annotate API.Vin with @(
  odata.draft.enabled,
  Common : {SemanticKey : [ID], },
);

annotate API.CepageColor with @(
  readonly,
  cds.autoexpose,
  odata.draft.enabled : null
);

annotate API.Assemblage with {
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
}

annotate API.Cepage with @(
  odata.draft.enabled,
  Common : {SemanticKey : [name], },
);

@cds.odata.valuelist
annotate API.Cepage with {
  description @UI.HiddenFilter;
  name        @Common :                   {
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

  couleur     @UI.HiddenFilter  @Common : {
    ValueListWithFixedValues : false,
    ValueList                : {
      CollectionPath : 'CepageColor',
      Parameters     : [{
        $Type             : 'Common.ValueListParameterInOut',
        LocalDataProperty : 'couleur',
        ValueListProperty : 'couleur'
      }]
    }
  };
};
