package crm.settings.service.impl;

import crm.exception.LoginException;
import crm.settings.dao.UserDao;
import crm.settings.domain.User;
import crm.settings.service.UserService;
import crm.utils.DateTimeUtil;
import crm.utils.SqlSessionUtil;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class UserServiceImpl implements UserService {

    private UserDao userDao = SqlSessionUtil.getSqlSession().getMapper(UserDao.class);

    @Override
    public User login(String loginAct, String loginPwd, String ip) throws LoginException{
        //System.out.println("进入登陆判断");
        Map<String, String> map = new HashMap<String, String>();
        map.put("loginAct", loginAct);
        map.put("loginPwd", loginPwd);

        User user = userDao.login(map);

        if(user == null)
        {
            //System.out.println("账号密码错误");
            throw new LoginException("账号密码错误");
        }
        //到达这里说明账号密码正确

        //验证失效时间
        String expireTime = user.getExpireTime();
        String currentTime = DateTimeUtil.getSysTime();
        if(expireTime.compareTo(currentTime) < 0)
        {
            throw new LoginException("账号已失效");
        }

        //验证锁定状态
        String lockState = user.getLockState();
        if("0".equals(lockState))
        {
            throw new LoginException("账号已锁定");
        }

        //判断ip地址
//        String allowIps = user.getAllowIps();
//        if(!allowIps.contains(ip))
//        {
//            throw new LoginException("ip地址受限");
//        }

        return user;
    }

    @Override
    public List<User> getUserList() {

        List<User> uList = userDao.getUserList();

        return uList;
    }
}
