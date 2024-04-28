package dk.studiosw.payslipgenerator;

import dk.studiosw.payslipgenerator.dao.EarningPeriodVO;
import dk.studiosw.payslipgenerator.dao.EarningsRepository;
import dk.studiosw.payslipgenerator.dao.ModelEarningPeriodVO;
import dk.studiosw.payslipgenerator.dao.ModelVO;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.Collection;
import java.util.List;
import java.util.UUID;

@RestController()
public class EarningsController {

    private final EarningsRepository repo;

    public EarningsController(EarningsRepository repo) {
        this.repo = repo;
    }


    @GetMapping("api/earningperiods")
    List<EarningPeriodVO> getEarnings() {
        return repo.getEarningPeriods();
    }

    @GetMapping("api/models")
    List<ModelVO> getModels(@RequestParam Boolean activeOnly) {
        return repo.getModels(activeOnly);
    }

    @GetMapping("api/modelearningperiods")
    Collection<ModelEarningPeriodVO> getModelEarningPeriods(@RequestParam UUID earningPeriodId) {
        return repo.getModelEarningPeriods(earningPeriodId);
    }
}
