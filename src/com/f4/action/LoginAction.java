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
        import com.opensymphony.xwork2.ActionSupport;

@ParentPackage("struts-default")
@Namespace("/")
public class LoginAction extends ActionSupport {
    String uname;
    String upwd;
    String vcode;
    String role;
    String returnResult="";

    @Action(value = "login")
    public void login() {
        try {
            ServletActionContext.getResponse().setCharacterEncoding("utf-8");
            PrintWriter out = ServletActionContext.getResponse().getWriter();
            // 鐛插彇session灏嶈薄
            HttpSession session = ServletActionContext.getRequest().getSession();

            String imgvcode = session.getAttribute("rand").toString();
            if (vcode.equals(imgvcode)) {
                DBUtils dbutils=new DBUtils();
                Login login=new Login();
                login.setUname(uname);
                login.setUpwd(dbutils.makeMD5(upwd));
                login.setRole(role);
                boolean temp=dbutils.login(login);
                if(temp){
                    session.setAttribute("uname",uname);
                    session.setAttribute("role",role);
                    if(role.equals("绠＄悊鍛�"))
                    {
                        returnResult = "adminLoginSuccess";
                        session.setAttribute("uname", uname);
                        session.setAttribute("result", returnResult);}
                    else{
                        returnResult = "adminLoginSuccess";}
                }else
                {
                    returnResult = "yonghuming or mima cuowu";
                }
                dbutils.close();
            } else {
                returnResult = "yanzhengma Error";
            }
            out.print(returnResult);
            out.flush();
            out.close();
        } catch (IOException e) {

        }

    }
    @Action(value = "androidlogin")
    public void androidlogin() {
        try {
            ServletActionContext.getResponse().setCharacterEncoding("utf-8");
            PrintWriter out = ServletActionContext.getResponse().getWriter();
            HttpSession session = ServletActionContext.getRequest().getSession();
            DBUtils dbutils=new DBUtils();
            Login login=new Login();
            login.setUname(uname);
            login.setUpwd(dbutils.makeMD5(upwd));
            boolean temp=dbutils.androidlogin(login);
            if(temp){
                session.setAttribute("uname",uname);
                session.setAttribute("role",role);
                returnResult = "鐧婚檰鎴愬姛" ;

            }else

            {
                returnResult = "鐢ㄦ埛鍚嶆垨瀵嗙爜閿欒";
            }
            dbutils.close();
            out.print(returnResult);
            out.flush();
            out.close();
        } catch (IOException e) {

        }

    }

    public String getVcode() {
        return vcode;
    }

    public void setVcode(String vcode) {
        this.vcode = vcode;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public String getUname() {
        return uname;
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
}
