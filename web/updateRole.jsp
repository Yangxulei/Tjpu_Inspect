<%--
  Created by IntelliJ IDEA.
  User: yangxulei
  Date: 2017/7/5
  Time: 下午7:02
  To change this template use File | Settings | File Templates.
--%>
<<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<%--<c:if test="${sessionScope.uname!=null}">--%>
    <head>
        <title>巡查員管理</title>
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
        function options() {
            return "<a href='javascript:saveRole()'><button class='btn btn-success' >修改</button></a>";
        }

        function findUname() {
            $("#datagrid").datagrid("reload", {
                "uname" : $("#uname").val()
            });

        }

        function saveRole(){
            var row = $("#datagrid").datagrid("getSelected");
            var rol;
            if(row.role=="巡查员")
                rol="管理员";
            else
                rol="巡查员";
            $.ajax({
                url:"saveRole",
                data:{
                    "uname":row.uname,
                    "role":rol
                },
                type:'post',
                cache:false,
                success:function(result){
                    if(result=="success"){
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
    </script>
    </script>
    <body>
    <c:if test="${sessionScope.role eq '管理员' }">

        <table width="100%" align="center"  frame="hsides" cellspacing="1" >

            <tr>
                <td align="center" >
                    <br>
                    <div >
                        <fieldset>
                            管理员姓名<input id="uname" type="text" name="uname" class="easyui-textbox" />
                            <a href="javascript:findUname()"class="easyui-linkbutton" data-options="iconCls:'icon-search'">搜索</a>
                        </fieldset>

                    </div>
                    <br>
                    <table id="datagrid" class="easyui-datagrid"
                           width="100%"
                           data-options=" url:'findLogin'
				,method:'post',pagination:true,rownumbers:true,striped:true,singleSelect:true,sortOrder:'desc',showHeader:true">

                        <thead>
                        <th data-options="field:'uname',width:'45%',align:'center'">巡查员</th>
                        <th data-options="field:'role',width:'45%',align:'center'">权限</th>
                        <th data-options="field:'',width:'10%',formatter:options"></th>

                        </thead>
                    </table>
            </tr>
        </table>

    </c:if>
    <c:if test="${sessionScope.role eq '巡查员' }">
        <h1>抱歉，您无权进行此项操作</h1>
    </c:if>
    </body>

<%--</c:if>--%>
<%--<c:if test="${sessionScope.uname==null}">--%>
    <%--非法访问，请联系管理员--%>
<%--</c:if>--%>
</html>


