import { LightningElement, track } from 'lwc';
import searchPatients from '@salesforce/apex/AppointmentService.searchPatients';

export default class PatientSearch extends LightningElement {
    searchKey = '';
    patients;
    columns = [
        { label: 'Name', fieldName: 'Name' },
        { label: 'Email', fieldName: 'Email__c' },
        { label: 'Phone', fieldName: 'Phone__c' }
    ];

    handleChange(event){
        this.searchKey = event.target.value;

        searchPatients({ keyword: this.searchKey })
        .then(result => {
            this.patients = result;
        })
        .catch(error => {
            console.error(error);
        });
    }
}
