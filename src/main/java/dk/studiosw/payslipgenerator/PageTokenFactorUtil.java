package dk.studiosw.payslipgenerator;

import dk.studiosw.payslipgenerator.dao.Website;

public class PageTokenFactorUtil {
    public static double getTokenFactor(Website website) {
        switch(website) {
            case Cam4: return 0.10;
            case Onlyfans, LiveJasmin: return 1.0;
            default: return 0.05;
        }
    }
}
