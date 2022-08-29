package crm.workbench.domain;

public class Activity {

    private String id;  //主键
    private String owner;  //市场活动的所有者，对应用户表，是一个外键，关联tbl_user
    private String name;  //市场活动的名称
    private String startDate;  //市场活动的开始时间 yyyy-MM-dd
    private String endDate;  //市场活动的结束时间  yyyy-MM-dd
    private String cost;  //市场活动的成本
    private String description;  //描述信息
    private String createTime;  //创建时间，yyyy-MM-dd HH:mm:ss
    private String createBy;  //创建人
    private String editTime;  //修改时间，yyyy-MM-dd HH:mm:ss
    private String editBy;  //修改人

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getOwner() {
        return owner;
    }

    public void setOwner(String owner) {
        this.owner = owner;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getStartDate() {
        return startDate;
    }

    public void setStartDate(String startDate) {
        this.startDate = startDate;
    }

    public String getEndDate() {
        return endDate;
    }

    public void setEndDate(String endDate) {
        this.endDate = endDate;
    }

    public String getCost() {
        return cost;
    }

    public void setCost(String cost) {
        this.cost = cost;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getCreateTime() {
        return createTime;
    }

    public void setCreateTime(String createTime) {
        this.createTime = createTime;
    }

    public String getCreateBy() {
        return createBy;
    }

    public void setCreateBy(String createBy) {
        this.createBy = createBy;
    }

    public String getEditTime() {
        return editTime;
    }

    public void setEditTime(String editTime) {
        this.editTime = editTime;
    }

    public String getEditBy() {
        return editBy;
    }

    public void setEditBy(String editBy) {
        this.editBy = editBy;
    }
}
