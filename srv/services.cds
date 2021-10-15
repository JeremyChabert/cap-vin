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

  annotate Assemblage with @(
    UI.TextArrangement : #TextOnly,
    cds.odata.valuelist
  ) {
    ID @UI.Hidden  @UI.HiddenFilter;
  };

  annotate Vin with {
    ID @UI.Hidden  @UI.HiddenFilter;
  };

}
