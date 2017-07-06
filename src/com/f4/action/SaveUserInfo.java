package com.f4.action;

/**
 * Created by yangxulei on 2017/7/6.
 */


        import java.io.IOException;
        import java.io.PrintWriter;

        import javax.servlet.http.HttpSession;

        import org.apache.struts2.ServletActionContext;
        import org.apache.struts2.convention.annotation.Action;
        import org.apache.struts2.convention.annotation.Namespace;
        import org.apache.struts2.convention.annotation.ParentPackage;

        import com.f4.dao.DBUtils;
        import com.f4.pojo.Login;
        import com.f4.pojo.UserInfo;
        import com.opensymphony.xwork2.ActionSupport;

@ParentPackage("struts-default")
@Namespace("/")
public class SaveUserInfo extends ActionSupport {
    String u_birthday;
    String u_address;
    String u_resume;
    String u_runame;
    String u_usex;
    String u_newuname;
    String u_uname;

    @Action("savaUserInfo")
    public void savaUserInfo() {
        DBUtils dbutils = new DBUtils();
        UserInfo userinfo = new UserInfo();
        userinfo.setUsex(u_usex);
        userinfo.setAddress(u_address);
        userinfo.setResume(u_resume);
        userinfo.setBirthday(u_birthday);
        userinfo.setUname(u_uname);
        userinfo.setNewuname(u_newuname);
        userinfo.setRuname(u_runame);

        try {
            ServletActionContext.getResponse().setCharacterEncoding("utf-8");
            PrintWriter out = ServletActionContext.getResponse().getWriter();
            HttpSession session = ServletActionContext.getRequest().getSession();
            if(session.getAttribute("uname")!=null){
                boolean temp = dbutils.saveUser(userinfo);
                if(u_uname.equals(session.getAttribute("uname"))&&!u_uname.equals(u_newuname)){
                    session.removeAttribute("uname");
                    session.setAttribute("uname", u_newuname);

                }
                if (temp) {
                    out.print("success!");
                } else {
                    out.print("error!");
                }
            }
            out.flush();
            out.close();
            dbutils.close();
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }
    @Action("AndroidsavaUserInfo")
    public void AndroidsavaUserInfo() {
        DBUtils dbutils = new DBUtils();
        UserInfo userinfo = new UserInfo();
        userinfo.setUsex(u_usex);
        userinfo.setAddress(u_address);
        userinfo.setResume(u_resume);
        userinfo.setBirthday(u_birthday);
        userinfo.setUname(u_uname);
        userinfo.setNewuname(u_newuname);
        userinfo.setRuname(u_runame);

        try {
            ServletActionContext.getResponse().setCharacterEncoding("utf-8");
            PrintWriter out = ServletActionContext.getResponse().getWriter();
            HttpSession session = ServletActionContext.getRequest().getSession();
            boolean temp = dbutils.saveUser(userinfo);


            if (temp) {
                out.print("success");
            } else {
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


    public String getU_newuname() {
        return u_newuname;
    }

    public void setU_newuname(String u_newuname) {
        this.u_newuname = u_newuname;
    }



    public String getU_uname() {
        return u_uname;
    }

    public void setU_uname(String u_uname) {
        this.u_uname = u_uname;
    }

    public String getU_birthday() {
        return u_birthday;
    }

    public void setU_birthday(String u_birthday) {
        this.u_birthday = u_birthday;
    }

    public String getU_address() {
        return u_address;
    }

    public void setU_address(String u_address) {
        this.u_address = u_address;
    }

    public String getU_resume() {
        return u_resume;
    }

    public void setU_resume(String u_resume) {
        this.u_resume = u_resume;
    }

    public String getU_runame() {
        return u_runame;
    }

    public void setU_runame(String u_runame) {
        this.u_runame = u_runame;
    }

    public String getU_usex() {
        return u_usex;
    }

    public void setU_usex(String u_usex) {
        this.u_usex = u_usex;
    }


}

