<%--
  Created by IntelliJ IDEA.
  User: yangxulei
  Date: 2017/7/5
  Time: 下午6:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>

<html>
<c:if test="${sessionScope.uname!=null}">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <link rel="stylesheet" type="text/css" href="css/layout_220082c.css" />

        <link rel="stylesheet" href="kindeditor/themes/default/default.css" />
        <script type="text/javascript" src="kindeditor/kindeditor-all-min.js"></script>
        <script type="text/javascript" src="kindeditor/lang/zh-CN.js"></script>
        <link rel="stylesheet" href="easyui/themes/metro/easyui.css" />
        <link rel="stylesheet" href="easyui/themes/icon.css" />
        <script type="text/javascript" src="easyui/jquery.min.js"></script>
        <script type="text/javascript" src="easyui/jquery.easyui.min.js"></script>
        <script type="text/javascript" src="easyui/locale/easyui-lang-zh_CN.js"></script>
        <script type="text/javascript">
            var runame;
            var editor;
            KindEditor.ready(function(K) {
                editor = K.create("textarea[name='resume']", {
                    resizeType : 1,
                    allowPreviewEmoticons : false,
                    allowImageUpload : false,
                    items : [ 'fontname', 'fontsize', '|', 'forecolor', 'hilitecolor',
                        'bold', 'italic', 'underline', 'removeformat', '|',
                        'justifyleft', 'justifycenter', 'justifyright',
                        'insertorderedlist', 'insertunorderedlist', '|',
                        'emoticons', 'image', 'link' ],
                    allowFileManager : true,
                    afterCreate : function() {
                        this.sync();
                    },
                    afterBlur : function() {
                        this.sync();
                    }
                });
            });

            function photoUpload() {
                $.messager.progress(); // 显示进度条
                $('#uploadform').form('submit', {
                    url : "photoUpload",
                    onSubmit : function() {
                        var isValid = $(this).form('validate');
                        if (!isValid) {
                            $.messager.show({
                                title : '消息提示',
                                msg : "请选择头像文件！",
                                timeout : 2000
                            });
                            $.messager.progress('close'); // 如果表单是无效的则隐藏进度条
                        }
                        return isValid; // 返回false终止表单提交
                    },
                    success : function(result) {
                        if (result == "photosuccess")

                        {$.messager.show({
                            title : '消息提示',
                            msg : '头像上传成功'
                        });
                            window.parent.location.reload();
                        }

                        if (result == "extnameerror")
                            $.messager.show({
                                title : '消息提示',
                                msg : '文件类型错误，请重新选择头像'
                            });
                        $.messager.progress('close'); // 如果提交成功则隐藏进度条
                    },
                    error : function() {
                        $.messager.alert("消息提示", "请求失败");
                        $.messager.progress('close');
                    }
                });
            }

            function saveUserInfo(){
                var olduname="<%=session.getAttribute("uname")%>";
                var sex;
                if(document.getElementById('usex1').checked){
                    sex="男";
                }else{
                    sex="女";}
                $.ajax({
                    url:'savaUserInfo',
                    data:{
                        "u_birthday":$("#birthday").datebox("getValue"),
                        "u_runame":runame,
                        "u_uname":"<%=session.getAttribute("uname")%>",
                        "u_newuname":$("#uname").textbox("getValue"),
                        "u_address":$("#address").textbox("getValue"),
                        "u_usex":sex,
                        "u_resume" : $("#resume").val()
                    },
                    type:'post',
                    cache:false,
                    success:function(result){
                        if(result=="success!"){

                            $.messager.show({
                                title : "消息提示",
                                msg : "修改成功",
                                showType : "show"
                            });

                        }
                        else{
                            $.messager.show({
                                title : "消息提示",
                                msg : "修改失败,用户名已存在",
                                showType : "show"
                            });
                        }

                    },
                    error:function(){
                        $.messager.show({
                            title : "消息提示",
                            msg : "修改失败",
                            showType : "show"
                        });
                    }
                });
            }
            function loadUserInfo() {
                $.ajax({
                    url : "findUserInfoToPersonCenter",
                    data : {
                        "uname" : '<%=session.getAttribute("uname")%>'
                    },
                    type : "post",
                    dataType : "json",
                    success : function(result) {
                        var row = eval(result);
                        $("#uname").textbox("setValue", row.uname);
                        if (row.usex == "男")
                            $("#usex1").attr("checked", "checked");
                        else
                            $("#usex2").attr("checked", "checked");

                        $("#birthday").datebox("setValue", row.birthday);
                        $("#address").textbox("setValue", row.address);
                        editor.html(row.resume);
                        $("#photo1").attr("src", row.photo);
                        runame=row.runame;
                        $("#runame").textbox("setValue", row.runame);
                        $("#td_runame").html(row.runame);
                        $("#td_usex").html(row.usex);
                        $("#td_birthday").html(row.birthday);
                        $("#td_address").html(row.address);
                        $("#td_resume").html(row.resume);
                    }
                });

            }
        </script>
        <meta name="viewport" content="width=device-width" />
        <title>个人中心</title>
        <link rel="stylesheet" type="text/css" href="css/home_2c89410.css" />
        <style type="text/css">
            /* 圆形样式 */
            #divcss {
                margin: 10px auto
            }

            #divcss img {
                border-radius: 50%
            }
        </style>
    </head>

    <body  onload="loadUserInfo()">



    <!-- customer -->
    <div class="ag-content-customer-wrap">
        <div class="ag-content-customer">
            <div class="ag-content-customer-ele">
                <div class="ag-content-customer-ele-shadow"></div>
                <span>查询个人信息</span> <img
                    src="images/ag-customer-tradition_ad3bf6f.png" data-hover="77"
                    data-normal="85" />
            </div>
            <div class="ag-content-customer-ele">
                <div class="ag-content-customer-ele-shadow"></div>
                <span>修改个人信息</span> <img src="images/ag-customer-taobao_a9d7af6.png"
                                         style="left:65px;" data-hover="57" data-normal="65" />
            </div>
            <div class="ag-content-customer-ele">
                <div class="ag-content-customer-ele-shadow"></div>
                <span>上传个人头像</span> <img src="images/ag-customer-small_35b8744.png"
                                         style="left:96px;" data-hover="88" data-normal="96" />
            </div>
            <div class="ag-content-customer-ele">
                <div class="ag-content-customer-ele-shadow"></div>
                <span>查看个人简介</span> <img src="images/ag-customer-brand_9ca1bac.png"
                                         style="left:83px;" data-hover="75" data-normal="83" />
            </div>

            <div class="ag-content-customer-ele-detail">
                <ul>
                    <li class="acced-li-1"></li>
                    <li class="acced-li-2"></li>
                    <li class="acced-li-3"></li>
                    <li class="acced-li-4"></li>
                </ul>
                <div class="ag-content-customer-ele-detail-display">
                    <div class="ag-content-customer-ele-detail-display-left">
                        <img src="images/ag-customer-tradition_ad3bf6f.png" />
                    </div>
                    <div class="ag-content-customer-ele-detail-display-right">
						<span>
							<table width="100%" style="text-align: left;font-size: 20px">

								<tr>
									<td width="50%">用户名：</td>
									<td width="50%"><%=session.getAttribute("uname")%></td>
								</tr>
								<tr>
									<td width="50%">真实姓名：</td>
									<td width="50%"><div id="td_runame"></div></td>
								</tr>
								<tr>
									<td width="50%">性别：</td>
									<td width="50%"><div id="td_usex"></div></td>
								</tr>
                                </tr>
                                <tr>
									<td width="50%">生日：</td>
									<td width="50%"><div id="td_birthday"></div></td>
								</tr>
								<tr>
									<td width="50%">家庭地址：</td>
									<td width="50%"><div id="td_address"></div></td>
								</tr>
							</table>
						</span>

                    </div>

                </div>
                <div class="ag-content-customer-ele-detail-display">
                    <div class="ag-content-customer-ele-detail-display-left">
                        <img src="images/ag-customer-taobao_a9d7af6.png" />
                    </div>
                    <div style=" width:600px; height:420px;position:relative;top:;right:-400px;">
                        <div style="margin-bottom:10px;" align="left">
                            <div style="color: #fff;">用户名:</div>
                            <input id="uname" class="easyui-textbox"
                                   style="width:200px;height:32px;">
                        </div>

                        <div style="margin-bottom:10px;color: #fff" align="left">
                            <div style="color: #fff;">性别：</div>
                            <input id="usex1" type="radio" name="usex" value="男"  />男
                            <input id="usex2" type="radio" name="usex" value="女" />女
                        </div>

                        <div style="margin-bottom:10px;" align="left">
                            <div style="color: #fff;">生日：</div>
                            <input id="birthday" type="text" class="easyui-datebox"
                                   style="width:200px;height: 32px;background-color: black;"
                                   required="required">
                        </div>

                        <div style="margin-bottom:10px;" align="left">
                            <div style="color: #fff;">家庭地址：</div>
                            <input id="address" type="text" class="easyui-textbox"
                                   style="width:200px;height: 32px">
                        </div>

                        <div style="margin-bottom:10px;" align="left">
                            <div style="color: #fff;">个人简介：</div>
                            <textarea id="resume" name="resume"
                                      style="width:250px;height:150px;visibility:hidden;"></textarea>
                        </div>

                        <div>
                            <center><a href="javascript:saveUserInfo()" class="easyui-linkbutton"
                                       style="width:60px;height:32px" data-options="iconCls:'icon-ok'">提交</a>
                            </center>
                        </div>
                    </div>

                </div>
                <div class="ag-content-customer-ele-detail-display">
                    <div class="ag-content-customer-ele-detail-display-left">
                        <img src="images/ag-customer-small_35b8744.png" />
                    </div>
                    <div class=""
                         style=" width:600px; height:420px;position:relative;top:100px;right:-500px;">
                        <div id="divcss">
                            <img id="photo1" border="1" alt="个人头像" src="img/tuzi.png"
                                 width="150px" height="150px" />
                        </div>
                        <br>
                        <form id="uploadform" class="easyui-form" action="#"
                              enctype="multipart/form-data" method="post">
                            <input class="easyui-filebox" id="photo"
                                   data-options="onChange:function(){
