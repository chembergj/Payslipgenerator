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

import static org.junit.jupiter.api.Assertions.*;

@ExtendWith(SpringExtension.class)
@SpringBootTest(classes = PayslipgeneratorApplication.class)
@TestPropertySource(locations="classpath:test.properties")
class PayslipRepositoryTest {

    @Autowired
    PayslipRepository repo;

    @Test
    public void testGetPayslip() {

        // ACT
        PayslipVO payslip = repo.getPayslip(LocalDate.of(2024, 3, 11), LocalDate.of(2024, 3, 18), TestConstants.MODEL_ID_MISS_TRIAL);

        // ASSERT

        assertNotNull(payslip);

        assertEquals(TestConstants.FULL_NAME_MISS_TRIAL, payslip.getFullname());
        assertEquals(LocalDate.of(2024, 3, 11), payslip.getFromDate());
        assertEquals(LocalDate.of(2024, 3, 18), payslip.getToDate());
        assertEquals(65, payslip.getPercentage());
        assertEquals(3780, payslip.getTRM());

        assertEquals(2, payslip.getLines().size());

        var cb = payslip.getLines().stream().filter(l -> l.getPagename().equals("Chaturbate")).findAny();
        assertTrue(cb.isPresent());
        assertEquals(cb.get().getTokens(), 506);

        var sc = payslip.getLines().stream().filter(l -> l.getPagename().equals("Stripchat")).findAny();
        assertTrue(sc.isPresent());
        assertEquals(sc.get().getTokens(), 10);
    }
}