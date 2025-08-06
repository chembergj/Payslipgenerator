package dk.studiosw.payslipgenerator.dao;

import java.util.Arrays;

public enum Website {

    Chaturbate("CB"),
    Cam4("C4"),
    LiveJasmin("LJ"),
    CamSoda("CS"),
    Stripchat("SC"),
    Onlyfans("OF"),

    XLove("XL");

    private final String dbName;


    Website(String dbName) {
        this.dbName = dbName;
    }

    public String getDbName() {
        return dbName;
    }

    public static Website fromDbName(String dbName) {
        return Arrays.stream(Website.values()).filter(ws -> ws.getDbName().equalsIgnoreCase(dbName)).findFirst().get();
    }
}
