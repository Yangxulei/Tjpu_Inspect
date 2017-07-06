package com.f4.action;

/**
 * Created by 任永硕 on 2017/7/6.
 */


        import java.io.PrintWriter;

        import org.apache.struts2.ServletActionContext;
        import org.apache.struts2.convention.annotation.Action;
        import org.apache.struts2.convention.annotation.Namespace;
        import org.apache.struts2.convention.annotation.ParentPackage;

        import com.f4.dao.DBUtils;
        import com.opensymphony.xwork2.ActionSupport;

@ParentPackage("struts-default")
@Namespace("/")
public class DeleteStudentInfo extends ActionSupport{
    int id;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }
    @Action(value="deleteStudentInfoByID")
    public void deleteStudentInfoById() {
        DBUtils db = new DBUtils();
        boolean temp = db.deleteStudentInfoById(id);
        System.out.println(id);
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
}

