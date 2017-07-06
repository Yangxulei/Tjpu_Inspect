<%--
  Created by IntelliJ IDEA.
  User: yangxulei
  Date: 2017/7/5
  Time: 下午7:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<%--<c:if test="${sessionScope.uname!=null}">--%>
    <head>
        <title>教室信息关联</title>
        <meta charset="UTF-8">
        <link rel="stylesheet" href="easyui/themes/metro/easyui.css" />
        <link rel="stylesheet" href="easyui/themes/icon.css" />
        <script type="text/javascript" src="easyui/jquery.min.js"></script>
        <script src="//cdn.bootcss.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
        <link rel="stylesheet" href="//cdn.bootcss.com/bootstrap/3.3.5/css/bootstrap.min.css">
        <script type="text/javascript" src="easyui/jquery.easyui.min.js"></script>
        <script type="text/javascript" src="easyui/locale/easyui-lang-zh_CN.js"></script>
        <link rel="stylesheet" type="text/css" href="css/button.css"
              media="screen">
    </head>


    <script type="text/javascript">

        function findRelationByTname() {
            $("#datagrid").datagrid("reload", {
                "tname" : $("#sousuo_tname").val()

            });
        }
        function options() {
            return "<a href='javascript:deleteRelationInfoByDname()'><button  class='btn btn-danger'>删除</button></a>";
        }
        function deleteRelationInfoByDname() {

            var row = $("#datagrid").datagrid("getSelected");
            if (row != null) {
                $.messager.confirm('确认', '您确定要删除记录吗？', function(r) {
                    if (r) {
                        $.ajax({
                            url : 'deleteTeacherRelation',

                            data : {
                                "tid" : row.tid,
                                "cid" :row.cid,
                                "sid" :row.sid

                            },
                            type:'post',
                            success : function(result) {
                                if (result == "success") {
                                    $("#datagrid").datagrid("reload");
                                    $("#datagrid").datagrid("clearSelections");
                                    $.messager.show({
                                        title : "消息提示",
                                        msg : "删除成功",
                                        showType : "show"
                                    });
                                    row = null;
                                } else {
                                    $("#datagrid").datagrid("reload");
                                    $("#datagrid").datagrid("clearSelections");
                                    $.messager.show({
                                        title : "消息提示",
                                        msg : "删除失败!",
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

        function addRelationInfo(){
            var row3 = $("#xueke").datagrid("getSelected");
            var row1=$("#laoshi").datagrid("getSelected");
            var row2=$("#banji").datagrid("getSelected");
            if(row3!=null&&row1!=null&&row2!=null){
                $.messager.confirm('确认', '您确定关联吗？', function(r) {
                    if (r) {
                        $.ajax({
                            url:"addTeacherRelationInfo",
                            data:{
                                "cid":row2.cid,
                                "tid":row1.sid,
                                "sid":row3.sid,
                                "tname":row1.rname,
                                "sname":row3.sname,
                                "cname":row2.cname
                            },
                            type:'post',
                            cache:false,
                            success:function(result){
                                if(result=="success"){
                                    $("#datagrid").datagrid("reload");
                                    $.messager.show({
                                        title : "消息提示",
                                        msg : "添加成功",
                                        showType : "show"
                                    });

                                }
                                else{
                                    $.messager.show({
                                        title : "消息提示",
                                        msg : "添加失败,已存在此关联",
                                        showType : "show"
                                    });
                                }

                            },
                            error:function(){

                            }
                        });
                    }
                });
            }
            else {
                $.messager.show({
                    title:"消息提示",
                    msg:"请选全",
                    showType:"show"
                });
            }
        }

    </script>

    <body>
    <!-- <div id="departmentManager" class="easyui-panel"
        data-options="title:'教师信息管理',fit:true"> -->
    <center><h4 style="font-family: Microsoft YaHei;">教师信息关联</h4></center>
    <table width="100%" align="center"  frame="hsides" cellspacing="1">
        <tr>
            <td >
                <fieldset	>
                    教师姓名<input id="sousuo_tname" type="text" name="uname" class="easyui-textbox" />
                    <a href="javascript:findRelationByTname()"
                       class="easyui-linkbutton" data-options="iconCls:'icon-search'">搜索</a>

                </fieldset></tr>
        <tr>
            <td>
                <table id="datagrid" class="easyui-datagrid"
                       data-options="url:'findTeacherRelation'
				,method:'post',pagination:true,rownumbers:true,striped:true,singleSelect:true,sortName:'dname',sortOrder:'desc',showHeader:true">
                    <thead>
                    <th data-options="field:'tid',width:'15%',align:'center'">教师id</th>
                    <th data-options="field:'tname',width:'15%',align:'center'">教师姓名</th>
                    <th data-options="field:'cid',width:'15%',align:'center'">班级id</th>
                    <th data-options="field:'cname',width:'15%',align:'center'">班级名称</th>
                    <th data-options="field:'sid',width:'15%',align:'center'">学科id</th>
                    <th data-options="field:'sname',width:'15%',align:'center'">学科名称</th>
                    <th data-options="field:'',width:'15%',formatter:options"></th>

                    </thead>
                </table>
        </tr>
    </table>
    <table width="100%" align="center" frame="hsides">
        <tr>
            <td width="33%"   style="margin: 0px;padding: 0px;">
                <table id="laoshi" style="width: 100%" class="easyui-datagrid"
                       data-options="url:'findTeacherInfo'
				,method:'post',pagination:true,rownumbers:true,striped:true,singleSelect:true,sortName:'dname',sortOrder:'desc',fitColumns:true,showHeader:true">
                    <thead>
                    <th data-options="field:'sid',width:'50%',align:'center'">教师id</th>
                    <th data-options="field:'rname',width:'50%',align:'center'">教师姓名</th>

                    </thead>
                </table>
            <td width="33%"  style="margin: 0px;padding: 0px;">
                <table id="banji"   height="350px" class="easyui-datagrid"
                       data-options="url:'findclassInfo'
				,method:'post',pagination:true,rownumbers:true,striped:true,singleSelect:true,sortName:'dname',sortOrder:'desc',fitColumns:true,showHeader:true">
                    <thead>
                    <th data-options="field:'cid',width:'50%',align:'center'">班级id</th>
                    <th data-options="field:'cname',width:'50%',align:'center'">班级名称</th>

                    </thead>
                </table>
            <td width="33%"  style="margin: 0px;padding: 0px;">
                <table id="xueke"  height="350px"  class="easyui-datagrid"
                       data-options="url:'findsubjectInfo'
				,method:'post',pagination:true,rownumbers:true,striped:true,singleSelect:true,sortName:'dname',sortOrder:'desc',fitColumns:true,showHeader:true">
                    <thead>
                    <th data-options="field:'sid',width:'50%',align:'center'">学科id</th>
                    <th data-options="field:'sname',width:'50%',align:'center'">学科名称</th>

                    </thead>
                </table>
        </tr>
    </table>
    <center><div class="button blue"onclick="javascript:addRelationInfo()">

        关联
    </div></center>


    </body>
<%--</c:if>--%>
<%--<c:if test="${sessionScope.uname==null}">--%>
    <%--非法访问，请先联系管理员！--%>
<%--</c:if>--%>
</html>
