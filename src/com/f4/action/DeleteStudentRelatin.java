package com.f4.action;

/**
 * Created by 任永硕 on 2017/7/6.
 */


        import java.io.PrintWriter;

        import javax.servlet.http.HttpSession;

        import org.apache.struts2.ServletActionContext;
        import org.apache.struts2.convention.annotation.Action;
        import org.apache.struts2.convention.annotation.Namespace;
        import org.apache.struts2.convention.annotation.ParentPackage;

        import com.f4.dao.DBUtils;
        import com.opensymphony.xwork2.ActionSupport;
@ParentPackage("struts-default")
@Namespace("/")
public class DeleteStudentRelatin extends ActionSupport {
    String sid;
    String cid;


    public String getSid() {
        return sid;
    }
    public void setSid(String sid) {
        this.sid = sid;
    }
    public String getCid() {
        return cid;
    }
    public void setCid(String cid) {
        this.cid = cid;
    }
    @Action("deleteStudentRelation")
    public void deleteStudentRelation() {
        DBUtils db = new DBUtils();
        boolean temp = db.deleteStudentRelation(sid, cid);
        try {
            PrintWriter out = ServletActionContext.getResponse().getWriter();
            if (temp)
                out.print("success");
            else
                out.print("error");

            out.flush();
            out.close();
            db.close();
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }

    }
    @Action("removeSession")
    public void removeSession(){
        ServletActionContext.getResponse().setCharacterEncoding("utf-8");
        HttpSession session=ServletActionContext.getRequest().getSession();
        session.invalidate();

    }

}
