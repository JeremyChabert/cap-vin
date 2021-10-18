using {
  cuid,
  managed,
  Currency,
  Country,
  sap.common.CodeList as CodeList
} from './common';

namespace my.cave;

aspect Boisson : cuid, managed {
  name   : String;
  annee  : String(4);
  type   : String;
  @Measures : {Unit : '%vol'}
  degre  : Decimal(4, 1);
  @Measures : {Unit : unit, }
  volume : Integer default 75;
  unit   : String @assert.range enum {
    L;
    cL;
  } default 'cL';
};

entity Cepage {
  key name           : String(30);
      description    : String(400);
      couleur        : String @assert.range enum {
        Noir;
        Blanc;
      };
      to_vins        : Association to many Assemblage
                         on to_vins.cepage = $self;
      to_superficies : Composition of many Superficie
                         on to_superficies.to_cepage = $self;
};

entity Superficie @(assert.unique : {Superficie : [
  to_cepage,
  annee
]}) : cuid {
  to_cepage  : Association to one Cepage;
  annee      : String(4);
  @Measures : {Unit : 'ha'}
  superficie : Integer default 0;
};

entity Assemblage    @(assert.unique : {Assemblage : [
  cepage,
  vin
]}) : cuid {
  cepage   : Association to Cepage;
  vin      : Association to Vin;
  @Measures :                        {Unit : '%'}
  pourcent : Integer @assert.range : [
    0,
    100
  ] default 0;
};

entity Vin : Boisson {
  color               : Association to VinColor;
  @Measures :                                   {ISOCurrency : devise_code, }
  prix                : Decimal(6, 2);
  devise              : Currency;
  igp                 : Boolean default false;
  aoc                 : Boolean default false;
  @Measures :                                   {Unit : '{i18n>anneeGarde}'}
  garde               : Integer @assert.range : [
    1,
    20
  ] default 1;
  to_cepages          : Composition of many Assemblage
                          on to_cepages.vin = $self;
  to_caracteristiques : Composition of many {
                          name  : String;
                          value : String;
                        };
};

@cds.autoexpose  @readonly  @cds.odata.valuelist
entity VinColor : CodeList {
  key code : String @assert.range enum {
        Rouge;
        ![Rosé];
        Vert;
        Blanc;
      };
};

@cds.autoexpose  @readonly : true
entity BiereColor : CodeList {

  key code : String @assert.range enum {
        Rousse;
        Blanche;
        Blonde;
        ![Ambrée];
        Stout;
        Brune;
      };
};

entity Biere : Boisson {
  color  : Association to BiereColor;
  @Measures : {ISOCurrency : devise_code, }
  prix   : Decimal;
  devise : Currency;
};

define view ColorCepage as
  select from Cepage distinct {
    key couleur as ID : String
  };

define view TypeBoisson as
  select from Vin distinct {
    key type as ID : String
  };
