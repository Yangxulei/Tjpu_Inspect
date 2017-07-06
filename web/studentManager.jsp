<%--
  Created by IntelliJ IDEA.
  User: yangxulei
  Date: 2017/7/5
  Time: 下午7:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<%--<c:if test="${sessionScope.uname!=null}">--%>
    <html>
    <head>
        <title>学生信息管理</title>
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
        function addStudent(){
            var id="自动生成"
            $("#s_id").textbox("setValue",id);
            $("#updateStudentInfo").dialog("open");


        }
        function updateStudentInfo(){
            var row = $("#datagrid").datagrid("getSelected");
            if(row!=null){
                $("#s_id").textbox("setValue",row.id);
                $("#s_sname").textbox("setValue",row.sname);
                $("#s_classname").textbox("setValue",row.classname);
                $("#s_telephone").textbox("setValue",row.telephone);
                $("#s_address").textbox("setValue",row.address);
                $("#s_birthday").datebox("setValue",row.birthday);
                $("#s_job").textbox("setValue",row.job);
                $("#updateStudentInfo").dialog("open");
            }
            else{
                $.messager.show({
                    title : "消息提示",
                    msg : "请选择行",
                    showType : "show"
                });}
        }
        function findStudentInfoByNameOrID() {
            $("#datagrid").datagrid("reload", {
                "id" : $("#id").val(),
                "sname" : $("#sname").val()
            });
        }

        function options(id){
            return "<a href='javascript:updateStudentInfo()'><button  class='btn btn-success' >修改</button></a>	&nbsp;&nbsp;<a href='javascript:deleteStudentInfoByID()'><button class='btn btn-danger' >删除</button></a>";
        }
        function deleteStudentInfoByID(){

            var row=$("#datagrid").datagrid("getSelected");
            if(row!=null){
                $.messager.confirm('确认','您确定要删除记录吗？',function(r){
                    if(r){
                        $.ajax({
                            url:'deleteStudentInfoByID',
                            data:{"id":row.id},
                            success:function(result){
                                if(result=="deleteSuccess"){
                                    $("#datagrid").datagrid("reload");
                                    $("#datagrid").datagrid("clearSelections");

                                }else
                                {
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

            }
            else{
                $.messager.show({
                    title : "消息提示",
                    msg : "请选择行",
                    showType : "show"
                });

            }
        }
        function saveStudentInfo(){
            $.ajax({
                url:"savaStudentInfo",
                data:{
                    "s_id":$("#s_id").val(),
                    "s_job":$("#s_job").val(),
                    "s_sname":$("#s_sname").val(),
                    "s_address":$("#s_address").val(),
                    "s_telephone":$("#s_telephone").val(),
                    "s_classname":$("#s_classname").val(),
                    "s_birthday":$("#s_birthday").datebox("getValue")
                },
                type:'post',
                cache:false,
                success:function(result){
                    if(result=="success!"){

                        $("#updateStudentInfo").dialog("close");
                        $("#datagrid").datagrid("reload");
                        $.messager.show({
                            title : "消息提示",
                            msg : "操作成功",
                            showType : "show"
                        });

                    }
                    else{
                        $("#datagrid").datagrid("reload");
                        $.messager.show({
                            title : "消息提示",
                            msg : "操作失败",
                            showType : "show"
                        });
                    }

                },
                error:function(){

                }
            });
        }

        function importExcelToDB() {
            $("#importexcel").window("open");
        }
        function confirmImport() {
            var importfile = $("#importFile").filebox("getValue");
            if (importfile.length == 0) {
                $.messager.show({
                    title : "提示消息",
                    msg : "请选择导入的Excel文件"
                });
                return;
            }
            if (importfile.lastIndexOf(".xls") == -1) {
                $.messager.show({
                    title : "提示消息",
                    msg : "你选择的文件有误，请选择导入的Excel文件"
                });
                return;

            }
            $.messager.progress();
            $("#importform").form("submit", {
                url : "excelImportDB",
                onSubmit : function() {
                    var isValid = $(this).form('validate');
                    if (!isValid) {
                        $.messager.progress('close'); // 如果表单是无效的则隐藏进度条
                    }
                    return isValid; // 返回false终止表单提交
                },
                success : function(result) {
                    $.messager.progress('close');
                    $.messager.show({
                        title : "提示消息",
                        msg : "数据导入成功"
                    });
                    // 如果提交成功则隐藏进度条
                },
                error : function() {
                    $.messager.show({
                        title : "提示消息",
                        msg : "请求服务器失败，请重试"
                    });
                }

            });
            $("#importexcel").window("close");
        }

    </script>
    </script>
    </script>
    <body>
    <!-- <div id="studentManager" class="easyui-panel"
data-options="title:'学生信息管理',fit:true"> -->
    <center><h4 style="font-family: Microsoft YaHei;">学生信息管理</h4></center>
    <table id="datagrid" class="easyui-datagrid"
           data-options="toolbar:'#btn',url:'findStudentInfo',fit:true
				,method:'post',pagination:true,rownumbers:true,striped:true,singleSelect:true,sortName:'birthday',sortOrder:'desc',showHeader:true">
        <thead>
        <th data-options="field:'id',width:'10%',align:'center'">学号</th>
        <th data-options="field:'sname',width:'10%',align:'center'">姓名</th>
        <th data-options="field:'telephone',width:'10%',align:'center'">电话</th>
        <th data-options="field:'classname',width:'10%',align:'center'">班级</th>
        <th data-options="field:'job',width:'10%',align:'center'">班内职务</th>
        <th data-options="field:'birthday',width:'20%',align:'center'">出生日期</th>
        <th data-options="field:'address',width:'20%'">家庭住址</th>
        <th data-options="field:'',width:'10%',formatter:options"></th>
        </thead>
    </table>
    <!-- </div> -->
    <div id="btn">
        <center>
            <a href="javascript:addStudent()" class="easyui-linkbutton" data-options="iconCls:'icon-add'">添加</a>
            <a href="javascript:updateStudentInfo()" class="easyui-linkbutton" data-options="iconCls:'icon-edit'">修改</a>
            <a href="javascript:deleteStudentInfoByID()" class="easyui-linkbutton" data-options="iconCls:'icon-remove'">删除</a>
            <a href="javascript:refreshDataGrid()" class="easyui-linkbutton" data-options="iconCls:'icon-reload'">刷新</a>
            <a href="javascript:importExcelToDB()" href="excel/text.xlsx" class="easyui-linkbutton" data-options="iconCls:'icon-save'">导入Excel</a>

            <br /><br />
            <fieldset>
                学生ID<input id="id" type="text" name="id"class="easyui-textbox" />
                学生姓名<input id="sname" type="text" name="sname"class="easyui-textbox" />

                <a href="javascript:findStudentInfoByNameOrID()" class="easyui-linkbutton" data-options="iconCls:'icon-search'">搜索</a>

            </fieldset>
        </center>
    </div>
    <div id="updateStudentInfo" class="easyui-dialog" data-options="buttons:'#btn_save',width:'500px',height:'500px',closed:true,title:'修改巡查員記錄',iconCls:'icon-edit'">
        <h2>学生信息修改</h2>
        <br>
        <div style="margin-bottom:20px" align="left">

            学号:<input id="s_id" class="easyui-textbox" data-options="prompt:'系统自动生成'"
                      disabled="disabled"	style="width:70%;height:32px">
        </div>
        <div style="margin-bottom:20px" align="left">

            姓名:<input id="s_sname" class="easyui-textbox"
                      style="width:70%;height:32px">
        </div>

        <div style="margin-bottom:20px" align="left">

            电话:<input id="s_telephone" type="text" class="easyui-textbox"
                      style="width:50%;height:32px">
        </div>
        <div style="margin-bottom:20px" align="left">

            班级:	<input id="s_classname" type="text" class="easyui-textbox"
                          style="width:100%;height:32px">
        </div>

        <div style="margin-bottom:20px" align="left">
            班内职务:<input id="s_job"  type="text"   class="easyui-textbox"
                        style="width:100%;height:32px">
        </div>
        <div style="margin-bottom:20px" align="left">

            出生日期:	<input id="s_birthday" type="text" class="easyui-datebox"
                            style="width:100%;height:32px">
        </div>
        <div style="margin-bottom:20px" align="left">

            家庭住址:	<input id="s_address" type="text" class="easyui-textbox"
                            style="width:100%;height:32px">
        </div>


    </div>
    <div id="btn_save">

        <a href="javascript:saveStudentInfo()" class="easyui-linkbutton"
           data-options="iconCls:'icon-save'">保存</a></div>

    <div id="importexcel" class="easyui-window"
         data-options="closed:true,title:'导入Excel数据',modal:true">
        <form id="importform" enctype="multipart/form-data" method="post">
            <input id="importFile" name="importFile" class="easyui-filebox"
                   data-options="required:true,missingMessage:'请选择巡查员信息Excel模板',width:'200px',buttonText:'选择Excel模板',buttonAligh:'left'">
            <a href="javascript:confirmImport()" class="easyui-linkbutton"
               data-options="iconCls:'icon-ok'">确认导入</a>
        </form>
    </div>
    </body>
<%--</c:if>--%>
<%--<c:if test="${sessionScope.uname==null}">--%>
    <%--非法访问，请联系管理员--%>
<%--</c:if>--%>
</html>

