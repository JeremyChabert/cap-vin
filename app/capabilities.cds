using API as service from '../srv/services';

annotate service.Vin with @odata.draft.enabled;
annotate service.Vin with @Common.SemanticKey : [ID];
annotate service.Cepage with @odata.draft.enabled;
annotate service.Cepage with @Common.SemanticKey : [name];
// annotate service.Assemblage with @odata.draft.enabled;
// annotate service.Assemblage with @Common.SemanticKey : [ID];