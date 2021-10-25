using retailer as service from  '../srv/retailer';
using customer as customer from  '../srv/customer';

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
  ID          @Core.Computed;
  cepage_name @mandatory;
};

// Input Cepage
annotate service.Cepage with {
  name @mandatory;
};

// Input Superficie
annotate service.Superficie with {
  ID          @Core.Computed;
  to_cepage   @UI.Hidden;
  cepage_name @readonly  @UI.Hidden;
  annee       @mandatory;
  superficie  @mandatory;
};


// Input Cave
annotate customer.Cave with {
  ID    @Core.Computed;
};
