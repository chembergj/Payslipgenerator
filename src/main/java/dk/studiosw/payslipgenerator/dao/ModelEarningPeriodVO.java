package dk.studiosw.payslipgenerator.dao;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

public record ModelEarningPeriodVO(UUID id, UUID modelId, UUID earningPeriodId, String modelName, double percentage, Optional<Double> specialTRM, Optional<Double> hoursWorked, List<ModelEarningVO> modelEarnings, List<PayslipGenericLineVO> payslipLines) {
    public ModelEarningPeriodVO withModelEarnings(List<ModelEarningVO> modelEarnings) {
        return new ModelEarningPeriodVO(id, modelId, earningPeriodId, modelName, percentage, specialTRM, hoursWorked, modelEarnings, payslipLines);
    }

    public ModelEarningPeriodVO withPercentage(double percentage) {
        return new ModelEarningPeriodVO(id, modelId, earningPeriodId, modelName, percentage, specialTRM, hoursWorked, modelEarnings, payslipLines);
    }

    public ModelEarningPeriodVO withTRM(Optional<Double> TRM) {
        return new ModelEarningPeriodVO(id, modelId, earningPeriodId, modelName, percentage, TRM, hoursWorked, modelEarnings, payslipLines);
    }

    public ModelEarningPeriodVO withHoursWorked(Optional<Double> hoursWorked) {
        return new ModelEarningPeriodVO(id, modelId, earningPeriodId, modelName, percentage, specialTRM, hoursWorked, modelEarnings, payslipLines);
    }
    public ModelEarningPeriodVO withPayslipLines(List<PayslipGenericLineVO> payslipLines) {
        return new ModelEarningPeriodVO(id, modelId, earningPeriodId, modelName, percentage, specialTRM, hoursWorked, modelEarnings, payslipLines);
    }

}
