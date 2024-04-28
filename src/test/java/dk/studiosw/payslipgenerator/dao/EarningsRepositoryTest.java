package dk.studiosw.payslipgenerator.dao;

import dk.studiosw.payslipgenerator.PayslipgeneratorApplication;
import dk.studiosw.payslipgenerator.TestConstants;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.TestPropertySource;
import org.springframework.test.context.junit.jupiter.SpringExtension;

import java.time.LocalDate;
import java.util.UUID;
import java.util.stream.Collectors;

import static org.junit.jupiter.api.Assertions.*;

@ExtendWith(SpringExtension.class)
@SpringBootTest(classes = PayslipgeneratorApplication.class)
@TestPropertySource(locations="classpath:test.properties")
class EarningsRepositoryTest {

    @Autowired
    EarningsRepository repo;

    @Test
    public void testGetModels() {
        var models = repo.getModels(true);
        assertEquals(2, models.size());
        assertEquals("Model with C4 only", models.get(0).name());
        assertTrue(models.get(0).active());
        assertEquals("Model with CB and SC", models.get(1).name());
        assertTrue(models.get(1).active());
    }

    @Test
    public void testGetEarningPeriods() {
        var earningperiods = repo.getEarningPeriods();
        assertEquals(2, earningperiods.size());

        assertEquals(LocalDate.of(2024, 3, 11), earningperiods.get(0).fromDate());
        assertEquals(LocalDate.of(2024, 3, 18), earningperiods.get(0).toDate());
        assertEquals(3780, earningperiods.get(0).TRM());
        assertEquals(LocalDate.of(2024, 3, 20), earningperiods.get(0).TRMDate());

        assertEquals(LocalDate.of(2024, 3, 1), earningperiods.get(1).fromDate());
        assertEquals(LocalDate.of(2024, 3, 10), earningperiods.get(1).toDate());
        assertEquals(3560, earningperiods.get(1).TRM());
        assertEquals(LocalDate.of(2024, 3, 11), earningperiods.get(1).TRMDate());
    }

    @Test
    public void testGetModelEarningPeriods() {
        var modelEarningPeriods = repo.getModelEarningPeriods(UUID.fromString("dac91a67-0c3b-43fd-8b0c-5e689a56133a"));
        assertNotNull(modelEarningPeriods);
        assertEquals(2, modelEarningPeriods.size());
        assertEquals("Model with C4 only", modelEarningPeriods.get(0).modelName());
        assertEquals("Model with CB and SC", modelEarningPeriods.get(1).modelName());
    }
}