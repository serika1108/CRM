package crm.settings.service.impl;

import crm.settings.dao.DicTypeDao;
import crm.settings.dao.DicValueDao;
import crm.settings.domain.DicType;
import crm.settings.domain.DicValue;
import crm.settings.service.DicService;
import crm.utils.SqlSessionUtil;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class DicServiceImpl implements DicService {

    private DicTypeDao dicTypeDao = SqlSessionUtil.getSqlSession().getMapper(DicTypeDao.class);
    private DicValueDao dicValueDao = SqlSessionUtil.getSqlSession().getMapper(DicValueDao.class);

    @Override
    public Map<String, List<DicValue>> getAll() {

        Map<String, List<DicValue>> map = new HashMap<String,  List<DicValue>>();
        //将字典类型列表取出
        List<DicType> dtList = dicTypeDao.getTypeList();
        //将字典类型遍历
        for(DicType dt : dtList){
            String code = dt.getCode();
            //根据每个字典类型取得字典值的列表
            List<DicValue> dvList = dicValueDao.getListByCode(code);
            map.put(code, dvList);
        }

        return map;
    }
}
