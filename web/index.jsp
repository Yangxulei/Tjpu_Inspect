<%--
  Created by IntelliJ IDEA.
  User: yangxulei
  Date: 2017/7/5
  Time: 下午6:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" errorPage="error.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<%--<c:if test="${sessionScope.uname!=null}">--%>
  <head>
    <meta charset="utf-8">
    <title>教务教学系统管理</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
    <!-- Le styles -->
    <link rel="stylesheet" href="easyui/themes/metro/easyui.css" />
    <link rel="stylesheet" href="easyui/themes/icon.css" />
    <link rel="stylesheet" href="css/managerfont.css" />
    <script type="text/javascript" src="easyui/jquery.min.js"></script>
    <script type="text/javascript" src="easyui/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="easyui/locale/easyui-lang-zh_CN.js"></script>


    <link rel="stylesheet" href="assets/css/style.css">
    <link rel="stylesheet" href="assets/css/loader-style.css">
    <link rel="stylesheet" href="assets/css/bootstrap.css">



    <link rel="SHORTCUT ICON" href="images/tuzi.png">
    <style type="text/css">

      canvas#canvas4 {
        position: relative;
        top: 20px;
      }

      .right {
        width: 100%;

        /*max-height: 800px;*/
        height: 100%;


      }

      .main {
        width: 100%;
        height: 100%;
      }
    </style>

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

        function loginOut1() {
            //	alert("message");
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


    <!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
    <!--[if lt IE 9]>
    <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->
    <!-- Fav and touch icons -->

  </head>

  <body onload="loadImg()">
  <!-- Preloader -->
  <div id="preloader">
    <div id="status">&nbsp;</div>
  </div>
  <!-- TOP NAVBAR -->
  <nav role="navigation" class="navbar navbar-static-top">
    <div class="container-fluid">
      <!-- Brand and toggle get grouped for better mobile display -->
      <div class="navbar-header">
        <button data-target="#bs-example-navbar-collapse-1"
                data-toggle="collapse" class="navbar-toggle" type="button">
          <span class="entypo-menu"></span>
        </button>





        <!--<div id="logo-mobile" class="visible-xs">
       <h1>WEB管理<span>v1.2</span></h1>
    </div>-->

      </div>


      <!-- Collect the nav links, forms, and other content for toggling -->
      <div id="bs-example-navbar-collapse-1"
           class="collapse navbar-collapse">
        <!--
                                           <div id="dt" class="navbar-left running-text visible-lg" style="text-align: center;font-size: 15px; ">


                            <script type="text/javascript">

                            /* var today = new Date(); //??Date
                             var date = today.getDate();//?
                             var day = today.getDay();//???
                             var month = today.getMonth()+1;//?·
                             var year = today.getFullYear();//?
                                     var minute=today.getMinutes();
                                var hours = today.getHours();
                                var second=today.getSeconds();
                             document.write(year+"年"+month+"月"+date+"日"+hours+":"+minute+":"+second+"<br />"); */
                             setInterval(
                                        "dt.innerHTML='<br/>'+new Date().toLocaleString()",
                                        1000);
                             </script>

                        </div> -->
        <img alt="" src="images/logo.png">
        <ul style="margin-right:0;" class="nav navbar-nav navbar-right">
          <li><a data-toggle="dropdown" class="dropdown-toggle"
                 href="#"> <img id="photo2" class="admin-pic img-circle"
                                src="img/tuzi.png">你好，<%=session.getAttribute("uname")%><b
                  class="caret"></b>
          </a>
            <ul style="margin-top:14px;" role="menu"
                class="dropdown-setting dropdown-menu">
              <li><a href="personCenter.jsp" target="iframe"> <span class="entypo-user"></span>&#160;&#160;个人中心
              </a></li>
              <li><a href="javascript:updatePwd()"> <span
                      class="entypo-vcard"></span>&#160;&#160;修改密码
              </a></li>
              <li><a href="javascript:loginOut1()"> <span
                      class="entypo-lifebuoy"></span>&#160;&#160;安全退出
              </a></li>

            </ul></li>
          <li><a data-toggle="dropdown" class="dropdown-toggle"
                 href="#"> <span class="icon-gear"></span>&#160;&#160;设置主题
          </a>
            <ul role="menu" class="dropdown-setting dropdown-menu">

              <li class="theme-bg">
                <div id="button-bg"></div>
                <div id="button-bg2"></div>
                <div id="button-bg3"></div>
                <div id="button-bg5"></div>
                <div id="button-bg6"></div>
                <div id="button-bg7"></div>
                <div id="button-bg8"></div>
                <div id="button-bg9"></div>
                <div id="button-bg10"></div>
                <div id="button-bg11"></div>
                <div id="button-bg12"></div>
                <div id="button-bg13"></div>
              </li>
            </ul></li>

        </ul>

      </div>
      <!-- /.navbar-collapse -->
    </div>
    <!-- /.container-fluid -->
  </nav>

  <!-- /END OF TOP NAVBAR -->

  <!-- SIDE MENU -->
  <div id="skin-select">
    <div >
      <center><img alt="" src="images/logoleft.png"></center>
    </div>

    <a id="toggle"> <span class="entypo-menu"></span>
    </a>


    <!--        <div class="search-hover">
    <form id="demo-2">
        <input type="search" placeholder="Search Menu..." class="id_search">
    </form>
</div>-->




    <div class="skin-part">
      <div id="tree-wrap">
        <div class="side-bar">
          <ul class="topnav menu-left-nest">
            <!--                       <a class="tooltip-tip ajax-load">
       <li>

            <a href="#" style="border-left:0px solid!important;" class="title-menu-left">

                <span class="widget-menu"></span>
                <i data-toggle="tooltip" class="entypo-cog pull-right config-wrap"></i>

            </a>

        </li>
</a>-->
            <li><a class="tooltip-tip ajax-load" href="#"
                   title="巡查员信息管理"> <i class="icon-document-edit"></i> <span>巡查信息管理</span>

            </a>
              <ul>
                <li><a class="tooltip-tip2 ajax-load"
                       href="addxunchaInfo.jsp" target="iframe" title="巡查信息录入"><i
                        class="entypo-doc-text"></i><span>巡查信息录入</span></a></li>
                <li><a href="xunchaRecordManager.jsp"
                       class="tooltip-tip2 ajax-load" target="iframe"
                       title="巡查信息查询"><i class="entypo-newspaper"></i><span>巡查信息查询</span></a></li>
                <li><a class="tooltip-tip2 ajax-load" href="studentCount.jsp" target="iframe"
                       title="学生统计分析"><i class="entypo-window"></i><span>学生统计分析</span></a>
                </li>
                <li><a class="tooltip-tip2 ajax-load" href="teacherCount.jsp" target="iframe"
                       title="教师统计分析"><i class="icon-preview"></i><span>教师统计分析</span></a>
                </li>
              </ul></li>


          </ul>


          <c:if test="${sessionScope.role eq '管理员' }">
            <ul class="topnav menu-left-nest">


              <li><a href="#" class="tooltip-tip" title="基础信息管理"> <i
                      class="icon-document-new"></i> <span>基础信息管理</span>
              </a>
                <ul>
                  <li><a class="tooltip-tip2 ajax-load"
                         href="teacherManager.jsp" target="iframe" title="教师信息管理"><i
                          class="icon-media-record"></i><span>教师信息管理</span></a></li>
                  <li><a class="tooltip-tip2 ajax-load"
                         href="departmentManager.jsp" target="iframe" title="部门信息管理"><i
                          class="icon-user"></i><span>部门信息管理</span></a></li>

                  <li><a class="tooltip-tip2 ajax-load"
                         href="studentManager.jsp" target="iframe" title="学生信息管理"><i
                          class="fontawesome-money"></i><span>学生信息管理</span></a></li>
                  <li><a class="tooltip-tip2 ajax-load"
                         href="xunchayuanManager.jsp" target="iframe" title="巡查员管理"><i
                          class="entypo-clock"></i><span>巡查员管理</span></a></li>
                  <!--                                <li>
              <a class="tooltip-tip2" href="404.html" title="404 Error Page"><i class="icon-thumbs-down"></i><span>404 Error Page</span></a>
          </li>
          <li>
              <a class="tooltip-tip2" href="500.html" title="500 Error Page"><i class="icon-thumbs-down"></i><span>500 Error Page</span></a>
          </li>
          <li>
              <a class="tooltip-tip2" href="lock-screen.html" title="Lock Screen"><i class="icon-lock"></i><span>Lock Screen</span></a>
          </li>-->
                </ul></li>



            </ul>

            <ul id="menu-showhide" class="topnav menu-left-nest">

              <li><a class="tooltip-tip" href="#"  title="业务信息管理"> <i
                      class="icon-document"></i> <span>业务信息管理</span>
              </a>
                <ul>
                  <li><a class="tooltip-tip2 ajax-load"
                         href="teacherRelation.jsp" target="iframe" title="教师信息关联"><i
                          class="icon-document-edit"></i><span>教师信息关联</span></a></li>
                  <li><a class="tooltip-tip2 ajax-load"
                         href="studentRelation.jsp" target="iframe" title="教务信息管理"><i
                          class="entypo-newspaper"></i><span>学生信息关联</span></a></li>
                  <!--    <li>
              <a class="tooltip-tip2 ajax-load" href="andvance-form.html" title="Andvance Form"><i class="icon-map"></i><span>Andvance Form</span></a>
          </li>
          <li>
              <a class="tooltip-tip2 ajax-load" href="text-editor.html" title="Text Editor"><i class="icon-code"></i><span>Text Editor</span></a>
          </li>
          <li>
              <a class="tooltip-tip2 ajax-load" href="file-upload.html" title="File Upload"><i class="icon-upload"></i><span>File Upload</span></a>
          </li>-->
                </ul></li>

            </ul>
            </li>


            </ul>

            <ul id="menu-showhide" class="topnav menu-left-nest">

              <li>
                <!--    <li>
                <a class="tooltip-tip2 ajax-load" href="andvance-form.html" title="Andvance Form"><i class="icon-map"></i><span>Andvance Form</span></a>
            </li>
            <li>
                <a class="tooltip-tip2 ajax-load" href="text-editor.html" title="Text Editor"><i class="icon-code"></i><span>Text Editor</span></a>
            </li>
            <li>
                <a class="tooltip-tip2 ajax-load" href="file-upload.html" title="File Upload"><i class="icon-upload"></i><span>File Upload</span></a>
            </li>-->

              </li>
              <li><a class="tooltip-tip" href="#" title="系统管理"> <i
                      class="icon-view-thumb"></i> <span>系统管理</span>
              </a>
                <ul>
                  <li><a class="tooltip-tip2 ajax-load"
                         href="personCenter.jsp" target="iframe" title="个人中心"><i
                          class="entypo-layout"></i><span>个人中心</span></a></li>
                  <li><a class="tooltip-tip2 ajax-load"
                         href="javascript:updatePwd()" title="修改密码"><i
                          class="entypo-menu"></i><span>修改密码</span></a></li>
                  <li><a class="tooltip-tip2 ajax-load"
                         href="updateRole.jsp" target="iframe" title="权限管理"><i
                          class="icon-upload"></i><span>权限管理</span></a></li>
                  <li><a class="tooltip-tip2 ajax-load"
                         href="javascript:loginOut1()" title="注销登录"><i class="icon-code"></i><span>注销登录</span></a></li>
                </ul></li>


            </ul>
          </c:if>
          <c:if test="${sessionScope.role eq '巡查员' }">
            <ul id="menu-showhide" class="topnav menu-left-nest">

              <li></li>
              <li><a class="tooltip-tip" href="#" title="系统管理"> <i
                      class="icon-view-thumb"></i> <span>系统管理</span>
              </a>
                <ul>
                  <li><a class="tooltip-tip2 ajax-load"
                         href="personCenter.jsp" target="iframe" title="个人中心"><i
                          class="entypo-layout"></i><span>个人中心</span></a></li>
                  <li><a class="tooltip-tip2 ajax-load"
                         href="javascript:updatePwd()" title="修改密码"><i
                          class="entypo-menu"></i><span>修改密码</span></a></li>

                  <li><a class="tooltip-tip2 ajax-load"
                         href="javascript:loginOut1()" title="注销登录"><i
                          class="icon-code"></i><span>注销登录</span></a></li>
                </ul></li>


            </ul>
          </c:if>
        </div>
      </div>
    </div>
  </div>
  <!-- END OF SIDE MENU -->



  <!--  PAPER WRAP -->
  <div class="wrap-fluid main" >
    <div class="container-fluid paper-wrap bevel tlbr right" id="center"style="width: 100%;height: 100%;position: fixed;">
      <iframe id="iframe" name="iframe" src="iframe1.jsp"
              style="width: 85%;height:90%; border: 0px;margin-top: 30px;"></iframe>
    </div>
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






  <!-- END OF RIGHT SLIDER CONTENT-->

  <!--<script src="assets/js/progress-bar/src/jquery.velocity.min.js"></script>-->

  <!--<script src="assets/js/progress-bar/progress-app.js"></script>-->



  <!-- MAIN EFFECT -->
  <script type="text/javascript" src="assets/js/preloader.js"></script>
  <script type="text/javascript" src="assets/js/bootstrap.js"></script>
  <script type="text/javascript" src="assets/js/app.js"></script>
  <script type="text/javascript" src="assets/js/load.js"></script>
  <script type="text/javascript" src="assets/js/main.js"></script>




  <!-- GAGE -->


  <!--    <script type="text/javascript" src="assets/js/chart/jquery.flot.js"></script>-->
  <!--    <script type="text/javascript" src="assets/js/chart/jquery.flot.resize.js"></script>-->
  <!--    <script type="text/javascript" src="assets/js/chart/realTime.js"></script>-->

  <!--    <script type="text/javascript" src="assets/js/countdown/jquery.countdown.js"></script>-->



  <script src="assets/js/jhere-custom.js"></script>







  </body>
<%--</c:if>--%>
<%--<c:if test="${sessionScope.uname==null}">--%>
  <%--非法访问，请先联系管理员！--%>
<%--</c:if>--%>
</html>

