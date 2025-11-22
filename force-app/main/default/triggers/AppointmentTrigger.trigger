trigger AppointmentTrigger on Appointment__c (before insert, before update) {
    if(Trigger.isBefore && Trigger.isInsert){
        AppointmentHandler.assignDoctor(Trigger.new);
    }
}
