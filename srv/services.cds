using {my.cave as cave} from '../db/schema';

service API {
  entity Vin        as projection on cave.Vin;

  view VinName as
    select from Vin distinct {
      key name
    };

  entity Cepage     as projection on cave.Cepage;
  entity Assemblage as projection on cave.Assemblage;

  annotate Cepage with @(
    UI.TextArrangement : #TextOnly,
    cds.odata.valuelist
  );

  entity Superficie as projection on cave.Superficie;

  annotate Assemblage with @(
    UI.TextArrangement : #TextOnly,
    cds.odata.valuelist
  ) {
    ID @UI.Hidden  @UI.HiddenFilter;
  };

  annotate Vin with {
    ID @UI.Hidden  @UI.HiddenFilter;
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
}
