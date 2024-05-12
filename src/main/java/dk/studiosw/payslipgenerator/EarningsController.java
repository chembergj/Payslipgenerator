package dk.studiosw.payslipgenerator;

import dk.studiosw.payslipgenerator.dao.EarningPeriodVO;
import dk.studiosw.payslipgenerator.dao.EarningsRepository;
import dk.studiosw.payslipgenerator.dao.ModelEarningPeriodVO;
import dk.studiosw.payslipgenerator.dao.ModelVO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.*;

import java.util.Collection;
import java.util.List;
import java.util.Map;
import java.util.UUID;

@RestController()
public class EarningsController {

    Logger logger = LoggerFactory.getLogger(EarningsController.class);

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

    @PostMapping(path = "api/modelearningperiods", consumes = MediaType.APPLICATION_JSON_VALUE)
    String postModelEarningPeriods(@RequestBody Collection<ModelEarningPeriodVO> periods) {
        logger.info(periods.toString());
        return "noget";
    }
}
