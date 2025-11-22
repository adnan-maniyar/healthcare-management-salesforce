
  public class AppointmentHandler {

    public static void assignDoctor(List<Appointment__c> appointments){
        Set<String> specializations = new Set<String>();

        for(Appointment__c app : appointments){
            if(app.Reason__c != null){
                specializations.add(app.Reason__c);
            }
        }

        Map<String, List<Doctor__c>> doctorMap = new Map<String, List<Doctor__c>>();

        for(Doctor__c d : [
            SELECT Id, Name, Specialization__c 
            FROM Doctor__c 
            WHERE Specialization__c IN :specializations
        ]) {
            if(!doctorMap.containsKey(d.Specialization__c)){
                doctorMap.put(d.Specialization__c, new List<Doctor__c>());
            }
            doctorMap.get(d.Specialization__c).add(d);
        }

        for(Appointment__c app : appointments){
            if(app.Doctor__c == null && doctorMap.containsKey(app.Reason__c)){
                app.Doctor__c = doctorMap.get(app.Reason__c)[0].Id;
            }
        }
    }
}

