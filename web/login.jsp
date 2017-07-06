<%--
  Created by IntelliJ IDEA.
  User: yangxulei
  Date: 2017/7/5
  Time: 下午6:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>高校教学教务巡查系统</title>
    <link rel="stylesheet" href="easyui/themes/metro/easyui.css" />
    <link rel="stylesheet" href="easyui/themes/icon.css" />
    <script type="text/javascript" src="easyui/jquery.min.js"></script>
    <script type="text/javascript" src="easyui/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="easyui/locale/easyui-lang-zh_CN.js"></script>
    <link rel="stylesheet"
          href="//cdn.bootcss.com/bootstrap/3.3.5/css/bootstrap.min.css">
    <script src="//cdn.bootcss.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
    <link rel="stylesheet" type="text/css" href="css/login.css" />

    <link rel="stylesheet" type="text/css" href="css/button.css"
          media="screen">
    <link rel="SHORTCUT ICON" href="images/tuzi.png">
    <script type="text/javascript">
        function form_reset() {
            document.getElementById("uname").value="";
            document.getElementById("upwd").value="";
            document.getElementById("vcode").value="";
            $("#role").switchbutton("reset");
            $.messager.show({
                title : "消息提示",
                msg : "表單已被清空!",
                showType : "show"
            });
        }

        function form_login() {
            var uname = $("#uname").val();
            if (uname.length == 0) {
                $.messager.show({
                    title : "消息提示",
                    msg : "用戶名不能為空!",
                    showType : "show"

                });
                return false;
            }
            var upwd = $("#upwd").val();
            if (upwd.length == 0) {
                $.messager.show({
                    title : "消息提示",
                    msg : "密碼不能為空!",
                    showType : "show"
                });
                return false;
            }
            var vcode = $("#vcode").val();
            if (vcode.length == 0) {
                $.messager.show({
                    title : "消息提示",
                    msg : "驗證碼不能為空!",
                    showType : "show"
                });
                return false;
            }
            $.ajax({
                url : 'login',
                type : 'post',
                cache : false,
                data : {
                    "uname" : $("#uname").val(),
                    "upwd" : $("#upwd").val(),
                    "vcode" : $("#vcode").val(),
                    "role" : switchValue
                },
                success : function(result) {
                    if (result == "adminLoginSuccess") {
                        window.location.href = "index.jsp";
                    } else if (result == "plantLoginSuccess") {
                        window.location.href = "index.jsp";
                    } else {
                        $.messager.show({
                            title : "消息提示",
                            msg :"用户名或者密码或者权限错误",
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
        function register() {
            window.location.href = "user_register.jsp";
        }
        function changevcode() {
            document.getElementById("imgcode").src = "vcode.jsp?id="
                + Math.random();
        }
        var switchValue = "巡查员";
        $(function() {
            $('#role').switchbutton({
                checked : false,
                onChange : function(checked) {
                    if (checked == true) {
                        switchValue = "管理员";
                        return;
                    }
                    if (checked == false) {
                        switchValue = "巡查员";
                    }
                }
            })
        });

        $(function(){
            $("#uname").blur(function() {
                $.ajax({
                    url :  "findUserInfoToPersonCenter",
                    type : 'post',
                    cache : false,
                    data : {
                        "uname" : $("#uname").val(),
                    },
                    dataType : "json",
                    success : function(result) {
                        var row = eval(result);
                        $("#photo3").attr("src", row.photo);
                    },
                    error : function(XMLHttpRequest, textStatus, errorThrown) {

                    }
                });
            });
        }) ;

    </script>
    <style type="text/css">
        /* 圆形样式 */
        #divcss {
            margin: 5px auto
        }

        #divcss img {
            border-radius: 50%
        }
        .navbar-color {
            background-color: #2076C3;
            border-bottom: 0px;
        }
        a:link {
            font-size: 12px;
            color: #FFFFFF;
            text-decoration: none;
        }

        a:visited {
            color: #FFFFFF;
            text-decoration: none;
        }
    </style>
</head>
<body>
<nav class="navbar  navbar-fixed-top navbar-color" role="navigation">
    <div class="container">

			<span
                    style="background: left;width:350px; height:64px;float:left;font-size: 25px;color: #ffffff;padding-top: 12px;font-family:Microsoft YaHei;">
				<img id="logo" border="0px" src="images/gongda.jpg" width="50px"
                     height="50px" /> 高校教学教务巡查系统
			</span>
        <div id="dt" align="right"
             style="height:100%;font-size: 20px;float: right;vertical-align: middle;color:#FFFFFF">
            <script>
                setInterval(
                    "dt.innerHTML='<br/>'+new Date().toLocaleString()",
                    1000);
            </script>
        </div>

    </div>

</nav>



<div class='signup_container'>
    <h1 class='signup_title'>用户登陆</h1>
    <div id="divcss">
        <img id="photo3" border="1"  src="images/tuzi.png"
             width="100px" height="100px" />
    </div>


    <div id="signup_forms" class="signup_forms clearfix">

        <form class="signup_form_form" id="signup_form" method="post"
              data-secure-ajax-action="">

            <div class="form_row first_row">
                <label for="uname">请输入用户名</label>
                <!--<div class='tip ok'></div>-->
                <input type="text" name="uanme" placeholder="请输入用户名" id="uname"
                       data-required="required">

                <div class="form_row">
                    <label for="upwd">请输入密码</label>
                    <!--<div class='tip error'></div>-->
                    <input type="password" placeholder="请输入密码" id="upwd" name="upwd"
                           data-required="required">
                </div>

                <div class="form_row">
                    <table>
                        <tr>
                            <td><label for="upwd">请输入验证码</label> <input type="text"
                                                                        id="vcode" name="vcode" placeholder="请输入验证码" /></td>
                            <td style="text-align: center;"><a
                                    href="javascript:changevcode()"><img id="imgcode"
                                                                         src="vcode.jsp" width="100px" height="20px" style="vertical-align: middle;"/></a></td>
                        </tr>
                    </table>

                </div>
            </div>
        </form>

    </div>

</div>

<div style="margin-top: 20px; text-align: center;">

    <table style="margin-left: 40px;margin: 0 auto;" >
        <tr>
            <td><input type="text" name="role" id="role"
                       class="easyui-switchbutton"
                       data-options="width:170,onText:'管理員',offText:'巡查员'"
                       onclick="switchChangeValue()" /></td>
            <td><a href="javascript:register()" class="easyui-linkbutton"
                   data-options="iconCls:'icon-save'" style="color: black">
                    新用户注册
                </a>
            </td>
        </tr>


    </table>
</div>

<div id="btn_login" >
    <div class="button blue"onclick="javascript:form_login()">
        <div class="shine"></div>
        <!--<a href="javascript:form_login()">登录</a>-->
        <input type="button" value="" onclick="javascript:form_login()"/>登录
    </div>
    <div class="button blue"onclick="javascript:form_reset()">
        <div class="shine"></div>
        <input type="button" value="" />取消
    </div><br>
    <br><br>
    Copyright © 2017-？ Paradise. F4:YXL,WQJ,RYS,ZJY All Rights Reserved
</div>

</body>



</html>