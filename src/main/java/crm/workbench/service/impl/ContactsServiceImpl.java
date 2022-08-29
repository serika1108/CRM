package crm.workbench.service.impl;

import crm.utils.SqlSessionUtil;
import crm.vo.PaginationVO;
import crm.workbench.dao.ContactsDao;
import crm.workbench.domain.Contacts;
import crm.workbench.domain.Customer;
import crm.workbench.service.ContactsService;

import java.util.List;
import java.util.Map;

public class ContactsServiceImpl implements ContactsService {

    ContactsDao contactsDao = SqlSessionUtil.getSqlSession().getMapper(ContactsDao.class);

    @Override
    public Contacts detail(String id) {
        Contacts c = contactsDao.detail(id);
        return c;
    }

    @Override
    public PaginationVO<Contacts> pageList(Map<String, Object> map) {
        int total = contactsDao.getTotal();
        List<Contacts> dataList = contactsDao.getContactsList(map);
        PaginationVO<Contacts> vo = new PaginationVO<Contacts>();
        vo.setTotal(total);
        vo.setDataList(dataList);

        return vo;
    }
}
