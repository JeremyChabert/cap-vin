using API as service from '../../srv/services';
using from '../list-vins/layout';

annotate service.Cepage with @UI : {
  HeaderInfo              : {
    Title          : {
      $Type : 'UI.DataField',
      Value : name,
    },
    TypeName       : '{i18n>cepage}',
    TypeNamePlural : '{i18n>cepages}',
    Description    : {Value : couleur},
    ImageUrl       : 'sap-icon://lab',
  },
  LineItem                : [
    {
      $Type : 'UI.DataField',
      Value : name
    },
    {
      $Type : 'UI.DataField',
      Value : description
    },
    {
      $Type : 'UI.DataField',
      Value : couleur
    }
  ],
  FieldGroup #Description : {Data : [
    {
      $Type : 'UI.DataField',
      Value : name
    },
    {
      $Type : 'UI.DataField',
      Value : description
    },
    {
      $Type : 'UI.DataField',
      Value : couleur
    }
  ]},
  Facets                  : [
    {
      $Type  : 'UI.CollectionFacet',
      ID     : 'CepagesDetails',
      Label  : '{i18n>details}',
      Facets : [{
        $Type  : 'UI.ReferenceFacet',
        Label  : '{i18n>label}',
        Target : '@UI.FieldGroup#Description'
      },

      ],
    },
    {
      $Type  : 'UI.ReferenceFacet',
      Label  : '{i18n>superficies}',
      Target : 'to_superficies/@UI.LineItem'
    },
    // {
    //   $Type  : 'UI.ReferenceFacet',
    //   Label  : '{i18n>mesvins}',
    //   Target : 'to_vins/@UI.LineItem#to_vins'
    // },
  ]
};

annotate service.Superficie with @UI : {

  LineItem                : [
    {
      $Type : 'UI.DataField',
      Value : annee
    },
    {
      $Type : 'UI.DataField',
      Value : superficie
    }
  ],
  FieldGroup #Description : {Data : [
    {
      $Type : 'UI.DataField',
      Value : annee
    },
    {
      $Type : 'UI.DataField',
      Value : superficie
    },
  ]}
}{
  ID                    @UI.Hidden  @UI.HiddenFilter;
  to_cepage_cepage_name @UI.Hidden  @UI.HiddenFilter;
};
