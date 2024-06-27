package dk.studiosw.payslipgenerator.dao;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.UUID;

public class PayslipVO {
    private final String fullname;
    private final LocalDate fromDate;
    private final LocalDate toDate;
    private final double percentage;
    private final double TRM;
    private final UUID modelEarningPeriodId;

    private final LocalDate calculationDate;

    private final List<PayslipLineVO> lines;

    public PayslipVO(String fullname, LocalDate fromDate, LocalDate toDate, double percentage, double TRM, UUID modelEarningPeriodId, LocalDate calculationDate) {
        this.fullname = fullname;
        this.fromDate = fromDate;
        this.toDate = toDate;
        this.percentage = percentage;
        this.TRM = TRM;
        this.modelEarningPeriodId = modelEarningPeriodId;
        this.calculationDate = calculationDate;

        lines = new ArrayList<>();
    }

    public List<PayslipLineVO> getLines() {
        return lines;
    }

    public void addLine(PayslipLineVO line) {
        this.lines.add(line);
    }

    public void addAllLines(Collection<PayslipLineVO> lines) {
        this.lines.addAll(lines);
    }

    public String getFullname() {
        return fullname;
    }

    public LocalDate getFromDate() {
        return fromDate;
    }

    public LocalDate getToDate() {
        return toDate;
    }

    public double getPercentage() {
        return percentage;
    }

    public double getTRM() {
        return TRM;
    }

    public UUID getModelEarningPeriodId() {
        return modelEarningPeriodId;
    }

    public LocalDate getCalculationDate() {
        return calculationDate;
    }
}
