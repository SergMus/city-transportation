public class StringArrayTest {
    public static List<String> generateStringArray(Integer arrayLength) {
        List<String> testVal = new List<String>();
        String test = 'Test ';
        for (Integer i=0; i<arrayLength; i++) {
            testVal.add(test+ i);
        }
        return testVal;
    }
}