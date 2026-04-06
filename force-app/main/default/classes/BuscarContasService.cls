public with sharing class BuscarContasService {

    public class UsuarioDTO {
        public String id;
        public String accountName;
    }
    @AuraEnabled
    public static List<UsuarioDTO> buscarContas() {

        HttpResponse res = IntegrationService.calloutIntegration('BuscaContas');

        IntegrationStatus__c is = [SELECT Id, Name, LastStatusReceived__c FROM IntegrationStatus__c WHERE Name = 'Busca de Contas' LIMIT 1];
        if (res.getStatusCode() != 200) {
            if(is != null){
                is.LastStatusReceived__c = String.valueOf(res.getStatusCode());
            }
        } else {
            if(is != null){
                is.LastStatusReceived__c = String.valueOf(res.getStatusCode());
            }
        }
        update is;

        List<UsuarioDTO> usuarios = (List<UsuarioDTO>) JSON.deserialize(
            res.getBody(),
            List<UsuarioDTO>.class
        );

        return usuarios;
    }
}