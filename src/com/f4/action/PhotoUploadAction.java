package com.f4.action;

/**
 * Created by yangxulei on 2017/7/6.
 */


        import java.io.File;
        import java.io.FileInputStream;
        import java.io.FileOutputStream;
        import java.io.PrintWriter;
        import java.util.ArrayList;
        import java.util.Date;

        import javax.servlet.http.HttpSession;

        import org.apache.struts2.ServletActionContext;
        import org.apache.struts2.convention.annotation.Action;
        import org.apache.struts2.convention.annotation.Namespace;
        import org.apache.struts2.convention.annotation.ParentPackage;

        import com.f4.dao.DBUtils;
        import com.opensymphony.xwork2.ActionSupport;


@ParentPackage("json-default")
@Namespace("/")
public class PhotoUploadAction extends ActionSupport{
    File photo;
    String photoFileName;
    String photoContentType;
    public File getPhoto() {
        return photo;
    }
    public void setPhoto(File photo) {
        this.photo = photo;
    }
    public String getPhotoFileName() {
        return photoFileName;
    }
    public void setPhotoFileName(String photoFileName) {
        this.photoFileName = photoFileName;
    }
    public String getPhotoContentType() {
        return photoContentType;
    }
    public void setPhotoContentType(String photoContentType) {
        this.photoContentType = photoContentType;
    }

    @Action("photoUpload")
    public void uploadPhoto(){
        HttpSession session=ServletActionContext.getRequest().getSession();
        String extName=photoFileName.substring(photoFileName.lastIndexOf("."));
        String context=ServletActionContext.getServletContext().getRealPath("/");
        try {
            PrintWriter out=ServletActionContext.getResponse().getWriter();
            ServletActionContext.getResponse().setCharacterEncoding("utf-8");
            ArrayList al=new ArrayList();
            al.add(".jpg");
            al.add(".gif");
            al.add(".bmp");
            al.add(".jpeg");
            al.add(".png");
            String fileName="uploadPhoto/"+session.getAttribute("uname").toString()+extName;
            if(al.contains(extName)){
                FileInputStream fis=new FileInputStream(photo);
                FileOutputStream fos=new FileOutputStream(
                        context+fileName);
                byte[]size=new byte[fis.available()];
                int length=0;
                while((length=fis.read(size))!=-1){
                    fos.write(size, 0, length);
                }
                DBUtils db=new DBUtils();
                boolean temp=	db.changeUserInfoPhoto(session.getAttribute("uname").toString(), fileName);
                if(temp)
                    db.close();
                fos.flush();
                fos.close();
                fis.close();
                out.print("photosuccess");

            }
            else{
                out.print("extnameerror");
            }
            out.flush();
            out.close();

        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }
}
