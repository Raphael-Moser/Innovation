public class IntegrationScheduler implements Schedulable {

    private Integer minutes;

    public IntegrationScheduler( Integer minutes ) {
        this.minutes = minutes;
    }

    public void execute ( SchedulableContext context ) {
        System.enqueueJob(new IntegrationQueueable());
        this.finish();
    }

    public void finish () {
        start(this.minutes);
    }

    public static void start( Integer minutes ) {
        new ScheduleHelper().scheduleIntoNextMinutes( new IntegrationScheduler(minutes), minutes );
    }
}