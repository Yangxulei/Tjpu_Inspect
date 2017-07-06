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

public class FindStudentRelation extends ActionSupport {
    Map map;
    int page;
    int rows;
    String sname="";
    String classname="";

    @Action(value="findStudentRelation")
    public void	findStudentRelation(){
        DBUtils db=new DBUtils();
        map=new HashMap();
        map.put("total", db.getStudentRelation());
        map.put("rows", db.findStudentRelation(page, rows,sname,classname));
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
    public Map getMap() {
        return map;
    }
    public void setMap(Map map) {
        this.map = map;
    }
    public String getSname() {
        return sname;
    }
    public void setSname(String sname) {
        this.sname = sname;
    }
    public String getClassname() {
        return classname;
    }
    public void setClassname(String classname) {
        this.classname = classname;
    }

}

