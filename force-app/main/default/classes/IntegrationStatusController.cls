public with sharing class IntegrationStatusController {

    @AuraEnabled(cacheable=false)
    public static List<IntegrationStatus__c> getIntegrationStatus() {
        return [
            SELECT Id, Name, LastStatusReceived__c
            FROM IntegrationStatus__c
            ORDER BY CreatedDate DESC
        ];
    }
}