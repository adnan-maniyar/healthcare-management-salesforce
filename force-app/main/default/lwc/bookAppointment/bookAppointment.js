import { LightningElement } from 'lwc';
import createAppointment from '@salesforce/apex/AppointmentService.createAppointment';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class BookAppointment extends LightningElement {

    patientId;
    doctorId;
    appDate;
    reason;

    handlePatient(e){ this.patientId = e.target.value; }
    handleDoctor(e){ this.doctorId = e.target.value; }
    handleDate(e){ this.appDate = e.target.value; }
    handleReason(e){ this.reason = e.target.value; }

    createApp(){
        createAppointment({
            app : {
                Patient__c : this.patientId,
                Doctor__c : this.doctorId,
                Appointment_Date__c : this.appDate,
                Reason__c : this.reason
            }
        })
        .then(() => {
            this.dispatchEvent(new ShowToastEvent({
                title: 'Success',
                message: 'Appointment Created',
                variant: 'success'
            }));
        })
        .catch(error => {
            console.log(error);
        });
    }
}
