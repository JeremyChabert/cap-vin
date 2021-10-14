using API as service from '../../srv/services';

// Input validation
annotate service.Vin with {
  ID    @Core.Computed;
  name  @mandatory;
  type  @mandatory;
  annee @mandatory;
  color @mandatory;
};
