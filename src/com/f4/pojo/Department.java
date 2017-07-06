package com.f4.pojo;

/**
 * Created by yangxulei on 2017/7/6.
 */
public class Department {
    String dname;
    String bossname;
    public String getBossname() {
        return bossname;
    }
    public void setBossname(String bossname) {
        this.bossname = bossname;
    }
    public String getDname() {
        return dname;
    }
    public void setDname(String dname) {
        this.dname = dname;
    }

    public String getAddress() {
        return address;
    }
    public void setAddress(String address) {
        this.address = address;
    }
    String address;

}
