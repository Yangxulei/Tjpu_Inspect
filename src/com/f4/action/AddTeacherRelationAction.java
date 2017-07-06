package com.f4.action;

/**
 * Created by 任永硕 on 2017/7/6.
 */


        import java.io.IOException;
        import java.io.PrintWriter;

        import org.apache.struts2.ServletActionContext;
        import org.apache.struts2.convention.annotation.Action;
        import org.apache.struts2.convention.annotation.Namespace;
        import org.apache.struts2.convention.annotation.ParentPackage;

        import com.f4.dao.DBUtils;
        import com.f4.pojo.TeacherRelation;
        import com.f4.pojo.xunchaInfo;
        import com.opensymphony.xwork2.ActionSupport;


@ParentPackage("struts-default")
@Namespace("/")
public class AddTeacherRelationAction extends ActionSupport{

    String tid;
    String sid;
    String cid;
    String tname;
    String cname;
    String sname;

    public String getTid() {
        return tid;
    }

    public void setTid(String tid) {
        this.tid = tid;
    }

    public String getSid() {
        return sid;
    }

    public void setSid(String sid) {
        this.sid = sid;
    }

    public String getCid() {
        return cid;
    }

    public void setCid(String cid) {
        this.cid = cid;
    }

    public String getTname() {
        return tname;
    }

    public void setTname(String tname) {
        this.tname = tname;
    }

    public String getCname() {
        return cname;
    }

    public String getSname() {
        return sname;
    }

    public void setSname(String sname) {
        this.sname = sname;
    }

    public void setCname(String cname) {
        this.cname = cname;
    }

    @Action("addTeacherRelationInfo")
    public void addTeacherRelationInfo() {
        DBUtils db=new DBUtils();
        TeacherRelation tr=new TeacherRelation();
        tr.setCid(cid);
        tr.setCname(cname);
        tr.setSid(sid);
        tr.setSname(sname);
        tr.setTid(tid);
        tr.setTname(tname);

        try {
            PrintWriter out=ServletActionContext.getResponse().getWriter();
            boolean temp = db.addteacherRelation(tr);
            if(temp)
                out.print("success");
            else
                out.print("false");
            out.flush();
            out.close();
            db.close();

        } catch (IOException e) {
            e.printStackTrace();
        }




    }}