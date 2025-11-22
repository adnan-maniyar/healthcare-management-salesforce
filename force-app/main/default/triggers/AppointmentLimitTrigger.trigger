trigger AppointmentLimitTrigger on Appointment__c (before insert) {
    for(Appointment__c app : Trigger.new){
        if(app.Doctor__c != null && app.Appointment_Date__c != null){
            Integer countExisting = [
                SELECT COUNT() FROM Appointment__c
                WHERE Doctor__c = :app.Doctor__c
                AND Appointment_Date__c = :app.Appointment_Date__c
            ];

            if(countExisting >= 8){
                app.addError('This doctor already has 8 appointments today.');
            }
        }
    }
}
