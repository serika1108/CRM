package crm.workbench.service.impl;

import crm.utils.DateTimeUtil;
import crm.utils.SqlSessionUtil;
import crm.utils.UUIDUtil;
import crm.vo.PaginationVO;
import crm.workbench.dao.CustomerDao;
import crm.workbench.dao.TranDao;
import crm.workbench.dao.TranHistoryDao;
import crm.workbench.domain.Clue;
import crm.workbench.domain.Customer;
import crm.workbench.domain.Tran;
import crm.workbench.domain.TranHistory;
import crm.workbench.service.TranService;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class TranServiceImpl implements TranService {

    private TranDao tranDao = SqlSessionUtil.getSqlSession().getMapper(TranDao.class);
    private TranHistoryDao tranHistoryDao = SqlSessionUtil.getSqlSession().getMapper(TranHistoryDao.class);
    private CustomerDao customerDao = SqlSessionUtil.getSqlSession().getMapper(CustomerDao.class);

    @Override
    public boolean save(Tran t, String customerName) {

        //进行交易添加业务，需要找到客户，因为t里面没有客户的id，我们需要根据客户的名字查询这个客户是否存在
        boolean flag = true;
        Customer cus = customerDao.getCustomerByName(customerName);
        if(cus == null){
            cus = new Customer();
            cus.setId(UUIDUtil.getUUID());
            cus.setName(customerName);
            cus.setCreateBy(t.getCreateBy());
            cus.setCreateTime(t.getCreateTime());
            cus.setContactSummary(t.getContactSummary());
            cus.setNextContactTime(t.getNextContactTime());
            cus.setOwner(t.getOwner());
            int count1 = customerDao.save(cus);
            if(count1 != 1)
                flag = false;
        }
        t.setCustomerId(cus.getId());
        int count2 = tranDao.save(t);
        if(count2 != 1)
            flag = false;

        //添加交易历史
        TranHistory th = new TranHistory();
        th.setId(UUIDUtil.getUUID());
        th.setTranId(t.getId());
        th.setStage(t.getStage());
        th.setMoney(t.getMoney());
        th.setExpectedDate(t.getExpectedDate());
        th.setCreateBy(t.getCreateBy());
        th.setCreateTime(t.getCreateTime());
        int count3 = tranHistoryDao.save(th);
        if(count3 != 1)
            flag = false;

        return flag;
    }

    @Override
    public Tran detail(String id) {

        Tran t = tranDao.detail(id);

        return t;
    }

    @Override
    public List<TranHistory> getHistoryListByTranId(String tranId) {

        List<TranHistory> thList = tranHistoryDao.getHistoryListByTranId(tranId);

        return thList;
    }

    @Override
    public boolean changeStage(Tran t, String possibility) {

        boolean flag = true;
        //改变交易阶段
        int count1 = tranDao.changeStage(t);
        if(count1 != 1)
            flag = false;

        //添加交易历史
        TranHistory th = new TranHistory();
        th.setId(UUIDUtil.getUUID());
        th.setCreateTime(DateTimeUtil.getSysTime());
        th.setCreateBy(t.getEditBy());
        th.setExpectedDate(t.getExpectedDate());
        th.setMoney(t.getMoney());
        th.setTranId(t.getId());
        th.setStage(t.getStage());
        th.setPossibility(possibility);

        int count2 = tranHistoryDao.save(th);
        if(count2 != 1)
            flag = false;

        return flag;
    }

    @Override
    public Map<String, Object> getCharts() {

        int total = tranDao.getTotal();
        List<Map<String, String>> dataList = tranDao.getCharts();
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("total", total);
        map.put("dataList", dataList);

        return map;
    }

    @Override
    public PaginationVO<Tran> pageList(Map<String, Object> map) {
        int total = tranDao.getTotal();
        List<Tran> dataList = tranDao.getClueList(map);
        PaginationVO<Tran> vo = new PaginationVO<Tran>();
        vo.setTotal(total);
        vo.setDataList(dataList);

        return vo;
    }
}
