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

    private final double hoursWorked;
    private final LocalDate calculationDate;

    private final List<PayslipIncomeLineVO> lines;

    private final List<PayslipGenericLineVO> genericLines;

    public PayslipVO(String fullname, LocalDate fromDate, LocalDate toDate, double percentage, double TRM, UUID modelEarningPeriodId, LocalDate calculationDate, double hoursWorked) {
        this.fullname = fullname;
        this.fromDate = fromDate;
        this.toDate = toDate;
        this.percentage = percentage;
        this.TRM = TRM;
        this.modelEarningPeriodId = modelEarningPeriodId;
        this.calculationDate = calculationDate;
        this.hoursWorked = hoursWorked;

        lines = new ArrayList<>();
        genericLines = new ArrayList<>();
    }

    public List<PayslipIncomeLineVO> getLines() {
        return lines;
    }

    public boolean hasNonezeroIncome() {
        return lines.stream().anyMatch(l -> l.tokens() != 0);
    }

    public List<PayslipGenericLineVO> getGenericLines() {
        return genericLines;
    }

    public void addLine(PayslipIncomeLineVO line) {
        this.lines.add(line);
    }

    public void addLine(PayslipGenericLineVO line) {
        this.genericLines.add(line);
    }

    public void addAllLines(Collection<PayslipIncomeLineVO> lines) {
        this.lines.addAll(lines);
    }

    public void addAllGenericLines(Collection<PayslipGenericLineVO> lines) {
        this.genericLines.addAll(lines);
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

    public double getHoursWorked() { return hoursWorked; }

    public UUID getModelEarningPeriodId() {
        return modelEarningPeriodId;
    }

    public LocalDate getCalculationDate() {
        return calculationDate;
    }
}
