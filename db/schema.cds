using {
  cuid,
  managed,
  Currency,
  Country,
  sap.common.CodeList as CodeList
} from './common';

namespace my.cave;

aspect Boisson : cuid, managed {
  name   : String(50);
  annee  : String(4)@assert.format : '[0-9]';
  type   : String(15);
  @Measures :                        {Unit : '%vol'}
  degre  : Decimal(4, 1);
  @Measures :                        {Unit : unit, }
  volume : Integer default 75;
  unit   : String(3)@assert.range enum {
    L;
    cL;
  } default 'cL';
};

entity Cepage {
  key name           : String(30);
      description    : String(400);
      color          : String(10)@assert.range enum {
        Noir;
        Blanc;
      };
      to_vins        : Association to many Assemblage
                         on to_vins.cepage = $self;
      to_superficies : Composition of many Superficie
                         on to_superficies.to_cepage = $self;
};

entity Superficie       @(assert.unique : {Superficie : [
  to_cepage,
  annee
]}) : cuid {
  to_cepage  : Association to one Cepage;
  annee      : String(4)@assert.format : '[0-9]';
  @Measures :                            {Unit : 'ha'}
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
  color                                                : Association to VinColor;
  @Measures :       {ISOCurrency : devise_code, }
  prix                                                 : Decimal(6, 2);
  devise                                               : Currency;
  igp                                                  : Boolean default false;
  aoc                                                  : Boolean default false;
  region                                               : Association to Region;
  @Measures :       {Unit : '{i18n>anneeGarde}'} garde : Integer
    @assert.range : [
      1,
      20
    ] default 1;
  to_cepages                                           : Composition of many Assemblage
                                                           on to_cepages.vin = $self;
  to_caracteristiques                                  : Composition of many {
                                                           name  : String;
                                                           value : String;
                                                         };
  @Core.Computed
  status                                               : Association to RetentionStatus;
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
    key color as ID : String
  };

define view TypeBoisson as
  select from Vin distinct {
    key type as ID : String
  };

@cds.autoexpose  @readonly : true
entity RetentionStatus : CodeList {
  key code        : String(1);
      criticality : Integer; //  1:red colour 2: yellow colour,  3: green colour, 0: unknown
};

entity Cave : cuid {
  vin      : Association to one Vin;
  @Measures : {Unit : '{i18n>bottles}'}
  quantity : Integer;
};

entity Region {
  key subregion : String;
      region    : String;
      country   : Country;
}
