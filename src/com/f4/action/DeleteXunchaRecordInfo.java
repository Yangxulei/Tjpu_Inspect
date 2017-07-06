package com.f4.action;

/**
 * Created by 任永硕 on 2017/7/6.
 */


        import java.io.PrintWriter;

        import org.apache.struts2.ServletActionContext;
        import org.apache.struts2.convention.annotation.Action;
        import org.apache.struts2.convention.annotation.Namespace;
        import org.apache.struts2.convention.annotation.ParentPackage;

        import com.f4.dao.DBUtils;
        import com.opensymphony.xwork2.ActionSupport;
@ParentPackage("struts-default")
@Namespace("/")
public class DeleteXunchaRecordInfo extends ActionSupport {
    String searchdate;
    String jieci;
    String tname;
    String subject;
    String xunchayuan;
    @Action(value="deleteXunchaRecordInfoByID")
    public void deleteXunchaRecordInfoByID(){
        DBUtils db = new DBUtils();
        boolean temp = db.deleteXuncahRecordInfo(searchdate,jieci,tname,subject,xunchayuan) ;
        try {
            PrintWriter out = ServletActionContext.getResponse().getWriter();
            if (temp)
                out.print("deleteSuccess");
            else
                out.print("deleteError");

            out.flush();
            out.close();
            db.close();
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }

    }

    public String getXunchayuan() {
        return xunchayuan;
    }

    public void setXunchayuan(String xunchayuan) {
        this.xunchayuan = xunchayuan;
    }

    public String getSearchdate() {
        return searchdate;
    }
    public void setSearchdate(String searchdate) {
        this.searchdate = searchdate;
    }

    public String getJieci() {
        return jieci;
    }
    public void setJieci(String jieci) {
        this.jieci = jieci;
    }

    public String getTname() {
        return tname;
    }
    public void setTname(String tname) {
        this.tname = tname;
    }
    public String getSubject() {
        return subject;
    }
    public void setSubject(String subject) {
        this.subject = subject;
    }


}

