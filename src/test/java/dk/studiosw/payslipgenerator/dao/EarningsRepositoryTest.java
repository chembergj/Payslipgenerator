package dk.studiosw.payslipgenerator.dao;

import dk.studiosw.payslipgenerator.PayslipgeneratorApplication;
import dk.studiosw.payslipgenerator.TestConstants;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.TestPropertySource;
import org.springframework.test.context.junit.jupiter.SpringExtension;
import org.springframework.test.context.junit4.AbstractTransactionalJUnit4SpringContextTests;

import java.time.LocalDate;
import java.util.UUID;
import java.util.stream.Collectors;

import static org.junit.jupiter.api.Assertions.*;

@ExtendWith(SpringExtension.class)
@SpringBootTest(classes = PayslipgeneratorApplication.class)
@TestPropertySource(locations="classpath:test.properties")
class EarningsRepositoryTest extends AbstractTransactionalJUnit4SpringContextTests {

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
        assertEquals(LocalDate.of(2024, 3, 19), earningperiods.get(0).TRMDate());

        assertEquals(LocalDate.of(2024, 3, 1), earningperiods.get(1).fromDate());
        assertEquals(LocalDate.of(2024, 3, 10), earningperiods.get(1).toDate());
        assertEquals(3690, earningperiods.get(1).TRM());
        assertEquals(LocalDate.of(2024, 3, 11), earningperiods.get(1).TRMDate());
    }

    @Test
    public void testGetModelEarningPeriods() {
        var modelEarningPeriods = repo.getModelEarningPeriods(UUID.fromString("2dc79111-a093-493f-bd23-ab8a1003a95e"));
        assertNotNull(modelEarningPeriods);
        assertEquals(2, modelEarningPeriods.size());
        assertEquals("Model with C4 only", modelEarningPeriods.get(0).modelName());
        assertEquals("Model with CB and SC", modelEarningPeriods.get(1).modelName());
    }

    @Test
    public void insertOrUpdateModelEarnings() {
        // ARRANGE
        var modelEarningPeriods = repo.getModelEarningPeriods(UUID.fromString("2dc79111-a093-493f-bd23-ab8a1003a95e"));
        modelEarningPeriods.get(0).modelEarnings().set(0,
            modelEarningPeriods.get(0).modelEarnings().get(0).withNoOfUnits(4711.0));

        var mepsWithoutEmptyEarnings = modelEarningPeriods.stream().map(mep -> {
            var existingEarnings = mep.modelEarnings().stream().filter(me -> me.id() != null).toList();
            return mep.withModelEarnings(existingEarnings);
        }).toList();

        repo.insertOrUpdateModelEarnings(mepsWithoutEmptyEarnings);

        // ACT
        var newModelEarningPeriods = repo.getModelEarningPeriods(UUID.fromString("2dc79111-a093-493f-bd23-ab8a1003a95e"));
        assertEquals(4711.0, newModelEarningPeriods.get(0).modelEarnings().get(0).noOfUnits());
    }
}