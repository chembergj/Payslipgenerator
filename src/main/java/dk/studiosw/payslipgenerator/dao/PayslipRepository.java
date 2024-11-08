package dk.studiosw.payslipgenerator.dao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
public class PayslipRepository {

    @Autowired
    JdbcTemplate jdbcTemplate;

    public PayslipVO getPayslip(UUID modelEarningPeriod) {

        var payslip = jdbcTemplate.queryForObject(
                "select models.Name, ep.FromDate, ep.ToDate, COALESCE(mep.SpecialTRM, ep.TRM) as TRM , mep.Percentage, mep.Id, IFNULL(mep.HoursWorked, 0) as HoursWorked, ep.TRMDate " +
                        "from models inner join modelearningperiods mep on models.Id=mep.modelId " +
                        "inner join earningperiods ep on mep.earningperiodId = ep.Id " +
                        " where mep.Id = ?", (resultSet, rowNum) -> {
                     return new PayslipVO(resultSet.getString("Name"),
                             resultSet.getDate("FromDate").toLocalDate(),
                             resultSet.getDate("ToDate").toLocalDate(),
                             resultSet.getDouble("Percentage"),
                             resultSet.getDouble("TRM"),
                             UUID.fromString(resultSet.getString("Id")),
                             resultSet.getDate("TRMDate").toLocalDate(),
                             resultSet.getDouble("HoursWorked")
                             );
                 }, modelEarningPeriod);

        var lines = jdbcTemplate.query("select me.noOfUnits as noOfUnits, ma.Website from modelearnings me " +
                 "inner join modelaccounts ma on ma.Id = me.modelaccountsId " +
                 "inner join modelearningperiods mep on me.ModelEarningPeriodId=mep.Id " +
                 "where mep.Id = ? ",
                (resultSet, rowNum) -> new PayslipIncomeLineVO(
                        Website.fromDbName(resultSet.getString("Website")),
                        resultSet.getInt("noOfUnits")
                ),
                payslip.getModelEarningPeriodId()
        );

        payslip.addAllLines(lines);

        payslip.addAllGenericLines(getGenericlines(List.of(payslip.getModelEarningPeriodId())));

        return payslip;
    }

    public List<PayslipGenericLineVO> getGenericlines(List<UUID> modelEarningPeriodIds) {

        var sql = "select modelearningperiodId, Id, Text, Amount from paysliplines where modelearningperiodId in (";
        sql += String.join(",", modelEarningPeriodIds.stream()
                .map(id -> "'" + id.toString() +"'")
                .collect(Collectors.toList()));
        sql += ")";

        return jdbcTemplate.query(sql,
            (resultSet, rowNum) ->
                new PayslipGenericLineVO(
                    UUID.fromString(resultSet.getString("Id")),
                    resultSet.getString("Text"),
                    resultSet.getDouble("Amount"),
                    UUID.fromString(resultSet.getString("modelearningperiodId"))
                )
        );
    }

    public List<UUID> getModelEarningPeriodsWithEarningsInPeriod(UUID earningPeriod) {
        return jdbcTemplate.query(
                "select mep.id from models " +
                "inner join modelearningperiods mep on models.Id=mep.modelId " +
                "where mep.earningperiodId = ?",  (resultSet, rowNum) -> UUID.fromString(resultSet.getString("id")), earningPeriod);
    }

    public void insertOrUpdateGenericPayslipLines(List<PayslipGenericLineVO> payslipLines) {
        payslipLines.forEach(line ->
                        jdbcTemplate.update("INSERT INTO paysliplines (Id, Text, Amount, modelearningperiodId)  VALUES (?,?,?,?)"
                                        + " ON DUPLICATE KEY UPDATE Text=?, Amount=?",
                                line.Id(),
                                line.text(),
                                line.amount(),
                                line.modelearningperiodId(),
                                line.text(),
                                line.amount()));
    }
}
