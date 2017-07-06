package com.f4.action;

/**
 * Created by yangxulei on 2017/7/6.
 */






        import org.apache.struts2.convention.annotation.Action;
        import org.apache.struts2.convention.annotation.Namespace;
        import org.apache.struts2.convention.annotation.ParentPackage;
        import org.apache.struts2.convention.annotation.Result;


        import com.f4.dao.DBUtils;
        import com.f4.pojo.UserInfo;
        import com.opensymphony.xwork2.ActionSupport;



@ParentPackage("json-default")
@Namespace("/")
public class FindUserInfoToPersonCenterAction extends ActionSupport{
    UserInfo userinfo;
    String uname="";
    public String getUname() {
        return uname;
    }

    public void setUname(String uname) {
        this.uname = uname;
    }

    public UserInfo getUserinfo() {
        return userinfo;
    }

    public void setUserinfo(UserInfo userinfo) {
        this.userinfo = userinfo;
    }


    @Action(value="findUserInfoToPersonCenter" ,
            results={ @Result(type="json",name="userinfo",
                    params={"root","userinfo"})})
    public String findUserInfoToPersonCenter(){
        DBUtils db=new DBUtils();
        userinfo=	db.findUserInfoToPersonCenter(uname);
        db.close();
        return "userinfo";
    }
}

