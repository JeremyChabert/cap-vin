using { my.cave as cave } from '../db/schema';

service API {
  entity Vin as projection on cave.Vin;
  view VinName as
  select from Vin distinct {
    key name
  };

  entity Cepage as projection on cave.Cepage;
  
}

annotate API.Vin with 
{
 ID @Core.Computed @UI.Hidden @UI.HiddenFilter
};
