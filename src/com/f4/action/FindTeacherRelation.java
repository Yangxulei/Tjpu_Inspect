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

public class FindTeacherRelation extends ActionSupport {
    Map map;
    int page;
    int rows;
    String tname="";

    @Action(value="findTeacherRelation")
    public void	findTeacherRelation(){
        DBUtils db=new DBUtils();
        map=new HashMap();
        map.put("total", db.getTeacherRelation());
        map.put("rows", db.findTeacherRelation(page, rows,tname));
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
    public String getTname() {
        return tname;
    }
    public void setTname(String tname) {
        this.tname = tname;
    }

}
