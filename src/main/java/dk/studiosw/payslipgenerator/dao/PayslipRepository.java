package dk.studiosw.payslipgenerator.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.List;
import java.util.UUID;

@Service
public class PayslipRepository {

    @Autowired
    JdbcTemplate jdbcTemplate;

    public PayslipVO getPayslip(LocalDate from, LocalDate to, UUID modelId) {

        var payslip = jdbcTemplate.queryForObject(
                "select models.Name, ep.FromDate, ep.ToDate, ep.TRM, mep.Percentage, mep.Id, ep.CalculationDate " +
                        "from models inner join modelearningperiods mep on models.Id=mep.modelId " +
                        "inner join earningperiods ep on mep.earningperiodId = ep.Id " +
                        " where FromDate = ? and ToDate = ? and models.Id=?", (resultSet, rowNum) -> {
                     return new PayslipVO(resultSet.getString("Name"),
                             resultSet.getDate("FromDate").toLocalDate(),
                             resultSet.getDate("ToDate").toLocalDate(),
                             resultSet.getInt("Percentage"),
                             resultSet.getDouble("TRM"),
                             UUID.fromString(resultSet.getString("Id")),
                             resultSet.getDate("CalculationDate").toLocalDate());
                 }, from, to, modelId);

        var lines = jdbcTemplate.query("select me.noOfUnits as noOfUnits, ma.Website from modelearnings me " +
                 "inner join modelaccounts ma on ma.Id = me.modelaccountsId " +
                 "inner join modelearningperiods mep on me.ModelEarningPeriodId=mep.Id " +
                 "where mep.Id = ? ",
                (resultSet, rowNum) -> {
                     return new PayslipLineVO(
                             Website.fromDbName(resultSet.getString("Website")),
                             resultSet.getInt("noOfUnits")
                     );
                 },
                payslip.getModelEarningPeriodId()
        );

        payslip.addAllLines(lines);

        return payslip;
    }

    public List<ModelVO> getModelsWithEarningsInPeriod(LocalDate from, LocalDate to) {
        return jdbcTemplate.query(
                "select models.Id, models.Name, models.Active from models " +
                "inner join modelearningperiods mep on models.Id=mep.modelId " +
                "inner join earningperiods ep on mep.earningperiodId = ep.Id " +
                "where FromDate = ? and ToDate = ?", EarningsRepository.ModelVORowMapper(), from, to);
    }
}
