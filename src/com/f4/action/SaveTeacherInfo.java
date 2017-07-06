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
        import com.f4.pojo.TeacherInfo;
        import com.f4.pojo.UserInfo;
        import com.opensymphony.xwork2.ActionSupport;
@ParentPackage("struts-default")
@Namespace("/")

public class SaveTeacherInfo extends ActionSupport {


    String u_id;
    String u_department;
    String u_job;
    String	 u_email;
    String u_telephone;
    String	 u_rname;
    String u_usex;
    public String getU_id() {
        return u_id;
    }

    public void setU_id(String u_id) {
        this.u_id = u_id;
    }

    public String getU_department() {
        return u_department;
    }

    public void setU_department(String u_department) {
        this.u_department = u_department;
    }

    public String getU_job() {
        return u_job;
    }

    public void setU_job(String u_job) {
        this.u_job = u_job;
    }

    public String getU_email() {
        return u_email;
    }

    public void setU_email(String u_email) {
        this.u_email = u_email;
    }

    public String getU_telephone() {
        return u_telephone;
    }

    public void setU_telephone(String u_telephone) {
        this.u_telephone = u_telephone;
    }

    public String getU_rname() {
        return u_rname;
    }

    public void setU_rname(String u_rname) {
        this.u_rname = u_rname;
    }

    public String getU_usex() {
        return u_usex;
    }

    public void setU_usex(String u_usex) {
        this.u_usex = u_usex;
    }



    @Action("savaTeacherInfo")
    public void savaTeacherInfo() {
        DBUtils dbutils = new DBUtils();
        TeacherInfo teacherinfo=new TeacherInfo();
        teacherinfo.setDepartment(u_department);
        teacherinfo.setEmail(u_email);
        teacherinfo.setJob(u_job);
        teacherinfo.setRname(u_rname);
        teacherinfo.setSex(u_usex);
        teacherinfo.setTelephone(u_telephone);
        teacherinfo.setSid(u_id);

        try {
            PrintWriter out = ServletActionContext.getResponse().getWriter();
            String result = dbutils.saveTeacher(teacherinfo);
            if (result.equals("success")) {
                out.print("success!");
            } else if(result.equals("bumenbucunzai")){
                out.print("bumenbucunzai");
            }
            else{
                out.print("error");
            }
            out.flush();
            out.close();
            dbutils.close();
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }

}
