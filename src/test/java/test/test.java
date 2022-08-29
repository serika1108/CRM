package test;

import crm.utils.DateTimeUtil;
import crm.utils.MD5Util;

public class test {

    public static void main(String[] args) {

        //验证失效时间
        String expireTime = "2019-10-10 10:10:10";
        String currentTime = DateTimeUtil.getSysTime();

        int count = expireTime.compareTo(currentTime);

       /* Date date = new Date();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String str = sdf.format(date);*/

        System.out.println(count);

        //验证账户锁定
        String localState = "0";
        if("0".equals(localState))
            System.out.println("账号已锁定");

        //验证ip地址
        String ip = "192.168.1.1";
        String allowIps = "192.168.1.1,192.168.1.2";
        if(allowIps.contains(ip))
            System.out.println("有效的ip地址");
        else
            System.out.println("ip地址受限");

        String pwd = "renpengfei123";
        pwd = MD5Util.getMD5(pwd);
        System.out.println(pwd);

    }

}
