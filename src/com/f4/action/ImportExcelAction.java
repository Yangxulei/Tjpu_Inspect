package com.f4.action;

/**
 * Created by yangxulei on 2017/7/6.
 */


        import java.io.File;
        import java.io.FileInputStream;
        import java.io.InputStream;
        import java.util.ArrayList;
        import java.util.Map;

        import org.apache.poi.hssf.usermodel.HSSFCell;
        import org.apache.poi.hssf.usermodel.HSSFRow;
        import org.apache.poi.hssf.usermodel.HSSFSheet;
        import org.apache.poi.hssf.usermodel.HSSFWorkbook;
        import org.apache.struts2.convention.annotation.Action;
        import org.apache.struts2.convention.annotation.Namespace;
        import org.apache.struts2.convention.annotation.ParentPackage;

        import com.f4.commoninterface.ParseDB;
        import com.f4.dao.DBUtils;
        import com.f4.pojo.Student;
        import com.opensymphony.xwork2.ActionSupport;


@ParentPackage("struts-default")
@Namespace("/")
public class ImportExcelAction extends ActionSupport{
    Map map;
    int page;
    int rows;
    String id="";
    String sname="";

    File importFile;
    public File getImportFile() {
        return importFile;
    }


    public void setImportFile(File importFile) {
        this.importFile = importFile;
    }


    public Map getMap() {
        return map;
    }


    public void setMap(Map map) {
        this.map = map;
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


    public String getId() {
        return id;
    }


    public void setId(String id) {
        this.id = id;
    }


    public String getSname() {
        return sname;
    }


    public void setSname(String sname) {
        this.sname = sname;
    }


    @Action(value = "excelImportDB")
    public void excelImportDB() {
        try {
            ArrayList<Student> stuList = new ArrayList<Student>();
            InputStream is = new FileInputStream(importFile);
            HSSFWorkbook hwb = new HSSFWorkbook(is);
            for (int i = 0; i < hwb.getNumberOfSheets(); i++) {
                HSSFSheet hs = hwb.getSheetAt(i);
                if (hs == null)
                    continue;
                else {
                    int firstrownum = hs.getFirstRowNum();
                    int lastrownum = hs.getLastRowNum();
                    // System.out.println(firstrownum+","+lastrownum);
                    for (int j = firstrownum + 1; j <= lastrownum; j++) {
                        HSSFRow hr = hs.getRow(j);
                        int firstcolumnnum = hr.getFirstCellNum();
                        int lastcolumnnum = hr.getLastCellNum();
                        // System.out.println(firstcolumnnum+","+lastcolumnnum);
                        String[] value = new String[lastcolumnnum];
                        for (int k = firstcolumnnum; k < lastcolumnnum; k++) {
                            HSSFCell hc = hr.getCell(k);
                            value[k] = ParseDB.parseDB(hc.getCellType(), hc);
                            // System.out.print(value[k]+"\t");
                        }
                        Student stu = new Student();
                        // stu.setId(Integer.parseInt(value[0]));
                        stu.setSname(value[2]);
                        stu.setTelephone(value[3]);
                        stu.setClassname(value[4]);
                        stu.setJob(value[5]);
                        stu.setBirthday(value[6]);
                        stu.setAddress(value[7]);

                        stuList.add(stu);
                    }
                }
            }
            for (int j = 0; j < stuList.size(); j++) {
                System.out.println(stuList.get(j).getId());

            }
            DBUtils dbutils = new DBUtils();
            boolean temp = dbutils.importExcel2DB(stuList);
            if (temp) {
                System.out.println("瀵煎叆鏁版嵁鎴愬姛");
            } else
                System.out.println("瀵煎叆鏁版嵁澶辫触");
            dbutils.close();

        } catch (Exception e) {
            System.out.println(e.getMessage());
        }

    }

}
