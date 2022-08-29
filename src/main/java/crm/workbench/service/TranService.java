package crm.workbench.service;

import crm.vo.PaginationVO;
import crm.workbench.domain.Tran;
import crm.workbench.domain.TranHistory;

import java.util.List;
import java.util.Map;

public interface TranService {

    boolean save(Tran t, String customerName);

    Tran detail(String id);

    List<TranHistory> getHistoryListByTranId(String tranId);

    boolean changeStage(Tran t, String possibility);

    Map<String, Object> getCharts();

    PaginationVO<Tran> pageList(Map<String, Object> map);
}
