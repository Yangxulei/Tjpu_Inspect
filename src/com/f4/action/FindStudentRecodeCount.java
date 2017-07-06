package com.f4.action;

/**
 * Created by 任永硕 on 2017/7/6.
 */







        import org.apache.struts2.convention.annotation.Action;
        import org.apache.struts2.convention.annotation.Namespace;
        import org.apache.struts2.convention.annotation.ParentPackage;
        import org.apache.struts2.convention.annotation.Result;



        import com.f4.dao.DBUtils;
        import com.f4.pojo.EcharStudentData;
        import com.opensymphony.xwork2.ActionSupport;



@ParentPackage("json-default")
@Namespace("/")
public class FindStudentRecodeCount extends ActionSupport{
    EcharStudentData esd;
    String grade;
    String classname;
    String teacher="";
    public EcharStudentData getEsd() {
        return esd;
    }
    public void setEsd(EcharStudentData esd) {
        this.esd = esd;
    }
    String xueqi;
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
    public String getXueqi() {
        return xueqi;
    }
    public void setXueqi(String xueqi) {
        this.xueqi = xueqi;
    }
    @Action(value="getCountNumber" ,
            results={ @Result(type="json",name="esd",
                    params={"root","esd"})})
    public String getCountNumber(){
        DBUtils db=new DBUtils();
        esd=db.findEcharStudentdata(classname, xueqi, grade,teacher);
        db.close();
        return "esd";
    }

}

