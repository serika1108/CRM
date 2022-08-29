package crm.web.filter;

import crm.settings.domain.User;

import javax.servlet.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class LoginFilter implements Filter {
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    @Override
    public void doFilter(ServletRequest req, ServletResponse resp, FilterChain chain) throws IOException, ServletException {
        //验证登录，必须登录才能进入首页，防止用户直接输入网址跳过登录页面进入首页
        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) resp;

        String path = request.getServletPath();
        //第一次重启服务器时还没进入登录页面，就会被过滤拦截，此时user还是null，会进入else
        //重定向再次到登录页，再次被拦截，会进去死循环
        //因此登录的资源需要被放行
        //System.out.println("path:"+path);
        if("/login.jsp".equals(path) || "/settings/user/login.do".equals(path))
        {
            //System.out.println("通过拦截");
            chain.doFilter(req, resp);
        }
        //其他资源需要被拦截
        else
        {
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("user");


            if(user != null){
                //不为空，放行
                chain.doFilter(req, resp);
            }
            else {
                //为空，说明没有登陆过，重定向到登录页面

            /*在实际项目开发中，路径的使用无论前端还是后端都是绝对路径
            请求转发使用的是特殊的绝对路径，前面不加 /项目名，这种路径称为内部路径，例如/login.jsp
            重定向使用传统绝对路径写法，前面必须以 /项目名 开头，后面是具体资源路径，例如/crm/login.jsp

            转发会停留在老路径上，而不是最新路径，我们应在用户跳转后浏览器的地址栏定位到新的路径*/

                response.sendRedirect(request.getContextPath() + "/login.jsp");
            }
        }
    }

    @Override
    public void destroy() {

    }
}
