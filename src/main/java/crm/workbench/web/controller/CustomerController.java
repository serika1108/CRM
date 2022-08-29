package crm.workbench.web.controller;

import crm.utils.PrintJson;
import crm.utils.ServiceFactory;
import crm.vo.PaginationVO;
import crm.workbench.domain.Clue;
import crm.workbench.domain.Customer;
import crm.workbench.service.ClueService;
import crm.workbench.service.CustomerService;
import crm.workbench.service.impl.ClueServiceImpl;
import crm.workbench.service.impl.CustomerServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

public class CustomerController  extends HttpServlet {

    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getServletPath();
        System.out.println(path);

        if("/workbench/customer/pageList.do".equals(path)){
            pageList(request, response);
        }
        else if("/workbench/customer/detail.do".equals(path)){
            detail(request, response);
        }
    }

    private void detail(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("id");
        CustomerService cs = (CustomerService) ServiceFactory.getService(new CustomerServiceImpl());
        Customer c = cs.detail(id);
        request.setAttribute("c", c);
        request.getRequestDispatcher("/workbench/customer/detail.jsp").forward(request, response);
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

        CustomerService cs = (CustomerService) ServiceFactory.getService(new CustomerServiceImpl());

        PaginationVO<Customer> vo = cs.pageList(map);
        PrintJson.printJsonObj(response, vo);
    }
}
