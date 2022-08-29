package crm.workbench.web.controller;

import crm.settings.dao.UserDao;
import crm.settings.domain.User;
import crm.settings.service.UserService;
import crm.settings.service.impl.UserServiceImpl;
import crm.utils.DateTimeUtil;
import crm.utils.PrintJson;
import crm.utils.ServiceFactory;
import crm.utils.UUIDUtil;
import crm.vo.PaginationVO;
import crm.workbench.domain.Activity;
import crm.workbench.domain.ActivityRemark;
import crm.workbench.domain.Clue;
import crm.workbench.domain.Tran;
import crm.workbench.service.ActivityService;
import crm.workbench.service.ClueService;
import crm.workbench.service.impl.ActivityServiceImpl;
import crm.workbench.service.impl.ClueServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Savepoint;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ClueController extends HttpServlet {

    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        System.out.println("进入到线索控制器");

        String path = request.getServletPath();

        if ("/workbench/clue/getUserList.do".equals(path)) {
            getUserList(request, response);
        }
        else if ("/workbench/clue/save.do".equals(path)) {
            save(request, response);
        }
        else if ("/workbench/clue/detail.do".equals(path)) {
            detail(request, response);
        }
        else if ("/workbench/clue/getActivityListByClueId.do".equals(path)) {
            getActivityListByClueId(request, response);
        }
        else if ("/workbench/clue/unbund.do".equals(path)) {
            unbund(request, response);
        }
        else if ("/workbench/clue/getActivityListByNameAndNotByClueId.do".equals(path)) {
            getActivityListByNameAndNotByClueId(request, response);
        }
        else if ("/workbench/clue/bund.do".equals(path)) {
            bund(request, response);
        }
        else if ("/workbench/clue/getActivityListByName.do".equals(path)) {
            getActivityListByName(request, response);
        }
        else if ("/workbench/clue/convert.do".equals(path)) {
            convert(request, response);
        }
        else if ("/workbench/clue/pageList.do".equals(path)) {
            pageList(request, response);
        }
        else if ("/workbench/clue/getCharts.do".equals(path)) {
            getCharts(request, response);
        }
    }

    private void getCharts(HttpServletRequest request, HttpServletResponse response) {
        ClueService cs = (ClueService) ServiceFactory.getService(new ClueServiceImpl());
        Map<String, Object> map = cs.getCharts();
        PrintJson.printJsonObj(response, map);
    }

    private void pageList(HttpServletRequest request, HttpServletResponse response) {
        String pageNoStr = request.getParameter("pageNo");
        String pageSizeStr = request.getParameter("pageSize");
        int pageNo = Integer.valueOf(pageNoStr);
        int pageSize = Integer.valueOf(pageSizeStr);
        //计算略过的记录数
        int skipCount = (pageNo-1)*pageSize;

        //从controller层传递数据使用map
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("skipCount", skipCount);
        map.put("pageSize", pageSize);

        ClueService cs = (ClueService) ServiceFactory.getService(new ClueServiceImpl());

        PaginationVO<Clue> vo = cs.pageList(map);
        PrintJson.printJsonObj(response, vo);
    }

    private void convert(HttpServletRequest request, HttpServletResponse response) throws IOException {
        //System.out.println("执行线索转换操作");
        String clueId = request.getParameter("clueId");
        //接收是否要创建交易的标记
        String flag = request.getParameter("flag");

        Tran t = null;

        //createBy要参与到参数的传递，因此放在外面
        String createBy = ((User)request.getSession().getAttribute("user")).getName();

        if("a".equals(flag)){
            //需要创建交易
            t = new Tran();
            //接收交易表单的参数
            String money = request.getParameter("money");
            String name = request.getParameter("name");
            String expectedDate = request.getParameter("expectedDate");
            String stage = request.getParameter("stage");
            String activityId = request.getParameter("activityId");
            String id = UUIDUtil.getUUID();
            String createTime = DateTimeUtil.getSysTime();

            t.setActivityId(activityId);
            t.setCreateBy(createBy);
            t.setMoney(money);
            t.setName(name);
            t.setExpectedDate(expectedDate);
            t.setStage(stage);
            t.setId(id);
            t.setCreateTime(createTime);

        }

        ClueService cs = (ClueService) ServiceFactory.getService(new ClueServiceImpl());

            /*
            为业务层传递的参数：
                1.必须传递clueId，这样我们才能知道转换哪个记录
                2.必须传递t对象，因为线索转换可能会需要临时创建交易(t是否为null在业务层判断)
             */
        boolean flag1 = cs.convert(clueId, t, createBy);
        //注意是传统请求，不是ajax请求，因此不用json，用重定向
        System.out.println("控制器里flag1="+flag1);
        if(flag1){
            response.sendRedirect(request.getContextPath()+"/workbench/clue/index.jsp");
        }
    }

    private void getActivityListByName(HttpServletRequest request, HttpServletResponse response) {
        //System.out.println("查询市场活动列表，根据名称模糊查询");
        String aname = request.getParameter("aname");
        ActivityService as = (ActivityService) ServiceFactory.getService(new ActivityServiceImpl());
        List<Activity> aList = as.getActivityListByName(aname);
        PrintJson.printJsonObj(response, aList);
    }

    private void bund(HttpServletRequest request, HttpServletResponse response) {
        //System.out.println("执行关联市场活动的操作");
        String cid = request.getParameter("cid");
        String[] aids = request.getParameterValues("aid");

        ClueService cs = (ClueService) ServiceFactory.getService(new ClueServiceImpl());
        boolean flag = cs.bund(cid, aids);
        PrintJson.printJsonFlag(response, flag);
    }

    private void getActivityListByNameAndNotByClueId(HttpServletRequest request, HttpServletResponse response) {
        //System.out.println("查询市场活动列表，根据名称模糊查询，同时排除掉已经关联指定线索的列表");
        String aname = request.getParameter("aname");
        String clueId = request.getParameter("clueId");
        Map<String, String> map = new HashMap<String, String>();

        map.put("aname", aname);
        map.put("clueId", clueId);

        ActivityService as = (ActivityService) ServiceFactory.getService(new ActivityServiceImpl());
        List<Activity> aList = as.getActivityListByNameAndNotByClueId(map);
        PrintJson.printJsonObj(response, aList);
    }

    private void unbund(HttpServletRequest request, HttpServletResponse response) {
        //System.out.println("解除关联操作");
        String id = request.getParameter("id");
        ClueService cs = (ClueService) ServiceFactory.getService(new ClueServiceImpl());
        boolean flag = cs.unbund(id);
        PrintJson.printJsonFlag(response, flag);
    }

    private void getActivityListByClueId(HttpServletRequest request, HttpServletResponse response) {
        //System.out.println("根据线索id查询关联的市场活动列表");
        String clueId = request.getParameter("clueId");
        ActivityService as = (ActivityService) ServiceFactory.getService(new ActivityServiceImpl());
        List<Activity> aList = as.getActivityListByClueId(clueId);
        PrintJson.printJsonObj(response, aList);
    }

    private void detail(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //System.out.println("跳转到详细信息页");
        String id = request.getParameter("id");
        ClueService cs = (ClueService) ServiceFactory.getService(new ClueServiceImpl());
        Clue c = cs.detail(id);
        request.setAttribute("c", c);
        request.getRequestDispatcher("/workbench/clue/detail.jsp").forward(request, response);
    }

    private void save(HttpServletRequest request, HttpServletResponse response) {
        String id = UUIDUtil.getUUID();
        String fullname = request.getParameter("fullname");
        String appellation = request.getParameter("appellation");
        String owner = request.getParameter("owner");
        String company = request.getParameter("company");
        String job = request.getParameter("job");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String website = request.getParameter("website");
        String mphone = request.getParameter("mphone");
        String state = request.getParameter("state");
        String source = request.getParameter("source");
        String createBy = ((User)request.getSession().getAttribute("user")).getName();
        String createTime = DateTimeUtil.getSysTime();
        String description = request.getParameter("description");
        String contactSummary = request.getParameter("contactSummary");
        String nextContactTime = request.getParameter("nextContactTime");
        String address = request.getParameter("address");

        Clue c = new Clue();
        c.setId(id);
        c.setFullname(fullname);
        c.setAppellation(appellation);
        c.setOwner(owner);
        c.setCompany(company);
        c.setJob(job);
        c.setEmail(email);
        c.setPhone(phone);
        c.setWebsite(website);
        c.setMphone(mphone);
        c.setState(state);
        c.setSource(source);
        c.setCreateBy(createBy);
        c.setCreateTime(createTime);
        c.setDescription(description);
        c.setContactSummary(contactSummary);
        c.setNextContactTime(nextContactTime);
        c.setAddress(address);

        ClueService cs = (ClueService) ServiceFactory.getService(new ClueServiceImpl());
        boolean flag = cs.save(c);
        PrintJson.printJsonFlag(response, flag);
    }

    private void getUserList(HttpServletRequest request, HttpServletResponse response) {
        System.out.println("取得用户信息列表");
        UserService us = (UserService) ServiceFactory.getService(new UserServiceImpl());
        List<User> uList = us.getUserList();
        PrintJson.printJsonObj(response, uList);
    }
}