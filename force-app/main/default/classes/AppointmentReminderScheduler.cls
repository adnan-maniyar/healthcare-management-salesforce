global class AppointmentReminderScheduler implements Schedulable {
    global void execute(SchedulableContext sc) {
        // Launch batch with a chunk size of 50 (adjust as needed)
        Database.executeBatch(new AppointmentReminderBatch(), 50);
    }
}
