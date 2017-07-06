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
public class DeleteTeacherInfo extends ActionSupport {

    int sid;
    public int getSid() {
        return sid;
    }

    public void setSid(int sid) {
        this.sid = sid;
    }



    @Action(value="deleteTeacherInfoBySid")
    public void deleteTeacherInfoBySid() {
        DBUtils db = new DBUtils();
        String temp = db.deleteTeacherInfoBySid(sid);


        try {

            PrintWriter out = ServletActionContext.getResponse().getWriter();
            if (temp=="success")
                out.print("deleteSuccess");
            else if(temp=="qingxianshanchu tb_tclink biaozhong xiangguanshuju")
                out.print("qingxianshanchu tb_tclink biaozhong xiangguanshuju");
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

