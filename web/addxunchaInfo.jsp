<%--
  Created by IntelliJ IDEA.
  User: yangxulei
  Date: 2017/7/5
  Time: 下午6:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<%--<c:if test="${sessionScope.uname!=null}">--%>
    <head>
        <title>addUserInfo.html</title>

        <meta name="keywords" content="keyword1,keyword2,keyword3">
        <meta name="description" content="this is my page">
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <link rel="stylesheet" href="easyui/themes/metro/easyui.css" />
        <link rel="stylesheet" href="easyui/themes/icon.css" />
        <link rel="stylesheet" type="text/css" href="css/button.css"
              media="screen">
        <link rel="stylesheet" href="//cdn.bootcss.com/bootstrap/3.3.5/css/bootstrap.min.css">
        <script src="//cdn.bootcss.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
        <script type="text/javascript" src="easyui/jquery.min.js"></script>
        <script type="text/javascript" src="easyui/jquery.easyui.min.js"></script>
        <script type="text/javascript" src="easyui/locale/easyui-lang-zh_CN.js"></script>

        <!--<link rel="stylesheet" type="text/css" href="./styles.css">-->
        <script type="text/javascript">
            $(function(){
                var curr_time = new Date();
                var strDate = curr_time.getFullYear()+"-";
                strDate += curr_time.getMonth()+1+"-";
                strDate += curr_time.getDate()
                $("#searchdate").datebox("setValue", strDate);
            });
            function add_xunchaInfo() {
                if ($("#searchdate").datebox("getValue").length == 0) {
                    $.messager.show({
                        title : "消息提示",
                        msg : "巡查日期不能为空!",
                        showType : "show"
                    });
                    return;
                }
                if ($("#zhouci").combobox("getValue").length == 0) {
                    $.messager.show({
                        title : "消息提示",
                        msg : "巡查周次不能为空!",
                        showType : "show"
                    });
                    return;
                }
                if ($("#jieci").combobox("getValue").length == 0) {
                    $.messager.show({
                        title : "消息提示",
                        msg : "巡查节次不能为空!",
                        showType : "show"
                    });
                    return;
                }
                if ($("#grade").combobox("getValue").length == 0) {
                    $.messager.show({
                        title : "消息提示",
                        msg : "巡查年级不能为空!",
                        showType : "show"
                    });
                    return;
                }
                if ($("#classname").combobox("getValue").length == 0) {
                    $.messager.show({
                        title : "消息提示",
                        msg : "巡查班级不能为空!",
                        showType : "show"
                    });
                    return;
                }
                if ($("#tname").combobox("getValue").length == 0) {
                    $.messager.show({
                        title : "消息提示",
                        msg : "老师姓名不能为空!",
                        showType : "show"
                    });
                    return;
                }
                if ($("#subject").val().length == 0) {
                    $.messager.show({
                        title : "消息提示",
                        msg : "学科不能为空!",
                        showType : "show"
                    });
                    return;
                }

                if ($("#absence").val().length == 0) {
                    $.messager.show({
                        title : "消息提示",
                        msg : "缺勤人数不能为空!",
                        showType : "show"
                    });
                    return;
                }
                if ($("#late").val().length == 0) {
                    $.messager.show({
                        title : "消息提示",
                        msg : "迟到人数不能为空!",
                        showType : "show"
                    });
                    return;
                }
                if ($("#sleep").val().length == 0) {
                    $.messager.show({
                        title : "消息提示",
                        msg : "上课睡觉人数不能为空!",
                        showType : "show"
                    });
                    return;
                }

                var ontime = $('input[name="ontime"]').filter(':checked').val();
                var tzhuangtai = $('input[name="tzhuangtai"]').filter(':checked').val();
                var classdiscipline = $('input[name="classdiscipline"]').filter(
                    ':checked').val();

                $.ajax({
                    url : "addXunchaInfo" ,
                    type : 'post' ,
                    cache : false,
                    data : {
                        "xunchayuan" :$("#xunchayuan").val(),
                        "searchdate" : $("#searchdate").datebox("getValue"),
                        "zhouci" : $("#zhouci").combobox("getValue"),
                        "jieci" : $("#jieci").combobox("getValue"),
                        "grade" : $("#grade").combobox("getValue"),
                        "classname" : $("#classname").combobox("getValue"),
                        "tname" : $("#tname").combobox("getValue"),
                        "qianzhui" : $("#qianzhui").combobox("getValue"),
                        "subject" : $("#subject").combobox("getValue"),
                        "xueqi" : $("#xueqi").combobox("getValue"),
                        "ontime" : ontime,
                        "tzhuangtai" : tzhuangtai,
                        "absence" : $("#absence").val(),
                        "late" : $("#late").val(),
                        "fangjian" : $("#fangjian").val(),
                        "sleep" : $("#sleep").val(),
                        "playphone" : $("#playphone").val(),
                        "chat" : $("#chat").val(),
                        "classdiscipline" : classdiscipline,
                    },

                    success : function(result) {

                        if (result == "addxunchaInfosuccess") {
                            $.messager.show({
                                title : "消息提示",
                                msg : "添加成功!",
                                showType : "show"
                            });
                        } else {
                            $.messager.show({
                                title : "消息提示",
                                msg : "添加失败!",
                                showType : "show"
                            });
                        }
                    },
                    error : function(XMLHttpRequest, textStatus, errorThrown) {
                        $.messager.show({
                            title : "消息提示",
                            msg : "请求服务器失败!",
                            showType : "show"
                        });
                    }
                });
            }
        </script>


    </head>

    <body>
    <!-- <div id="panel" class="easyui-panel"
        data-options="title:'巡查员信息录入',fit:true"> -->
    <!-- <form id="addUserInfo" method="post" style=""> -->
    <h4 style="font-family: Microsoft YaHei;">巡查员信息录入</h4><br>
    记录人员:	 <input id="xunchayuan" class="easyui-textbox" value="${sessionScope.uname}" 	style="width:20%;height:32px">

    <div style="width: 95%;margin-left: 2%" >
        <table id="addUser" width="100%" style="border:1px  #000000;width: 100%">
            <thead><th width="15%">&nbsp;</th></thead>
            <thead><th width="15%">&nbsp;</th></thead>
            <thead><th width="15%"></th></thead>
            <thead>
            <th width="15%">巡查日期</th>
            <th width="15%">年级</th>
            <th width="15%">班级</th>
            <th width="15%">学期</th>
            <th width="15%">周次</th>
            <th width="15%">节次</th>

            </thead>

            <thead><th width="15%">&nbsp;</th></thead>

            <tr>

                <td><input id="searchdate" type="text" class="easyui-datebox"
                           style="width:100%"></td>
                <td><select id="grade" class="easyui-combobox" name="dept"
                            style="width:100%;">
                    <option>大一</option>
                    <option>大二</option>
                    <option>大三</option>
                    <option>大四</option>
                </select></td>
                <td><select id="classname" class="easyui-combobox" name="dept"
                            style="width:100%;">
                    <option>一班</option>
                    <option>二班</option>
                    <option>三班</option>
                    <option>五班</option>
                    <option>六班</option>
                    <option>七班</option>
                    <option>八班</option>
                    <option>九班</option>
                    <option>十班</option>
                    <option>十一班</option>
                    <option>十二班</option>
                    <option>Z1班</option>
                    <option>Z2班</option>
                </select></td>
                <td><select id="xueqi" class="easyui-combobox" name="dept"
                            style="width:100%;">
                    <option >第一学期</option>
                    <option>第二学期</option>
                </select></td>

                <td><select id="zhouci" class="easyui-combobox" name="dept"
                            data-options="required:true" style="width:100%;">
                    <option>第一周</option>
                    <option>第二周</option>
                    <option>第三周</option>
                    <option>第四周</option>
                    <option>第五周</option>
                    <option>第六周</option>
                    <option>第七周</option>
                    <option>第八周</option>
                    <option>第九周</option>
                    <option>第十周</option>
                    <option>第十一周</option>
                    <option>第十二周</option>
                    <option>第十三周</option>
                    <option>第十四周</option>
                    <option>第十五周</option>
                    <option>第十六周</option>
                </select></td>
                <td> <select id="jieci" class="easyui-combobox" name="dept"
                             style="width:100%;">
                    <option >第一节</option>
                    <option>第二节</option>
                    <option>第三节</option>
                    <option>第四节</option>
                    <option>第五节</option>
                </select></td>

            </tr>
            <thead><th width="15%">&nbsp;</th></thead>
            <thead><th width="15%">&nbsp;</th></thead>
            <thead><th width="15%">&nbsp;</th></thead>
            <thead><th width="15%">教师信息:</th></thead>
            <thead><th width="15%">&nbsp;</th></thead>
            <thead>
            <th width="10%">教师</th>
            <th width="10%">学科</th>
            <th width="10%">课堂纪律</th>
            <th width="10%">教师准时进班</th>
            <th width="10%">教师状态</th>
            </thead>

            <tr>
                <td><select id="tname" class="easyui-combobox" name="dept"
                            style="width:100%;">
                    <option>张建军</option>
                    <option>王秋菊</option>
                    <option>崔源</option>
                    <option>薛大欣</option>
                </select></td>
                <td><select id="subject" class="easyui-combobox" name="dept"
                            style="width:100%;">
                    <option>高数</option>
                    <option>英语</option>
                    <option>物理</option>
                    <option>软件</option>
                    <option>线代</option>
                    <option>离散</option>
                </select></td>
                <td><input type="radio" value="好" checked="checked"
                           name="classdiscipline" style="width:10%;height:20px">好 <input
                        type="radio" value="坏" name="classdiscipline"
                        style="width:10%;height:20px">坏</td>
                <td><input type="radio" value="是" checked="checked"
                           name="ontime" style="width:10%;height:20px">是 <input
                        type="radio" value="否" name="ontime" style="width:10%;height:20px">否
                <td><input type="radio" value="好" checked="checked"
                           name="tzhuangtai" style="width:10%;height:20px">好 <input
                        type="radio" value="坏" name="tzhuangtai"
                        style="width:10%;height:20px">坏</td>
                </td>


                <thead>

                <thead><th width="15%">&nbsp;</th></thead>
                <thead><th width="15%">&nbsp;</th></thead>
                <thead><th width="15%">&nbsp;</th></thead>
                <thead><th width="15%">上课情况:</th></thead>
                <thead><th width="15%">&nbsp;</th></thead>
                <th width="10%">教室</th>
                <th width="10%">缺勤人数</th>
                <th width="10%">迟到人数</th>
                <th width="10%">上课睡觉人数</th>
                <th width="10%">上课玩手机人数</th>
                <th width="10%">上课聊天人数</th>
                </thead>

            <tr>
                <td><select id="qianzhui" class="easyui-combobox" name="dept"
                            style="width:25%;">
                    <option>a</option>
                    <option>b</option>
                    <option>c</option>
                    <option>d</option>
                </select><input id="fangjian"  style="width:80px;"
                                required="required" data-options="min:0,max:1000,editable:true">  </td>
                <td><input id="absence" class="easyui-numberspinner" value="0" style="width:80px;"
                           required="required" data-options="min:0,max:1000,editable:true">  </td>
                <td><input id="late" class="easyui-numberspinner" value="0" style="width:80px;"
                           required="required" data-options="min:0,max:1000,editable:true"></td>
                <td><input id="sleep" class="easyui-numberspinner" value="0" style="width:80px;"
                           required="required" data-options="min:0,max:1000,editable:true"></td>
                <td><input id="playphone" class="easyui-numberspinner" value="0" style="width:80px;"
                           required="required" data-options="min:0,max:1000,editable:true"></td>
                <td><input id="chat" class="easyui-numberspinner" value="0" style="width:80px;"
                           required="required" data-options="min:0,max:1000,editable:true"></td>
            </tr>			  <tr>  <tr>  <tr>  <tr>  <tr>  <tr>  <tr>  <tr>  <tr>  <tr>  <tr>  <tr>
        </table>
    </div>
    <br>
    <br>
    <br>
    <br>
    <br>
    <div style="width: 100%">
        <center>
            <button id="btn" onClick="javascript:add_xunchaInfo()"
                    class="btn btn-primary"
                    data-options="iconCls:'icon-search',width:'100px',height:'40px'"
                    style="background-color: #458bff;">提交</button>
        </center>
    </div>
    <!-- </form> -->

    <!-- </div> -->

    </body>
<%--</c:if>--%>
<%--<c:if test="${sessionScope.uname==null}">--%>
    <%--非法访问，请先联系管理员--%>
<%--</c:if>--%>
<%--</html>--%>