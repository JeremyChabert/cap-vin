using API as service from '../srv/services';

annotate service.Vin with @(title : '{i18n>vin}',

) {
  name   @title : '{i18n>name}';
  type   @title : '{i18n>type}';
  volume @title : '{i18n>volume}';
  degre  @title : '{i18n>degre}';
  color  @title : '{i18n>categorie}';
  annee  @title : '{i18n>millesime}';
  prix   @title : '{i18n>prix}';
  AOC    @title : '{i18n>AOC}';
  IGP    @title : '{i18n>IGP}';
};

annotate service.Assemblage with @(title : '{i18n>assemblage}',

) {
  name        @title : '{i18n>cepage}';
  description @title : '{i18n>cepage_description}';
  pourcent    @title : '{i18n>teneur}';
};

annotate service.Cepage with @(title : '{i18n>cepage}',

) {
  name           @title : '{i18n>cepage}';
  description    @title : '{i18n>cepage_description}';
  couleur        @title : '{i18n>couleur}';
  to_vins_vin_ID @title : '{i18n>vin}';
};

annotate service.Superficie with @(title : '{i18n>superficie}',

) {
  annee      @title : '{i18n>annee}';
  superficie @title : '{i18n>superficie}';
};