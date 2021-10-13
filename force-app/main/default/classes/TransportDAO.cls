public class TransportDAO {
    public static Integer getNumberOfStops(Id busRouteId){
        Decimal mydecval = [SELECT TotalStops__c FROM BusRoute__c WHERE Id = :busRouteId].TotalStops__c;
        Integer numberOfBusStops = mydecval.intValue();
        return numberOfBusStops;
    }
    public static Id getLongestByTimeRouteId(){
        List<BusRoute__c> routes = new List<BusRoute__c>([SELECT DurationInMinutes__c, id FROM BusRoute__c ORDER BY DurationInMinutes__c DESC NULLS LAST LIMIT 1]);
        return routes.get(0).id;
    }
    public static List<Schedule__c> getSchedules(Integer limits, Integer offset){
        List<Schedule__c> schedules = new List<Schedule__c>([SELECT id FROM Schedule__c LIMIT :limits OFFSET :offset]);
        return schedules;
    }
    public static List<BusStop__c> getBusStopsByIds(Set<Id> busStops){
        List<BusStop__c> stops = new List<BusStop__c>([SELECT id FROM BusStop__c WHERE Id IN :busStops]);
        return stops;
    }
    public static List<BusRoute__c> getBusRoutes(Set<Id> busStops){
       List<Schedule__c> sch = new List<Schedule__c>([SELECT BusRoute__c FROM Schedule__c WHERE BusStop__c IN :busStops]);
       Set<Id> routesId = new Set<Id>();
        for (Integer i=0; i<sch.size(); i++) {
            routesId.add(sch[i].BusRoute__c);
        }
        List<BusRoute__c> routes = new List<BusRoute__c>([SELECT id FROM BusRoute__c WHERE Id IN :routesId]);
        return routes;
    }
    public static Map<Id, Integer> getBusRoutesWithMinDuration(Integer limits){
        List<BusRoute__c> routeMinDuration = new List<BusRoute__c>([SELECT DurationInMinutes__c FROM BusRoute__c ORDER BY DurationInMinutes__c ASC NULLS FIRST LIMIT :limits]);
        Map<Id, Integer> minRoutes = new Map<Id, Integer>();
        for(BusRoute__c r: routeMinDuration) {
           minRoutes.put(r.id, r.DurationInMinutes__c.intValue());  
        }
        return minRoutes;
    }
    public static Map<Id, Integer> getBusRoutesWithMaxDuration(Integer limits){
        List<BusRoute__c> routeMaxDuration = new List<BusRoute__c>([SELECT DurationInMinutes__c FROM BusRoute__c ORDER BY DurationInMinutes__c DESC NULLS LAST LIMIT :limits]);
        Map<Id, Integer> maxRoutes = new Map<Id, Integer>();
        for(BusRoute__c r: routeMaxDuration) {
           maxRoutes.put(r.id, r.DurationInMinutes__c.intValue());  
        }
        return maxRoutes;
    }
}