public class TimeUtils {
    public static Time calculateMinimumTime(List<Time> timeList){
        Time minTime;
        timeList.sort();
        minTime = timeList.get(0);
        return minTime;
    }
    public static Time calculateMaximumTime(List<Time> timeList){
        Time maxTime;
        timeList.sort();
        maxTime= timeList.get(timeList.size()-1);
        return maxTime;
    }
}