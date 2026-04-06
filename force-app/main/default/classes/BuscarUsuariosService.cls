public with sharing class BuscarUsuariosService {

    public class UsuarioDTO {
        public String createdAt;
        public String name;
        public String id;
    }
    @AuraEnabled
    public static List<UsuarioDTO> buscarUsuarios() {

        HttpResponse res = IntegrationService.calloutIntegration('BuscaUsuarios');

        IntegrationStatus__c is = [SELECT Id, Name, LastStatusReceived__c FROM IntegrationStatus__c WHERE Name = 'Busca de Usuários' LIMIT 1];
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