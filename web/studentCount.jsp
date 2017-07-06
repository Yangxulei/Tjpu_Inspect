<%--
  Created by IntelliJ IDEA.
  User: yangxulei
  Date: 2017/7/5
  Time: 下午6:57
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
            + request.getServerName() + ":" + request.getServerPort()
            + path + "/";
%>

<%--<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">--%>
<html>
<%--<c:if test="${sessionScope.uname!=null}">--%>
    <head>
        <base href="<%=basePath%>">

        <title>My JSP 'studentCount.jsp' starting page</title>

        <meta http-equiv="pragma" content="no-cache">
        <meta http-equiv="cache-control" content="no-cache">
        <meta http-equiv="expires" content="0">
        <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
        <meta http-equiv="description" content="This is my page">
        <!--
            <link rel="stylesheet" type="text/css" href="styles.css">
            -->
        <link rel="stylesheet" href="easyui/themes/bootstrap/easyui.css" />
        <link rel="stylesheet" href="easyui/themes/icon.css" />
        <link rel="stylesheet" href="css/managerfont.css" />
        <script src="//cdn.bootcss.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
        <link rel="stylesheet" href="//cdn.bootcss.com/bootstrap/3.3.5/css/bootstrap.min.css">
        <script type="text/javascript" src="easyui/jquery.min.js"></script>
        <script type="text/javascript" src="easyui/jquery.easyui.min.js"></script>
        <script type="text/javascript" src="easyui/locale/easyui-lang-zh_CN.js"></script>
        <script src="js/echarts.min.js"></script>
        <script type="text/javascript">

            function find() {
                var series=[];
                $.ajaxSettings.async = false;
                $.ajax({
                    url : "getCountNumber",
                    data : {
                        "grade" : $("#grade").combobox("getValue"),
                        "classname" : $("#classname").combobox("getValue"),
                        "xueqi" : $("#xueqi").combobox("getValue"),
                    },
                    type : "post",
                    dataType : "json",

                    success : function(result) {
                        var row = eval(result);
                        series.push(row.absence);
                        series.push(row.late);
                        series.push(row.sleep);
                        series.push(row.playphone);
                        series.push(row.chat);

                    },
                    error : function(r, e, i) {

                    }
                });

                var echart = echarts.init(document.getElementById("left"));
                var pie = echarts.init(document.getElementById("right"));
                var radio = echarts.init(document.getElementById("right2"));
                var option = {
                    title : {
                        text : '学生统计分析'
                    },
                    tooltip : {
                        trigger : 'axis'
                    },
                    legend : {
                        data : [ '人数' ]
                    },
                    toolbox : {
                        show : true,
                        feature : {
                            mark : {
                                show : true
                            },
                            dataView : {
                                show : true,
                                readOnly : false
                            },
                            magicType : {
                                show : true,
                                type : [ 'line', 'bar' ]
                            },
                            restore : {
                                show : true
                            },
                            saveAsImage : {
                                show : true
                            }
                        }
                    },
                    calculable : true,
                    xAxis : [ {
                        type : 'category',
                        data : [ '缺勤', '迟到', '睡觉', '玩手机', '闲聊' ]
                    } ],
                    yAxis : [ {
                        type : 'value',
                        splitArea : {
                            show : true
                        }
                    } ],
                    series : [ {
                        name : '人数',
                        type : 'bar',
                        data : series
                    } ]
                };

                // 使用刚指定的配置项和数据显示图表。

                echart.setOption(option);

                var option1 = {
                    title : {
                        text : '学生统计分析饼图',

                    },
                    tooltip : {
                        trigger : 'item',
                        formatter : "{a} <br/>{b} : {c} ({d}%)"
                    },
                    legend : {
                        x : 'center',
                        y : 'bottom',
                        data : [ '缺勤', '迟到', '睡觉', '玩手机', '闲聊' ]
                    },
                    toolbox : {
                        show : true,
                        feature : {
                            mark : {
                                show : true
                            },
                            dataView : {
                                show : true,
                                readOnly : false
                            },
                            magicType : {
                                show : true,
                                type : [ 'pie', 'funnel' ]
                            },
                            restore : {
                                show : true
                            },
                            saveAsImage : {
                                show : true
                            }
                        }
                    },
                    calculable : true,
                    series : [ {
                        name : '面积模式',
                        type : 'pie',
                        radius : [ 30, 110 ],

                        roseType : 'area',
                        data : [ {
                            value :series[0],
                            name : '缺勤'
                        }, {
                            value :series[1],
                            name : '迟到'
                        }, {
                            value :series[2],
                            name : '睡觉'
                        }, {
                            value :series[3],
                            name : '玩手机'
                        }, {
                            value :series[4],
                            name : '闲聊'
                        } ]
                    } ]
                }
                pie.setOption(option1);

                var option2 = {
                    title : {
                        text : '学生统计分析雷达图',

                    },
                    tooltip : {},
                    legend : {
                        data : [ '人数' ],
                        x : 'right'
                    },
                    radar : {
                        // shape: 'circle',
                        indicator : [ {
                            name : '缺勤',
                            max : 30
                        }, {
                            name : '迟到',
                            max : 30
                        }, {
                            name : '睡觉',
                            max : 30
                        }, {
                            name : '玩手机',
                            max : 30
                        }, {
                            name : '闲聊',
                            max : 30
                        } ],

                    },
                    series : [ {
                        name : '人数',
                        type : 'radar',
                        // areaStyle: {normal: {}},
                        data : [ {
                            value :series,
                            name : '人数'
                        } ]
                    } ]
                };
                radio.setOption(option2);
            }
        </script>
    </head>


    <body onload="find()">
    <!-- 为ECharts准备一个具备大小（宽高）的Dom -->
    <center><h4 style="font-family:Microsoft YaHei; ">学生统计分析</h4></center>
    <div style="overflow: hidden;width: 100%">
        <table id="addUser" width="100%" style="border:1px  #000000;width: 100%;margin-left: 10px">
            <thead>
            <th width="15%">年级</th>
            <th width="15%">班级</th>
            <th width="15%">学期</th>

            </thead>

            <td><select id="grade" class="easyui-combobox" name="dept"
                        style="width:100%;">
                <option>大一</option>
                <option>大二</option>
                <option>大三</option>
                <option>大四</option>
            </select></td>
            <td><select id="classname" class="easyui-combobox" name="dept"
                        style="width:100%;">
                <option>一班</option>
                <option>二班</option>
                <option>三班</option>
                <option>四班</option>
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
            </select></td>
            <td><select id="xueqi" class="easyui-combobox" name="dept"
                        style="width:100%;">
                <option >第一学期</option>
                <option>第二学期</option>
            </select></td>
            <thead><th width="15%">&nbsp;</th></thead>
            <thead>
        </table>
        <center><Button class="btn btn-primary" onclick="javascript:find()">搜索</button></center>
        <br>
        <table style="width: 95%">
            <tr>
                <td rowspan="2" width="50%"><div id="left"
                                                 style="width: 100%;height:500px;"></div></td>
                <td width="50%"><div id="right"
                                     style="width: 100%;height: 250px;"></div></td>
            <tr><td width="50%"><div id="right2"
                                     style="width: 100%;height: 250px;"></div></td></tr>
            </tr>
        </table>
    </div>
    </body>
<%--</c:if>--%>

<%--<c:if test="${sessionScope.uname==null}">--%>
    <%--非法访问，请先联系管理员--%>
<%--</c:if>--%>
</html>
