package dk.studiosw.payslipgenerator.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
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

        var lines = jdbcTemplate.query("select sum(me.noOfUnits) as sumOfNoOfUnits, ma.Website from modelearnings me " +
                 "inner join modelaccounts ma on ma.Id = me.modelaccountsId " +
                 "inner join modelearningperiods mep on mep.modelId=ma.modelsId " +
                 "inner join earningperiods ep on mep.earningperiodId = ep.Id " +
                 "where mep.Id = ? and ep.fromDate <= me.date and me.date <= ep.toDate " +
                 "group by ma.Website",
                (resultSet, rowNum) -> {
                     return new PayslipLineVO(
                             resultSet.getString("Website"),
                             resultSet.getInt("sumOfNoOfUnits")
                     );
                 },
                payslip.getModelEarningPeriodId()
        );

        payslip.addAllLines(lines);

        return payslip;
    }
}
