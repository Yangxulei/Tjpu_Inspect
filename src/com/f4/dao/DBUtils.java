package com.f4.dao;

/**
 * Created by 任永硕 on 2017/7/6.
 */


        import java.math.BigInteger;
        import java.security.MessageDigest;
        import java.sql.Connection;
        import java.sql.DriverManager;
        import java.sql.PreparedStatement;
        import java.sql.ResultSet;
        import java.sql.SQLException;
        import java.sql.Statement;
        import java.util.ArrayList;
        import java.util.HashMap;
        import java.util.List;
        import java.util.Map;
        import java.util.Properties;

        import com.f4.commoninterface.CommonDB;
        import com.f4.pojo.Department;
        import com.f4.pojo.EcharStudentData;
        import com.f4.pojo.Educational;
        import com.f4.pojo.Login;
        import com.f4.pojo.Student;
        import com.f4.pojo.StudentRelation;
        import com.f4.pojo.TeacherInfo;
        import com.f4.pojo.TeacherRelation;
        import com.f4.pojo.UserInfo;
        import com.f4.pojo.xunchaInfo;

public class DBUtils implements CommonDB {

    Connection conn;
    Statement stmt;
    PreparedStatement pstmt;
    PreparedStatement pstmt1;
    ResultSet rs;
    ResultSet rs1;

    public DBUtils() {
        try {
            Properties properties = new Properties();
            properties.load(getClass().getResourceAsStream(
                    "../../../jdbc.properties"));

            String driverName = properties.getProperty("driverName");
            String url = properties.getProperty("url");
            String uname = properties.getProperty("uname");
            String upwd = properties.getProperty("upwd");
            // ////////////////////////////////////////
            Class.forName(driverName);
            conn = DriverManager.getConnection(url, uname, upwd);

        } catch (Exception e) {
            System.out.println("鏁告摎搴�ｆ帴澶辨晽");
        }
    }
    @Override
    public boolean login(Login login) {
        try {
            String sql = "select * from tb_login where uname=? and upwd= ? and role=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, login.getUname());
            pstmt.setString(2, login.getUpwd());
            pstmt.setString(3, login.getRole());
            rs = pstmt.executeQuery();
            if (rs.next())
                return true;
        } catch (Exception e) {
            System.out.println("鐧婚寗鐣板父");
        }
        return false;
    }
    @Override
    public boolean androidlogin(Login login) {
        try {
            String sql = "select * from tb_login where uname=? and upwd=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, login.getUname());
            pstmt.setString(2, login.getUpwd());
            rs = pstmt.executeQuery();
            if (rs.next())
                return true;
        } catch (Exception e) {
            System.out.println("鐧婚寗鐣板父");
        }
        return false;
    }


    public void close() {
        try {
            if (rs != null)
                rs.close();
            if (pstmt != null)
                pstmt.close();
            if (conn != null) {
                conn.close();
            }

        } catch (Exception e) {
            System.out.println("鏁版嵁搴撳叧闂紓甯�");
        }
    }

    @Override
    public String registerUser(Login login, UserInfo userinfo) {
        try {
            String sql3="select * from tb_login where uname=?";
            pstmt=conn.prepareStatement(sql3);
            pstmt.setString(1, login.getUname());
            rs=pstmt.executeQuery();
            if (rs.next()){
                return "chongfu";
            }
            conn.setAutoCommit(false);
            String sql1 = "insert into tb_login (uname,upwd,role) values(?,?,?)";
            pstmt = conn.prepareStatement(sql1);
            pstmt.setString(1, login.getUname());
            pstmt.setString(2, login.getUpwd());
            pstmt.setString(3, login.getRole());

            pstmt.executeUpdate();
            String sql2 = "insert into tb_userinfo (uname,runame,usex,birthday,photo,address,resume) values(?,?,?,?,?,?,?)";
            pstmt = conn.prepareStatement(sql2);
            pstmt.setString(1, userinfo.getUname());
            pstmt.setString(2, userinfo.getRuname());
            pstmt.setString(3, userinfo.getUsex());
            pstmt.setString(4, userinfo.getBirthday());
            pstmt.setString(5, userinfo.getPhoto());
            pstmt.setString(6, userinfo.getAddress());
            pstmt.setString(7, userinfo.getResume());
            pstmt.executeUpdate();
            conn.commit();
            return "success";
        } catch (Exception e) {
            System.out.println("鐢ㄦ埛娉ㄥ唽澶辫触" + e.getMessage());
        }
        return "shibai";
    }

