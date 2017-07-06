package com.f4.action;

/**
 * Created by yangxulei on 2017/7/6.
 */




        import java.io.IOException;
        import java.io.PrintWriter;
        import java.util.HashMap;
        import java.util.Map;


        import javax.swing.JScrollBar;

        import org.apache.struts2.ServletActionContext;
        import org.apache.struts2.convention.annotation.Action;
        import org.apache.struts2.convention.annotation.Namespace;
        import org.apache.struts2.convention.annotation.ParentPackage;

        import com.alibaba.fastjson.JSON;
        import com.f4.dao.DBUtils;
        import com.opensymphony.xwork2.ActionSupport;
@ParentPackage("struts-default")
@Namespace("/")
public class FindUserInfoAction extends ActionSupport{
    Map map;
    int page;
    int rows;
    String uname="";
    String birthday="";
    int id;
    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }
    public String getUname() {
        return uname;
    }
    public void setUname(String uname) {
        this.uname = uname;
    }
    public String getBirthday() {
        return birthday;
    }
    public void setBirthday(String birthday) {
        this.birthday = birthday;
    }
    public int getPage() {
        return page;
    }
    public void setPage(int page) {
        this.page = page;
    }
    public int getRows() {
        return rows;
    }
    public void setRows(int rows) {
        this.rows = rows;
    }
    @Action(value="findUserInfo")
    public void findUserInfo(){
        try {
            DBUtils db=new DBUtils();
            System.out.println(uname);
            map=new HashMap();
            map.put("total",db.getUserInfoSize());
            map.put("rows",db.findUserInfo(page,rows,uname,birthday));
            String jsonster=JSON.toJSONString(map);
            ServletActionContext.getResponse().setCharacterEncoding("utf-8");
            PrintWriter	out=ServletActionContext.getResponse().getWriter();
            out.print(jsonster);
            out.flush();
            out.close();
            db.close();
        } catch (IOException e) {

            e.printStackTrace();
        }


    }


}
