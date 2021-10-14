using {
  cuid,
  managed,
  Currency,
  Country,
  sap.common.CodeList as CodeList
} from './common';

namespace my.cave;

aspect Boisson : managed {
  key name  : String;
  key annee : String(4);
  key type  : String;
  @Measures : {Unit : '%vol'}
  degre     : Decimal(4, 1);
  @Measures : {Unit : unit, }
  volume    : Integer;
  @assert.range
  unit      : String enum {
    L;
    cL;
  }
};

entity Cepage {
  key name        : String(30);
      description : String(200);
}

entity Vin : Boisson {
  key color  : Association to VinColor;
      @Measures : {ISOCurrency : devise_code, }
      prix   : Decimal(6, 2);
      devise : Currency;
      IGP    : Boolean default false;
      AOC    : Boolean default false;
};

@cds.autoexpose  @readonly
entity VinColor : CodeList {
      @assert.range
  key code : String enum {
        Rou = 'Rouge';
        B   = 'Blanc';
        Ros = 'Rosé';
        V   = 'Vert';
      }
};

@cds.autoexpose  @readonly
entity BiereColor : CodeList {
      @assert.range
  key code : String enum {
        R   = 'Rousse';
        Bla = 'Blanche';
        Blo = 'Blonde';
        A   = 'Ambrée';
        S   = 'Stout';
        Bru = 'Brune';
      }
};

entity Biere : Boisson {
  color  : Association to BiereColor;
  @Measures : {ISOCurrency : devise_code, }
  prix   : Decimal;
  devise : Currency;
}
