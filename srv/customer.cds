using {my.cave as cave} from '../db/schema';

service customer @(
  path     : '/customer',
  requires : 'authenticated-user'
) {

  @readonly
  entity Vin        as
    select from cave.Vin {
      *
    }
    where
      availability.code != 'B'
    actions {
      action addToMyCave @(requires : 'customer')(quantity : Integer not null  @Common.Label : '{i18n>quantity}');
    };

  @readonly
  entity Region     as projection on cave.Region;

  @readonly
  entity Assemblage as projection on cave.Assemblage;

  @readonly
  entity Cepage     as projection on cave.Cepage;

  entity Cave                                      @(restrict : [{
    grant : '*',
    to    : 'customer',
    where : 'createdBy = $user'
  }, ])             as projection on cave.Cave actions {
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
