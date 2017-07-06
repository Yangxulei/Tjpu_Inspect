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
        import com.opensymphony.xwork2.ActionSupport;
@ParentPackage("struts-default")
@Namespace("/")
public class DeleteEducationInfo extends ActionSupport{

    int id;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    @Action("deleteEducationalInfo")
    public void deleteEducationalInfo(){
        DBUtils db=new DBUtils();
        boolean temp=db.deleteEducationalInfo(id);

        try {
            PrintWriter out = ServletActionContext.getResponse().getWriter();
            if(temp){
                out.print("success");
            }else{
                out.print("error");
            }
            out.flush();
            out.close();
            db.close();
        } catch (IOException e) {

            e.printStackTrace();
        }

    }


}
