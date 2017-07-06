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
        import com.f4.pojo.Login;
        import com.f4.pojo.UserInfo;
        import com.opensymphony.xwork2.ActionSupport;

@ParentPackage("struts-default")
@Namespace("/")
public class RegisterAction extends ActionSupport {
    String uname;
    String upwd;
    String usex;
    String birthday;
    String address;
    String resume;
    String runame;
    String personid;
    @Action(value = "registerUser")
    public void registerUser() {
        DBUtils dbutils = new DBUtils();
        Login login = new Login();
        login.setUname(uname);
        login.setUpwd(dbutils.makeMD5(upwd));
        login.setRole("宸℃煡鍛�");
        UserInfo userinfo = new UserInfo();
        userinfo.setUname(uname);
        userinfo.setRuname(runame);
        userinfo.setUsex(usex);
        userinfo.setAddress(address);
        userinfo.setResume(resume);
        userinfo.setBirthday(birthday);
        userinfo.setPhoto("img/tuzi.png");
        try {
            PrintWriter out = ServletActionContext.getResponse().getWriter();
            String  result = dbutils.registerUser(login, userinfo);
            if (result=="success") {
                out.print("registerok");
            } else if(result=="shibai"){
                out.print("registererror");
            }
            else{

                out.print("chongfu");
            }
            out.flush();
            out.close();
            dbutils.close();
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }

    public String getUname() {
        return uname;
    }

    public String getPersonid() {
        return personid;
    }

    public void setPersonid(String personid) {
        this.personid = personid;
    }

    public void setUname(String uname) {
        this.uname = uname;
    }

    public String getUpwd() {
        return upwd;
    }

    public void setUpwd(String upwd) {
        this.upwd = upwd;
    }

    public String getUsex() {
        return usex;
    }

    public void setUsex(String usex) {
        this.usex = usex;
    }

    public String getBirthday() {
        return birthday;
    }

    public void setBirthday(String birthday) {
        this.birthday = birthday;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getResume() {
        return resume;
    }

    public void setResume(String resume) {
        this.resume = resume;
    }

    public String getRuname() {
        return runame;
    }

    public void setRuname(String runame) {
        this.runame = runame;
    }

}

