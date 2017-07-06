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
        import com.opensymphony.xwork2.ActionSupport;

@ParentPackage("struts-default")
@Namespace("/")
public class SavePaw extends ActionSupport {
    String uname;
    String paw;
    String opaw;
    String rpaw;

    public String getRpaw() {
        return rpaw;
    }

    public void setRpaw(String rpaw) {
        this.rpaw = rpaw;
    }

    public String getUname() {
        return uname;
    }

    public void setUname(String uname) {
        this.uname = uname;
    }

    public String getPaw() {
        return paw;
    }

    public void setPaw(String paw) {
        this.paw = paw;
    }

    public String getOpaw() {
        return opaw;
    }

    public void setOpaw(String opaw) {
        this.opaw = opaw;
    }

    @Action("savePaw")
    public void savePaw() {

        try {
            PrintWriter out = ServletActionContext.getResponse().getWriter();
            ServletActionContext.getResponse().setCharacterEncoding("utf-8");
            if (!paw.equals(rpaw)) {
                out.print("liangcibuyizhi");
            } else {
                DBUtils db = new DBUtils();
                String result = db.savePaw(uname, db.makeMD5(paw), db.makeMD5(opaw));
                if (result == "passworderror") {
                    out.print("jiumimacuowu");
                } else if (result == "success") {
                    out.print("success");
                } else {
                    out.print("error");
                }
                out.flush();
                out.checkError();
                db.close();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    @Action("androidSavePaw")
    public void androidSavePaw(){
        System.out.println("sdfkjaskf");
        try {
            PrintWriter out = ServletActionContext.getResponse().getWriter();
            ServletActionContext.getResponse().setCharacterEncoding("utf-8");
            DBUtils db = new DBUtils();
            String result = db.savePaw(uname, db.makeMD5(paw), db.makeMD5(opaw));
            if (result == "passworderror") {
                out.print("jiumimacuowu");
            } else if (result == "success") {
                out.print("success");
            } else {
                out.print("error");
            }
            out.flush();
            out.checkError();
            db.close();

        } catch (IOException e) {
            e.printStackTrace();
        }
    }



}

