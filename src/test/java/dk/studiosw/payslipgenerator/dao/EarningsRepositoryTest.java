package dk.studiosw.payslipgenerator.dao;

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
import java.util.Optional;
import java.util.UUID;

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
        assertEquals(LocalDate.of(2024, 3, 20), earningperiods.get(0).TRMDate());

        assertEquals(LocalDate.of(2024, 3, 1), earningperiods.get(1).fromDate());
        assertEquals(LocalDate.of(2024, 3, 10), earningperiods.get(1).toDate());
        assertEquals(3560, earningperiods.get(1).TRM());
        assertEquals(LocalDate.of(2024, 3, 11), earningperiods.get(1).TRMDate());
    }

    @Test
    public void testInsertOrUpdateEarningPeriodInserts() {

        var origEarningperiods = repo.getEarningPeriods();
        EarningPeriodVO newEarningPeriodVO = new EarningPeriodVO(UUID.randomUUID(), LocalDate.now().minusDays(1), LocalDate.now().plusDays(6), 99.0, LocalDate.now());
        repo.insertOrUpdateEarningPeriod(newEarningPeriodVO);
        var newEarningperiods = repo.getEarningPeriods();
        assertEquals(origEarningperiods.size() + 1, newEarningperiods.size());
        var returnedNewEarningPeriod = newEarningperiods.stream().filter(ep -> ep.id().equals(newEarningPeriodVO.id())).findFirst();
        assertTrue(returnedNewEarningPeriod.isPresent());
        assertEquals(returnedNewEarningPeriod.get(), newEarningPeriodVO);

    }

    @Test
    public void testInsertOrUpdateEarningPeriodUpdates() {

        var origEarningperiods = repo.getEarningPeriods();
        var earningperiod = origEarningperiods.get(0);
        repo.insertOrUpdateEarningPeriod(new EarningPeriodVO(
                earningperiod.id(),
                earningperiod.fromDate(),
                earningperiod.toDate(),
                earningperiod.TRM() + 10.0,
                earningperiod.TRMDate()));

        var newEarningPeriods = repo.getEarningPeriods();
        assertEquals(origEarningperiods.size(), newEarningPeriods.size());
        assertEquals(earningperiod.TRM() + 10.0, newEarningPeriods.stream().filter(ep -> ep.id().equals(earningperiod.id())).findFirst().get().TRM());
    }

    @Test
    public void testGetModelEarningPeriods() {
        var modelEarningPeriods = repo.getModelEarningPeriods(UUID.fromString("dac91a67-0c3b-43fd-8b0c-5e689a56133a"), false);
        assertNotNull(modelEarningPeriods);
        assertEquals(2, modelEarningPeriods.size());
        assertEquals("Model with C4 only", modelEarningPeriods.get(0).modelName());
        assertFalse(modelEarningPeriods.get(1).specialTRM().isPresent());
        assertEquals(1111f, modelEarningPeriods.get(0).specialTRM().get());
        assertEquals("Model with CB and SC", modelEarningPeriods.get(1).modelName());
    }

    @Test
    public void insertOrUpdateModelEarnings() {
        // ARRANGE
        var modelEarningPeriods = repo.getModelEarningPeriods(UUID.fromString("2dc79111-a093-493f-bd23-ab8a1003a95e"), false);
        modelEarningPeriods.get(0).modelEarnings().set(0,
            modelEarningPeriods.get(0).modelEarnings().get(0).withNoOfUnits(4711.0));

        var mepsWithoutEmptyEarnings = modelEarningPeriods.stream().map(mep -> {
            var existingEarnings = mep.modelEarnings().stream().filter(me -> me.id() != null).toList();
            return mep.withModelEarnings(existingEarnings);
        }).toList();

        repo.insertOrUpdateModelEarnings(mepsWithoutEmptyEarnings);

        // ACT
        var newModelEarningPeriods = repo.getModelEarningPeriods(UUID.fromString("2dc79111-a093-493f-bd23-ab8a1003a95e"), false);
        assertEquals(4711.0, newModelEarningPeriods.get(0).modelEarnings().get(0).noOfUnits());
    }

    @Test
    public void insertOrUpdateModelEarningPeriods() {

        // ARRANGE
        var modelEarningPeriods = repo.getModelEarningPeriods(UUID.fromString("2dc79111-a093-493f-bd23-ab8a1003a95e"), true);
        int oldNoOfPeriods = modelEarningPeriods.size();
        modelEarningPeriods.set(0, modelEarningPeriods.get(0).withPercentage(10));
        var newMEP = new ModelEarningPeriodVO(UUID.randomUUID(), modelEarningPeriods.get(0).modelId(), modelEarningPeriods.get(0).earningPeriodId(),"Test", 44, Optional.of((double)3232), List.of());
        modelEarningPeriods.add(newMEP);

        // ACT
        repo.insertOrUpdateModelEarningPeriods(modelEarningPeriods);

        // ASSERT
        var newModelEarningPeriods = repo.getModelEarningPeriods(UUID.fromString("2dc79111-a093-493f-bd23-ab8a1003a95e"), true);
        assertEquals(oldNoOfPeriods + 1, newModelEarningPeriods.size());

        var newMEPFromDb = newModelEarningPeriods.stream().filter(mep -> mep.id().equals(newMEP.id())).findFirst().get();
        var oldMEPFromDB = newModelEarningPeriods.stream().filter(mep -> !mep.id().equals(newMEP.id())).findFirst().get();

        assertEquals(10.0, oldMEPFromDB.percentage());
        assertEquals(44.0, newMEPFromDb.percentage());
        assertEquals((double)3232, newMEPFromDb.specialTRM().get());
    }
}