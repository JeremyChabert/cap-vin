using API as service from '../../srv/services';

annotate service.Vin with @odata.draft.enabled;
annotate service.Vin with @Common.SemanticKey : [ID];