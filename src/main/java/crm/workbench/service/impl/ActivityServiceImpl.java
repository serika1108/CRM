package crm.workbench.service.impl;

import crm.settings.dao.UserDao;
import crm.settings.domain.User;
import crm.utils.SqlSessionUtil;
import crm.vo.PaginationVO;
import crm.workbench.dao.ActivityDao;
import crm.workbench.dao.ActivityRemarkDao;
import crm.workbench.domain.Activity;
import crm.workbench.domain.ActivityRemark;
import crm.workbench.service.ActivityService;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ActivityServiceImpl implements ActivityService {

    private ActivityDao activityDao = SqlSessionUtil.getSqlSession().getMapper(ActivityDao.class);
    private ActivityRemarkDao activityRemarkDao = SqlSessionUtil.getSqlSession().getMapper(ActivityRemarkDao.class);
    private UserDao userDao = SqlSessionUtil.getSqlSession().getMapper(UserDao.class);

    @Override
    public boolean save(Activity a) {

        boolean flag = true;
        //返回受到影响的条数
        int count = activityDao.save(a);
        if(count != 1)
            flag = false;

        return flag;
    }

    @Override
    public PaginationVO<Activity> pageList(Map<String, Object> map) {

        //取得total
        int total = activityDao.getTotalByCondition(map);

        //取得dataList
        List<Activity> dataList = activityDao.getActivityListByCondition(map);
        //封装数据到vo
        PaginationVO<Activity> vo = new PaginationVO<Activity>();
        vo.setTotal(total);
        vo.setDataList(dataList);

        return vo;
    }

    @Override
    public boolean delete(String[] ids) {

        boolean flag = true;

        //活动表外键关联备注表，因此要先查询删除的备注数量
        int count1 = activityRemarkDao.getCountByAids(ids);

        //删除备注，返回受到影响的条数，即实际删除的数量
        int count2 = activityRemarkDao.deleteByAids(ids);

        if(count1 != count2)
            flag = false;

        //删除市场活动
        int count3 = activityDao.delete(ids);
        //数组的长度是我们想要删除的，count3是返回实际删除的条数
        if(count3 != ids.length)
            flag = false;

        return flag;
    }

    @Override
    public Map<String, Object> getUserListAndActivity(String id) {

        //取uList
        List<User> uList = userDao.getUserList();

        //取a，根据id查单条
        Activity a = activityDao.getById(id);

        Map<String, Object>map = new HashMap<String, Object>();
        map.put("uList", uList);
        map.put("a", a);

        return map;
    }

    @Override
    public boolean update(Activity a) {

        boolean flag = true;
        //返回受到影响的条数
        int count = activityDao.update(a);
        if(count != 1)
            flag = false;

        return flag;
    }

    @Override
    public Activity detail(String id) {

        Activity a = activityDao.detail(id);
        return a;
    }

    @Override
    public List<ActivityRemark> getRemarkListByAid(String activityId) {

        List<ActivityRemark> arList = activityRemarkDao.getRemarkListByAid(activityId);

        return arList;
    }

    @Override
    public boolean deleteRemark(String id) {

        boolean flag = true;

        int count = activityRemarkDao.deleteRemark(id);

        if(count != 1)
            flag = false;

        return flag;
    }

    @Override
    public boolean saveRemark(ActivityRemark ar) {

        boolean flag = true;

        int count = activityRemarkDao.saveRemark(ar);
        if(count != 1)
            flag = false;

        return flag;
    }

    @Override
    public boolean updateRemark(ActivityRemark ar) {

        boolean flag = true;

        int count = activityRemarkDao.updateRemark(ar);
        if(count != 1)
            flag = false;

        return flag;
    }

    @Override
    public List<Activity> getActivityListByClueId(String clueId) {

        List<Activity> aList =  activityDao.getActivityListByClueId(clueId);

        return aList;
    }

    @Override
    public List<Activity> getActivityListByNameAndNotByClueId(Map<String, String> map) {

        List<Activity> aList = activityDao.getActivityListByNameAndNotByClueId(map);

        return aList;
    }

    @Override
    public List<Activity> getActivityListByName(String aname) {

        List<Activity> aList = activityDao.getActivityListByName(aname);

        return aList;
    }

    @Override
    public Map<String, Object> getCharts() {
        List<String> time1 = activityDao.getTime();
        List<String> value = activityDao.getValue();

        List<String> time = new ArrayList<String>();
        for (String t : time1){
            String temp = t.substring(5);
            time.add(temp);
        }
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("time", time);
        map.put("value", value);
        return map;
    }
}
