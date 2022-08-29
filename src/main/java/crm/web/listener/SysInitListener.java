package crm.web.listener;

import crm.settings.domain.DicValue;
import crm.settings.service.DicService;
import crm.settings.service.impl.DicServiceImpl;
import crm.utils.ServiceFactory;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import java.util.*;

public class SysInitListener implements ServletContextListener {

    /*
        该方法是用来监听上下文域对象(application)的方法。
        当服务器启动，上下文域对象创建，一旦创建完毕就执行该方法
        参数event可以取得监听的对象，监听什么就可以通过event取得什么
     */
    @Override
    public void contextInitialized(ServletContextEvent event) {

        //System.out.println("上下文域对象被创建了");

        ServletContext application =  event.getServletContext();

        //取出数据字典并放入上下文域对象中
        DicService ds = (DicService) ServiceFactory.getService(new DicServiceImpl());
        Map<String, List<DicValue>> map = ds.getAll();
        //将map的键值对解析为上下文域对象的键值对
        Set<String> set = map.keySet();
        for(String key : set) {
            application.setAttribute(key, map.get(key));
        }

        //处理完数据字典后解析Stage2Possibility.properties文件
        //将文件中键值对关系转换成map
        Map<String, String> pMap = new HashMap<String, String>();
        ResourceBundle rb = ResourceBundle.getBundle("Stage2Possibility");
        Enumeration<String> e = rb.getKeys();
        while (e.hasMoreElements()){
            //阶段
            String key = e.nextElement();
            //可能性
            String value = rb.getString(key);
            pMap.put(key, value);
        }
        application.setAttribute("pMap", pMap);
    }
}
