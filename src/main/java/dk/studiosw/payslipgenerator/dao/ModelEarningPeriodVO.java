package dk.studiosw.payslipgenerator.dao;

import java.util.List;
import java.util.UUID;

public record ModelEarningPeriodVO(UUID id, UUID modelId, String modelName, double percentage, List<ModelEarningVO> modelEarnings) { }
