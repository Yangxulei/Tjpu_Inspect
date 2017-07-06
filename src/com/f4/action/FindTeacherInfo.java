package com.f4.action;

/**
 * Created by yangxulei on 2017/7/6.
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

public class FindTeacherInfo extends ActionSupport {
    Map map;
    int page;
    int rows;
    String sid="";
    String rname="";




    public String getSid() {
        return sid;
    }
    public void setSid(String sid) {
        this.sid = sid;
    }
    public String getRname() {
        return rname;
    }
    public void setRname(String rname) {
        this.rname = rname;
    }
    @Action(value="findTeacherInfo")
    public void	findTeacherInfo(){
        DBUtils db=new DBUtils();
        map=new HashMap();
        map.put("total", db.getTeacherInfoSize());
        map.put("rows", db.findTeacherInfo(page, rows,sid,rname));
        String json=JSON.toJSONString(map);
        PrintWriter out;
        try {
            ServletActionContext.getResponse().setCharacterEncoding("utf-8");
            out=ServletActionContext.getResponse().getWriter();
            out.print(json);
            out.flush();
            out.close();
            db.close();
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }

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

}
