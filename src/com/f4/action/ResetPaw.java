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
public class ResetPaw extends ActionSupport{

    String uname;

    public String getUname() {
        return uname;
    }

    public void setUname(String uname) {
        this.uname = uname;
    }
    @Action("resetPaw")
    public void resetPaw(){
        try {
            ServletActionContext.getResponse().setCharacterEncoding("utf-8");
            PrintWriter out = ServletActionContext.getResponse().getWriter();
            DBUtils db = new DBUtils();
            boolean tempt=	db.resetPaw(uname);
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