    @Override
    public boolean saveUser(UserInfo userinfo) {
        try {
            String sql3="update tb_login set uname=? where uname=?";
            String sql2="select * from tb_userinfo where uname=?";
            String sql1 = "update tb_userinfo set runame=?,usex=?,birthday=?,address=?,resume=?,uname=? where uname= ? ";
            if(userinfo.getUname().equals(userinfo.getNewuname())){
                conn.setAutoCommit(false);
                pstmt = conn.prepareStatement(sql1);
                pstmt.setString (1, userinfo.getRuname());
                pstmt.setString(2, userinfo.getUsex());
                pstmt.setString(3, userinfo.getBirthday());
                pstmt.setString(4, userinfo.getAddress());
                pstmt.setString(5, userinfo.getResume());
                pstmt.setString(6, userinfo.getUname());
                pstmt.setString(7, userinfo.getUname());
                pstmt.executeUpdate();
                conn.commit();
                return true;
            }else{
                pstmt1=conn.prepareStatement(sql2);
                pstmt1.setString(1,userinfo.getNewuname());
                rs=pstmt1.executeQuery();
                if(rs.next()){
                    return false;
                }
                else{
                    conn.setAutoCommit(false);
                    pstmt = conn.prepareStatement(sql1);
                    pstmt.setString(1, userinfo.getRuname());
                    pstmt.setString(2, userinfo.getUsex());
                    pstmt.setString(3, userinfo.getBirthday());
                    pstmt.setString(4, userinfo.getAddress());
                    pstmt.setString(5, userinfo.getResume());
                    pstmt.setString(6, userinfo.getNewuname());
                    pstmt.setString(7, userinfo.getUname());
                    pstmt.executeUpdate();

                    pstmt=conn.prepareStatement(sql3);
                    pstmt.setString(1, userinfo.getNewuname());
                    pstmt.setString(2,userinfo.getUname());
                    pstmt.executeUpdate();
                    conn.commit();
                    return true;

                }

            }
        } catch (Exception e) {
            System.out.println("鐢ㄦ埛淇敼澶辫触" + e.getMessage());
        }
        return false;
    }
    @Override
    public int getUserInfoSize() {
        try {
            String sql="select count(*) from tb_userinfo";
            pstmt=conn.prepareStatement(sql);
            rs=pstmt.executeQuery();
            if(rs.next())
                return rs.getInt(1);
        } catch (Exception e) {
            // TODO: handle exception
            System.out.println(e.getMessage());
        }
        // TODO Auto-generated method stub
        return 0;
    }

