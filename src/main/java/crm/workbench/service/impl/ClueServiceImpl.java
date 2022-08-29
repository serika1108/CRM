package crm.workbench.service.impl;

import crm.utils.DateTimeUtil;
import crm.utils.SqlSessionUtil;
import crm.utils.UUIDUtil;
import crm.vo.PaginationVO;
import crm.workbench.dao.*;
import crm.workbench.domain.*;
import crm.workbench.service.ClueService;

import java.util.*;

public class ClueServiceImpl implements ClueService {

    //线索相关的表
    private ClueDao clueDao = SqlSessionUtil.getSqlSession().getMapper(ClueDao.class);
    private ClueActivityRelationDao clueActivityRelationDao = SqlSessionUtil.getSqlSession().getMapper(ClueActivityRelationDao.class);
    private ClueRemarkDao clueRemarkDao = SqlSessionUtil.getSqlSession().getMapper(ClueRemarkDao.class);

    //客户相关表
    private CustomerDao customerDao = SqlSessionUtil.getSqlSession().getMapper(CustomerDao.class);
    private CustomerRemarkDao customerRemarkDao = SqlSessionUtil.getSqlSession().getMapper(CustomerRemarkDao.class);

    //联系人相关表
    private ContactsDao contactsDao = SqlSessionUtil.getSqlSession().getMapper(ContactsDao.class);
    private ContactsRemarkDao contactsRemarkDao = SqlSessionUtil.getSqlSession().getMapper(ContactsRemarkDao.class);
    private ContactsActivityRelationDao contactsActivityRelationDao = SqlSessionUtil.getSqlSession().getMapper(ContactsActivityRelationDao.class);

    //交易相关表
    private TranDao tranDao = SqlSessionUtil.getSqlSession().getMapper(TranDao.class);
    private TranHistoryDao TranHistoryDao = SqlSessionUtil.getSqlSession().getMapper(TranHistoryDao.class);

    @Override
    public boolean save(Clue c) {

        boolean flag = true;
        int count = clueDao.save(c);
        if(count != 1)
            flag = false;

        return flag;
    }

    @Override
    public Clue detail(String id) {

        Clue c = clueDao.detail(id);
        return c;
    }

    @Override
    public boolean unbund(String id) {

        boolean flag = true;
        int count = clueActivityRelationDao.unbund(id);
        if(count != 1)
            flag = false;

        return flag;
    }

    @Override
    public boolean bund(String cid, String[] aids) {

        boolean flag = true;

        for(String aid : aids){
            //关联每一个aid
            ClueActivityRelation car = new ClueActivityRelation();
            car.setId(UUIDUtil.getUUID());
            car.setActivityId(aid);
            car.setClueId(cid);

            int count = clueActivityRelationDao.bund(car);
            if(count != 1)
                flag = false;
        }
        return flag;
    }

