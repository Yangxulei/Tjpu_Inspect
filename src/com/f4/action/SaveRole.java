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
        import com.opensymphony.xwork2.ActionSupport;
@ParentPackage("struts-default")
@Namespace("/")
public class SaveRole extends ActionSupport {

    String uname;
    String role;
    public String getUname() {
        return uname;
    }
    public void setUname(String uname) {
        this.uname = uname;
    }
    public String getRole() {
        return role;
    }
    public void setRole(String role) {
        this.role = role;

    }

    @Action("saveRole")
    public void saveRole(){
        DBUtils db=new DBUtils();
        String result=db.saveRole(uname, role);
        try {
            PrintWriter out=ServletActionContext.getResponse().getWriter();
            if(result=="success"){
                out.print("success");
            }
            else out.print("error");
            out.flush();
            out.close();
            db.close();

        } catch (IOException e) {
            e.printStackTrace();
        }


    }
}