    @Override
    public List<Map<String, String>> findUserInfo(int page,int rows,String uname,String birthday) {
        try {
            String sql1="select*from tb_userinfo limit?,?";
            String sql2="select*from tb_userinfo where uname like ? and birthday like ? limit ?,?";

            if(uname!=""||birthday!=""){
                pstmt=conn.prepareStatement(sql2);
                pstmt.setString(1, "%"+uname+"%");
                pstmt.setString(2,"%"+birthday+"%");
                pstmt.setInt(3, (page-1)*(rows));
                pstmt.setInt(4, rows);
            }
            else{
                pstmt=conn.prepareStatement(sql1);
                pstmt.setInt(1, (page-1)*(rows));
                pstmt.setInt(2, rows);
            }
            ArrayList al=new ArrayList();
            rs=pstmt.executeQuery();
            while(rs.next()){
                Map map=new HashMap();
                map.put("id", rs.getObject(1));
                map.put("uname", rs.getObject(2));
                map.put("runame", rs.getObject(3));
                map.put("usex", rs.getObject(4));
                map.put("birthday", rs.getObject(5));
                map.put("photo", rs.getObject(6));
                map.put("address", rs.getObject(7));
                map.put("resume", rs.getObject(8));
                al.add(map);
            }
            return al;
        } catch (Exception e) {
            return null;
        }

    }
    public int getTeacherInfoSize() {

        try {
            String sql="select count(*) from tb_teacher";
            pstmt=conn.prepareStatement(sql);
            rs=pstmt.executeQuery();

            if(rs.next())
                return rs.getInt(1);


        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return 0;
    }

    @Override
    public List<Map<String, String>> findTeacherInfo(int page, int rows,String sid,String rname) {
        try {
            String sql1="select * from tb_teacher limit ?,?";
            String sql2="select * from tb_teacher where sid like ? and rname like ? limit ?,?";
            if(sid!=""||rname!=""){
                pstmt=conn.prepareStatement(sql2);
                pstmt.setString(1, "%"+sid+"%");
                pstmt.setString(2,"%"+rname+"%");
                pstmt.setInt(3, (page-1)*rows);
                pstmt.setInt(4, rows);
            }else{
                pstmt=conn.prepareStatement(sql1);
                pstmt.setInt(1, (page-1)*rows);
                pstmt.setInt(2, rows);
            }
            ArrayList al=new ArrayList();
            rs=pstmt.executeQuery();
            while(rs.next()){
                Map map=new HashMap();
                map.put("sid", rs.getObject(1));
                map.put("rname", rs.getObject(2));
                map.put("usex", rs.getObject(3));
                map.put("telephone", rs.getObject(4));
                map.put("email", rs.getObject(5));
                map.put("department", rs.getObject(6));
                map.put("job", rs.getObject(7));
                al.add(map);
            }
            return al;
        } catch (Exception e) {

            return null;
        }
    }
    public boolean deleteUserInfoById(int id) {
        try {
            conn.setAutoCommit(false);

            String sql2="delete from tb_login where uname="
                    + "(select uname from tb_userinfo where id=?)";
            pstmt=conn.prepareStatement(sql2);
            pstmt.setInt(1, id);
            pstmt.executeUpdate();

            String sql1="delete from tb_userinfo where id=?";
            pstmt=conn.prepareStatement(sql1);
            pstmt.setInt(1, id);
            pstmt.executeUpdate();

            conn.commit();
            return true;
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return false;
    }
    public String deleteTeacherInfoBySid(int sid) {
        try {
            conn.setAutoCommit(false);
            String sql0="select * from tb_tclink where sid=?";
            pstmt=conn.prepareStatement(sql0);
            pstmt.setInt(1, sid);
            rs=pstmt.executeQuery();
            if(rs.next())
            {
                return "qingxianshanchu tb_tclink biaozhong xiangguanshuju";

            }else{
                String sql1="delete from tb_teacher where sid=?";
                pstmt1=conn.prepareStatement(sql1);
                pstmt1.setInt(1, sid);
                pstmt1.executeUpdate();
                conn.commit();

                return "success";
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return "false";
    }
    @Override
    public int getDapatmentInfoSize() {
        String sql="select count(*) from tb_department";
        try {
            pstmt=conn.prepareStatement(sql);
            rs=pstmt.executeQuery();
            if(rs.next())
                return rs.getInt(1);



        } catch (SQLException e) {

            e.printStackTrace();
        }

        return 0;
    }
    @Override
    public List<Map<String, String>> findDepartmentInfo(int page, int rows,
                                                        String dname) {

        try {
            String sql="select * from tb_department limit ?,?";
            String sql2="select * from tb_department where dname like ? limit ?,?";
            String sql3="select count(*) from tb_teacher  where department=?";
            if(dname!=""){
                pstmt=conn.prepareStatement(sql2);
                pstmt.setString(1,"%"+dname+"%");
                pstmt.setInt(2, (page-1)*rows);
                pstmt.setInt(3, rows);
            }else{
                pstmt=conn.prepareStatement(sql);
                pstmt.setInt(1, (page-1)*rows);
                pstmt.setInt(2, rows);
            }
            ArrayList al=new ArrayList();
            rs=pstmt.executeQuery();
            pstmt1=conn.prepareStatement(sql3);
            while(rs.next()){
                pstmt1.setString(1, (String) rs.getObject(1));
                rs1=pstmt1.executeQuery();
                int number=0;
                if(rs1.next()){
                    number =rs1.getInt(1);
                }
                Map map=new HashMap();
                map.put("dname",rs.getObject(1));
                map.put("bossname", rs.getObject(2));
                map.put("address", rs.getObject(3));
                map.put("dnumber", number);
                al.add(map);
            }
            return al;
        } catch (Exception e) {

            return null;
        }

    }
    @Override
    public List<Map<String, String>> findStudentInfo(int page, int rows,String id, String sname) {
        try {
            String sql="select*from tb_student limit?,?";
            String sql2="select*from tb_student where id like ? and sname like ? limit ?,?";
            if(id!=""||sname!=""){
                pstmt=conn.prepareStatement(sql2);
                pstmt.setString(1, "%"+id+"%");
                pstmt.setString(2,"%"+sname+"%");
                pstmt.setInt(3, (page-1)*rows);
                pstmt.setInt(4, rows);
            }else{

                pstmt=conn.prepareStatement(sql);
                pstmt.setInt(1, (page-1)*rows);
                pstmt.setInt(2, rows);
            }
            ArrayList al=new ArrayList();
            rs=pstmt.executeQuery();
            while(rs.next()){
                Map map=new HashMap();
                map.put("id", rs.getObject(1));
                map.put("sname", rs.getObject(2));
                map.put("telephone", rs.getObject(3));
                map.put("classname", rs.getObject(4));
                map.put("job", rs.getObject(5));
                map.put("birthday", rs.getObject(6));
                map.put("address", rs.getObject(7));
                al.add(map);
            }
            return al;
        } catch (Exception e) {

            return null;
        }
    }
    @Override
    public int getStudentInfoSize() {
        try {
            String sql="select count(*) from tb_student";
            pstmt=conn.prepareStatement(sql);
            rs=pstmt.executeQuery();
            if(rs.next())
                return rs.getInt(1);
        } catch (Exception e) {
            // TODO: handle exception
            System.out.println(e.getMessage());
        }
        // TODO Auto-generated method stub
        return 0;
    }

    @Override
    public boolean deleteStudentInfoById(int id) {
        try {
            conn.setAutoCommit(false);


            String sql1="delete from tb_student where id=?";
            pstmt=conn.prepareStatement(sql1);
            pstmt.setInt(1, id);
            pstmt.executeUpdate();

            conn.commit();
            return true;
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return false;
    }
    @Override
    public boolean deleteEducationalInfo(int id) {
        try {
            conn.setAutoCommit(false);
            String sql1="delete from tb_tclink where id=?";
            pstmt=conn.prepareStatement(sql1);
            pstmt.setInt(1,id);
            pstmt.executeUpdate();
            conn.commit();
            return true;

        }catch (Exception e) {
//		System.out.println(e.getMessage());
        }
        return false;
    }
    @Override
    public List<Map<String, String>> findEducationalInfo(int page, int rows,
                                                         String classname, String subject) {
        try {
            String sql1="select * from tb_tclink limit ?,? ";
            String sql2="select * from tb_tclink where classname like ? and subject like ? limit ?,?";
            String sql3="select rname from tb_teacher where sid = ?";
            if(classname!=""||subject!=""){
                pstmt=conn.prepareStatement(sql2);
                pstmt.setString(1, "%"+classname+"%");
                pstmt.setString(2,"%"+subject+"%");
                pstmt.setInt(3, (page-1)*rows);
                pstmt.setInt(4, rows);
            }else{
                pstmt=conn.prepareStatement(sql1);
                pstmt.setInt(1, (page-1)*rows);
                pstmt.setInt(2, rows);
            }
            pstmt1=conn.prepareStatement(sql3);
            ArrayList al=new ArrayList();
            rs=pstmt.executeQuery();
            while(rs.next()){
                String name1="";
                pstmt1.setString(1, rs.getString(1));
                rs1=pstmt1.executeQuery();
                rs1.next();
                name1=rs1.getString(1);
                Map map=new HashMap();
                map.put("name", name1);
                map.put("subject", rs.getObject(2));
                map.put("classname", rs.getObject(3));
                map.put("id",rs.getObject(4));
                al.add(map);


            }
            return al;
        }
        catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
    @Override
    public int getEducationalInfoSize() {
        try {
            String sql="select count(*) from tb_tclink";
            pstmt=conn.prepareStatement(sql);
            rs=pstmt.executeQuery();

            if(rs.next())
                return rs.getInt(1);


        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return 0;
    }
    @Override
    public String saveTeacher(TeacherInfo teacherinfo) {

        try {
            String sql3="insert into tb_teacher (rname,usex,telephone,email,department,job) values (?,?,?,?,?,?)";
            String sql2="select * from tb_department where dname=?";
            String sql1 = "update tb_teacher set rname=?,usex=?,telephone=?,email=?,department=? , job= ? where sid=? ";
            pstmt1=conn.prepareStatement(sql2);
            pstmt1.setString(1,teacherinfo.getDepartment());
            rs=pstmt1.executeQuery();
            if(rs.next()){
                if(teacherinfo.getSid().equals("鑷姩鐢熸垚")){
                    conn.setAutoCommit(false);
                    pstmt = conn.prepareStatement(sql3);
                    pstmt.setString(1, teacherinfo.getRname());
                    pstmt.setString(2, teacherinfo.getSex());
                    pstmt.setString(3, teacherinfo.getTelephone());
                    pstmt.setString(4, teacherinfo.getEmail());
                    pstmt.setString(5, teacherinfo.getDepartment());
                    pstmt.setString(6, teacherinfo.getJob());
                    pstmt.executeUpdate();
                    conn.commit();
                    return "success";

                }else{
                    conn.setAutoCommit(false);
                    pstmt = conn.prepareStatement(sql1);
                    pstmt.setString(1, teacherinfo.getRname());
                    pstmt.setString(2, teacherinfo.getSex());
                    pstmt.setString(3, teacherinfo.getTelephone());
                    pstmt.setString(4, teacherinfo.getEmail());
                    pstmt.setString(5, teacherinfo.getDepartment());
                    pstmt.setString(6, teacherinfo.getJob());
                    pstmt.setString(7, teacherinfo.getSid());
                    pstmt.executeUpdate();
                    conn.commit();
                    return "success";
                }
            }
            else{
                return "bumenbucunzai";
            }
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return "error";
    }
    @Override
    public boolean saveStudent(Student student){

        if(student.getId().equalsIgnoreCase("鑷姩鐢熸垚")){
            try {
                conn.setAutoCommit(false);
                String sql = "insert into tb_student (telephone,classname,job,birthday,address,sname) values(?,?,?,?,?,?)";
                pstmt=conn.prepareStatement(sql);
                pstmt.setString(1, student.getTelephone());
                pstmt.setString(2, student.getClassname());
                pstmt.setString(3, student.getJob());
                pstmt.setString(4, student.getBirthday());
                pstmt.setString(5, student.getAddress());
                pstmt.setString(6, student.getSname());
                pstmt.executeUpdate();
                conn.commit();

                return true;

            } catch (SQLException e) {
                e.printStackTrace();
                return false;
            }

        }else{
            try {
                conn.setAutoCommit(false);
                String sql="update tb_student set telephone=? ,classname=?, job=?, birthday=?,address=?,sname=? where id=?";
                pstmt=conn.prepareStatement(sql);
                pstmt.setString(1, student.getTelephone());
                pstmt.setString(2, student.getClassname());
                pstmt.setString(3, student.getJob());
                pstmt.setString(4, student.getBirthday());
                pstmt.setString(5, student.getAddress());
                pstmt.setString(6, student.getSname());
                pstmt.setString(7, student.getId());
                pstmt.executeUpdate();
                conn.commit();
                return  true;


            } catch (Exception e) {
                return false;
            }
        }

    }
    @Override
    public String deleteDepartment(String dname){

        String sql1="select * from tb_teacher where department=?";
        try {
            pstmt=conn.prepareStatement(sql1);
            pstmt.setString(1, dname);
            rs=pstmt.executeQuery();
            if(rs.next()){
                return "qingxianqingkongbumenneiburenyuan";
            }
            else{
                conn.setAutoCommit(false);
                String sql2="delete from tb_department where dname = ?";
                pstmt1=conn.prepareStatement(sql2);
                pstmt1.setString(1, dname);
                pstmt1.executeUpdate();
                conn.commit();
                return "true";
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return "false";
    }
    @Override
    public boolean addDepartment(Department department) {
        String sql1="select * from tb_department where dname=?";
        String sql2="insert into tb_department (dname,bossname,daddress) values(?,?,?)";
        try {
            pstmt1=	conn.prepareStatement(sql1);
            pstmt1.setString(1, department.getDname());
            rs=pstmt1.executeQuery();
            if(rs.next()){

                return false;

            }
            else{   conn.setAutoCommit(false);
                pstmt=conn.prepareStatement(sql2);
                pstmt.setString(1, department.getDname());
                pstmt.setString(2, department.getBossname());
                pstmt.setString(3, department.getAddress());
                pstmt.executeUpdate();
                conn.commit();
                return true;
            }
        }
        catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    @Override
    public boolean saveDepartment(Department department) {
        String sql="update tb_department set bossname=? , daddress= ?  where dname=? ";

        try {

            conn.setAutoCommit(false);
            pstmt=conn.prepareStatement(sql);
            pstmt.setString(1, department.getBossname());
            pstmt.setString(2, department.getAddress());
            pstmt.setString(3, department.getDname());
            pstmt.executeUpdate();
            conn.commit();
            return true;

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    @Override
    public boolean addxunchaInfo(xunchaInfo xunchaInfo) {
        try {
            conn.setAutoCommit(false);
            String sql2 = "insert into tb_xuncha_record (searchdate,zhouci,jieci,grade,classname,tname,subject,ontime,tzhuangtai,absence,late,sleep,classdiscipline,xunchayuan,playphone,chat,xueqi,fangjian) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
            pstmt = conn.prepareStatement(sql2);
            pstmt.setString(1, xunchaInfo.getSearchdate());
            pstmt.setString(2, xunchaInfo.getZhouci());
            pstmt.setString(3, xunchaInfo.getJieci());
            pstmt.setString(4, xunchaInfo.getGrade());
            pstmt.setString(5, xunchaInfo.getClassname());
            pstmt.setString(6, xunchaInfo.getTname());
            pstmt.setString(7, xunchaInfo.getSubject());
            pstmt.setString(8, xunchaInfo.getOntime());
            pstmt.setString(9, xunchaInfo.getTzhuangtai());
            pstmt.setString(10, xunchaInfo.getAbsence());
            pstmt.setString(11, xunchaInfo.getLate());
            pstmt.setString(12, xunchaInfo.getSleep());
            pstmt.setString(13, xunchaInfo.getClassdiscipline());
            pstmt.setString(14, xunchaInfo.getXunchayuan());
            pstmt.setString(15, xunchaInfo.getPlayphone());
            pstmt.setString(16, xunchaInfo.getChat());
            pstmt.setString(17, xunchaInfo.getXueqi());
            pstmt.setString(18, xunchaInfo.getFangjian());
            pstmt.executeUpdate();
            conn.commit();
            return true;
        } catch (Exception e) {
            // TODO: handle exception
            System.out.println("宸℃煡淇℃伅娣诲姞澶辫触" + e.getMessage());
        }
        return false;
    }


    @Override
    public boolean saveEducational(Educational educational) {
        String sql="update tb_tclink set subject= ? ,classname=? where id=?";
        String sql1="insert into  tb_tclink (sid,subject,classname) values(?,?,?)";
        String sql2="select * from tb_teacher where sid= ?";
        try {
            if(educational.getId().equals("鑷姩娣诲姞")){
                pstmt=conn.prepareStatement(sql2);
                pstmt.setString(1, educational.getTid());
                rs=pstmt.executeQuery();
                if(rs.next()){
                    conn.setAutoCommit(false);
                    pstmt1=conn.prepareStatement(sql1);
                    pstmt1.setString(1, educational.getTid());
                    pstmt1.setString(2, educational.getSubject());
                    pstmt1.setString(3,educational.getClassname());
                    pstmt1.executeUpdate();
                    conn.commit();
                    return true;
                }
                else{
                    return false;
                }

            }else{
                conn.setAutoCommit(false);
                pstmt=conn.prepareStatement(sql);
                pstmt.setString(1, educational.getSubject());
                pstmt.setString(2,educational.getClassname());
                pstmt.setString(3, educational.getId());
                pstmt.executeUpdate();
                conn.commit();
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }
    @Override
    public String savePaw(String uname, String paw, String opaw) {
        String sql1="select upwd from tb_login where uname=?";
        String sql2="update tb_login set upwd=? where uname=?";
        try {
            pstmt=conn.prepareStatement(sql1);
            pstmt.setString(1, uname);
            rs=pstmt.executeQuery();
            if(rs.next()){
                String upaw=rs.getString(1);
                if(!opaw.equals(upaw)){
                    return "passworderror";
                }
                else{
                    conn.setAutoCommit(false);
                    pstmt=conn.prepareStatement(sql2);
                    pstmt.setString(1, paw);
                    pstmt.setString(2, uname);
                    pstmt.executeUpdate();
                    conn.commit();
                    return "success";

                }
            }
            else{}
        } catch (SQLException e) {
            e.printStackTrace();
        }



        return null;
    }
    @Override
    public boolean resetPaw(String uname) {
        String sql="update tb_login set upwd=? where uname=?";
        try {
            conn.setAutoCommit(false);
            pstmt=conn.prepareStatement(sql);
            pstmt.setString(1,makeMD5("88888888"));
            pstmt.setString(2, uname);
            pstmt.executeUpdate();
            conn.commit();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    @Override
    public String saveRole(String uname, String role) {
        String sql2="update tb_login set role=? where uname=?";
        try {
            conn.setAutoCommit(false);
            pstmt1=conn.prepareStatement(sql2);
            pstmt1.setString(1, role);
            pstmt1.setString(2, uname);
            pstmt1.executeUpdate();
            conn.commit();
            return "success";
        } catch (SQLException e) {
            e.printStackTrace();
        }


        return null;
    }
    @Override
    public boolean deleteXuncahRecordInfo(String searchdate,String jieci,String tname,String subject,String xunchayuan){
        try {
            conn.setAutoCommit(false);
            String sql1="delete from tb_xuncha_record where tname=? and jieci=? and searchdate=? and subject=? and xunchayuan=?";
            pstmt=conn.prepareStatement(sql1);
            pstmt.setString(1, tname);
            pstmt.setString(2, jieci);
            pstmt.setString(3, searchdate);
            pstmt.setString(4,subject);
            pstmt.setString(5, xunchayuan);
            pstmt.executeUpdate();
            conn.commit();
            return true;

        }catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return false;
    }
    @Override
    public List<Map<String, String>> findXunchaRecordInfo(int page, int rows,
                                                          String searchdate, String zhouci, String tname, String jieci,String xunchayuan) {
        try {
            String sql="select*from tb_xuncha_record limit?,?";
            String sql2="select*from tb_xuncha_record where searchdate like ? and zhouci like ? and tname like? and jieci like? and xunchayuan like ? limit ?,?";
            if(searchdate!=""||zhouci!=""||tname!=""||jieci!=""||xunchayuan!=""){
                pstmt=conn.prepareStatement(sql2);
                pstmt.setString(1, "%"+searchdate+"%");
                pstmt.setString(2,"%"+zhouci+"%");
                pstmt.setString(3,"%"+tname+"%");
                pstmt.setString(4,"%"+jieci+"%");
                pstmt.setString(5,"%"+xunchayuan+"%");
                pstmt.setInt(6, (page-1)*rows);
                pstmt.setInt(7, rows);
            }else{

                pstmt=conn.prepareStatement(sql);
                pstmt.setInt(1, (page-1)*rows);
                pstmt.setInt(2, rows);
            }
            ArrayList al=new ArrayList();
            rs=pstmt.executeQuery();
            while(rs.next()){
                Map map=new HashMap();
                map.put("searchdate", rs.getObject(1));
                map.put("zhouci", rs.getObject(2));
                map.put("jieci", rs.getObject(3));
                map.put("grade", rs.getObject(4));
                map.put("classname", rs.getObject(5));
                map.put("tname", rs.getObject(6));
                map.put("subject", rs.getObject(7));
                map.put("ontime", rs.getObject(8));
                map.put("tzhuangtai", rs.getObject(9));
                map.put("absence", rs.getObject(10));
                map.put("late", rs.getObject(11));
                map.put("sleep", rs.getObject(12));
                map.put("classdiscipline", rs.getObject(13));
                map.put("xunchayuan", rs.getObject(14));
                map.put("playphone", rs.getObject(15));
                map.put("chat", rs.getObject(16));
                map.put("xueqi", rs.getObject(17));
                map.put("fangjian", rs.getObject(18));
                al.add(map);
            }
            return al;
        } catch (Exception e) {

            return null;
        }
    }
    @Override
    public int getXunchaRecordInfoSize() {
        try {
            String sql="select count(*) from tb_xuncha_record";
            pstmt=conn.prepareStatement(sql);
            rs=pstmt.executeQuery();

            if(rs.next())
                return rs.getInt(1);


        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return 0;
    }
    @Override
    public List<Map<String, String>> findLogin(int page, int rows, String uname) {

        try {
            String sql1="select*from tb_login limit?,?";
            String sql2="select*from tb_login where uname like ?  limit ?,?";

            if(uname!=""){
                pstmt=conn.prepareStatement(sql2);
                pstmt.setString(1, "%"+uname+"%");
                pstmt.setInt(2, (page-1)*(rows));
                pstmt.setInt(3, rows);
            }
            else{
                pstmt=conn.prepareStatement(sql1);
                pstmt.setInt(1, (page-1)*(rows));
                pstmt.setInt(2, rows);
            }
            ArrayList al=new ArrayList();
            rs=pstmt.executeQuery();
            while(rs.next()){
                Map map=new HashMap();
                map.put("uname", rs.getObject(2));
                map.put("role", rs.getObject(4));
                al.add(map);
            }
            return al;
        } catch (Exception e) {
            return null;
        }

    }
    @Override
    public boolean changeUserInfoPhoto(String uname,String photo) {
        try {
            String sql="update tb_userinfo set photo=? where uname=?";
            pstmt=conn.prepareStatement(sql);
            pstmt.setString(1, photo);
            pstmt.setString(2, uname);
            int i=pstmt.executeUpdate();
            if(i>0)
                return true;
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return false;

    }
    public UserInfo findUserInfoToPersonCenter(String uname) {
        try {
            String sql = "select * from tb_userinfo where uname=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, uname);
            rs = pstmt.executeQuery();
            UserInfo userinfo = new UserInfo();
            if (rs.next()) {

                userinfo.setUname(rs.getString("uname"));
                userinfo.setUsex(rs.getString("usex"));
                userinfo.setBirthday(rs.getString("birthday"));
                userinfo.setAddress(rs.getString("address"));
                userinfo.setPhoto(rs.getString("photo"));
                userinfo.setResume(rs.getString("resume"));
                userinfo.setRuname(rs.getString("runame"));

            }
            return userinfo;

        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return null;
    }
    @Override
    public String makeMD5(String upwd) {
        MessageDigest md;
        try {
            // 鐢熸垚涓�涓狹D5鍔犲瘑璁＄畻鎽樿
            md = MessageDigest.getInstance("MD5");
            // 璁＄畻md5鍑芥暟
            md.update(upwd.getBytes());
            // digest()鏈�鍚庣‘瀹氳繑鍥瀖d5 hash鍊硷紝杩斿洖鍊间负8涓哄瓧绗︿覆銆傚洜涓簃d5 hash鍊兼槸16浣嶇殑hex鍊硷紝瀹為檯涓婂氨鏄�8浣嶇殑瀛楃
            // BigInteger鍑芥暟鍒欏皢8浣嶇殑瀛楃涓茶浆鎹㈡垚16浣峢ex鍊硷紝鐢ㄥ瓧绗︿覆鏉ヨ〃绀猴紱寰楀埌瀛楃涓插舰寮忕殑hash鍊�
            String pwd = new BigInteger(1, md.digest()).toString(16);
            System.err.println(pwd);
            return pwd;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return upwd;

    }
    @Override
    public boolean deleteTeacherRelation(String tid, String sid, String cid) {


        String sql1="delete from tb_teacher_class_subject where tid=? and sid=? and cid=?";
        try {
            conn.setAutoCommit(false);
            pstmt=conn.prepareStatement(sql1);
            pstmt.setString(1, tid);
            pstmt.setString(2, sid);
            pstmt.setString(3, cid);
            pstmt.executeUpdate();
            conn.commit();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
        }


        return false;
    }
    @Override
    public boolean addteacherRelation(TeacherRelation tr) {
        String sql = "insert into tb_teacher_class_subject (sid,cid,tid,sname,cname,tname) values(?,?,?,?,?,?)";
        try {
            conn.setAutoCommit(false);
            pstmt=conn.prepareStatement(sql);
            pstmt.setString(1, tr.getSid());
            pstmt.setString(2, tr.getCid());
            pstmt.setString(3, tr.getTid());
            pstmt.setString(4, tr.getSname());
            pstmt.setString(5, tr.getCname());
            pstmt.setString(6, tr.getTname());
            pstmt.executeUpdate();
            conn.commit();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }
    @Override
    public int getTeacherRelation() {
        try {
            String sql="select count(*) from tb_teacher_class_subject";
            pstmt=conn.prepareStatement(sql);
            rs=pstmt.executeQuery();

            if(rs.next())
                return rs.getInt(1);


        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return 0;
    }
    @Override
    public List<Map<String, String>> findTeacherRelation(int page, int rows,
                                                         String tname) {
        try {
            String sql="select*from tb_teacher_class_subject where tname like ?  limit ?,?";


            pstmt=conn.prepareStatement(sql);
            pstmt.setString(1, "%"+tname+"%");
            pstmt.setInt(2, (page-1)*(rows));
            pstmt.setInt(3, rows);
            ArrayList al=new ArrayList();
            rs=pstmt.executeQuery();
            while(rs.next()){
                Map map=new HashMap();
                map.put("tid", rs.getObject(1));
                map.put("cid", rs.getObject(2));
                map.put("sid", rs.getObject(3));
                map.put("tname", rs.getObject(4));
                map.put("sname", rs.getObject(5));
                map.put("cname", rs.getObject(6));
                al.add(map);
            }
            return al;
        } catch (Exception e) {
            return null;
        }
    }
    @Override
    public List<Map<String, String>> findClassInfo(int page, int rows) {
        try {
            String sql="select*from tb_classname limit ?,?";
            pstmt=conn.prepareStatement(sql);
            pstmt.setInt(1, (page-1)*(rows));
            pstmt.setInt(2, rows);
            ArrayList al=new ArrayList();
            rs=pstmt.executeQuery();
            while(rs.next()){
                Map map=new HashMap();
                map.put("cid", rs.getObject(1));
                map.put("cname", rs.getObject(2));
                al.add(map);
            }
            return al;
        } catch (Exception e) {
            return null;
        }
    }
    @Override
    public int getClassInfoSize() {
        try {
            String sql="select count(*) from tb_classname";
            pstmt=conn.prepareStatement(sql);
            rs=pstmt.executeQuery();

            if(rs.next())
                return rs.getInt(1);


        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return 0;
    }
    @Override
    public List<Map<String, String>> findSubjectInfo(int page, int rows) {
        try {
            String sql="select*from tb_subject limit ?,?";
            pstmt=conn.prepareStatement(sql);
            pstmt.setInt(1, (page-1)*(rows));
            pstmt.setInt(2, rows);
            ArrayList al=new ArrayList();
            rs=pstmt.executeQuery();
            while(rs.next()){
                Map map=new HashMap();
                map.put("sid", rs.getObject(1));
                map.put("sname", rs.getObject(2));
                al.add(map);
            }
            return al;
        } catch (Exception e) {
            System.out.println(e.getMessage());
            return null;
        }
    }
    @Override
    public int getSubjectInfoSize() {
        try {
            String sql="select count(*) from tb_subject";
            pstmt=conn.prepareStatement(sql);
            rs=pstmt.executeQuery();

            if(rs.next())
                return rs.getInt(1);


        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return 0;

    }
    @Override
    public EcharStudentData findEcharStudentdata(String classname,String xueqi,String grade,String teacher) {
        try {
            EcharStudentData esd=new EcharStudentData();

            String sql = "select sum(absence) as a,sum(late) as b,sum(chat) as c,sum(sleep) as d,sum(playphone) as e  from tb_xuncha_record where classname=? and xueqi=? and grade=? ";
            String sql1 = "select sum(absence) as a,sum(late) as b,sum(chat) as c,sum(sleep) as d,sum(playphone) as e  from tb_xuncha_record where classname=? and xueqi=? and grade=? and tname=?";
            String sql2="select count(*)  from tb_xuncha_record where classname=? and xueqi=? and grade=? and tname=? and ontime=?";
            String sql3="select count(*)  from tb_xuncha_record where classname=? and xueqi=? and grade=? and tname=? and tzhuangtai =?";
            String sql4="select count(*)  from tb_xuncha_record where classname=? and xueqi=? and grade=? and tname=? and classdiscipline=?";
            String sql5="select count(*)  from tb_xuncha_record where classname=? and xueqi=? and grade=? and tname=? ";
            if(teacher==""){
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, classname);
                pstmt.setString(2, xueqi);
                pstmt.setString(3, grade);
                rs = pstmt.executeQuery();
                rs.next() ;
                esd.setAbsence(rs.getString(1));
                esd.setLate(rs.getString(2));
                esd.setChat(rs.getString(3));
                esd.setSleep(rs.getString(4));
                esd.setPlayphone(rs.getString(5));
            }
            else{
                pstmt = conn.prepareStatement(sql1);
                pstmt.setString(1, classname);
                pstmt.setString(2, xueqi);
                pstmt.setString(3, grade);
                pstmt.setString(4, teacher);
                rs = pstmt.executeQuery();
                rs.next();
                esd.setAbsence(rs.getString(1));
                esd.setLate(rs.getString(2));
                esd.setChat(rs.getString(3));
                esd.setSleep(rs.getString(4));
                esd.setPlayphone(rs.getString(5));

                pstmt = conn.prepareStatement(sql2);
                pstmt.setString(1, classname);
                pstmt.setString(2, xueqi);
                pstmt.setString(3, grade);
                pstmt.setString(4, teacher);
                pstmt.setString(5, "鏄�");
                rs = pstmt.executeQuery();
                rs.next();
                esd.setOntime(rs.getString(1));

                pstmt = conn.prepareStatement(sql3);
                pstmt.setString(1, classname);
                pstmt.setString(2, xueqi);
                pstmt.setString(3, grade);
                pstmt.setString(4, teacher);
                pstmt.setString(5, "濂�");
                rs = pstmt.executeQuery();
                rs.next();
                esd.setZhuangtai(rs.getString(1));

                pstmt = conn.prepareStatement(sql4);
                pstmt.setString(1, classname);
                pstmt.setString(2, xueqi);
                pstmt.setString(3, grade);
                pstmt.setString(4, teacher);
                pstmt.setString(5, "濂�");
                rs = pstmt.executeQuery();
                rs.next();
                esd.setJilv(rs.getString(1));

                pstmt = conn.prepareStatement(sql5);
                pstmt.setString(1, classname);
                pstmt.setString(2, xueqi);
                pstmt.setString(3, grade);
                pstmt.setString(4, teacher);
                rs = pstmt.executeQuery();
                rs.next();
                esd.setZongshu(rs.getString(1));

            }
            return esd;

        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return null;
    }
    @Override
    public String androidFindphoto(String uname) {

        try {
            String sql="select photo from tb_userinfo where uname=?";
            pstmt=conn.prepareStatement(sql);
            pstmt.setString(1, uname);
            rs=pstmt.executeQuery();
            if(rs.next()){
                return rs.getString(1);
            }
            return "meiyoutouxiang";

        } catch (Exception e) {

        }
        return "error";
    }
    @Override
    public List<Map<String, String>> findStudentRelation(int page, int rows,
                                                         String sname, String classname) {
        try {
            String sql="select*from tb_student_class where sname like ? and cname like ?  limit ?,?";
            pstmt=conn.prepareStatement(sql);
            pstmt.setString(1, "%"+sname+"%");
            pstmt.setString(2, "%"+classname+"%");
            pstmt.setInt(3, (page-1)*(rows));
            pstmt.setInt(4, rows);
            ArrayList al=new ArrayList();
            rs=pstmt.executeQuery();
            while(rs.next()){
                Map map=new HashMap();
                map.put("sid", rs.getObject(1));
                map.put("sname", rs.getObject(2));
                map.put("cid", rs.getObject(3));
                map.put("cname", rs.getObject(4));
                al.add(map);
            }
            return al;
        } catch (Exception e) {
            return null;
        }
    }
    @Override
    public int getStudentRelation() {
        try {
            String sql="select count(*) from tb_student_class";
            pstmt=conn.prepareStatement(sql);
            rs=pstmt.executeQuery();

            if(rs.next())
                return rs.getInt(1);


        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return 0;
    }
    @Override
    public boolean addstudentrRelation(StudentRelation sr) {
        String sql = "insert into tb_student_class (sid,sname,cid,cname	) values(?,?,?,?)";
        try {
            conn.setAutoCommit(false);
            pstmt=conn.prepareStatement(sql);
            pstmt.setString(1, sr.getSid());
            pstmt.setString(2, sr.getSname());
            pstmt.setString(3, sr.getCid());
            pstmt.setString(4, sr.getCname());
            pstmt.executeUpdate();
            conn.commit();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return false;
    }
    @Override
    public boolean deleteStudentRelation(String sid, String cid) {

        String sql1="delete from tb_student_class where  sid=? and cid=?";
        try {
            conn.setAutoCommit(false);
            pstmt=conn.prepareStatement(sql1);
            pstmt.setString(1, sid);
            pstmt.setString(2, cid);
            pstmt.executeUpdate();
            conn.commit();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
    public boolean importExcel2DB(ArrayList<Student> stuList) {
        try {
            conn.setAutoCommit(false);
            for (int i = 0; i < stuList.size(); i++) {
                Student user = stuList.get(i);
                String sql = "select * from tb_student where id=?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, user.getId());
                rs = pstmt.executeQuery();
                if (!rs.next()) {
                    String insertSql = "insert into tb_student(sname,telephone,classname,job,birthday,address) values(?,?,?,?,?)";
                    pstmt = conn.prepareStatement(insertSql);
                    pstmt.setString(1, user.getSname());
                    pstmt.setString(2, user.getTelephone());
                    pstmt.setString(3, user.getClassname());
                    pstmt.setString(4, user.getJob());
                    pstmt.setString(5, user.getBirthday());
                    pstmt.setString(6, user.getAddress());

                    pstmt.executeUpdate();
                } else {
                    System.out.println("閲嶅鏁版嵁");
                }
            }
            conn.commit();
            return true;
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return false;
    }
}







