package com.f4.commoninterface;

import java.util.List;
import java.util.Map;

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
/**
 * Created by yangxulei on 2017/7/6.
 */

public interface CommonDB {
    boolean addxunchaInfo(xunchaInfo xunchaInfo);
    boolean addteacherRelation(TeacherRelation tr);
    boolean addstudentrRelation(StudentRelation sr);

    boolean login(Login login);
    String androidFindphoto(String uname);

    boolean androidlogin(Login login);

    String registerUser(Login login, UserInfo userinfo);

    boolean addDepartment(Department department);

    boolean saveUser(UserInfo userinfo);

    boolean saveStudent(Student student);

    String savePaw(String uname, String paw, String opaw);

    boolean saveDepartment(Department department);

    boolean saveEducational(Educational educational);

    String saveRole(String uname, String role);

    String saveTeacher(TeacherInfo teacherinfo);

    List<Map<String, String>> findUserInfo(int page, int rows, String uname,
                                           String birthday);

    int getUserInfoSize();

    List<Map<String, String>> findTeacherInfo(int page, int rows, String sid,
                                              String rname);

    int getTeacherInfoSize();
    int getTeacherRelation();
    int getStudentRelation();

    int getDapatmentInfoSize();

    List<Map<String, String>> findDepartmentInfo(int page, int rows,
                                                 String dname);

    List<Map<String, String>> findStudentInfo(int page, int rows, String id,
                                              String sname);

    List<Map<String, String>> findLogin(int page, int rows, String uname);
    List<Map<String, String>> findClassInfo(int page, int rows);
    List<Map<String, String>> findSubjectInfo(int page, int rows);
    List<Map<String, String>> findTeacherRelation(int page, int rows, String tname);
    List<Map<String, String>> findStudentRelation(int page, int rows, String sname,String classname);
    int getSubjectInfoSize();
    int getStudentInfoSize();
    int getClassInfoSize();

    List<Map<String, String>> findEducationalInfo(int page, int rows,
                                                  String classname, String subject);

    int getEducationalInfoSize();

    boolean deleteUserInfoById(int id);
    boolean deleteTeacherRelation(String tid,String sid,String cid);
    boolean deleteStudentRelation(String sid,String cid);

    String deleteTeacherInfoBySid(int sid);

    boolean deleteStudentInfoById(int id);

    boolean deleteEducationalInfo(int id);

    String deleteDepartment(String dname);

    boolean resetPaw(String uname);

    boolean deleteXuncahRecordInfo(String searchdate, String jieci,
                                   String tname, String subject, String xunchayuan);

    List<Map<String, String>> findXunchaRecordInfo(int page, int rows,
                                                   String searchdate, String zhouci, String tname, String jieci,
                                                   String xunchayuan);

    int getXunchaRecordInfoSize();

    boolean changeUserInfoPhoto(String uname, String photo);

    UserInfo findUserInfoToPersonCenter(String uname);
    EcharStudentData findEcharStudentdata(String classname,String xueqi,String grade,String teacher);

    String makeMD5(String upwd);

}
