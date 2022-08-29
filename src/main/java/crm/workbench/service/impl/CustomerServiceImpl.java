package crm.workbench.service.impl;

import crm.utils.SqlSessionUtil;
import crm.vo.PaginationVO;
import crm.workbench.dao.CustomerDao;
import crm.workbench.domain.Clue;
import crm.workbench.domain.Customer;
import crm.workbench.service.CustomerService;

import java.util.List;
import java.util.Map;

public class CustomerServiceImpl implements CustomerService {

    private CustomerDao customerDao = SqlSessionUtil.getSqlSession().getMapper(CustomerDao.class);

    @Override
    public List<String> getCustomerName(String name) {

        List<String> sList = customerDao.getCustomerName(name);

        return sList;
    }

    @Override
    public PaginationVO<Customer> pageList(Map<String, Object> map) {
        int total = customerDao.getTotal();
        List<Customer> dataList = customerDao.getCustomerList(map);
        PaginationVO<Customer> vo = new PaginationVO<Customer>();
        vo.setTotal(total);
        vo.setDataList(dataList);

        return vo;
    }

    @Override
    public Customer detail(String id) {
        Customer c = customerDao.detail(id);
        return c;
    }
}
