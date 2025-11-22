public with sharing class AppointmentService {

    @AuraEnabled(cacheable=true)
    public static List<Patient__c> searchPatients(String keyword){
        return [
            SELECT Id, Name, Email__c, Contact__c 
            FROM Patient__c
            WHERE Name LIKE :('%' + keyword + '%')
        ];
    }

    @AuraEnabled(cacheable=true)
    public static List<Appointment__c> getAppointments(Id doctorId){
        return [
            SELECT Id, Name, Appointment_Date__c, Patient__r.Name
            FROM Appointment__c
            WHERE Doctor__c = :doctorId
            ORDER BY Appointment_Date__c ASC
        ];
    }

    @AuraEnabled
    public static void createAppointment(Appointment__c app){
        insert app;
    }
}
