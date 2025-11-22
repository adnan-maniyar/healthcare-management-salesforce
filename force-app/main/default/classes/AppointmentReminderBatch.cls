global class AppointmentReminderBatch implements Database.Batchable<sObject>, Database.Stateful {
    global Database.QueryLocator start(Database.BatchableContext bc) {
        Date tomorrow = Date.today().addDays(1);
        return Database.getQueryLocator([SELECT Id, Appointment_Date__c, Patient__r.Email__c, Patient__r.Name
                                         FROM Appointment__c
                                         WHERE Appointment_Date__c = :tomorrow]);
    }
    global void execute(Database.BatchableContext bc, List<Appointment__c> scope) {
        List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();
        List<Appointment__c> updates = new List<Appointment__c>();
        for (Appointment__c appt : scope) {
            if (appt.Patient__r != null && !String.isBlank(appt.Patient__r.Email__c)) {
                Messaging.SingleEmailMessage m = new Messaging.SingleEmailMessage();
                m.setToAddresses(new String[]{appt.Patient__r.Email__c});
                m.setSubject('Appointment Reminder');
                m.setPlainTextBody('Hello ' + appt.Patient__r.Name + ', your appointment is on ' + appt.Appointment_Date__c);
                emails.add(m);
                // mark logic here if you have Reminder_Sent__c
                // appt.Reminder_Sent__c = true; updates.add(appt);
            }
        }
        if (!emails.isEmpty()) Messaging.sendEmail(emails);
        if (!updates.isEmpty()) update updates;
    }
    global void finish(Database.BatchableContext bc) {
        System.debug('AppointmentReminderBatch finished');
    }
}
