public class TransportServices {
    public static void createStop(String name, String address){
        BusStop__c busStop = new BusStop__c(name=name, address__c=address); 
        try {
           insert busStop; 
        } catch(dmlException e) {
            System.debug('The following exception has occurred: ' + e.getMessage());
        }
        
    }
    public static void addStopToSchedule(Id busRouteId, Id busStopId, Time timeValue){
        Schedule__c schedule = new Schedule__c(BusRoute__c=busRouteId, BusStop__c=busStopId, Time__c=timeValue);
        try {
           insert schedule; 
        } catch(dmlException e) {
            System.debug('The following exception has occurred: ' + e.getMessage());
        }
    }
    public static void updateScheduleTimes(List <ScheduleTimeHelper> scheduleTimes){
        List <Id> idList = new List <Id>();
        for (ScheduleTimeHelper r :  scheduleTimes) {
            idList.add(r.scheduleId);
        }
        List <Schedule__c> schedulesList = [SELECT id FROM Schedule__c WHERE id IN :idList];
        for (ScheduleTimeHelper r :  scheduleTimes) {
            for (Schedule__c k : schedulesList) {
                if (r.scheduleId == k.id) {
                    k.Time__c = r.timeValue;
                }
            }
        }
        try {
            update schedulesList;
        } catch(dmlException e) {
            System.debug('The following exception has occurred: ' + e.getMessage());
        }        
    }
    public static void deleteBusStop(Id busStopId){
        List<Schedule__c> schedules= [SELECT id FROM Schedule__c WHERE BusStop__c= :busStopId];
        BusStop__c bus = [SELECT Id FROM BusStop__c WHERE Id = :busStopId];
        try {
            delete schedules;
            delete bus;
        } catch(dmlException e) {
            System.debug('The following exception has occurred: ' + e.getMessage());
        }
    }
    class ScheduleTimeHelper {
     Id scheduleId;
     Time timeValue;
   }
}