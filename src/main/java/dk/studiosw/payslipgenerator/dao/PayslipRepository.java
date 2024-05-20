package dk.studiosw.payslipgenerator.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.UUID;

@Service
public class PayslipRepository {

    @Autowired
    JdbcTemplate jdbcTemplate;

    public PayslipVO getPayslip(UUID modelEarningPeriod) {

        var payslip = jdbcTemplate.queryForObject(
                "select models.Name, ep.FromDate, ep.ToDate, ep.TRM, mep.Percentage, mep.Id, ep.TRMDate " +
                        "from models inner join modelearningperiods mep on models.Id=mep.modelId " +
                        "inner join earningperiods ep on mep.earningperiodId = ep.Id " +
                        " where mep.Id = ?", (resultSet, rowNum) -> {
                     return new PayslipVO(resultSet.getString("Name"),
                             resultSet.getDate("FromDate").toLocalDate(),
                             resultSet.getDate("ToDate").toLocalDate(),
                             resultSet.getInt("Percentage"),
                             resultSet.getDouble("TRM"),
                             UUID.fromString(resultSet.getString("Id")),
                             resultSet.getDate("TRMDate").toLocalDate());
                 }, modelEarningPeriod);

        var lines = jdbcTemplate.query("select me.noOfUnits as noOfUnits, ma.Website from modelearnings me " +
                 "inner join modelaccounts ma on ma.Id = me.modelaccountsId " +
                 "inner join modelearningperiods mep on me.ModelEarningPeriodId=mep.Id " +
                 "where mep.Id = ? ",
                (resultSet, rowNum) -> new PayslipLineVO(
                        Website.fromDbName(resultSet.getString("Website")),
                        resultSet.getInt("noOfUnits")
                ),
                payslip.getModelEarningPeriodId()
        );

        payslip.addAllLines(lines);

        return payslip;
    }

    public List<UUID> getModelEarningPeriodsWithEarningsInPeriod(UUID earningPeriod) {
        return jdbcTemplate.query(
                "select mep.id from models " +
                "inner join modelearningperiods mep on models.Id=mep.modelId " +
                "where mep.earningperiodId = ?",  (resultSet, rowNum) -> UUID.fromString(resultSet.getString("id")), earningPeriod);
    }
}
