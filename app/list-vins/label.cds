using API as service from '../../srv/services';

annotate service.Vin with @(title : 'Vin',

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
