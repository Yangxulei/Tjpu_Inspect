package com.f4.action;

/**
 * Created by yangxulei on 2017/7/6.
 */


        import java.io.IOException;
        import java.io.PrintWriter;

        import org.apache.struts2.ServletActionContext;
        import org.apache.struts2.convention.annotation.Action;
        import org.apache.struts2.convention.annotation.Namespace;
        import org.apache.struts2.convention.annotation.ParentPackage;

        import com.f4.dao.DBUtils;
        import com.f4.pojo.Department;
        import com.opensymphony.xwork2.ActionSupport;
@ParentPackage("struts-default")
@Namespace("/")

public class SaveDepartmentInfo extends ActionSupport {
    String dname;
    String bossname;
    String address;
    public String getDname() {
        return dname;
    }
    public void setDname(String dname) {
        this.dname = dname;
    }
    public String getBossname() {
        return bossname;
    }
    public void setBossname(String bossname) {
        this.bossname = bossname;
    }
    public String getAddress() {
        return address;
    }
    public void setAddress(String address) {
        this.address = address;
    }

    @Action("savaDepartmentInfo")
    public void savaDepartmentInfo(){
        Department department = new Department();
        department.setAddress(address);
        department.setBossname(bossname);
        department.setDname(dname);
        DBUtils db=new DBUtils();
        boolean tempt=	db.saveDepartment(department);
        try {
            PrintWriter out=ServletActionContext.getResponse().getWriter();
            if(tempt){
                out.print("success");
            }
            else{
                out.print("error");
            }
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }


    }
    @Action("addDepartmentInfo")
    public void addDepartmentInfo(){
        Department department = new Department();
        department.setAddress(address);
        department.setBossname(bossname);
        department.setDname(dname);
        DBUtils db=new DBUtils();
        boolean tempt=	db.addDepartment(department);
        try {
            PrintWriter out=ServletActionContext.getResponse().getWriter();

            if(tempt){
                out.print("success");
            }
            else{
                out.print("error");
            }
            out.flush();
            out.close();
            db.close();
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }

}