$('#photo1').attr('src',$('#photo').filebox('getValue'));
    },width:'150px',buttonText:'请选择头像',required:true,missingMessage:'请选择一个头像'"
                                   name="photo" /> <a href="javascript:photoUpload()"
                                                      class="easyui-linkbutton"  >上传</a>
                        </form>


                    </div>
                </div>

                <div class="ag-content-customer-ele-detail-display">
                    <div class="ag-content-customer-ele-detail-display-left">
                        <img src="images/ag-customer-brand_9ca1bac.png" />
                    </div>
                    <div class="ag-content-customer-ele-detail-display-right"style="color: #fff;">
                        <h2>个人简历:</h2>
                        <div id="td_resume" style="font-size: large;"></div>
                    </div>
                </div>

                <div class="ag-content-customer-ele-detail-return">
                    <span><</span>返回上页
                </div>
            </div>
        </div>
    </div>

    <script type="text/javascript">
        var ctrlBar = false;

        var float_timer = null;
        var float_max_X;
        var float_max_Y;
        var float_ctrl_X = true;
        var float_ctrl_Y = true;
        $(function() {
            float_max_X = $(window).width();
            float_max_Y = $(window).height();
        });

        function showVideoImage() {
            if ($('.vjs-poster').css('display') == 'none') {
                $('.vjs-poster').addClass('index').show();
            } else {
                setTimeout('showVideoImage()', 50);
            }
        }

        function startMove() {
            var obj = $('#floatAdv');
            var limit_X = float_max_X - obj.width();
            var limit_Y = float_max_Y - obj.height();
            float_timer = setInterval(function() {
                var _x = parseInt(obj.css('left'));
                var _y = parseInt(obj.css('top'));
                if (_x >= limit_X) {
                    float_ctrl_X = false;
                }
                if (_x <= 0) {
                    float_ctrl_X = true;
                }
                if (_y >= limit_Y) {
                    float_ctrl_Y = false;
                }
                if (_y <= 0) {
                    float_ctrl_Y = true;
                }
                if (float_ctrl_X) {
                    _x += 1;
                } else {
                    _x -= 1;
                }
                if (float_ctrl_Y) {
                    _y += 1;
                } else {
                    _y -= 1;
                }
                obj.css({
                    'left' : _x + 'px',
                    'top' : _y + 'px'
                });
            }, 10);
        }

        function endMove() {
            clearInterval(float_timer);
        }

        $(document)
            .ready(
                function() {
                    $('.ag-header ul li:eq(0)').addClass(
                        'current-page');
                    showVideoImage();

                    $('#floatAdv').mouseenter(function() {
                        endMove();
                    });
                    $('#floatAdv').mouseleave(function() {
                        startMove();
                    });
                    $('#floatAdv span').click(
                        function(e) {
                            endMove();
                            $('#floatAdv').attr('href',
                                'javascript:;').removeAttr(
                                'target').hide();
                        });

                    $(".ag-content-customer-ele")
                        .bind(
                            "mouseenter mouseleave",
                            function(e) {
                                var w = $(this).width();
                                var h = $(this).height();
                                var x = (e.pageX
                                    - this.offsetLeft - (w / 2))
                                    * (w > h ? (h / w)
                                        : 1);
                                var y = (e.pageY
                                    - this.offsetTop - (h / 2))
                                    * (h > w ? (w / h)
                                        : 1);
                                var direction = Math
                                        .round((((Math
                                                .atan2(y, x) * (180 / Math.PI)) + 180) / 90) + 3) % 4;
                                if (e.type == 'mouseenter') {
                                    // 0:up - 1:right - 2:down - 3:left
                                    if (direction == 0) {
                                        $(this)
                                            .find('div')
                                            .css(
                                                {
                                                    'top' : '-470px',
                                                    'left' : '0px'
                                                });
                                        $(this)
                                            .find('div')
                                            .animate(
                                                {
                                                    'top' : 0
                                                },
                                                {
                                                    queue : false,
                                                    duration : 300
                                                });
                                    } else if (direction == 2) {
                                        $(this)
                                            .find('div')
                                            .css(
                                                {
                                                    'top' : '470px',
                                                    'left' : '0px'
                                                });
                                        $(this)
                                            .find('div')
                                            .animate(
                                                {
                                                    'top' : 0
                                                },
                                                {
                                                    queue : false,
                                                    duration : 300
                                                });
                                    } else if (direction == 1) {
                                        $(this)
                                            .find('div')
                                            .css(
                                                {
                                                    'top' : '0px',
                                                    'left' : '167px'
                                                });
                                        $(this)
                                            .find('div')
                                            .animate(
                                                {
                                                    'left' : 0
                                                },
                                                {
                                                    queue : false,
                                                    duration : 300
                                                });
                                    } else if (direction == 3) {
                                        $(this)
                                            .find('div')
                                            .css(
                                                {
                                                    'top' : '0px',
                                                    'left' : '-167px'
                                                });
                                        $(this)
                                            .find('div')
                                            .animate(
                                                {
                                                    'left' : 0
                                                },
                                                {
                                                    queue : false,
                                                    duration : 300
                                                });
                                    }
                                    $(this).find('span')
                                        .css('color',
                                            '#fff');
                                    $(this)
                                        .find('img')
                                        .animate(
                                            {
                                                'left' : $(
                                                    this)
                                                    .find(
                                                        'img')
                                                    .attr(
                                                        'data-hover')
                                            },
                                            {
                                                queue : false,
                                                duration : 200
                                            });
                                } else {
                                    if (direction == 0) {
                                        $(this)
                                            .find('div')
                                            .animate(
                                                {
                                                    'top' : -470
                                                },
                                                {
                                                    queue : false,
                                                    duration : 300
                                                });
                                    } else if (direction == 2) {
                                        $(this)
                                            .find('div')
                                            .animate(
                                                {
                                                    'top' : 470
                                                },
                                                {
                                                    queue : false,
                                                    duration : 300
                                                });
                                    } else if (direction == 1) {
                                        $(this)
                                            .find('div')
                                            .animate(
                                                {
                                                    'left' : 167
                                                },
                                                {
                                                    queue : false,
                                                    duration : 300
                                                });
                                    } else if (direction == 3) {
                                        $(this)
                                            .find('div')
                                            .animate(
                                                {
                                                    'left' : -167
                                                },
                                                {
                                                    queue : false,
                                                    duration : 300
                                                });
                                    }
                                    $(this)
                                        .find('span')
                                        .css('color',
                                            '#262626');
                                    $(this)
                                        .find('img')
                                        .animate(
                                            {
                                                'left' : $(
                                                    this)
                                                    .find(
                                                        'img')
                                                    .attr(
                                                        'data-normal')
                                            },
                                            {
                                                queue : false,
                                                duration : 200
                                            });
                                }
                            });

                    $(".ag-content-customer-ele")
                        .bind(
                            'click',
                            function(e) {

                                var navIndex = $(e.target)
                                    .parent().index();
                                $(
                                    '.ag-content-customer-ele-detail ul li')
                                    .removeClass(
                                        'current');
                                $(
                                    '.ag-content-customer-ele-detail ul li')
                                    .eq(navIndex)
                                    .addClass('current');

                                $(
                                    '.ag-content-customer-wrap')
                                    .css(
                                        'background-color',
                                        '#469acb');
                                $(
                                    '.ag-content-customer-ele')
                                    .animate({
                                        'width' : 0
                                    }, 500);

                                $(
                                    '.ag-content-customer-ele-detail')
                                    .animate(
                                        {
                                            'width' : 1002
                                        },
                                        {
                                            duration : 500,
                                            complete : function() {
                                                $(
                                                    '.ag-content-customer-ele-detail ul li')
                                                    .eq(
                                                        navIndex)
                                                    .click();
                                            }
                                        });
                            });

                    $('.ag-content-customer-ele-detail-return')
                        .bind(
                            'click',
                            function(e) {

                                $(
                                    '.ag-content-customer-wrap')
                                    .css(
                                        'background-color',
                                        '#f1f1f1');
                                $(
                                    '.ag-content-customer-ele-detail')
                                    .css('overflow',
                                        'hidden');
                                $(
                                    '.ag-content-customer-ele')
                                    .animate({
                                        'width' : 167
                                    }, 500);
                                $(
                                    '.ag-content-customer-ele-detail')
                                    .animate({
                                        'width' : 0
                                    }, 500);
                                $(
                                    '.ag-content-customer-ele-detail-display')
                                    .hide();
                            });

                    $('.ag-content-customer-ele-detail ul li')
                        .bind(
                            'click',
                            function() {

                                $(
                                    '.ag-content-customer-ele-detail ul li')
                                    .removeClass(
                                        'current');
                                $(this).addClass('current');
                                $(
                                    '.ag-content-customer-ele-detail')
                                    .css('overflow',
                                        'visible');

                                var disIndex = $(this)
                                    .index();
                                $(
                                    '.ag-content-customer-ele-detail-display')
                                    .hide();
                                $(
                                    '.ag-content-customer-ele-detail-display')
                                    .eq(disIndex)
                                    .show();

                                // IE
                                if ("ActiveXObject" in window) {
                                    $(
                                        '.ag-content-customer-ele-detail-display-left')
                                        .css(
                                            {
                                                'left' : '0px',
                                                'opacity' : '1'
                                            });
                                    $(
                                        '.ag-content-customer-ele-detail-display-right')
                                        .css(
                                            {
                                                'right' : '-120px',
                                                'opacity' : '1'
                                            });
                                    $(
                                        '.ag-content-customer-ele-detail-display-left')
                                        .eq(disIndex)
                                        .animate(
                                            {
                                                'left' : 120
                                            },
                                            {
                                                duration : 1000,
                                                easing : 'easeOutQuint'
                                            });
                                    $(
                                        '.ag-content-customer-ele-detail-display-right')
                                        .eq(disIndex)
                                        .animate(
                                            {
                                                'right' : 0
                                            },
                                            {
                                                duration : 1000,
                                                easing : 'easeOutQuint'
                                            });
                                }
                            });

                    $('body').on(
                        'click',
                        '.vjs-big-play-button',
                        function() {
                            $(this).hide();
                            ctrlBar = true;
                            $('.vjs-control-bar').removeClass(
                                'vjs-fade-out').addClass(
                                'vjs-fade-in');
                        });

                    $('.ag-content-app-wytgg-right')
                        .click(
                            function() {
                                if (!$('#ag-app-video')
                                        .hasClass(
                                            'vjs-playing')) {
                                    $(
                                        '.vjs-big-play-button')
                                        .css('display',
                                            'none');
                                    ctrlBar = true;
                                    $('.vjs-control-bar')
                                        .removeClass(
                                            'vjs-fade-out')
                                        .addClass(
                                            'vjs-fade-in');
                                }
                            });

                    // IE7
                    if (window.navigator.userAgent
                            .indexOf('MSIE 7.0') >= 0) {
                        $('#ag-app-video').css({
                            'width' : '570px',
                            'height' : '380px',
                            'position' : 'relative'
                        });
                        $('#ag-app-video').find('div.vjs-poster')
                            .css({
                                'width' : '570px',
                                'height' : '380px',
                                'position' : 'absolute',
                                'top' : '0px'
                            });
                        $('.vjs-big-play-button').css({
                            'width' : '100px',
                            'height' : '100px',
                            'position' : 'absolute',
                            'top' : '140px',
                            'left' : '235px'
                        });
                        $('.ag-content-app-wytgg-right').css(
                            'overflow', 'hidden');
                    } else {
                        $('.ag-content-app-wytgg-right')
                            .hover(
                                function() {
                                    if (ctrlBar) {
                                        $(
                                            '.vjs-control-bar')
                                            .removeClass(
                                                'vjs-fade-out')
                                            .addClass(
                                                'vjs-fade-in');
                                    }
                                },
                                function() {
                                    $('.vjs-control-bar')
                                        .removeClass(
                                            'vjs-fade-in')
                                        .addClass(
                                            'vjs-fade-out');
                                });
                    }
                });
    </script>

    </div>

    </body>
<%--</c:if>--%>
<%--<c:if test="${sessionScope.uname==null}">--%>
    <%--非法访问，请先联系管理员--%>
<%--</c:if>--%>
</html>