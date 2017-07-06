<%--
  Created by IntelliJ IDEA.
  User: yangxulei
  Date: 2017/7/5
  Time: 下午7:01
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<%--<c:if test="${sessionScope.uname!=null}">--%>
    <head>
        <title>教师信息管理</title>
        <meta charset="UTF-8">
        <link rel="stylesheet" href="easyui/themes/metro/easyui.css" />
        <link rel="stylesheet" href="easyui/themes/icon.css" />
        <link rel="stylesheet" href="//cdn.bootcss.com/bootstrap/3.3.5/css/bootstrap.min.css">
        <script src="//cdn.bootcss.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
        <script type="text/javascript" src="easyui/jquery.min.js"></script>
        <script type="text/javascript" src="easyui/jquery.easyui.min.js"></script>
        <script type="text/javascript" src="easyui/locale/easyui-lang-zh_CN.js"></script>
    </head>


    <script type="text/javascript">

        function refreshDataGrid() {
            $("#datagrid").datagrid("reload");
        }
        function findTeacherInfoBySidandRname() {
            $("#datagrid").datagrid("reload", {
                "sid" : $("#sid").val(),
                "rname" : $("#rname").combobox("getValue"),
            });
        }
        function addTeacher(){
            var id="自动生成";
            $("#u_id").textbox("setValue",id);
            $("#updateTeacherInfo").dialog("open");
        }
        function updateTeacherInfo(){
            var row = $("#datagrid").datagrid("getSelected");
            if(row!=null){
                $("#u_id").textbox("setValue",row.sid);
                $("#u_rname").textbox("setValue",row.rname);
                if(row.usex=="男"){
                    document.getElementById('u_usex1').checked=true;}
                else{
                    document.getElementById('u_usex2').checked=true;}
                $("#u_telephone").textbox("setValue",row.telephone);
                $("#u_email").textbox("setValue",row.email);
                $("#u_department").textbox("setValue",row.department);
                $("#u_job").textbox("setValue",row.job);
                $("#updateTeacherInfo").dialog("open");}
            else{
                $.messager.show({
                    title : "消息提示",
                    msg : "请选择行",
                    showType : "show"
                });}
        }

        function options(id) {
            return "<a href='javascript:updateTeacherInfo()'><button  class='btn btn-success' >修改</button>	&nbsp;&nbsp;<a href='javascript:deleteTeacherInfoBySid()'><button class='btn btn-danger' >删除</button></a>";
        }
        function deleteTeacherInfoBySid() {

            var row = $("#datagrid").datagrid("getSelected");
            if (row != null) {
                $.messager
                    .confirm(
                        '确认',
                        '您确定要删除记录吗？',
                        function(r) {
                            if (r) {
                                $.ajax({
                                    url : 'deleteTeacherInfoBySid',
                                    data : {
                                        "sid" : row.sid
                                    },
                                    success : function(result) {
                                        alert(result);
                                        if (result == "deleteSuccess") {
                                            $("#datagrid").datagrid("reload");
                                            $("#datagrid").datagrid("clearSelections");

                                        } else {
                                            if (result == "qingxianshanchu tb_tclink biaozhong xiangguanshuju") {
                                                $.messager
                                                    .show({
                                                        title : "消息提示",
                                                        msg : "请先删除教务管理中相关信息!",
                                                        showType : "show"
                                                    });
                                            } else {
                                                $.messager
                                                    .show({
                                                        title : "消息提示",
                                                        msg : "删除数据失败!",
                                                        showType : "show"
                                                    });
                                            }
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
        function saveTeacherInfo(){
            var sex;
            if(document.getElementById('u_usex1').checked){
                sex="男";
            }else{
                sex="女";}

            $.ajax({
                url:"savaTeacherInfo",
                data:{
                    "u_id":$("#u_id").val(),
                    "u_department":$("#u_department").val(),
                    "u_job":$("#u_job").val(),
                    "u_email":$("#u_email").val(),
                    "u_telephone":$("#u_telephone").val(),
                    "u_rname":$("#u_rname").val(),
                    " u_usex":sex
                },
                type:'post',
                cache:false,
                success:function(result){
                    if(result=="success!"){

                        $("#updateTeacherInfo").dialog("close");
                        $("#datagrid").datagrid("reload");
                        $.messager.show({
                            title : "消息提示",
                            msg : "操作成功",
                            showType : "show"
                        });

                    }
                    else if(result=="bumenbucunzai"){
                        $.messager.show({
                            title : "消息提示",
                            msg : "不存在此部门",
                            showType : "show"
                        });
                    }
                    else{
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
    </script>
    </script>
    </script>
    <body>
    <!-- <div id="teacherManager" class="easyui-panel"
        data-options="title:'教师信息管理',fit:true"> -->
    <center><h4 style="font-family: Microsoft YaHei;">教师信息管理</h4></center>
    <table id="datagrid" class="easyui-datagrid"
           data-options="toolbar:'#btn',url:'findTeacherInfo'
				,method:'post',pagination:true,rownumbers:true,striped:true,singleSelect:true,sortName:'birthday',sortOrder:'desc',showHeader:true">
        <thead>


        <th data-options="field:'sid',width:'10%',align:'center'">教师编号</th>
        <th data-options="field:'rname',width:'15%',align:'center'">姓名</th>
        <th data-options="field:'usex',width:'10%',align:'center'">性别</th>
        <th data-options="field:'telephone',width:'15%',align:'center'">电话</th>
        <th data-options="field:'email',width:'20%'">Email</th>
        <th data-options="field:'department',width:'10%'">部门名</th>
        <th data-options="field:'job',width:'10%',align:'center'">职务</th>
        <th data-options="field:'',width:'15%',formatter:options,align:'center'"></th>

        </thead>
    </table>

    <div id="btn"><center>
        <a href="javascript:addTeacher()"
           class="easyui-linkbutton" data-options="iconCls:'icon-add'">添加</a> <a
            href="javascript:updateTeacherInfo()" class="easyui-linkbutton" data-options="iconCls:'icon-edit'">修改</a>
        <a href="javascript:deleteTeacherInfoBySid()"
           class="easyui-linkbutton" data-options="iconCls:'icon-remove'">删除</a>
        <a href="javascript:refreshDataGrid()" class="easyui-linkbutton"
           data-options="iconCls:'icon-reload'">刷新</a> <br />

        <br />
        <fieldset>
            教师编号<input id="sid" type="text" name="uname" class="easyui-textbox" />
            姓名	<select id="rname" class="easyui-combobox" name="dept"
                          style="width:15%;">
            <option selected="selected"></option>
            <option>张建军</option>
            <option>尹海欣</option>
            <option>姜丽丽</option>
            <option>韩教授</option>
        </select>
            <a href="javascript:findTeacherInfoBySidandRname()"
               class="easyui-linkbutton" data-options="iconCls:'icon-search'">搜索</a>

        </fieldset>
    </center>
    </div>
    <div id="updateTeacherInfo" class="easyui-dialog" data-options="buttons:'#btn_save',width:'500px',height:'500px',closed:true,title:'教师信息添加/修改',iconCls:'icon-edit'">
        <h2>教师信息修改</h2>
        <br>
        <div style="margin-bottom:20px" align="left">

            教师编号:<input id="u_id" class="easyui-textbox"
                        disabled="disabled"	style="width:70%;height:32px">
        </div>
        <div style="margin-bottom:20px" align="left">

            姓名:<input id="u_rname" class="easyui-textbox"
                      style="width:70%;height:32px">
        </div>
        <div style="margin-bottom:20px" align="left">

            性别：  男    <input type="radio" id="u_usex1" name="identity" value="男" />	 女<input type="radio" id="u_usex2" name="identity" value="女" />
        </div>
        <div style="margin-bottom:20px" align="left">

            电话:<input id="u_telephone" type="text" class="easyui-textbox"
                      style="width:50%;height:32px">
        </div>
        <div style="margin-bottom:20px" align="left">

            email:	<input id="u_email" type="text" class="easyui-textbox"
                             style="width:100%;height:32px">
        </div>
        <div style="margin-bottom:20px" align="left">

            部门名:	<input id="u_department" type="text" class="easyui-textbox"
                           style="width:100%;height:32px">
        </div>
        <div style="margin-bottom:20px" align="left">
            职务:<input id="u_job"  type="text" class="easyui-textbox"
                      style="width:100%;height:32px">
        </div>

    </div>
    <div id="btn_save">

        <a href="javascript:saveTeacherInfo()" class="easyui-linkbutton"
           data-options="iconCls:'icon-save'">保存</a></div>
    </body>
<%--</c:if>--%>
<%--<c:if test="${sessionScope.uname==null}">--%>
    <%--非法访问，请联系管理员--%>
<%--</c:if>--%>
</html>


