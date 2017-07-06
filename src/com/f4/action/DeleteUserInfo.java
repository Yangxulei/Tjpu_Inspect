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
public class DeleteUserInfo extends ActionSupport {
    int id;
    int sid;
    public int getSid() {
        return sid;
    }

    public void setSid(int sid) {
        this.sid = sid;
    }


    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    @Action("deleteUserInfoByID")
    public void deleteUserInfoById() {
        DBUtils db = new DBUtils();
        boolean temp = db.deleteUserInfoById(id);
        try {
            PrintWriter out = ServletActionContext.getResponse().getWriter();
            if (temp)
                out.print("deleteSuccess");
            else
                out.print("deleteError");

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
