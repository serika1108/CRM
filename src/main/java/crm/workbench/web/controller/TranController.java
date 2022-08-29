package crm.workbench.web.controller;

import crm.settings.domain.User;
import crm.settings.service.UserService;
import crm.settings.service.impl.UserServiceImpl;
import crm.utils.DateTimeUtil;
import crm.utils.PrintJson;
import crm.utils.ServiceFactory;
import crm.utils.UUIDUtil;
import crm.vo.PaginationVO;
import crm.workbench.domain.*;
import crm.workbench.service.ActivityService;
import crm.workbench.service.ClueService;
import crm.workbench.service.CustomerService;
import crm.workbench.service.TranService;
import crm.workbench.service.impl.ActivityServiceImpl;
import crm.workbench.service.impl.ClueServiceImpl;
import crm.workbench.service.impl.CustomerServiceImpl;
import crm.workbench.service.impl.TranServiceImpl;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.awt.*;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.ResourceBundle;

public class TranController extends HttpServlet {

    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        System.out.println("进入到交易控制器");

        String path = request.getServletPath();

        //System.out.println(path);

        if("/workbench/transaction/add.do".equals(path))
        {
            add(request, response);
        }
        else if("/workbench/transaction/getCustomerName.do".equals(path))
        {
            getCustomerName(request, response);
        }
        else if("/workbench/transaction/save.do".equals(path))
        {
            save(request, response);
        }
        else if("/workbench/transaction/detail.do".equals(path))
        {
            detail(request, response);
        }
        else if("/workbench/transaction/getHistoryListByTranId.do".equals(path))
        {
            getHistoryListByTranId(request, response);
        }
        else if("/workbench/transaction/changeStage.do".equals(path))
        {
            changeStage(request, response);
        }
        else if("/workbench/transaction/getCharts.do".equals(path))
        {
            getCharts(request, response);
        }
        else if("/workbench/transaction/pageList.do".equals(path))
        {
            pageList(request, response);
        }
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

        TranService ts = (TranService) ServiceFactory.getService(new TranServiceImpl());

        PaginationVO<Tran> vo = ts.pageList(map);
        PrintJson.printJsonObj(response, vo);
    }

    private void getCharts(HttpServletRequest request, HttpServletResponse response) {
        //取得交易阶段数量统计图表的数据
        TranService ts = (TranService) ServiceFactory.getService(new TranServiceImpl());
        //业务层需要返回total和dataList，表示总条数和每个阶段的个数，用map返回
        Map<String, Object> map = ts.getCharts();
        PrintJson.printJsonObj(response, map);
    }

    private void changeStage(HttpServletRequest request, HttpServletResponse response) {
        //阶段详细信息的图标更改
        String id = request.getParameter("id");
        String stage = request.getParameter("stage");
        String money = request.getParameter("money");
        String expectedDate = request.getParameter("expectedDate");
        String editTime = DateTimeUtil.getSysTime();
        String editBy = ((User)request.getSession().getAttribute("user")).getName();

        Tran t = new Tran();
        t.setId(id);
        t.setStage(stage);
        t.setMoney(money);
        t.setExpectedDate(expectedDate);
        t.setEditTime(editTime);
        t.setEditBy(editBy);

        Map<String, String> pMap = (Map<String, String>) request.getServletContext().getAttribute("pMap");
        String possibility = pMap.get(stage);

        TranService ts = (TranService) ServiceFactory.getService(new TranServiceImpl());
        boolean flag = ts.changeStage(t, possibility);

        Map<String, Object> map = new HashMap<String, Object>();
        map.put("success", flag);
        map.put("possibility", possibility);
        map.put("t", t);

        PrintJson.printJsonObj(response, map);
    }

    private void getHistoryListByTranId(HttpServletRequest request, HttpServletResponse response) {
        String tranId = request.getParameter("tranId");
        TranService ts = (TranService) ServiceFactory.getService(new TranServiceImpl());
        List<TranHistory> thList = ts.getHistoryListByTranId(tranId);

        //取得每个交易历史的可能性
        Map<String, String> pMap = (Map<String, String>) request.getServletContext().getAttribute("pMap");
        for(TranHistory th : thList){
            String stage = th.getStage();
            String possibility = pMap.get(stage);
            th.setPossibility(possibility);
        }

        PrintJson.printJsonObj(response, thList);
    }

    private void detail(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        System.out.println("跳转到详细信息页");
        String id = request.getParameter("id");
        TranService ts = (TranService) ServiceFactory.getService(new TranServiceImpl());
        Tran t = ts.detail(id);
        //处理可能性
        String stage = t.getStage();
        Map<String, String> pMap = (Map<String, String>) request.getServletContext().getAttribute("pMap");
        String possibility = pMap.get(stage);
        request.setAttribute("possibility", possibility);

        request.setAttribute("t", t);
        request.getRequestDispatcher("/workbench/transaction/detail.jsp").forward(request, response);
    }

    private void save(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String id = UUIDUtil.getUUID();
        String owner = request.getParameter("owner");
        String money = request.getParameter("money");
        String name = request.getParameter("name");
        String expectedDate = request.getParameter("expectedDate");
        //注意这里客户从前端传递过来的不是id，而是客户名称，因为这个客户可能还不存在，它还没有id
        String customerName = request.getParameter("customerName");
        String stage = request.getParameter("stage");
        String type = request.getParameter("type");
        String source = request.getParameter("source");
        String activityId = request.getParameter("activityId");
        String contactsId = request.getParameter("contactsId");
        String createBy = ((User)request.getSession().getAttribute("user")).getName();
        String createTime = DateTimeUtil.getSysTime();
        String description = request.getParameter("description");
        String contactSummary = request.getParameter("contactSummary");
        String nextContactTime = request.getParameter("nextContactTime");

        Tran t = new Tran();
        t.setId(id);
        t.setOwner(owner);
        t.setMoney(money);
        t.setName(name);
        t.setExpectedDate(expectedDate);
        t.setStage(stage);
        t.setType(type);
        t.setSource(source);
        t.setActivityId(activityId);
        t.setContactsId(contactsId);
        t.setCreateBy(createBy);
        t.setCreateTime(createTime);
        t.setDescription(description);
        t.setContactSummary(contactSummary);
        t.setNextContactTime(nextContactTime);

        TranService ts = (TranService) ServiceFactory.getService(new TranServiceImpl());
        boolean flag = ts.save(t, customerName);
        if(flag){
            response.sendRedirect(request.getContextPath()+"/workbench/transaction/index.jsp");
        }
    }

    private void getCustomerName(HttpServletRequest request, HttpServletResponse response) {
        System.out.println("取得客户名称列表，按照客户名称进行模糊查询");
        String name = request.getParameter("name");

        CustomerService cs = (CustomerService) ServiceFactory.getService(new CustomerServiceImpl());
        List<String> sList = cs.getCustomerName(name);
        PrintJson.printJsonObj(response, sList);
    }

    private void add(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        //System.out.println("进入到跳转交易添加页的操作");

        UserService us = (UserService) ServiceFactory.getService(new UserServiceImpl());
        List<User> uList = us.getUserList();
        request.setAttribute("uList", uList);
        request.getRequestDispatcher("/workbench/transaction/save.jsp").forward(request, response);
    }


}
