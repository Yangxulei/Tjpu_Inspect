<%--
  Created by IntelliJ IDEA.
  User: yangxulei
  Date: 2017/7/5
  Time: 下午6:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<%--<c:if test="${sessionScope.uname!=null}">--%>
    <head>
        <title>部门信息管理</title>
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
        function findDepartmentInfoByDname() {
            $("#datagrid").datagrid("reload", {
                "dname" : $("#dname").val()

            });
        }
        function addDepartment(){
            $("#addDepartmentInfo").dialog("open");

        }
        function updateDepartmentInfo(){
            var row = $("#datagrid").datagrid("getSelected");
            if(row!=null){
                $("#d_dname").textbox("setValue",row.dname);
                $("#d_bossname").textbox("setValue",row.bossname);
                $("#d_address").textbox("setValue",row.address);
                $("#updateDepartmentInfo").dialog("open");}
            else{
                $.messager.show({
                    title : "消息提示",
                    msg : "请选择行",
                    showType : "show"
                });
            }
        }


        function options() {
            return "<a href='javascript:updateDepartmentInfo()'><button  class='btn btn-success' >修改</button></a>	&nbsp;&nbsp;<a href='javascript:deleteDepartmentInfoByDname()'><button class='btn btn-danger'  >删除</button></a>";
        }
        function deleteDepartmentInfoByDname() {

            var row = $("#datagrid").datagrid("getSelected");
            if (row != null) {
                $.messager.confirm('确认', '您确定要删除记录吗？', function(r) {
                    if (r) {
                        $.ajax({
                            url : 'deleteDepartmentInfoByDname',

                            data : {
                                "dname" : row.dname

                            },
                            type:'post',
                            success : function(result) {
                                if (result == "qingchuneiburenyuan") {
                                    $("#datagrid").datagrid("reload");
                                    $("#datagrid").datagrid("clearSelections");
                                    $.messager.show({
                                        title : "消息提示",
                                        msg : "请先删除部门内部教师!",
                                        showType : "show"
                                    });
                                    row = null;
                                } else if(result=="success"){
                                    $("#datagrid").datagrid("reload");
                                    $("#datagrid").datagrid("clearSelections");
                                    $.messager.show({
                                        title : "消息提示",
                                        msg : "删除数据成功!",
                                        showType : "show"
                                    });
                                }
                                else{
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
        function addDepartmentInfo(){
            $.ajax({
                url:"addDepartmentInfo",
                data:{
                    "dname":$("#d_dname2").val(),
                    "address":$("#d_address2").val(),
                    "bossname":$("#d_bossname2").val()
                },
                type:'post',
                cache:false,
                success:function(result){
                    if(result=="success"){

                        $("#addDepartmentInfo").dialog("close");
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
                            msg : "部门名称已存在",
                            showType : "show"
                        });
                    }

                },
                error:function(){

                }
            });
        }
        function saveDepartmentInfo(){
            $.ajax({
                url:"savaDepartmentInfo",
                data:{
                    "dname":$("#d_dname").val(),
                    "address":$("#d_address").val(),
                    "bossname":$("#d_bossname").val()
                },
                type:'post',
                cache:false,
                success:function(result){
                    if(result=="success"){

                        $("#updateDepartmentInfo").dialog("close");
                        $("#datagrid").datagrid("reload");
                        $.messager.show({
                            title : "消息提示",
                            msg : "修改成功",
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

    <body>
    <!-- <div id="departmentManager" class="easyui-panel"
        data-options="title:'部门信息管理',fit:true"> -->
    <center><h4 style="font-family: Microsoft YaHei;">部门信息管理</h4></center>
    <table id="datagrid" class="easyui-datagrid"
           data-options="toolbar:'#btn',url:'findDepartmentInfo'
				,method:'post',pagination:true,rownumbers:true,striped:true,singleSelect:true,sortName:'dname',sortOrder:'desc',showHeader:true">
        <thead>
        <th data-options="field:'dname',width:'20%',align:'center'">名称</th>
        <th data-options="field:'bossname',width:'20%',align:'center'">主任姓名</th>
        <th data-options="field:'address',width:'25%',align:'center'">部门地址</th>
        <th data-options="field:'dnumber',width:'20%',align:'center'">部门人数</th>
        <th data-options="field:'',width:'20%',formatter:options"></th>

        </thead>
    </table>

    <div id="btn">
        <center>
            <a href="javascript:addDepartment()" class="easyui-linkbutton" data-options="iconCls:'icon-add'">添加</a> <a
                href="javascript:updateDepartmentInfo()" class="easyui-linkbutton" data-options="iconCls:'icon-edit'">修改</a>
            <a href="javascript:deleteDepartmentInfoByDname()"       class="easyui-linkbutton"
               data-options="iconCls:'icon-remove'">删除</a>
            <a href="javascript:refreshDataGrid()" class="easyui-linkbutton"
               data-options="iconCls:'icon-reload'">刷新</a> <br />
            <br />
            <fieldset>

                部门<input id="dname" type="text" name="uname" class="easyui-textbox" />
                <a href="javascript:findDepartmentInfoByDname()"
                   class="easyui-linkbutton" data-options="iconCls:'icon-search'">搜索</a>

            </fieldset>
        </center>
    </div>
    <div id="updateDepartmentInfo" class="easyui-dialog" data-options="buttons:'#btn_save',width:'500px',height:'500px',closed:true,title:'修改巡查員記錄',iconCls:'icon-edit'">
        <h2>部门信息修改</h2>
        <br>
        <div style="margin-bottom:20px" align="left">

            部门:<input id="d_dname" class="easyui-textbox"
                      disabled="disabled"	style="width:70%;height:32px">
        </div>
        <div style="margin-bottom:20px" align="left">

            主任姓名:<input id="d_bossname" class="easyui-textbox"
                        style="width:70%;height:32px">
        </div>
        <div style="margin-bottom:20px" align="left">

            部门地址:<input id="d_address" type="text" class="easyui-textbox"
                        style="width:50%;height:32px">
        </div>

    </div>
    <div id="btn_save">
        <a href="javascript:saveDepartmentInfo()" class="easyui-linkbutton"
           data-options="iconCls:'icon-save'">保存</a></div>


    <div id="addDepartmentInfo" class="easyui-dialog" data-options="buttons:'#btn_save1',width:'500px',height:'500px',closed:true,title:'修改巡查員記錄',iconCls:'icon-edit'">
        <h2>部门添加</h2>
        <br>
        <div style="margin-bottom:20px" align="left">

            部门:<input id="d_dname2" class="easyui-textbox"
                      style="width:70%;height:32px">
        </div>
        <div style="margin-bottom:20px" align="left">

            主任姓名:<input id="d_bossname2" class="easyui-textbox"
                        style="width:70%;height:32px">
        </div>
        <div style="margin-bottom:20px" align="left">

            部门地址:<input id="d_address2" type="text" class="easyui-textbox"
                        style="width:50%;height:32px">
        </div>

    </div>

    <div id="btn_save1">

        <a href="javascript:addDepartmentInfo()" class="easyui-linkbutton"
           data-options="iconCls:'icon-save'">保存</a></div>
    </body>
<%--</c:if>--%>
<%--<c:if test="${sessionScope.uname==null}">--%>
    <%--非法访问，请联系管理员--%>
<%--</c:if>--%>
<%--</html>--%>