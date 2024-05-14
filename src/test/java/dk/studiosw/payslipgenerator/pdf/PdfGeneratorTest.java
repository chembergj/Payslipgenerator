package dk.studiosw.payslipgenerator.pdf;

import dk.studiosw.payslipgenerator.PayslipgeneratorApplication;
import dk.studiosw.payslipgenerator.dao.PayslipLineVO;
import dk.studiosw.payslipgenerator.dao.PayslipVO;
import dk.studiosw.payslipgenerator.dao.Website;
import dk.studiosw.payslipgenerator.pdfgenerator.PdfGenerator;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.io.FileNotFoundException;
import java.time.LocalDate;

@SpringBootTest(classes = PayslipgeneratorApplication.class)
class PdfGeneratorTest {

    @Autowired
    PdfGenerator pdfGenerator;

    @Test
    public void testGenerate() throws FileNotFoundException {

        var payslip = new PayslipVO(
                "Test Testing",
                LocalDate.of(2024, 3, 11),
                LocalDate.of(2024, 3, 17),
                65,
                3545,
                null,
                LocalDate.now());

        payslip.addLine(new PayslipLineVO(Website.Chaturbate, 3437));
        payslip.addLine(new PayslipLineVO(Website.Cam4, 310));
        pdfGenerator.generate("test.pdf", payslip);

    }
}