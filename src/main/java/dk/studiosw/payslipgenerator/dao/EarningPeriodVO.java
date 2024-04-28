package dk.studiosw.payslipgenerator.dao;

import java.time.LocalDate;
import java.util.UUID;

public record EarningPeriodVO(UUID id, LocalDate fromDate, LocalDate toDate, double TRM, LocalDate TRMDate) {}
