package crm.workbench.dao;

import crm.workbench.domain.Clue;

import java.util.List;
import java.util.Map;

public interface ClueDao {

    int save(Clue c);

    Clue detail(String id);

    Clue getById(String clueId);

    int delete(String clueId);

    int getTotal();

    List<Clue> getClueList(Map<String, Object> map);

    List<String> getSource();

    List<Integer> getValue();
}
