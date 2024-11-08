package dk.studiosw.payslipgenerator.pdf;

import dk.studiosw.payslipgenerator.PayslipgeneratorApplication;
import dk.studiosw.payslipgenerator.dao.PayslipGenericLineVO;
import dk.studiosw.payslipgenerator.dao.PayslipIncomeLineVO;
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
                LocalDate.now(),
                30.5);

        payslip.addLine(new PayslipIncomeLineVO(Website.Chaturbate, 3437));
        payslip.addLine(new PayslipIncomeLineVO(Website.Cam4, 310));
        payslip.addLine(new PayslipGenericLineVO(null, "some text", 99.99, null));
        pdfGenerator.generate("test.pdf", payslip);

    }
}