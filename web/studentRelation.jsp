<%--
  Created by IntelliJ IDEA.
  User: yangxulei
  Date: 2017/7/5
  Time: 下午7:01
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>

<head>
    <title>学生信息关联</title>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="easyui/themes/metro/easyui.css" />
    <link rel="stylesheet" href="easyui/themes/icon.css" />
    <script src="//cdn.bootcss.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="//cdn.bootcss.com/bootstrap/3.3.5/css/bootstrap.min.css">
    <script type="text/javascript" src="easyui/jquery.min.js"></script>
    <link rel="stylesheet" href="//cdn.bootcss.com/bootstrap/3.3.5/css/bootstrap.min.css">
    <script src="//cdn.bootcss.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="easyui/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="easyui/locale/easyui-lang-zh_CN.js"></script>
    <link rel="stylesheet" type="text/css" href="css/button.css"
          media="screen">
</head>


<script type="text/javascript">

    function findStudentRelationBySname() {
        $("#datagrid").datagrid("reload", {
            "sname" : $("#sousuo_sname").val(),
            "classname" :  $("#classname").combobox("getValue")

        });
    }
    function options() {

        return "<a href='javascript:deleteRelationInfoByDname()'><button class='btn btn-danger'  >删除</button></a>";

    }
    function checkbox(){
        return "<input type='checkbox'/>";
    }
    function deleteRelationInfoByDname() {

        var row = $("#datagrid").datagrid("getSelected");
        if (row != null) {
            $.messager.confirm('确认', '您确定要删除记录吗？', function(r) {
                if (r) {
                    $.ajax({
                        url : 'deleteStudentRelation',

                        data : {
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
        var row1=$("#xuesheng").datagrid("getSelections");
        var row2=$("#banji").datagrid("getSelected");
        if(row1!=null&&row2!=null){
            $.messager.confirm('确认', '您确定关联吗？', function(r) {
                if (r) {
                    for( var i=0;i<row1.length;i++){
                        $.ajax({
                            url:"addStudentRelationInfo",
                            data:{
                                "cid":row2.cid,
                                "sid":row1[i].id,
                                "sname":row1[i].sname,
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


                }
                $("#xuesheng").datagrid("reload");
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
    data-options="title:'学生信息关联',fit:true"> -->
<center><h4 style="font-family: Microsoft YaHei;">学生信息关联</h4></center>
<table width="100%" align="center"  frame="hsides" cellspacing="1">
    <tr align="center">
        <td>
            <fieldset>
                学生姓名<input id="sousuo_sname" type="text" name="uname" class="easyui-textbox" />
                班级名称<select id="classname" class="easyui-combobox" name="dept"
                            style="width:15%;">
                <option selected="selected"></option>
                <option>一班</option>
                <option>二班</option>
                <option>三班</option>
                <option>五班</option>
                <option>六班</option>
                <option>七班</option>
                <option>八班</option>
                <option>九班</option>
                <option>十班</option>
                <option>十一班</option>
                <option>十二班</option>
                <option>Z1班</option>
                <option>Z2班</option>
            </select>
                <a href="javascript:findStudentRelationBySname()"
                   class="easyui-linkbutton" data-options="iconCls:'icon-search'">搜索</a>
            </fieldset>
    </tr>
    <tr >
        <td >	<table width="100%" id="datagrid" class="easyui-datagrid"
                        data-options="url:'findStudentRelation'
				,method:'post',pagination:true,rownumbers:true,striped:true,singleSelect:true,sortName:'cid',sortOrder:'desc',showHeader:true">
            <thead align="center">
                <th data-options="field:'sid',width:'23%',align:'center'">学生id</th>
                <th data-options="field:'sname',width:'23%',align:'center'">学生姓名</th>
                <th data-options="field:'cid',width:'23%',align:'center'">班级id</th>
                <th data-options="field:'cname',width:'23%',align:'center'">班级名称</th>
                <th data-options="field:'',width:'20%',formatter:options"></th>
            </thead>
        </table>
    </tr>
</table>
<br>
<br>


<table width="100%" align="center" frame="hsides">
    <tr>
        <td width="50%"  style="float: left;margin: 0px;padding: 0px;">
            <table width="100%"  height="350px" id="banji" class="easyui-datagrid"
                   data-options="url:'findclassInfo'
				,method:'post',pagination:true,rownumbers:true,striped:true,singleSelect:true,sortName:'dname',sortOrder:'desc',fitColumns:true,showHeader:true">
                <thead>
                <th data-options="field:'cid',width:'50%',align:'center'">班级id</th>
                <th data-options="field:'cname',width:'45%',align:'center'">班级名称</th>
                </thead>
            </table>
        <td width="50%" style="float: right;margin: 0px;padding: 0px;">
            <table width="100%"   height="350px"  id="xuesheng" class="easyui-datagrid"
                   data-options="url:'findStudentInfo'
				,method:'post',pagination:true,rownumbers:true,striped:true,sortName:'dname',sortOrder:'desc',fitColumns:true,showHeader:true">
                <thead>
                <th data-options="field:'id',width:'50%',align:'center'">学生id</th>
                <th data-options="field:'sname',width:'40%',align:'center'">学生名称</th>
                <th data-options="field:'',width:'20%',formatter:checkbox"></th>

                </thead>
            </table>
    </tr>
</table>
<center><div class="button blue"onclick="javascript:addRelationInfo()">
    关联
</div></center>
<br>
<br>




</body>

<%--<c:if test="${sessionScope.uname==null}">--%>
    <%--非法访问，请先联系管理员！--%>
<%--</c:if>--%>
</html>