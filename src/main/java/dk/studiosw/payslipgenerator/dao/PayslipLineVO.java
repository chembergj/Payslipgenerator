package dk.studiosw.payslipgenerator.dao;

public class PayslipLineVO {
    final String pagename;
    final int tokens;

    public PayslipLineVO(String pagename, int tokens) {
        this.pagename = pagename;
        this.tokens = tokens;
    }

    public int getTokens() {
        return tokens;
    }

    public String getPagename() {
        return pagename;
    }
}
