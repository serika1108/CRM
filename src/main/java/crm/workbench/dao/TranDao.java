package crm.workbench.dao;

import crm.workbench.domain.Tran;

import java.util.List;
import java.util.Map;

public interface TranDao {

    int save(Tran t);

    Tran detail(String id);

    int changeStage(Tran t);

    int getTotal();

    List<Map<String, String>> getCharts();

    List<Tran> getClueList(Map<String, Object> map);
}
