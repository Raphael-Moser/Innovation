public with sharing class IntegrationService {

    public static HttpResponse calloutIntegration(String integrationName){

            Integration__mdt config = [
            SELECT Endpoint__c, Method__c
            FROM Integration__mdt
            WHERE DeveloperName = :integrationName
            LIMIT 1
            ];

            HttpRequest req = new HttpRequest();
            req.setEndpoint(config.Endpoint__c);
            req.setMethod(config.Method__c);
            req.setHeader('Content-Type', 'application/json');

            Http http = new Http();
            HttpResponse res;


            res = http.send(req);

            return res;
    }
}