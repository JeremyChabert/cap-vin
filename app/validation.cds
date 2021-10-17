using API as service from '../srv/services';

// Input validation
annotate service.Vin with {
  ID    @Core.Computed;
  name  @mandatory;
  type  @mandatory;
  annee @mandatory;
  color @mandatory;
};


// Input Assemblage
annotate service.Assemblage with {
  ID                 @Core.Computed;
  cepage_name        @mandatory;
  vin_ID             @mandatory;
  cepage_description @readonly;
};

// Input Assemblage
annotate service.Cepage with {
  name        @mandatory;
  description @readonly;
};
