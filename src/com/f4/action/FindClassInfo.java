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

public class FindClassInfo extends ActionSupport{
    Map map;
    int page;
    int rows;
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
    @Action ("findclassInfo")
    public void	findclassInfo(){
        DBUtils db=new DBUtils();
        map=new HashMap();
        map.put("total", db.getClassInfoSize());
        map.put("rows",db.findClassInfo(page, rows));
        String json=JSON.toJSONString(map);
        try {
            ServletActionContext.getResponse().setCharacterEncoding("utf-8");
            PrintWriter out=ServletActionContext.getResponse().getWriter();

            out.print(json);
            out.flush();
            out.close();
            db.close();
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }
}
