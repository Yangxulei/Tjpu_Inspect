<%--
  Created by IntelliJ IDEA.
  User: yangxulei
  Date: 2017/7/5
  Time: 下午7:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>高校教学教务巡查系统_用户注册</title>
    <link rel="stylesheet" href="easyui/themes/metro/easyui.css" />
    <link rel="stylesheet" href="easyui/themes/icon.css" />
    <script type="text/javascript" src="easyui/jquery.min.js"></script>
    <script type="text/javascript" src="easyui/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="easyui/locale/easyui-lang-zh_CN.js"></script>
    <link rel="stylesheet"
          href="//cdn.bootcss.com/bootstrap/3.3.5/css/bootstrap.min.css">
    <script src="//cdn.bootcss.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>

    <script type="text/javascript" src="kindeditor/kindeditor-all-min.js"></script>
    <script type="text/javascript" src="kindeditor/lang/zh-CN.js"></script>
    <link href="css/jquery.idealforms.min.css" rel="stylesheet"
          media="screen" />
    <script type="text/javascript" src="js/jquery.idealforms.js"></script>
    <link rel="stylesheet" type="text/css" href="css/button.css"
          media="screen">


    <style>
        div {
            font-size: 12px;
        }
        body{
            background-color: #049ec4;
        }
    </style>
    <script>
        function login() {
            window.location.href="login.jsp";
        }

        function s() {
            window.parent.location.reload();
        }
        var editor;
        KindEditor.ready(function(K) {
            editor = K.create("textarea[name='resume']", {
                resizeType : 1,
                allowPreviewEmoticons : false,
                allowImageUpload : false,
                items : [ 'fontname', 'fontsize', '|', 'forecolor', 'hilitecolor',
                    'bold', 'italic', 'underline', 'removeformat', '|',
                    'justifyleft', 'justifycenter', 'justifyright',
                    'insertorderedlist', 'insertunorderedlist', '|',
                    'emoticons', 'image', 'link' ],
                allowFileManager : true,
                afterCreate : function() {
                    this.sync();
                },
                afterBlur : function() {
                    this.sync();
                }
            });

        });

        function register_user() {
            if ($("#uname").val().length == 0) {
                $.messager.show({
                    title : "消息提示",
                    iconCls : 'icon-help',
                    msg : "用戶名不能为空!",
                    showType : "show"
                });
                return;
            }
            if ($("#upwd").val().length == 0) {
                $.messager.show({
                    title : "消息提示",
                    msg : "密碼不能为空!",
                    showType : "show"
                });
                return;
            }
            if ($("#upwd").val() != $("#cupwd").val()) {
                $.messager.show({
                    title : "消息提示",
                    msg : "密碼和确认密碼不一致!",
                    showType : "show"
                });
                return;
            }
            var usex = $('input[name="sex"]').filter(':checked').val();
            $.ajax({
                url : "registerUser",
                type : "post",
                cache : false,
                data : {
                    "uname" : $("#uname").val(),
                    "upwd" : $("#upwd").val(),
                    "runame" : $("#runame").val(),
                    "usex" : usex,
                    "birthday" : $("#birthday").datebox("getValue"),
                    "address" : $("#address").val(),
                    "resume" : $("#resume").val()
                },
                success : function(result) {
                    if (result == "registerok") {
                        window.location.href = "login.jsp";
                    } else if (result == "chongfu") {
                        $.messager.show({
                            title : "消息提示",
                            msg : "存在相同的用戶名，请换一个新的用戶名!",
                            showType : "show"
                        });
                    } else {
                        $.messager.show({
                            title : "消息提示",
                            msg : "用户注册失败!",
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

        body {
            font: normal 15px/1.5 Arial, Helvetica, Free Sans, sans-serif;
            color: #222;
            overflow-y: scroll;
            padding: 60px 0 0 0;
        }

        #my-form {
            width: 755px;
            margin: 0 auto;
            border: 1px solid #ccc;
            padding: 3em;
            border-radius: 3px;
            box-shadow: 0 0 2px rgba(0, 0, 0, .2);
        }

        #comments {
            width: 350px;
            height: 100px;
        }
    </style>
</head>

<body>
<div style="font-size: 30px;font-family: Microsoft YaHei;color: #FFFFFF"><center>新用户注册</center></div><br>
<form id="my-form" >

    <section name="第一步">
        <div style="margin-bottom:15px" align="left">
            <div style="font-size: 18px;font-family: Microsoft YaHei;">用户名:</div>
            <br> <input id="uname" class="easyui-textbox"
                        data-options="required:true,prompt:'请输入账号',validType:'email'"
                        style="width:70%;height:32px ;"><font color="red">*(必填，30字符以下)</font>
        </div>
        <div style="margin-bottom:15px" align="left">
            <div style="font-size: 18px;font-family: Microsoft YaHei">真实姓名:</div>
            <br> <input id="runame" class="easyui-textbox"
                        data-options="prompt:'请输入您的真实姓名'" style="width:70%;height:32px"><font>(可选)</font>
        </div>



    </section>

    <section name="第二步">
        <div style="margin-bottom:15px" align="left">
            <div style="font-size: 18px;font-family: Microsoft YaHei">密码:</div>
            <br> <input id="upwd" type="password" class="easyui-textbox"
                        data-options="required:true,prompt:'请输入不少于六位的密码'"
                        style="width:250px;height:32px;"><font color="red">*(必填)</font>
        </div>
        <div style="margin-bottom:15px" align="left">
            <div style="font-size: 18px;font-family: Microsoft YaHei">确认密码:</div>
            <br> <input id="cupwd" type="password" class="easyui-textbox"
                        data-options="required:true,prompt:'请重复上面的密码'"
                        style="width:250px;height:32px;"><font color="red">*(必填)</font>
        </div>
        <div style="margin-bottom:15px" align="left">
            <div style="font-size: 18px;font-family: Microsoft YaHei">出生年月:</div>
            <br> <input id="birthday" type="text" class="easyui-datebox"
                        style="width:250px;height:32px">
        </div>

    </section>

    <section name="第三步">
        <div style="margin-bottom:15px" align="left">
            <div style="font-size: 18px;font-family: Microsoft YaHei">性别:</div>

            <div>
                <input type="radio" value="男" checked="checked" name="sex"
                       style="width:50px;height:20px"><font>男</font><input
                    type="radio" value="女" name="sex" style="width:50px;height:20px"><font>女</font>
            </div>
        </div>


        <div style="margin-bottom:15px" align="left">
            <div style="font-size: 18px;font-family: Microsoft YaHei">家庭地址:</div>
            <br> <input id="address" type="text" class="easyui-textbox"
                        style="width:500px;height:32px">
        </div>
        <div style="margin-bottom:15px" align="left">
            <div style="font-size: 18px;font-family: Microsoft YaHei">个人介绍:</div>
            <br>
            <textarea id="resume" name="resume"
                      style="width:400px;height:100px;visibility:hidden;"></textarea>
        </div>
    </section>

    <div>
        <hr />
    </div>



    <table style="width: 100%">
        <tr>
            <td ><div class="button gray"onclick="register_user()"style="height: 50px">
                <div class="shine"></div>
                <!--<a href="javascript:form_login()">登录</a>-->
                注册
            </div></td>
            <td><div class="button gray"onclick="javascript:s()"style="height: 50px">
                <div class="shine"></div>
                取消
            </div></td>
            <td><div class="button gray"onclick="javascript:login()"style="height: 50px">
                <div class="shine"></div>
                已经是注册用户，返回登录

            </div></td>
        </tr>
    </table>
    <!-- 	<a href="#" class="easyui-linkbutton" iconCls="icon-no"
            style="width:100px;height:32px;color: black">取消</a> <a
            href="login.jsp" class="easyui-linkbutton" iconCls="icon-back"
            style="width:400px;height:32px;color: black"></a> -->

    <br>
    <div>
        <center>Copyright © 2017-？ Paradise. F4:万千钧,任永硕,张锦源，杨旭磊 All Rights Reserved</center>
    </div>
</form>
<!-- <nav class="navbar  navbar-fixed-top navbar-color" role="navigation">
    <div class="container">

        <span
            style="background: left;width:350px; height:64px;float:left;font-size: 25px;color: #ffffff;padding-top: 12px;font-family:Microsoft YaHei;">
            <img id="logo" border="0px" src="img/gongda.jpg" width="50px"
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

</nav> -->

<!-- <center>

    <div
        style="color:#FFFFFF ;font-size: 20px;font-family: Microsoft YaHei">新用户注册</div>
    <br /> <br />
    <div id="content" align="center" style="width: 500px;">
        <div style="margin-bottom:15px" align="left">
            <div
                style="color:#FFFFFF ;font-size: 18px;font-family: Microsoft YaHei">用户名:</div>
            <input id="uname" class="easyui-textbox"
                data-options="required:true,prompt:'请输入账号）',validType:'email'"
                style="width:70%;height:32px ;"><font color="red">*(必填，30字符以下)</font>
        </div>
        <div style="margin-bottom:15px" align="left">
            <div
                style="color: #FFFFFF;font-size: 18px;font-family: Microsoft YaHei">真实姓名:</div>
            <input id="runame" class="easyui-textbox"
                data-options="prompt:'请输入您的真实姓名'" style="width:70%;height:32px"><font
                color="#FFFFFF">(可选)</font>
        </div>
        <div style="margin-bottom:15px" align="left">
            <div
                style="color: #FFFFFF;font-size: 18px;font-family: Microsoft YaHei">密码:</div>
            <input id="upwd" type="password" class="easyui-textbox"
                data-options="required:true" style="width:70%;height:32px;"><font
                color="red">*(必填)</font>
        </div>
        <div style="margin-bottom:15px" align="left">
            <div
                style="color: #FFFFFF;font-size: 18px;font-family: Microsoft YaHei">确认密码:</div>
            <input id="cupwd" type="password" class="easyui-textbox"
                data-options="required:true" style="width:70%;height:32px;"><font
                color="red">*(必填)</font>
        </div>
        <div style="margin-bottom:15px" align="left">
            <div
                style="color: #FFFFFF;font-size: 18px;font-family: Microsoft YaHei">性别:</div>
            <div>
                &nbsp;&nbsp;&nbsp;&nbsp; <input type="radio" value="男"
                    checked="checked" name="sex" style="width:10%;height:20px"><font
                    color="#FFFFFF">男</font> <input type="radio" value="女" name="sex"
                    style="width:10%;height:20px"><font color="#FFFFFF">女</font>
            </div>
            </div>
            <div style="margin-bottom:15px" align="left">
                <div
                    style="color: #FFFFFF;font-size: 18px;font-family: Microsoft YaHei">出生年月:</div>
                <input id="birthday" type="text" class="easyui-datebox"
                    style="width:50%;height:32px">
            </div>
            <div style="margin-bottom:15px" align="left">
                <div
                    style="color: #FFFFFF;font-size: 18px;font-family: Microsoft YaHei">家庭地址:</div>
                <input id="address" type="text" class="easyui-textbox"
                    style="width:100%;height:32px">
            </div>
            <div style="margin-bottom:15px" align="left">
                <div
                    style="color: #FFFFFF;font-size: 18px;font-family: Microsoft YaHei">个人介绍:</div>
                <textarea id="resume" name="resume"
                    style="width:100%;height:100px;visibility:hidden;"></textarea>
            </div>

            <div>
                <a href="javascript:register_user()" class="easyui-linkbutton"
                    iconCls="icon-ok" style="width:20%;height:32px;color: black">注册</a>
                <a href="#" class="easyui-linkbutton" iconCls="icon-no"
                    style="width:20%;height:32px;color: black">取消</a> <a
                    href="login.jsp" class="easyui-linkbutton" iconCls="icon-back"
                    style="width:50%;height:32px;color: black">已经是注册用户，返回登录</a>
            </div>
        </div>
</center> -->
<!-- <center>
    <div id="page_footer"
        style="width:960px;background-color:gray;font-size: 12px; color:white">
        <center>
            <br /> &copy;2017-？ 软通动力&天津工业大学 Copy Right<br /> <br />
        </center>
    </div>
</center> -->

</body>
<script type="text/javascript">
    var options = {

        onFail : function() {
            alert($myform.getInvalid().length + ' invalid fields.')
        },

        /* 	inputs: {
         'password': {
         filters: 'required pass',
         },
         'username': {
         filters: 'required username',
         data: {
         //ajax: { url:'validate.php' }
         }
         },
         'file': {
         filters: 'extension',
         data: { extension: ['jpg'] }
         },
         'comments': {
         filters: 'min max',
         data: { min: 50, max: 200 }
         },
         'states': {
         filters: 'exclude',
         data: { exclude: ['default'] },
         errors : {
         exclude: '选择国籍.'
         }
         },
         'langs[]': {
         filters: 'min max',
         data: { min: 2, max: 3 },
         errors: {
         min: 'Check at least <strong>2</strong> options.',
         max: 'No more than <strong>3</strong> options allowed.'
         }
         }
         } */

    };

    var $myform = $('#my-form').idealforms(options).data('idealforms');

    $('#reset').click(function() {
        $myform.reset().fresh().focusFirst()
    });

    $myform.focusFirst();
</script>
</html>

