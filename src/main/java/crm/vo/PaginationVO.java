package crm.vo;

import java.util.List;

public class PaginationVO<T> {

    //数据总数
    private int total;
    //数据列表，用泛型来保证每个分页操作都能使用
    private List<T> dataList;

    public int getTotal() {
        return total;
    }

    public void setTotal(int total) {
        this.total = total;
    }

    public List<T> getDataList() {
        return dataList;
    }

    public void setDataList(List<T> dataList) {
        this.dataList = dataList;
    }
}
