package crm.workbench.service;

import crm.vo.PaginationVO;
import crm.workbench.domain.Contacts;
import crm.workbench.domain.Customer;

import java.util.Map;

public interface ContactsService {

    Contacts detail(String id);

    PaginationVO<Contacts> pageList(Map<String, Object> map);

}
