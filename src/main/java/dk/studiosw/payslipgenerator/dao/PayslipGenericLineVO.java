package dk.studiosw.payslipgenerator.dao;

import java.util.UUID;

public record PayslipGenericLineVO(UUID Id, String text, double amount, UUID modelearningperiodId) {
}
