package com.f4.action;

/**
 * Created by 任永硕 on 2017/7/6.
 */


        import java.io.IOException;
        import java.io.PrintWriter;

        import org.apache.struts2.ServletActionContext;
        import org.apache.struts2.convention.annotation.Action;
        import org.apache.struts2.convention.annotation.Namespace;
        import org.apache.struts2.convention.annotation.ParentPackage;

        import com.f4.dao.DBUtils;
        import com.opensymphony.xwork2.ActionSupport;
@ParentPackage("struts-default")
@Namespace("/")

public class DeleteDepartmentInfo extends ActionSupport {
    String dname="";

    public String getDname() {
        return dname;
    }

    public void setDname(String dname) {
        this.dname = dname;
    }

    @Action("deleteDepartmentInfoByDname")
    public void  deleteDepartmentInfoByDname(){
        DBUtils db=new DBUtils();
        String result=db.deleteDepartment(dname);
        try {
            PrintWriter out=ServletActionContext.getResponse().getWriter();
            if(result=="true"){
                out.print("success");
            }
            else if(result=="qingxianqingkongbumenneiburenyuan"){
                out.print("qingchuneiburenyuan");
            }
            else{
                out.print("error");
            }
            out.flush();
            out.close();
            db.close();

        } catch (IOException e) {
            e.printStackTrace();
        }

    }


}
