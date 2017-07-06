package com.f4.action;

/**
 * Created by 任永硕 on 2017/7/6.
 */


        import java.io.IOException;
        import java.io.PrintWriter;
        import java.util.HashMap;
        import java.util.Map;

        import org.apache.struts2.ServletActionContext;
        import org.apache.struts2.convention.annotation.Action;
        import org.apache.struts2.convention.annotation.Namespace;
        import org.apache.struts2.convention.annotation.ParentPackage;

        import com.alibaba.fastjson.JSON;
        import com.f4.dao.DBUtils;
        import com.opensymphony.xwork2.ActionSupport;

@ParentPackage("struts-default")
@Namespace("/")
public class FindPhotoUrl extends ActionSupport {
    String uname="";
    public String getUname() {
        return uname;
    }


    public void setUname(String uname) {
        this.uname = uname;
    }


    @Action(value = "androidFindPhoto")
    public void androidFindPhoto() {
        DBUtils db = new DBUtils();
        String url=db.androidFindphoto(uname);
        PrintWriter out;
        try {
            ServletActionContext.getResponse().setCharacterEncoding("utf-8");
            out = ServletActionContext.getResponse().getWriter();
            System.out.println(uname);
            out.print(url);
            out.flush();
            out.close();
            db.close();
        } catch (IOException e) {

            e.printStackTrace();
        }

    }
}
