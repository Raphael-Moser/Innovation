import { LightningElement } from 'lwc';
import getIntegrationStatus from '@salesforce/apex/IntegrationStatusController.getIntegrationStatus';

export default class IntegrationStatusList extends LightningElement {

    records;
    error;
    interval;

    connectedCallback() {
        this.loadData();
        this.interval = setInterval(() => {
            this.loadData();
            console.log('Entrou');
        }, 3000);
    }

    disconnectedCallback() {
        if (this.interval) {
            clearInterval(this.interval);
        }
    }

    async loadData() {
        getIntegrationStatus()
            .then((data) => {
                this.records = data.map(item => ({
                    ...item,
                    cssClass: item.LastStatusReceived__c === '200'
                        ? 'box success'
                        : 'box error'
                }));
            })
            .catch(error => {
                this.error = error;
            });
    }
}