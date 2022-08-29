package crm.workbench.service;

import crm.vo.PaginationVO;
import crm.workbench.domain.Clue;
import crm.workbench.domain.Customer;

import java.util.List;
import java.util.Map;

public interface CustomerService {

    List<String> getCustomerName(String name);

    PaginationVO<Customer> pageList(Map<String, Object> map);

    Customer detail(String id);
}
