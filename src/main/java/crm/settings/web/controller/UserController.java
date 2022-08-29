package crm.settings.web.controller;

import crm.settings.domain.User;
import crm.settings.service.UserService;
import crm.settings.service.impl.UserServiceImpl;
import crm.utils.MD5Util;
import crm.utils.PrintJson;
import crm.utils.ServiceFactory;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

public class UserController extends HttpServlet {

    @Override
    protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        //System.out.println("进入到用户控制器");

        String path = request.getServletPath();
        //System.out.println(path);

        if("/settings/user/login.do".equals(path))
        {
            login(request, response);
        }
    }

    private void login(HttpServletRequest request, HttpServletResponse response) {

        String loginAct = request.getParameter("loginAct");
        String loginPwd = request.getParameter("loginPwd");
        //将密码的明文形式转换成MD5密文
        loginPwd = MD5Util.getMD5(loginPwd);
        //接收浏览器端的ip地址
        String ip = request.getRemoteAddr();

        //业务开发统一使用代理类的接口对象
        UserService us = (UserService) ServiceFactory.getService(new UserServiceImpl());
        //System.out.println("ip: " + ip);

        try {
            //检验用户登录操作利用抛自定义异常的形式处理登录失败的情况
            User user = us.login(loginAct, loginPwd, ip);
            request.getSession().setAttribute("user", user);
            //如果登录成功应该向前端返回一个json
            PrintJson.printJsonFlag(response, true);
        }catch (Exception e){
            //获取异常信息
            String msg = e.getMessage();
            //如果登录失败则要传递两种信息，success和msg
            /*
            将多项信息传递给ajax请求，有两种手段可以处理：
            把信息打包成一个map或者创建一个vo类
            如果展现的信息将来还会大量使用则使用vo类，否则使用map
            */
            System.out.println("接收到异常");
            Map<String, Object> map = new HashMap<String, Object>();
            map.put("success", false);
            map.put("msg", msg);
            PrintJson.printJsonObj(response, map);
        }
    }
}
