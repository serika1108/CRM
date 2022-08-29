package crm.settings.dao;

import crm.settings.domain.DicValue;

import java.util.List;

public interface DicValueDao {

    List<DicValue> getListByCode(String code);
}
