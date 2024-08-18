package dk.studiosw.payslipgenerator.dao;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

public record ModelEarningPeriodVO(UUID id, UUID modelId, UUID earningPeriodId, String modelName, double percentage, Optional<Double> specialTRM, List<ModelEarningVO> modelEarnings) {
    public ModelEarningPeriodVO withModelEarnings(List<ModelEarningVO> modelEarnings) {
        return new ModelEarningPeriodVO(id, modelId, earningPeriodId, modelName, percentage, specialTRM, modelEarnings);
    }

    public ModelEarningPeriodVO withPercentage(double percentage) {
        return new ModelEarningPeriodVO(id, modelId, earningPeriodId, modelName, percentage, specialTRM, modelEarnings);
    }

    public ModelEarningPeriodVO withTRM(Optional<Double> TRM) {
        return new ModelEarningPeriodVO(id, modelId, earningPeriodId, modelName, percentage, TRM, modelEarnings);
    }
}
