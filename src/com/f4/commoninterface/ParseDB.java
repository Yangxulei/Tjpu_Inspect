package com.f4.commoninterface;
import org.apache.poi.hssf.usermodel.HSSFCell;
/**
 * Created by yangxulei on 2017/7/6.
 */

public class ParseDB {
    public static String parseDB(int celltype, HSSFCell hc) {
        if (celltype == HSSFCell.CELL_TYPE_STRING) {
            return String.valueOf(hc.getStringCellValue());
        } else if (celltype == HSSFCell.CELL_TYPE_NUMERIC)
            return String.valueOf(hc.getNumericCellValue());
        else
            return String.valueOf(hc.getBooleanCellValue());

    }
}