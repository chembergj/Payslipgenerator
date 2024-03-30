package dk.studiosw.payslipgenerator;

public class PageTokenFactorUtil {
    public static double getTokenFactor(String pagename) {
        switch(pagename.toLowerCase()) {
            case "cam4": return 0.10;
            default: return 0.05;
        }
    }
}
