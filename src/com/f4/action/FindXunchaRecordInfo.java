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
public class FindXunchaRecordInfo extends ActionSupport{
    Map map;
    int page;
    int rows;
    String searchdate="";
    String zhouci="";
    String tname="";
    String jieci="";
    String xunchayuan="";
    public String getXunchayuan() {
        return xunchayuan;
    }
    public void setXunchayuan(String xunchayuan) {
        this.xunchayuan = xunchayuan;
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
    public String getSearchdate() {
        return searchdate;
    }
    public void setSearchdate(String searchdate) {
        this.searchdate = searchdate;
    }
    public String getZhouci() {
        return zhouci;
    }
    public void setZhouci(String zhouci) {
        this.zhouci = zhouci;
    }
    public String getTname() {
        return tname;
    }
    public void setTname(String tname) {
        this.tname = tname;
    }
    public String getJieci() {
        return jieci;
    }
    public void setJieci(String jieci) {
        this.jieci = jieci;
    }
    @Action(value="findXunchaRecordInfo")
    public void findXunchaRecordInfo(){
        DBUtils db=new DBUtils();
        map=new HashMap();
        map.put("rows",db.findXunchaRecordInfo(page, rows, searchdate, zhouci, tname, jieci, xunchayuan));
        map.put("total",db.getXunchaRecordInfoSize());
        String jsonster=JSON.toJSONString(map);
        PrintWriter out;
        try {
            ServletActionContext.getResponse().setCharacterEncoding("utf-8");
            out=ServletActionContext.getResponse().getWriter();
            out.print(jsonster);
            out.flush();
            out.close();
            db.close();
        } catch (IOException e) {

            e.printStackTrace();
        }


    }
}
