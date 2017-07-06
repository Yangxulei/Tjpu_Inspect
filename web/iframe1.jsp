<%--
  Created by IntelliJ IDEA.
  User: yangxulei
  Date: 2017/7/5
  Time: 下午6:55
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>闪光</title>
    <link href="css/iframe1.css" type="text/css"  rel="stylesheet"/>
    <script >
        function updatePwd() {
            $("#updatePwd").dialog("open");
        }


        function voidd(){
            $("#updatePwd").dialog("close");
        }
        /*        function close(){
         $.messager.confirm('系统提示', '您确定要退出系统吗?', function(r) {

         if (r) {
         window.close();
         }
         });
         }
         */
        function savePwd(){

            $.ajax({
                url:"savePaw",
                data:{
                    "uname":"<%=session.getAttribute("uname")%>",
                    "opaw":$("#txtOldPass").val(),
                    "paw":$("#txtNewPass").val(),
                    "rpaw":$("#txtRePass").val()
                },
                type:'post',
                cache:false,
                success:function(result){
                    if(result=="liangcibuyizhi"){
                        $.messager.show({
                            title : "消息提示",
                            msg : "两次密码不一致",
                            showType : "show"
                        });
                    }else if(result=="jiumimacuowu"){

                        $.messager.show({
                            title : "消息提示",
                            msg : "旧密码错误",
                            showType : "show"
                        });

                    }else if(result=="success"){

                        $("#updatePwd").dialog("close");
                        $.messager.show({
                            title : "消息提示",
                            msg : "修改成功",
                            showType : "show"
                        });
                    } else  {
                        $.messager.show({
                            title : "消息提示",
                            msg : "修改失败",
                            showType : "show"
                        });

                    }

                },
                error:function(){

                }

            });
        }

        function loginOut1() {
            //	alert("message");
            $.messager.confirm('系统提示', '您确定要退出本次登录吗?', function(r) {

                if (r) {
                    $.ajax({
                        url:'removeSession',
                        type:'post',
                        cache:false,
                        success:function(result){
                            window.parent.location.href = 'login.jsp';
                        }
                    });
                }
            });
        }
    </script>
</head>

<body>
<link rel="stylesheet" href="easyui/themes/metro/easyui.css" />
<link rel="stylesheet" href="easyui/themes/icon.css" />
<script type="text/javascript" src="easyui/jquery.min.js"></script>
<script type="text/javascript" src="easyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="easyui/locale/easyui-lang-zh_CN.js"></script>
<script src="js/iframe1.js" type="text/javascript"></script>

<div class="main" >
    <center>
        <table >
            <tr>
                <td rowspan="2">     <a class="yellow"href="addxunchaInfo.jsp" target="iframe"style="width: 400px;height: 260px;">
                    <img src="images/xuncha1.png" style="margin-top: 60px" /></br>巡查信息录入</a></td>

                <td> <a class="pink" href="studentCount.jsp" target="iframe"style="width: 150px;height: 125px;font-size:20px ">
                    <img src="images/tongji1.png" style="margin-top: 10px"/><br />学生统计分析</a></td>
                <td rowspan="2" colspan="2"><a class="purple" href="xunchaRecordManager.jsp" target="iframe"style="width: 510px;height: 260px;">
                    <img src="images/xuncha2.png" style="margin-top: 60px" /></br>巡查信息查询</a></td>

            </tr>
            <tr>

                <td > <a class="green" href="teacherCount.jsp" target="iframe"style="width: 150px;height: 125px;font-size:20px">
                    <img src="images/tongji2.png" style="margin-top: 10px"/><br />教师统计分析</a></td>
                <td></td>
                <td></td>
            </tr>
            <tr>
                <td colspan="2" rowspan="2">   <a class="blue" href="personCenter.jsp" target="iframe"style="width: 565px;height: 260px;">
                    <img src="images/person.png" style="margin-top: 60px"/><br />个人中心</a></td>

                <td colspan="2">    <a class="orange" href="javascript:updatePwd()"style="width: 510px;height: 125px;">
                    <img src="images/password.png" style="margin-top: 10px"/><br />修改密码</a></td>

            </tr>
            <tr>

                <td>   <a class="red"href="updateRole.jsp" target="iframe"style="width: 250px;height: 125px;">
                    <img src="images/role.png" style="margin-top: 10px"/><br />权限管理</a></td>
                <td> <a class="lblue"href="javascript:loginOut1()"style="width: 250px;height: 125px;">
                    <img src="images/out.png" style="margin-top: 10px"/><br />注销登录</a></td>
            </tr>
        </table>
    </center>
</div>

<!--修改密码窗口-->
<div id="updatePwd" class="easyui-dialog" title="修改密码" collapsible="false" minimizable="false" maximizable="false" data-options="buttons:'#btn',iconCls:'icon-edit',modal:true,closed:true" style="width: 300px; height: 200px; padding: 5px;
        background: #fafafa;">
    <table>
        <tr>
            <td>旧密码：</td>
            <td><input id="txtOldPass"  class="txt01" /></td>
        </tr>
        <tr>
            <td>新密码：</td>
            <td><input id="txtNewPass"  class="txt01" /></td>
        </tr>
        <tr>
            <td>确认密码：</td>
            <td><input id="txtRePass"  class="txt01" /></td>
        </tr>
    </table>
</div>
<div id="btn">
    <a id="btnEp" class="easyui-linkbutton" icon="icon-ok" href="javascript:savePwd()"> 确定</a>
    <a id="btnCancel" class="easyui-linkbutton" icon="icon-cancel" href="javascript:voidd()">取消</a>
</div>


</body>
</html>

