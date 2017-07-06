<%--
  Created by IntelliJ IDEA.
  User: yangxulei
  Date: 2017/7/5
  Time: 下午7:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<%--<c:if test="${sessionScope.uname!=null}">--%>
    <head>
        <title>巡查員管理</title>
        <meta charset="UTF-8">
        <link rel="stylesheet" href="easyui/themes/metro/easyui.css" />
        <link rel="stylesheet" href="easyui/themes/icon.css" />
        <link rel="stylesheet"
              href="//cdn.bootcss.com/bootstrap/3.3.5/css/bootstrap.min.css">
        <script src="//cdn.bootcss.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
        <script type="text/javascript" src="easyui/jquery.min.js"></script>
        <script type="text/javascript" src="easyui/jquery.easyui.min.js"></script>
        <script type="text/javascript" src="easyui/locale/easyui-lang-zh_CN.js"></script>
    </head>


    <script type="text/javascript">
        function refreshDataGrid() {
            $("#datagrid").datagrid("reload");
        }

        function findUserInfoByNameOrBirthday() {
            $("#datagrid").datagrid("reload", {
                "uname" : $("#uname").val(),
                "birthday" : $("#birthday").datebox("getValue")

            });

        }
        function showPhoto(img) {
            return "<img src='"+iamges+"' width=50px height=50px/>";
        }
        function updateUserInfo() {
            var row = $("#datagrid").datagrid("getSelected");
            if (row != null) {
                $("#u_olduname").textbox("setValue", row.uname)
                $("#u_newuname").textbox("setValue", row.uname);
                $("#u_runame").textbox("setValue", row.runame);
                if (row.usex == "男") {
                    document.getElementById('u_usex1').checked = true;
                } else {
                    document.getElementById('u_usex2').checked = true;
                }
                $("#u_birthday").textbox("setValue", row.birthday);
                $("#u_address").textbox("setValue", row.address);
                $("#u_resume").textbox("setValue", row.resume);
                $("#updateUserInfo").dialog("open");
            } else {
                $.messager.show({
                    title : "消息提示",
                    msg : "请选择行",
                    showType : "show"
                });
            }
        }
        function resetPaw() {
            var row = $("#datagrid").datagrid("getSelected");

            $.messager.confirm('确认', '您确定要重置管理员密码吗？', function(r) {
                if (r) {
                    $.ajax({
                        url : 'resetPaw',
                        data : {
                            "uname" : row.uname
                        },
                        type : 'post',
                        success : function(result) {
                            if (result == "success") {
                                $.messager.show({
                                    title : "消息提示",
                                    msg : "重置成功，新密码为88888888!",
                                    showType : "show"
                                });
                            } else {
                                $.messager.show({
                                    title : "消息提示",
                                    msg : "重置失败",
                                    showType : "show"
                                });
                            }

                        }

                    });

                }
            });
        }

        function options() {
            return "<a href='javascript:updateUserInfo()'><button  class='btn btn-success'>修改</button></a>&nbsp;&nbsp;<a href='javascript:deleteUserInfoByID()'><button class='btn btn-danger'  >删除</button></a> &nbsp;&nbsp;<a href='javascript:resetPaw()'><button  class='btn btn-primary btn-sm' >重置密码</button></a>";
        }
        function deleteUserInfoByID() {
            var row = $("#datagrid").datagrid("getSelected");
            if (row != null) {
                $.messager.confirm('确认', '您确定要删除记录吗？', function(r) {
                    if (r) {
                        $.ajax({
                            url : 'deleteUserInfoByID',
                            data : {
                                "id" : row.id
                            },
                            success : function(result) {
                                if (result == "deleteSuccess") {
                                    $("#datagrid").datagrid("reload");
                                    $("#datagrid").datagrid("clearSelections");
                                    row = null;
                                } else {
                                    $.messager.show({
                                        title : "消息提示",
                                        msg : "删除数据失败!",
                                        showType : "show"
                                    });
                                }
                            }
                        });

                    }
                });

            } else {
                $.messager.show({
                    title : "消息提示",
                    msg : "请选择行",
                    showType : "show"
                });

            }
        }
        function saveUserInfo() {
            var sex;
            if (document.getElementById('u_usex1').checked) {
                sex = "男";
            } else {
                sex = "女";
            }

            $.ajax({
                url : 'savaUserInfo',
                data : {
                    "u_birthday" : $("#u_birthday").val(),
                    "u_address" : $("#u_address").val(),
                    "u_resume" : $("#u_resume").val(),
                    "u_runame" : $("#u_runame").val(),
                    "u_uname" : $("#u_olduname").val(),
                    "u_newuname" : $("#u_newuname").val(),
                    " u_usex" : sex
                },
                type : 'post',
                cache : false,
                success : function(result) {
                    if (result == "success!") {

                        $("#updateUserInfo").dialog("close");
                        $("#datagrid").datagrid("reload");
                        $.messager.show({
                            title : "消息提示",
                            msg : "修改成功",
                            showType : "show"
                        });

                    } else {
                        $.messager.show({
                            title : "消息提示",
                            msg : "修改失败,用户名已存在",
                            showType : "show"
                        });
                    }

                },
                error : function() {

                }
            });

        }


    </script>


    <style>
        .datagrid-cell,.datagrid-cell-group,.datagrid-header-rownumber,.datagrid-cell-rownumber
        {
            -o-text-overflow: ellipsis;
            text-overflow: ellipsis;
        }
    </style>
    <body>

    <center><h4 style="font-family: Microsoft YaHei;">巡查员查询</h4></center>
    <table id="datagrid"
           class="easyui-datagrid datagrid-cell datagrid-cell-group  datagrid-header-rownumber datagrid-cell-rownumber"
           data-options="toolbar:'#btn', url:'findUserInfo'

				,method:'post',pagination:true,rownumbers:true,striped:true,singleSelect:true,sortOrder:'desc',showHeader:true">
        <thead>

        <th data-options="field:'photo',width:'10%',formatter:showPhoto,align:'center'">照片</th>
        <th data-options="field:'uname',width:'10%',align:'center'">登录名称</th>
        <th data-options="field:'runame',width:'10%',align:'center'">真实姓名</th>
        <th data-options="field:'usex',width:'10%',align:'center'">性别</th>
        <th data-options="field:'birthday',width:'10%',align:'center'">出生年月</th>
        <th data-options="field:'address',width:'10%',align:'center'">家庭地址</th>
        <th data-options="field:'resume',width:'10%'" class="table">个人简介</th>
        <th data-options="field:'',width:'10%',formatter:options"></th>

        </thead>
    </table>

    <div id="btn">
        <center>
            <a href="javascript:updateUserInfo()" class="easyui-linkbutton"
               data-options="iconCls:'icon-edit'">修改</a> <a
                href="javascript:deleteUserInfoByID()" class="easyui-linkbutton"
                data-options="iconCls:'icon-remove'">删除</a> <a
                href="javascript:refreshDataGrid()" class="easyui-linkbutton"
                data-options="iconCls:'icon-reload'">刷新</a> <br /> <br />
            <fieldset>
                登录名<input id="uname" type="text" name="uname" class="easyui-textbox" />
                真实姓名<select id="rname" class="easyui-combobox" name="dept"
                            style="width:15%;">
                <option selected="selected"></option>
                <option>张建军</option>
                <option>尹海欣</option>
                <option>姜丽丽</option>
                <option>韩教授</option>
            </select> 出生日期<input id="birthday" class="easyui-datebox" type="text"
                                 name="uname" /> <a
                    href="javascript:findUserInfoByNameOrBirthday()"
                    class="easyui-linkbutton" data-options="iconCls:'icon-search'">搜索</a>

            </fieldset>
        </center>
    </div>
    <div id="updateUserInfo" class="easyui-dialog"
         data-options="buttons:'#btn_save',width:'500px',height:'500px',closed:true,title:'修改巡查員記錄',iconCls:'icon-edit'">
        <h2>巡查员记录修改</h2>
        <br>
        <div style="margin-bottom:20px" align="left">
            <input id="u_olduname" type="text" class="easyui-textbox"
                   style="width:0%;height:0px"> 用户名:<input id="u_newuname"
                                                           class="easyui-textbox"
                                                           data-options="required:true,prompt:'请盡量输入账号（Email/手机号）'"
                                                           style="width:70%;height:32px">
        </div>
        <div style="margin-bottom:20px" align="left">

            真实姓名:<input id="u_runame" class="easyui-textbox"
                        data-options="prompt:'请输入您的真实姓名'" style="width:70%;height:32px">
        </div>
        <div style="margin-bottom:20px" align="left">

            性别： 男 <input type="radio" id="u_usex1" name="identity" value="男" />
            女<input type="radio" id="u_usex2" name="identity" value="女" />
        </div>
        <div style="margin-bottom:20px" align="left">

            出生年月:<input id="u_birthday" type="text" class="easyui-datebox"
                        style="width:50%;height:32px">
        </div>
        <div style="margin-bottom:20px" align="left">

            家庭地址: <input id="u_address" type="text" class="easyui-textbox"
                         style="width:100%;height:32px">
        </div>
        <div style="margin-bottom:20px" align="left">

            个人介绍:<input id="u_resume" style="height: 100px;width: 100%;"
                        type="text" data-options="multiline:true" class="easyui-textbox"
                        style="width:100%;height:32px">
        </div>

    </div>
    <div id="btn_save">

        <a href="javascript:saveUserInfo()" class="easyui-linkbutton"
           data-options="iconCls:'icon-save'">保存</a>
    </div>
    </body>
<%--</c:if>--%>
<%--<c:if test="${sessionScope.uname==null}">--%>
    <%--非法访问，请先联系管理员--%>
<%--</c:if>--%>
</html>