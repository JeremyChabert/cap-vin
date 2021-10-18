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
  aoc    @title : '{i18n>aoc}';
  igp    @title : '{i18n>igp}';
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
  to_vins_vin_ID @title : '{i18n>vin}';
};