    @Override
    public boolean convert(String clueId, Tran t, String createBy) {

        String createTime = DateTimeUtil.getSysTime();
        boolean flag = true;

        //通过线索的id获得线索的对象，因为线索的对象中封装了线索(潜在客户)相关的信息
        Clue c = clueDao.getById(clueId);

        //通过线索对象提取客户信息，当该客户不存在时，创建新客户，根据公司名精确匹配来确定客户是否存在
        //因为该公司可能已经和这个客户做过交易，但是搜集线索时并不知道曾经做过交易，因此搜集线索时将这个客户当做了潜在客户
        String company = c.getCompany();
        Customer cus = customerDao.getCustomerByName(company);
        if(cus == null){
            cus = new Customer();
            cus.setId(UUIDUtil.getUUID());
            cus.setAddress(c.getAddress());
            cus.setWebsite(c.getWebsite());
            cus.setPhone(c.getPhone());
            cus.setOwner(c.getOwner());
            cus.setNextContactTime(c.getNextContactTime());
            cus.setName(company);
            cus.setDescription(c.getDescription());
            cus.setCreateTime(createTime);
            cus.setCreateBy(createBy);
            cus.setContactSummary(c.getContactSummary());
            int count1 = customerDao.save(cus);
            if(count1 != 1){
                flag = false;
            }
            //System.out.println("count1="+count1);
        }

        //通过线索对象提取联系人信息，保存联系人
        Contacts con = new Contacts();
        con.setId(UUIDUtil.getUUID());
        con.setSource(c.getSource());
        con.setOwner(c.getOwner());
        con.setNextContactTime(c.getMphone());
        con.setMphone(c.getMphone());
        con.setJob(c.getJob());
        con.setFullname(c.getFullname());
        con.setEmail(c.getEmail());
        con.setDescription(c.getDescription());
        con.setCustomerId(cus.getId());
        con.setCreateTime(createTime);
        con.setCreateBy(createBy);
        con.setContactSummary(c.getContactSummary());
        con.setAppellation(c.getAppellation());
        con.setAddress(c.getAddress());
        int count2 = contactsDao.save(con);
        if(count2 != 1){
            flag = false;
        }
        //System.out.println("count2="+count2);

        //线索备注转换到客户备注和联系人备注里面
        List<ClueRemark> clueRemarkList = clueRemarkDao.getListByClueId(clueId);
        for(ClueRemark clueRemark : clueRemarkList){
            String noteContent = clueRemark.getNoteContent();
            CustomerRemark customerRemark = new CustomerRemark();
            customerRemark.setId(UUIDUtil.getUUID());
            customerRemark.setCreateTime(createTime);
            customerRemark.setCreateBy(createBy);
            customerRemark.setNoteContent(noteContent);
            customerRemark.setCustomerId(cus.getId());
            customerRemark.setEditBy("0");
            int count3 = customerRemarkDao.save(customerRemark);
            if(count3 != 1){
                flag = false;
            }
            System.out.println("count3="+count3);

            ContactsRemark contactsRemark = new ContactsRemark();
            contactsRemark.setId(UUIDUtil.getUUID());
            contactsRemark.setCreateTime(createTime);
            contactsRemark.setCreateBy(createBy);
            contactsRemark.setNoteContent(noteContent);
            contactsRemark.setContactsId(con.getId());
            contactsRemark.setEditBy("0");
            int count4 = contactsRemarkDao.save(contactsRemark);
            if(count4 != 1){
                flag = false;
            }
            //System.out.println("count4="+count4);
        }

        //将线索(潜在客户)和市场活动关系转换到联系人和市场活动的关系
        //查询与该线索关联的市场活动(tbl_clue_activity_relation)
        List<ClueActivityRelation> clueActivityRelationList = clueActivityRelationDao.getListByClueId(clueId);
        for(ClueActivityRelation clueActivityRelation : clueActivityRelationList){
            String activityId = clueActivityRelation.getActivityId();

            ContactsActivityRelation contactsActivityRelation = new ContactsActivityRelation();
            contactsActivityRelation.setId(UUIDUtil.getUUID());
            contactsActivityRelation.setActivityId(activityId);
            contactsActivityRelation.setContactsId(con.getId());

            int count5 = contactsActivityRelationDao.save(contactsActivityRelation);
            if(count5 != 1){
                flag = false;
            }
            //System.out.println("count5="+count5);
        }

        //如果有创建交易的需求，则创建一个交易
        if(t != null){
            //在controller中已经为交易封装了部分信息，这里可以完善一下
            t.setSource(c.getSource());
            t.setOwner(c.getOwner());
            t.setNextContactTime(c.getNextContactTime());
            t.setDescription(c.getDescription());
            t.setCustomerId(cus.getId());
            t.setContactSummary(c.getContactSummary());
            t.setContactsId(con.getId());

            int count6 = tranDao.save(t);
            if(count6 != 1){
                flag = false;
            }
            //System.out.println("count6="+count6);

            //如果创建了交易，就创建一条交易历史记录
            TranHistory th = new TranHistory();
            th.setId(UUIDUtil.getUUID());
            th.setCreateBy(createBy);
            th.setCreateTime(createTime);
            th.setExpectedDate(t.getExpectedDate());
            th.setMoney(t.getMoney());
            th.setStage(t.getStage());
            th.setTranId(t.getId());
            int count7 =  TranHistoryDao.save(th);
            if(count7 != 1){
                flag = false;
            }
            //System.out.println("count7="+count7);
        }

        //删除线索备注
        for(ClueRemark clueRemark : clueRemarkList){
            int count8 = clueRemarkDao.delete(clueRemark);
            if(count8 != 1){
                flag = false;
            }
        }

        //删除线索和市场活动的管理那关系
        for(ClueActivityRelation clueActivityRelation : clueActivityRelationList){
            int count9 = clueActivityRelationDao.delete(clueActivityRelation);
            if(count9 != 1){
                flag = false;
            }
        }

        //删除线索
        int count10 = clueDao.delete(clueId);
        if(count10 != 1){
            flag = false;
        }

        return flag;
    }

    @Override
    public PaginationVO<Clue> pageList(Map<String, Object> map) {
        int total = clueDao.getTotal();
        List<Clue> dataList = clueDao.getClueList(map);
        PaginationVO<Clue> vo = new PaginationVO<Clue>();
        vo.setTotal(total);
        vo.setDataList(dataList);

        return vo;
    }

    @Override
    public Map<String, Object> getCharts() {
        List<String> source = clueDao.getSource();
        List<Integer> value = clueDao.getValue();
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("source", source);
        map.put("value", value);
        System.out.println(value);
        System.out.println(source);

        return map;
    }
}
