using { my.cave as cave } from '../db/schema';

service API {
  entity Vin as projection on cave.Vin;
  view VinName as
  select from Vin distinct {
    key name
  };
  
}

annotate API.Vin with 
{
 ID @Core.Computed @UI.Hidden @UI.HiddenFilter
};
