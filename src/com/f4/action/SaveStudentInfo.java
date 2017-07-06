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
        import com.f4.pojo.Student;
        import com.opensymphony.xwork2.ActionSupport;
@ParentPackage("struts-default")
@Namespace("/")

public class SaveStudentInfo extends ActionSupport {

    String	s_id;
    String	 s_job;
    String	 s_sname;
    String	 s_address;
    String	 s_telephone;
    String	 s_classname;
    String	 s_birthday;


    public String getS_id() {
        return s_id;
    }
    public void setS_id(String s_id) {
        this.s_id = s_id;
    }
    public String getS_job() {
        return s_job;
    }
    public void setS_job(String s_job) {
        this.s_job = s_job;
    }
    public String getS_sname() {
        return s_sname;
    }
    public void setS_sname(String s_sname) {
        this.s_sname = s_sname;
    }
    public String getS_address() {
        return s_address;
    }
    public void setS_address(String s_address) {
        this.s_address = s_address;
    }
    public String getS_telephone() {
        return s_telephone;
    }
    public void setS_telephone(String s_telephone) {
        this.s_telephone = s_telephone;
    }
    public String getS_classname() {
        return s_classname;
    }
    public void setS_classname(String s_classname) {
        this.s_classname = s_classname;
    }
    public String getS_birthday() {
        return s_birthday;
    }
    public void setS_birthday(String s_birthday) {
        this.s_birthday = s_birthday;
    }

    @Action("savaStudentInfo")
    public void savaStudentInfo(){
        Student st=new Student();
        DBUtils db=new DBUtils();
        st.setAddress(s_address);
        st.setBirthday(s_birthday);
        st.setClassname(s_classname);
        st.setId(s_id);
        st.setJob(s_job);
        st.setSname(s_sname);
        st.setSname(s_sname);
        st.setTelephone(s_telephone);
        boolean 	temt= db.saveStudent(st);
        try {
            PrintWriter out=ServletActionContext.getResponse().getWriter();
            if(temt){
                out.print("success!");
            }
            else{
                out.print("error!");
            }
            out.flush();
            out.close();
            db.close();
        } catch (IOException e) {
            e.printStackTrace();
        }


    }

}

