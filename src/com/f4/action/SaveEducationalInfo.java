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
        import com.f4.pojo.Educational;
        import com.opensymphony.xwork2.ActionSupport;
@ParentPackage("struts-default")
@Namespace("/")
public class SaveEducationalInfo extends ActionSupport{
    String id;
    String subject;
    String classname;
    String sid;
    public String getSid() {
        return sid;
    }
    public void setSid(String sid) {
        this.sid = sid;
    }
    public String getId() {
        return id;
    }
    public void setId(String id) {
        this.id = id;
    }

    public String getClassname() {
        return classname;
    }
    public void setClassname(String classname) {
        this.classname = classname;
    }
    public String getSubject() {
        return subject;
    }
    public void setSubject(String subject) {
        this.subject = subject;
    }

    @Action("savaEducationInfo")
    public void savaEducationInfo(){
        Educational educational=new Educational();
        DBUtils db=new DBUtils();
        educational.setClassname(classname);
        educational.setId(id);
        educational.setTid(sid);
        educational.setSubject(subject);
        boolean tempt =db.saveEducational(educational);
        try {
            PrintWriter out=ServletActionContext.getResponse().getWriter();
            if(tempt)
                out.print("success");
            else
                out.print("error");
            out.flush();
            out.close();
            db.close();
        } catch (IOException e) {

            e.printStackTrace();
        }


    }


}

