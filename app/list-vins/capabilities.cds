using API as service from '../../srv/services';

annotate service.Vin with @fiori.draft.enabled @odata.draft.enabled;
annotate service.Vin with @Common.SemanticKey : [ID];