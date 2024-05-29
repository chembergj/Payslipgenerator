package dk.studiosw.payslipgenerator.dao;

import dk.studiosw.payslipgenerator.Utils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import java.util.LinkedList;
import java.util.List;
import java.util.UUID;
import java.util.function.Function;
import java.util.stream.Collectors;

@Repository
public class EarningsRepository {

    @Autowired
    JdbcTemplate jdbcTemplate;

    public List<EarningPeriodVO> getEarningPeriods() {
        return jdbcTemplate.query(
                "select Id, FromDate, ToDate, TRM, TRMDate from earningperiods order by FromDate desc",
                (rs,rowNum) -> new EarningPeriodVO(
                        Utils.UUIDOrNull(rs.getString("Id")),
                        rs.getDate("FromDate").toLocalDate(),
                        rs.getDate("ToDate").toLocalDate(),
                        rs.getDouble("TRM"),
                        rs.getDate("TRMDate").toLocalDate()
                        )
                );
    }

    public List<ModelEarningPeriodVO> getModelEarningPeriods(UUID earningPeriodId, boolean excludeEarnings) {
        var mapIdToModelEarningPeriods = jdbcTemplate.query(
                "select mep.Id, mep.earningperiodId, mep.Percentage, mep.modelId, models.Name from modelearningperiods mep " +
                        "inner join models on mep.modelId = models.Id " +
                        "where mep.earningPeriodId=? " +
                        "order by models.Name",
                (rs,rowNum) -> new ModelEarningPeriodVO(
                            Utils.UUIDOrNull(rs.getString("Id")),
                            Utils.UUIDOrNull(rs.getString("modelId")),
                            rs.getString("Name"),
                            rs.getDouble("Percentage"),
                            new LinkedList<>()
                ),
                earningPeriodId
        ).stream().collect(Collectors.toMap(ModelEarningPeriodVO::id, Function.identity()));

        if(!excludeEarnings) {
            var earnings = jdbcTemplate.query("select me.Id, ma.Id as modelAccountId, ma.Username, ma.Website, me.noOfUnits, mep.Id ModelEarningPeriodId from modelearningperiods mep " +
                            "inner join modelaccounts ma on mep.modelId=ma.modelsId " +
                            "left join modelearnings me on me.ModelAccountsId=ma.Id and me.ModelEarningPeriodId=mep.Id " +
                            "where mep.earningperiodId=?"
                    ,
                    (rs, rowNum) -> new ModelEarningVO(
                            Utils.UUIDOrNull(rs.getString("Id")),
                            Utils.UUIDOrNull(rs.getString("modelAccountId")),
                            rs.getString("Username"),
                            Website.fromDbName(rs.getString("Website")),
                            rs.getDouble("noOfUnits"),
                            Utils.UUIDOrNull(rs.getString("ModelEarningPeriodId"))), earningPeriodId);
            earnings.forEach(e -> mapIdToModelEarningPeriods.get(e.modelEarningPeriodId()).modelEarnings().add(e));
        }

        return new LinkedList<>(mapIdToModelEarningPeriods.values());
    }

    public List<ModelVO> getModels(boolean activeOnly) {
        return jdbcTemplate.query(
                "select models.Id, models.Name, models.Active " +
                "from models " + (activeOnly ? " where Active=1 " : ""),
                ModelVORowMapper());
    }

    public static RowMapper<ModelVO> ModelVORowMapper() {
        return (resultSet, rowNum) -> new ModelVO(
                Utils.UUIDOrNull(resultSet.getString("Id")),
                resultSet.getString("Name"),
                resultSet.getBoolean("Active"));
    }

    public void insertOrUpdateModelEarnings(List<ModelEarningPeriodVO> modelEarningPeriods) {
        modelEarningPeriods.forEach(mep ->
            mep.modelEarnings().forEach(me ->
                    jdbcTemplate.update("INSERT INTO modelearnings (Id, ModelEarningPeriodId, modelaccountsId, noOfUnits)  VALUES (?,?,?,?)"
                            + " ON DUPLICATE KEY UPDATE noOfUnits=?",
                            me.id(),
                            me.modelEarningPeriodId(),
                            me.modelAccountId(),
                            me.noOfUnits(),
                            me.noOfUnits())));
    }
}
