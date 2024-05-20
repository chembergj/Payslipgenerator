package dk.studiosw.payslipgenerator.dao;

import dk.studiosw.payslipgenerator.TestConstants;
import dk.studiosw.payslipgenerator.PayslipgeneratorApplication;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.TestPropertySource;
import org.springframework.test.context.junit.jupiter.SpringExtension;

import java.time.LocalDate;
import java.util.UUID;

import static org.junit.jupiter.api.Assertions.*;

@ExtendWith(SpringExtension.class)
@SpringBootTest(classes = PayslipgeneratorApplication.class)
@TestPropertySource(locations="classpath:test.properties")
class PayslipRepositoryTest {

    @Autowired
    PayslipRepository repo;

    @Test
    public void testGetPayslip() {

        PayslipVO payslip = repo.getPayslip(UUID.fromString("d9eeca3f-81d6-49d3-98cd-25d026cca33b"));

        // ASSERT

        assertNotNull(payslip);
        // ACT

        assertEquals(TestConstants.NAME_MODEL_WITH_CB_AND_SC, payslip.getFullname());
        assertEquals(LocalDate.of(2024, 3, 11), payslip.getFromDate());
        assertEquals(LocalDate.of(2024, 3, 18), payslip.getToDate());
        assertEquals(65, payslip.getPercentage());
        assertEquals(3780, payslip.getTRM());

        assertEquals(2, payslip.getLines().size());

        var cb = payslip.getLines().stream().filter(l -> l.website() == Website.Chaturbate).findAny();
        assertTrue(cb.isPresent());
        assertEquals(cb.get().tokens(), 461);

        var sc = payslip.getLines().stream().filter(l -> l.website() == Website.Stripchat).findAny();
        assertTrue(sc.isPresent());
        assertEquals(sc.get().tokens(), 162);
    }

    @Test
    void canGetModelEarningPeriodsWithEarnings() {
        var models = repo.getModelEarningPeriodsWithEarningsInPeriod(UUID.fromString("dac91a67-0c3b-43fd-8b0c-5e689a56133a"));
        assertEquals(2, models.size());
    }
}