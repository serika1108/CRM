package crm.workbench.dao;

import crm.workbench.domain.Clue;
import crm.workbench.domain.Customer;

import java.util.List;
import java.util.Map;

public interface CustomerDao {

    Customer getCustomerByName(String company);

    int save(Customer cus);

    List<String> getCustomerName(String name);

    int getTotal();

    List<Customer> getCustomerList(Map<String, Object> map);

    Customer detail(String id);
}
