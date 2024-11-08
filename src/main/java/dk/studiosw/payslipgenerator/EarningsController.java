package dk.studiosw.payslipgenerator;

import dk.studiosw.payslipgenerator.dao.*;
import dk.studiosw.payslipgenerator.pdfgenerator.PdfGenerator;
import jakarta.servlet.http.HttpServletResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.*;

import java.io.*;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.*;
import java.util.stream.Collectors;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

@RestController()
public class EarningsController {

    private final static DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern( "dd.MM.yyyy");
    Logger logger = LoggerFactory.getLogger(EarningsController.class);

    private final EarningsRepository repo;
    private final PayslipRepository paysliprepo;
    private final PdfGenerator pdfGenerator;

    public EarningsController(EarningsRepository repo, PayslipRepository paysliprepo, PdfGenerator pdfGenerator) {
        this.repo = repo;
        this.paysliprepo = paysliprepo;
        this.pdfGenerator = pdfGenerator;
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
    Collection<ModelEarningPeriodVO> getModelEarningPeriods(@RequestParam UUID earningPeriodId, @RequestParam(required = false, defaultValue  = "false") boolean excludeEarnings) {
        var meps = repo.getModelEarningPeriods(earningPeriodId, excludeEarnings);
        if(!excludeEarnings) {

            // Read the generic lines and add them to the matching modelEarningPeriod
            var lines = paysliprepo.getGenericlines(meps.stream().map(line -> line.id()).collect(Collectors.toList()));
            for(var l: lines) {
                var mepThatLineBelongsTo = meps.stream().filter(mep -> mep.id().equals(l.modelearningperiodId())).findFirst();
                if(mepThatLineBelongsTo.isPresent()) {
                    mepThatLineBelongsTo.get().payslipLines().add(l);
                }
            }
            // When there are no lines, just make an empty list to avoid errors
            meps = meps.stream().map(mep-> mep.payslipLines() != null ? mep : mep.withPayslipLines(new ArrayList<>())).collect(Collectors.toList());
        }

        return meps;
    }

    @GetMapping(value = "api/pdf")
    void getModelEarningPeriodsAsPdf(@RequestParam UUID earningPeriodId, HttpServletResponse response) throws IOException {

        response.setContentType(MediaType.APPLICATION_OCTET_STREAM_VALUE);
        response.setHeader(HttpHeaders.CONTENT_DISPOSITION, "attachment;filename=\"pagos " + LocalDate.now().format(dateFormatter) + ".zip\"");

        var modelEarningPeriods = paysliprepo.getModelEarningPeriodsWithEarningsInPeriod(earningPeriodId);
        var zos = new ZipOutputStream(response.getOutputStream());
        byte[] buffer = new byte[1024];

        modelEarningPeriods.forEach(mep -> {
            try {
                var payslip = paysliprepo.getPayslip(mep);
                var bos = new ByteArrayOutputStream();

                pdfGenerator.generate(bos, payslip);
                zos.putNextEntry(new ZipEntry(payslip.getFullname() + ".pdf"));

                int length;

                var bis = new ByteArrayInputStream(bos.toByteArray());
                while ((length = bis.read(buffer)) > 0) {
                    zos.write(buffer, 0, length);
                }
                zos.closeEntry();
                bis.close();
            } catch (IOException e) {
                throw new RuntimeException(e);
            }
        });

        zos.close();
    }

    @PostMapping(path = "api/modelearnings", consumes = MediaType.APPLICATION_JSON_VALUE)
    String postModelEarnings(@RequestBody List<ModelEarningPeriodVO> periods) {
        repo.insertOrUpdateModelEarnings(periods);
        return "{\"status\": \"ok\"}";
    }

    @PostMapping(path = "api/modelearningperiods", consumes = MediaType.APPLICATION_JSON_VALUE)
    String postModelEarningPeriods(@RequestBody List<ModelEarningPeriodVO> periods) {
        repo.insertOrUpdateModelEarningPeriods(periods);
        return "{\"status\": \"ok\"}";
    }

    @PostMapping(path = "api/earningperiod", consumes = MediaType.APPLICATION_JSON_VALUE)
    String postEarningPeriods(@RequestBody List<EarningPeriodVO> earningperiods) {
        earningperiods.forEach(ep -> repo.insertOrUpdateEarningPeriod(ep));
        return "{\"status\": \"ok\"}";
    }

}
