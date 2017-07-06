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
        import com.f4.pojo.xunchaInfo;
        import com.opensymphony.xwork2.ActionSupport;


@ParentPackage("struts-default")
@Namespace("/")
public class AddxunchaInfoAction extends ActionSupport{
    String qianzhui;
    public String getQianzhui() {
        return qianzhui;
    }
    public void setQianzhui(String qianzhui) {
        this.qianzhui = qianzhui;
    }
    String xunchayuan;
    String searchdate;
    String zhouci;
    String jieci;
    String grade;
    String classname;
    String tname;
    String subject;
    String ontime;
    String tzhuangtai;
    String absence;
    String late;
    String sleep;
    String classdiscipline;
    String playphone;
    String chat;

    String xueqi;


    String fangjian;


    public String getFangjian() {
        return fangjian;
    }
    public void setFangjian(String fangjian) {
        this.fangjian = fangjian;
    }

    public String getXueqi() {
        return xueqi;
    }
    public void setXueqi(String xueqi) {
        this.xueqi = xueqi;
    }
    @Action("addXunchaInfo")
    public void addXunchaInfo() {
        DBUtils dbutils = new DBUtils();
        xunchaInfo xunchaInfo = new xunchaInfo();
        xunchaInfo.setXunchayuan(xunchayuan);
        xunchaInfo.setSearchdate(searchdate);
        xunchaInfo.setZhouci(zhouci);
        xunchaInfo.setJieci(jieci);
        xunchaInfo.setGrade(grade);
        xunchaInfo.setClassname(classname);
        xunchaInfo.setTname(tname);
        xunchaInfo.setSubject(subject);
        xunchaInfo.setOntime(ontime);
        xunchaInfo.setTzhuangtai(tzhuangtai);
        xunchaInfo.setAbsence(absence);
        xunchaInfo.setLate(late);
        xunchaInfo.setSleep(sleep);
        xunchaInfo.setClassdiscipline(classdiscipline);
        xunchaInfo.setPlayphone(playphone);
        xunchaInfo.setXueqi(xueqi);
        xunchaInfo.setChat(chat);

        xunchaInfo.setXueqi(xueqi);
        xunchaInfo.setFangjian(qianzhui+fangjian);


        try {

            PrintWriter out = ServletActionContext.getResponse().getWriter();
            boolean temp = dbutils.addxunchaInfo(xunchaInfo);
            if (temp) {
                out.print("addxunchaInfosuccess");
            } else {
                out.print("adderror");
            }
            out.flush();
            out.close();
            dbutils.close();
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }
    public String getPlayphone() {
        return playphone;
    }
    public void setPlayphone(String playphone) {
        this.playphone = playphone;
    }
    public String getChat() {
        return chat;
    }
    public void setChat(String chat) {
        this.chat = chat;
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
    public String getZhouci() {
        return zhouci;
    }
    public void setZhouci(String zhouci) {
        this.zhouci = zhouci;
    }
    public String getJieci() {
        return jieci;
    }
    public void setJieci(String jieci) {
        this.jieci = jieci;
    }
    public String getGrade() {
        return grade;
    }
    public void setGrade(String grade) {
        this.grade = grade;
    }
    public String getClassname() {
        return classname;
    }
    public void setClassname(String classname) {
        this.classname = classname;
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
    public String getOntime() {
        return ontime;
    }
    public void setOntime(String ontime) {
        this.ontime = ontime;
    }
    public String getTzhuangtai() {
        return tzhuangtai;
    }
    public void setTzhuangtai(String tzhuangtai) {
        this.tzhuangtai = tzhuangtai;
    }
    public String getAbsence() {
        return absence;
    }
    public void setAbsence(String absence) {
        this.absence = absence;
    }
    public String getLate() {
        return late;
    }
    public void setLate(String late) {
        this.late = late;
    }
    public String getSleep() {
        return sleep;
    }
    public void setSleep(String sleep) {
        this.sleep = sleep;
    }
    public String getClassdiscipline() {
        return classdiscipline;
    }
    public void setClassdiscipline(String classdiscipline) {
        this.classdiscipline = classdiscipline;
    }

}

