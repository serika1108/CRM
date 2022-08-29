package crm.workbench.web.controller;

import crm.settings.domain.User;
import crm.settings.service.UserService;
import crm.settings.service.impl.UserServiceImpl;
import crm.utils.*;
import crm.vo.PaginationVO;
import crm.workbench.domain.Activity;
import crm.workbench.domain.ActivityRemark;
import crm.workbench.service.ActivityService;
import crm.workbench.service.ClueService;
import crm.workbench.service.impl.ActivityServiceImpl;
import crm.workbench.service.impl.ClueServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ActivityController extends HttpServlet {

    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        //System.out.println("进入到市场活动控制器");

        String path = request.getServletPath();
        System.out.println(path);

        if("/workbench/activity/getUserList.do".equals(path))
        {
            getUserList(request, response);
        }
        else if("/workbench/activity/save.do".equals(path))
        {
            save(request, response);
        }
        else if("/workbench/activity/pageList.do".equals(path))
        {
            pageList(request, response);
        }
        else if("/workbench/activity/delete.do".equals(path))
        {
            delete(request, response);
        }
        else if("/workbench/activity/getUserListAndActivity.do".equals(path))
        {
            getUserListAndActivity(request, response);
        }
        else if("/workbench/activity/update.do".equals(path))
        {
            update(request, response);
        }
        else if("/workbench/activity/detail.do".equals(path))
        {
            detail(request, response);
        }
        else if("/workbench/activity/getRemarkListByAid.do".equals(path))
        {
            getRemarkListByAid(request, response);
        }
        else if("/workbench/activity/deleteRemark.do".equals(path))
        {
            deleteRemark(request, response);
        }
        else if("/workbench/activity/saveRemark.do".equals(path))
        {
            saveRemark(request, response);
        }
        else if("/workbench/activity/updateRemark.do".equals(path))
        {
            updateRemark(request, response);
        }
        else if("/workbench/activity/getCharts.do".equals(path))
        {
            getCharts(request, response);
        }

    }

    private void getCharts(HttpServletRequest request, HttpServletResponse response) {
        ActivityService as = (ActivityService) ServiceFactory.getService(new ActivityServiceImpl());
        Map<String, Object> map = as.getCharts();
        PrintJson.printJsonObj(response, map);
    }

    private void updateRemark(HttpServletRequest request, HttpServletResponse response) {

        System.out.println("执行修改备注的操作");

        String id = request.getParameter("id");
        String noteContent = request.getParameter("noteContent");
        String editTime = DateTimeUtil.getSysTime();
        String editBy = ((User)request.getSession().getAttribute("user")).getName();
        String editFlag = "1";

        ActivityRemark ar = new ActivityRemark();
        ar.setId(id);
        ar.setEditBy(editBy);
        ar.setNoteContent(noteContent);
        ar.setEditFlag(editFlag);
        ar.setEditTime(editTime);

        ActivityService as = (ActivityService) ServiceFactory.getService(new ActivityServiceImpl());
        boolean flag = as.updateRemark(ar);
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("success", flag);
        map.put("ar", ar);

        PrintJson.printJsonObj(response, map);
    }

    private void saveRemark(HttpServletRequest request, HttpServletResponse response) {

        //System.out.println("执行添加备注的操作");

        String noteContent = request.getParameter("noteContent");
        String activityId = request.getParameter("activityId");
        String id = UUIDUtil.getUUID();
        String createTime = DateTimeUtil.getSysTime();
        String createBy = ((User)request.getSession().getAttribute("user")).getName();
        String editFlag = "0";

        ActivityRemark ar = new ActivityRemark();
        ar.setCreateBy(createBy);
        ar.setActivityId(activityId);
        ar.setCreateTime(createTime);
        ar.setNoteContent(noteContent);
        ar.setEditFlag(editFlag);
        ar.setId(id);

        ActivityService as = (ActivityService) ServiceFactory.getService(new ActivityServiceImpl());
        boolean flag = as.saveRemark(ar);
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("success", flag);
        map.put("ar", ar);

        PrintJson.printJsonObj(response, map);
    }

    private void deleteRemark(HttpServletRequest request, HttpServletResponse response) {

        //System.out.println("删除备注操作");

        String id = request.getParameter("id");

        ActivityService as = (ActivityService) ServiceFactory.getService(new ActivityServiceImpl());

        boolean flag = as.deleteRemark(id);

        PrintJson.printJsonFlag(response, flag);

    }

    private void getRemarkListByAid(HttpServletRequest request, HttpServletResponse response) {

        //System.out.println("根据市场活动id来取得备注信息列表");

        String activityId = request.getParameter("activityId");

        ActivityService as = (ActivityService) ServiceFactory.getService(new ActivityServiceImpl());

        List<ActivityRemark> arList = as.getRemarkListByAid(activityId);

        PrintJson.printJsonObj(response, arList);
    }

    private void detail(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        //System.out.println("跳转到详细信息页面");
        //获取参数
        String id = request.getParameter("id");

        ActivityService as = (ActivityService) ServiceFactory.getService(new ActivityServiceImpl());

        Activity a = as.detail(id);
        //将查询到的信息封装成activity对象
        request.setAttribute("a", a);
        //请求转发
        request.getRequestDispatcher("/workbench/activity/detail.jsp").forward(request,response);

    }

    private void update(HttpServletRequest request, HttpServletResponse response) {
        //System.out.println("执行市场活动修改操作");
        String id = request.getParameter("id");
        String owner = request.getParameter("owner");
        String name = request.getParameter("name");
        String startDate = request.getParameter("startDate");
        String endDate = request.getParameter("endDate");
        String cost = request.getParameter("cost");
        String description = request.getParameter("description");
        String editTime = DateTimeUtil.getSysTime();  //修改时间是当前系统时间
        String editBy = ((User)request.getSession().getAttribute("user")).getName();

        Activity a = new Activity();
        a.setId(id);
        a.setCost(cost);
        a.setEditBy(editBy);
        a.setOwner(owner);
        a.setName(name);
        a.setStartDate(startDate);
        a.setEndDate(endDate);
        a.setDescription(description);
        a.setEditTime(editTime);

        ActivityService as = (ActivityService) ServiceFactory.getService(new ActivityServiceImpl());
        boolean flag = as.update(a);
        PrintJson.printJsonFlag(response, flag);
    }

    private void getUserListAndActivity(HttpServletRequest request, HttpServletResponse response) {
        //System.out.println("进入到查询用户信息列表和根据市场活动id查询单条记录的操作");

        String id = request.getParameter("id");
        ActivityService as = (ActivityService) ServiceFactory.getService(new ActivityServiceImpl());
        Map<String, Object> map = as.getUserListAndActivity(id);
        PrintJson.printJsonObj(response, map);

    }

    private void delete(HttpServletRequest request, HttpServletResponse response) {
        //System.out.println("执行市场活动的删除操作");
        String ids[] = request.getParameterValues("id");

        ActivityService as = (ActivityService) ServiceFactory.getService(new ActivityServiceImpl());
        boolean flag = as.delete(ids);
        PrintJson.printJsonFlag(response, flag);
    }

    private void pageList(HttpServletRequest request, HttpServletResponse response) {
        //System.out.println("进入到查询市场活动信息列表的操作");
        String name = request.getParameter("name");
        String owner = request.getParameter("owner");
        String startDate = request.getParameter("startDate");
        String endDate = request.getParameter("endDate");
        String pageNoStr = request.getParameter("pageNo");
        String pageSizeStr = request.getParameter("pageSize");
        int pageNo = Integer.valueOf(pageNoStr);
        int pageSize = Integer.valueOf(pageSizeStr);
        //计算略过的记录数
        int skipCount = (pageNo-1)*pageSize;

        //从controller层传递数据使用map
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("name", name);
        map.put("owner", owner);
        map.put("startDate", startDate);
        map.put("endDate", endDate);
        map.put("skipCount", skipCount);
        map.put("pageSize", pageSize);

        ActivityService as = (ActivityService) ServiceFactory.getService(new ActivityServiceImpl());

        //从数据库返回数据使用map或vo类
        //因为分页是相当常见的要求，因此这里使用vo类
        PaginationVO<Activity> vo = as.pageList(map);
        PrintJson.printJsonObj(response, vo);
    }

    private void save(HttpServletRequest request, HttpServletResponse response) {
        //System.out.println("执行市场活动的添加操作");
        String id = UUIDUtil.getUUID();
        String owner = request.getParameter("owner");
        String name = request.getParameter("name");
        String startDate = request.getParameter("startDate");
        String endDate = request.getParameter("endDate");
        String cost = request.getParameter("cost");
        String description = request.getParameter("description");
        String createTime = DateTimeUtil.getSysTime();  //创建时间是当前系统时间
        String createBy = ((User)request.getSession().getAttribute("user")).getName();

        Activity a = new Activity();
        a.setId(id);
        a.setCost(cost);
        a.setCreateBy(createBy);
        a.setOwner(owner);
        a.setName(name);
        a.setStartDate(startDate);
        a.setEndDate(endDate);
        a.setDescription(description);
        a.setCreateTime(createTime);

        ActivityService as = (ActivityService) ServiceFactory.getService(new ActivityServiceImpl());
        boolean flag = as.save(a);
        PrintJson.printJsonFlag(response, flag);
    }

    private void getUserList(HttpServletRequest request, HttpServletResponse response) {

        //System.out.println("获取用户列表");

        //获取用户列表，属于用户的业务
        UserService us = (UserService) ServiceFactory.getService(new UserServiceImpl());
        List<User> uList = us.getUserList();
        //System.out.println(uList);
        PrintJson.printJsonObj(response, uList);
    }

}
