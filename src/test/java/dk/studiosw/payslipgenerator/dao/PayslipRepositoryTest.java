package dk.studiosw.payslipgenerator.dao;

import dk.studiosw.payslipgenerator.TestConstants;
import dk.studiosw.payslipgenerator.PayslipgeneratorApplication;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.TestPropertySource;
import org.springframework.test.context.junit.jupiter.SpringExtension;
import org.springframework.test.context.junit4.AbstractTransactionalJUnit4SpringContextTests;

import java.time.LocalDate;
import java.util.List;
import java.util.UUID;

import static org.junit.jupiter.api.Assertions.*;

@ExtendWith(SpringExtension.class)
@SpringBootTest(classes = PayslipgeneratorApplication.class)
@TestPropertySource(locations="classpath:test.properties")
class PayslipRepositoryTest extends AbstractTransactionalJUnit4SpringContextTests {

    public static final UUID MODEL_EARNING_PERIOD = UUID.fromString("d9eeca3f-81d6-49d3-98cd-25d026cca33b");
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
    public void testGetPayslipWithSpecialTRM() {

        PayslipVO payslip = repo.getPayslip(UUID.fromString("ff3c1e65-1463-4be4-baeb-eeffee2accb5"));

        // ASSERT

        assertNotNull(payslip);
        // ACT

        assertEquals(TestConstants.NAME_MODEL_WITH_CB_AND_SC, payslip.getFullname());
        assertEquals(LocalDate.of(2024, 3, 1), payslip.getFromDate());
        assertEquals(LocalDate.of(2024, 3, 10), payslip.getToDate());
        assertEquals(65, payslip.getPercentage());
        assertEquals(3333, payslip.getTRM());

        assertEquals(1, payslip.getLines().size());
    }

    @Test
    void canGetModelEarningPeriodsWithEarnings() {
        var models = repo.getModelEarningPeriodsWithEarningsInPeriod(UUID.fromString("dac91a67-0c3b-43fd-8b0c-5e689a56133a"));
        assertEquals(2, models.size());
    }


    @Test
    void canInsertPayslipLines() {

        // ARRANGE/ACT
        repo.insertOrUpdateGenericPayslipLines(List.of(new PayslipGenericLineVO(UUID.randomUUID(), "textline", 99.99, MODEL_EARNING_PERIOD)));

        // ASSERT
        var payslip = repo.getPayslip(MODEL_EARNING_PERIOD);
        assertEquals(1, payslip.getGenericLines().size());
        assertEquals("textline", payslip.getGenericLines().get(0).text());
        assertEquals(99.99, payslip.getGenericLines().get(0).amount());
    }

    @Test
    void canUpdatePayslipLines() {

        // ARRANGE/ACT
        PayslipGenericLineVO payslipline = new PayslipGenericLineVO(UUID.randomUUID(), "textline", 99.99, UUID.fromString("d9eeca3f-81d6-49d3-98cd-25d026cca33b"));
        repo.insertOrUpdateGenericPayslipLines(List.of(payslipline));
        repo.insertOrUpdateGenericPayslipLines(List.of(new PayslipGenericLineVO(payslipline.Id(), "updated textline", 88.88, payslipline.modelearningperiodId())));

        // ASSERT
        var payslip = repo.getPayslip(MODEL_EARNING_PERIOD);
        assertEquals(1, payslip.getGenericLines().size());
        assertEquals("updated textline", payslip.getGenericLines().get(0).text());
        assertEquals(88.88, payslip.getGenericLines().get(0).amount());
    }
}