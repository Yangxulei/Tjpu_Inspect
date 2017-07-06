<%--
  Created by IntelliJ IDEA.
  User: yangxulei
  Date: 2017/7/5
  Time: 下午7:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<%--<c:if test="${sessionScope.uname!=null}">--%>
    <head>
        <title>巡查信息查询</title>
        <meta charset="UTF-8">
        <link rel="stylesheet" href="easyui/themes/metro/easyui.css" />
        <link rel="stylesheet" href="easyui/themes/icon.css" />
        <script type="text/javascript" src="easyui/jquery.min.js"></script>
        <script src="//cdn.bootcss.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
        <link rel="stylesheet" href="//cdn.bootcss.com/bootstrap/3.3.5/css/bootstrap.min.css">
        <script type="text/javascript" src="easyui/jquery.easyui.min.js"></script>
        <script type="text/javascript" src="easyui/locale/easyui-lang-zh_CN.js"></script>
    </head>


    <script type="text/javascript">
        function refreshDataGrid() {
            $("#datagrid").datagrid("reload");
        }
        function findXunchaRecordInfoBySearchdateOrZhouciOrTnameOrJieci() {
            $("#datagrid").datagrid("reload", {
                "searchdate" : $("#searchdate").datebox("getValue"),
                "zhouci" : $("#zhouci").combobox("getValue"),
                "tname" : $("#tname").combobox("getValue"),
                "jieci" : $("#jieci").combobox("getValue"),
                "xunchayuan" : $("#xunchayuan").val()
            });
        }

        function options() {
            return " <a href='javascript:deleteXunchaRecordInfo()'><Button class='btn btn-danger' >删除</button></a>";
        }
        function deleteXunchaRecordInfo() {
            var row = $("#datagrid").datagrid("getSelected");
            if (row != null) {
                $.messager.confirm('确认', '您确定要删除记录吗？', function(r) {
                    if (r) {
                        if('<%=session.getAttribute("uname")%>'==row.xunchayuan||'<%=session.getAttribute("role")%>'=="管理员" ){
                            $.ajax({
                                url : 'deleteXunchaRecordInfoByID',
                                type:'post',
                                data : {
                                    "tname" : row.tname,
                                    "jieci": row.jieci,
                                    "searchdate":row.searchdate,
                                    "subject":row.subject,
                                    "xunchayuan":row.xunchayuan
                                },
                                success : function(result) {
                                    if (result == "deleteSuccess") {
                                        $("#datagrid").datagrid("reload");
                                        $("#datagrid").datagrid("clearSelections");
                                        $.messager.show({
                                            title : "消息提示",
                                            msg : "删除成功!",
                                            showType : "show"
                                        });

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

                        else {
                            $.messager.show({
                                title: "消息提示",
                                msg : "只能删除自己记录的信息",
                                showType : "show"
                            });
                        }


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
    </script>

    <style>
        .datagrid-cell,.datagrid-cell-group,.datagrid-header-rownumber,.datagrid-cell-rownumber
        {
            -o-text-overflow: ellipsis;
            text-overflow: ellipsis;
        }
    </style>

    <body>
    <!-- <div id="saveXunchaRecord" class="easyui-panel "
        data-options="title:'巡查信息查询',fit:true"> -->
    <center><h4 style="font-family: Microsoft YaHei;">巡查信息查询</h4></center>
    <table id="datagrid" class="easyui-datagrid datagrid-cell datagrid-cell-group datagrid-header-rownumber datagrid-cell-rownumber"
           data-options="toolbar:'#btn',url:'findXunchaRecordInfo'
				,method:'post',pagination:true,rownumbers:true,striped:true, singleSelect:true,sortName:'searchdate',sortOrder:'desc',showHeader:true">
        <thead>
        <th data-options="field:'xunchayuan',width:'6%',align:'center'">记录人员</th>
        <th data-options="field:'searchdate',width:'7%',align:'center'">日期</th>
        <th data-options="field:'classname',width:'3%',align:'center'">班级</th>
        <th data-options="field:'fangjian',width:'3%',align:'center'">教室</th>
        <th data-options="field:'grade',width:'3%',align:'center'">年级</th>
        <th data-options="field:'xueqi',width:'5%',align:'center'">学期</th>
        <th data-options="field:'zhouci',width:'5%',align:'center'">周次</th>
        <th data-options="field:'jieci',width:'5%',align:'center'">节次</th>
        <th data-options="field:'subject',width:'5%',align:'center'">学科</th>
        <th data-options="field:'tname',width:'5%',align:'center'">教师</th>
        <th data-options="field:'ontime',width:'7%',align:'center'">老师准时进班</th>
        <th data-options="field:'tzhuangtai',width:'5%',align:'center'">教师状态</th>
        <th data-options="field:'classdiscipline',width:'5%',align:'center'">课堂纪律</th>
        <th data-options="field:'absence',width:'5%',align:'center'">缺勤人数</th>
        <th data-options="field:'late',width:'5%',align:'center'">迟到人数</th>
        <th data-options="field:'sleep',width:'5%',align:'center'">睡觉人数</th>
        <th data-options="field:'playphone',width:'6%',align:'center'">玩手机人数</th>
        <th data-options="field:'chat',width:'5%',align:'center'">闲聊人数</th>
        <th data-options="field:'',width:'10%',formatter:options,align:'center'"></th>

        </thead>
    </table>
    </div>
    <div id="btn">

        <fieldset>
            记录人员<input id="xunchayuan" type="text" name="searchdate" class="easyui-textbox" />
            日期<input id="searchdate" type="text" name="searchdate" class="easyui-datebox" />
            周次<select id="zhouci" class="easyui-combobox"
                      style="width:15%;">
            <option selected="selected"></option>
            <option>第一周</option>
            <option>第二周</option>
            <option>第三周</option>
            <option>第四周</option>
            <option>第五周</option>
            <option>第六周</option>
            <option>第七周</option>
            <option>第八周</option>
            <option>第九周</option>
            <option>第十周</option>
            <option>第十一周</option>
            <option>第十二周</option>
            <option>第十三周</option>
            <option>第十四周</option>
            <option>第十五周</option>
            <option>第十六周</option>
        </select>
            教师<select id="tname" class="easyui-combobox" name="dept"
                      style="width:15%;">
            <option selected="selected"></option>
            <option>张建军</option>
            <option>姜丽丽</option>
            <option>尹海欣</option>
            <option>韩教授</option>
        </select>
            节次<select id="jieci" class="easyui-combobox" name="dept"
                      style="width:15%;">
            <option selected="selected"></option>
            <option>第一节</option>
            <option>第二节</option>
            <option>第三节</option>
            <option>第四节</option>
            <option>第五节</option>
        </select>
            <a href="javascript:findXunchaRecordInfoBySearchdateOrZhouciOrTnameOrJieci()"
               class="easyui-linkbutton" data-options="iconCls:'icon-search'">查询</a>

        </fieldset>
    </div>
        <!-- </div> -->
    </body>
<%--</c:if>--%>
<%--<c:if test="${sessionScope.uname==null}">--%>
    <%--非法访问，请联系管理员--%>
<%--</c:if>--%>
</html>
