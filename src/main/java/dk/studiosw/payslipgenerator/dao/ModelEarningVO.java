package dk.studiosw.payslipgenerator.dao;

import java.time.LocalDate;
import java.util.UUID;

public record ModelEarningVO(UUID id, UUID modelAccountId, String modelUserName, Website website, Double noOfUnits, UUID modelEarningPeriodId) { }
