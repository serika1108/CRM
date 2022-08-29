package crm.workbench.dao;

import crm.workbench.domain.Contacts;

import java.util.List;
import java.util.Map;

public interface ContactsDao {

    int save(Contacts con);

    Contacts detail(String id);

    int getTotal();

    List<Contacts> getContactsList(Map<String, Object> map);
}
