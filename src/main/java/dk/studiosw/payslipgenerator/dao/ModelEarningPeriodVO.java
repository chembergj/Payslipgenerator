package dk.studiosw.payslipgenerator.dao;

import java.util.List;
import java.util.UUID;

public record ModelEarningPeriodVO(UUID id, UUID modelId, UUID earningPeriodId, String modelName, double percentage, List<ModelEarningVO> modelEarnings) {
    public ModelEarningPeriodVO withModelEarnings(List<ModelEarningVO> modelEarnings) {
        return new ModelEarningPeriodVO(id, modelId, earningPeriodId, modelName, percentage, modelEarnings);
    }

    public ModelEarningPeriodVO withPercentage(double percentage) {
        return new ModelEarningPeriodVO(id, modelId, earningPeriodId, modelName, percentage, modelEarnings);
    }
}
