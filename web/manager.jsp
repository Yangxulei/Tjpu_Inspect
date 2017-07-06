<%--
  Created by IntelliJ IDEA.
  User: yangxulei
  Date: 2017/7/5
  Time: 下午6:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<%--<c:if test="${sessionScope.uname!=null}">--%>
    <head>
        <meta charset="UTF-8">
        <title>高校教务巡查系统</title>
        <link rel="stylesheet" href="easyui/themes/metro/easyui.css" />
        <link rel="stylesheet" href="easyui/themes/icon.css" />
        <link rel="stylesheet" href="css/managerfont.css" />
        <script type="text/javascript" src="easyui/jquery.min.js"></script>
        <script type="text/javascript" src="easyui/jquery.easyui.min.js"></script>
        <script type="text/javascript" src="easyui/locale/easyui-lang-zh_CN.js"></script>
        <script>

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

            function addXunchaInfo() {
                var content1 = "addxunchaInfo.jsp";
                if (!$('#center').tabs('exists', '巡查信息录入')) {
                    $('#center').tabs('add', {
                        title: '巡查信息录入',
                        iconCls: 'icon-add',
                        content: "<iframe id='mainFrame' name='mainFrame' src='" + content1 + "' width=100% height=100% frameborder=0 scrolling='no' />",
                        closable: true
                    });
                } else {
                    $('#center').tabs('select', '巡查信息录入');
                }
            }
            function xunchaManager() {
                var content1 = "xunchaRecordManager.jsp";
                if (!$('#center').tabs('exists', '巡查信息查询')) {
                    $('#center').tabs('add', {
                        title: '巡查信息查询',
                        iconCls: 'icon-add',
                        content: "<iframe id='mainFrame' name='mainFrame' src='" + content1 + "' width=100% height=100% frameborder=0 scrolling='no' />",
                        closable: true
                    });
                } else {
                    $('#center').tabs('select', '巡查信息查询');
                }
            }


            function showUser() {
                var content1 = "addUser.html";
                if (!$('#center').tabs('exists', '显示用户')) {
                    $('#center').tabs('add', {
                        title: '显示用户',
                        iconCls: 'icon-add',
                        content: "<iframe id='mainFrame' name='mainFrame' src='" + content1 + "' width=100% height=100% frameborder=0 scrolling='no' />",
                        closable: true
                    });
                } else {
                    $('#center').tabs('select', '显示用户');
                }
            }

            function updatePwd() {
                $("#updatePwd").dialog("open");
            }

            function loginOut() {
                $.messager.confirm('系统提示', '您确定要退出本次登录吗?', function(r) {

                    if (r) {
                        $.ajax({
                            url:'removeSession',
                            type:'post',
                            cache:false,
                            success:function(result){
                                location.href = 'login.jsp';
                            }
                        });
                    }
                });
            }


            function teacherManager(){
                var content1 = "teacherManager.jsp";
                if (!$('#center').tabs('exists', '教师信息管理')) {
                    $('#center').tabs('add', {
                        title: '教师信息管理',
                        iconCls: 'icon-teachermanage',
                        content: "<iframe id='mainFrame' name='mainFrame' src='" + content1 + "' width=100% height=100% frameborder=0 scrolling='no' />",
                        closable: true
                    });
                } else {
                    $('#center').tabs('select', '教师信息管理');
                }
            }
            function xunchayuanManager(){
                var content1 = "xunchayuanManager.jsp";
                if (!$('#center').tabs('exists', '巡查员信息管理')) {
                    $('#center').tabs('add', {
                        title: '巡查员信息管理',
                        iconCls: 'icon-teachermanage',
                        content: "<iframe id='mainFrame' name='mainFrame' src='" + content1 + "' width=100% height=100% frameborder=0 scrolling='no' />",
                        closable: true
                    });
                } else {
                    $('#center').tabs('select', '巡查员信息管理');
                }
            }
            function updateRole(){
                var content1 = "updateRole.jsp";
                if (!$('#center').tabs('exists', '更改权限')) {
                    $('#center').tabs('add', {
                        title: '更改权限',
                        iconCls: 'icon-teachermanage',
                        content: "<iframe id='mainFrame' name='mainFrame' src='" + content1 + "' width=100% height=100% frameborder=0 scrolling='no' />",
                        closable: true
                    });
                } else {
                    $('#center').tabs('select', '更改权限');
                }
            }
            function educationalManager(){
                var content1 = "educationalManager.jsp";
                if (!$('#center').tabs('exists', '教务信息管理')) {
                    $('#center').tabs('add', {
                        title: '教务信息管理',
                        iconCls: 'icon-teachermanage',
                        content: "<iframe id='mainFrame' name='mainFrame' src='" + content1 + "' width=100% height=100% frameborder=0 scrolling='no' />",
                        closable: true
                    });
                } else {
                    $('#center').tabs('select', '教务信息管理');
                }
            }
            function departmentManager(){
                var content1 = "departmentManager.jsp";
                if (!$('#center').tabs('exists', '部门信息管理')) {
                    $('#center').tabs('add', {
                        title: '部门信息管理',
                        iconCls: 'icon-teachermanage',
                        content: "<iframe id='mainFrame' name='mainFrame' src='" + content1 + "' width=100% height=100% frameborder=0 scrolling='no' />",
                        closable: true
                    });
                } else {
                    $('#center').tabs('select', '部门信息管理');
                }
            }



            function studentManager(){
                var content1 = "studentManager.jsp";
                if (!$('#center').tabs('exists', '学生信息管理')) {
                    $('#center').tabs('add', {
                        title: '学生信息管理',
                        iconCls: 'icon-teachermanage',
                        content: "<iframe id='mainFrame' name='mainFrame' src='" + content1 + "' width=100% height=100% frameborder=0 scrolling='no' />",
                        closable: true
                    });
                } else {
                    $('#center').tabs('select', '学生信息管理');

                }
            }

            function teacherRelation(){
                var content1 = "teacherRelation.jsp";
                if (!$('#center').tabs('exists', '教师关联')) {
                    $('#center').tabs('add', {
                        title: '教师关联信息',
                        iconCls: 'icon-teachermanage',
                        content: "<iframe id='mainFrame' name='mainFrame' src='" + content1 + "' width=100% height=100% frameborder=0 scrolling='no' />",
                        closable: true
                    });
                } else {
                    $('#center').tabs('select', '教师关联');

                }
            }
            function personCenter(){
                var content1 = "personCenter.jsp";
                if (!$('#center').tabs('exists', '个人中心')) {
                    $('#center').tabs('add', {
                        title: '个人中心',
                        iconCls: 'icon-teachermanage',
                        content: "<iframe id='mainFrame' name='mainFrame' src='" + content1 + "' width=100% height=100% frameborder=0 scrolling='no' />",
                        closable: true
                    });
                } else {
                    $('#center').tabs('select', '个人中心');

                }
            }
            function studentCount(){
                var content1 = "studentCount.jsp";
                if (!$('#center').tabs('exists', '学生信息统计')) {
                    $('#center').tabs('add', {
                        title: '学生信息统计',
                        iconCls: 'icon-teachermanage',
                        content: "<iframe id='mainFrame' name='mainFrame' src='" + content1 + "' width=100% height=100% frameborder=0 scrolling='no' />",
                        closable: true
                    });
                } else {
                    $('#center').tabs('select', '学生信息统计');

                }
            }

            function loadImg() {
                $.ajax({
                    url : "findUserInfoToPersonCenter",
                    data : {
                        "uname" : '<%=session.getAttribute("uname")%>'
                    },
                    type : "post",
                    dataType : "json",
                    success : function(result) {
                        var row = eval(result);
                        $("#photo2").attr("src", row.photo);
                    }
                });

            }
        </script>

        <style type="text/css">
            /* 圆形样式 */
            #divcss {
                margin: 5px auto
            }

            #divcss img {
                border-radius: 50%
            }
        </style>

    </head>

    <body class="easyui-layout" onload="loadImg()">

    <div id="head" data-options="region:'north',height:70">
        <div region="north" split="true" border="false" style="overflow: hidden; height: 65px;
			background:#2076C3 url(images/headbg.png) repeat-x;line-height: 64px;color: #fff; font-family: Verdana, 微软雅黑,黑体">
				<span  id="divcss" style="float:right; padding-right:20px;" class="head">
				<table >
					<tr>
						<td>
						<a href="javascript:personCenter()">
						<img id="photo2" border="1" alt="个人头像" src="images/tuzi.png"
                             width="50px" height="50px" /></a></td>
				<td style="padding-bottom: 20px">

    欢迎 &nbsp;&nbsp;<%=session.getAttribute("uname")%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  <a href="javascript:updatePwd()" id="editpass" style="color: white;">修改密码</a>&nbsp;&nbsp;<a href="javascript:loginOut()" id="loginOut" style="color: white;">安全退出</a>
    &nbsp;&nbsp;&nbsp;&nbsp;</td>
    </tr>
    </table>
    </span>
            <span style="background: left;width:350px; height:64px;float:left;margin-left: 30px;font-size: 20px;">
				<img id="logo" border="0px" src="images/gongda.jpg" width="50px"
                     height="50px" />
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;高校教学教务巡查系统 </span>
        </div>
    </div>
    <div id="left" data-options="iconCls:'icon-edit',region:'west',split:true
			,width:150,title:'导航菜单'">
        <div class="easyui-accordion" data-options="width:'100%',multiple:true">
            <div data-options="title:'巡查信息管理',iconCls:'icon-large-chart'">
                <ul class="easyui-tree">
                    <li><span><a href="javascript:addXunchaInfo()">巡查信息录入</a></span></li>
                    <li><span><a href="javascript:xunchaManager()">巡查信息查询</a></span></li>

                    <li><span><a href="javascript:showUser()">巡查结果统计分析</a></span>
                        <ul>
                            <li><span><a href="javascript:studentCount()">学生统计分析</a></span></li>
                            <li><span><a href="javascript:showUser()">教师统计分析</a></span></li>
                        </ul>
                    </li>
                </ul>
            </div>
            <c:if test="${sessionScope.role eq '管理员' }">
                <div data-options="title:'基础信息管理',iconCls:'icon-large-shapes'">
                    <ul class="easyui-tree">
                        <li><span><a href="javascript:teacherManager()">教师信息管理</a></span></li>
                        <li><span><a href="javascript:departmentManager()">部门信息管理</a></span></li>
                        <li><span><a href="javascript:educationalManager()">教务信息管理</a></span></li>
                        <li><span><a href="javascript:studentManager()">学生信息管理</a></span></li>
                        <li><span><a href="javascript:xunchayuanManager()">巡查员管理</a></span></li>
                    </ul>
                </div>
                <div data-options="title:'业务信息管理',iconCls:'icon-large-clipart'">
                    <ul class="easyui-tree">
                        <li><span><a href="javascript:teacherRelation()">教师信息关联</a></span></li>
                    </ul>
                </div>

                <div data-options="title:'系统管理',iconCls:'icon-large-picture'">
                    <ul class="easyui-tree">
                        <li><span><a href="javascript:personCenter()">个人中心</a></span></li>
                        <li><span><a href="javascript:updatePwd()">修改密码</a></span></li>
                        <li><span><a href="javascript:updateRole()">权限管理</a></span></li>
                        <li><span><a href="javascript:loginOut()">注销登录</a></span></li>
                    </ul>
                </div>
            </c:if>
            <c:if test="${sessionScope.role eq '巡查员' }">
                <div data-options="title:'系统管理',iconCls:'icon-large-picture'">
                    <ul class="easyui-tree">
                        <li><span><a href="javascript:personCenter()">个人中心</a></span></li>
                        <li><span><a href="javascript:updatePwd()">修改密码</a></span></li>
                        <li><span><a href="javascript:loginOut()">注销登录</a></span></li>
                    </ul>
                </div>
            </c:if>
        </div>
    </div>

    <div id="center" class="easyui-tabs" data-options="region:'center',pill:true,split:true">
        <div title="欢迎使用" style="margin-left: 10px;">
        </div>

    </div>
    <div id="bottom" data-options="region:'south',height:'50px',split:true">
        <center>
            <br /> &copy;2017-2018 isoft&TJPU_F4 Copy Right<br />
            <br />
        </center>
    </div>
    <div id="east" data-options="region:'east',width:150,title:'扩展功能',iconCls:'icon-back',split:true,collapsed:true">3</div>

    <!--修改密码窗口-->
    <div id="updatePwd" class="easyui-dialog" title="修改密码" collapsible="false" minimizable="false" maximizable="false" data-options="buttons:'#btn',iconCls:'icon-edit',modal:true,closed:true" style="width: 300px; height: 200px; padding: 5px;
        background: #fafafa;">
        <table>
            <tr>
                <td>旧密码：</td>
                <td><input id="txtOldPass" type="text" class="txt01" /></td>
            </tr>
            <tr>
                <td>新密码：</td>
                <td><input id="txtNewPass" type="text" class="txt01"></td>
            </tr>
            <tr>
                <td>确认密码：</td>
                <td><input id="txtRePass" type="text" class="txt01" /></td>
            </tr>
        </table>
    </div>
    <div id="btn">
        <a id="btnEp" class="easyui-linkbutton" icon="icon-ok" href="javascript:savePwd()"> 确定</a>
        <a id="btnCancel" class="easyui-linkbutton" icon="icon-cancel" href="javascript:voidd()">取消</a>
    </div>
    </body>
<%--</c:if>--%>
<%--<c:if test="${sessionScope.uname==null}">--%>
    <%--非法访问，请联系管理员--%>
<%--</c:if>--%>
</html>


