<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="ctx" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>梦境网</title>
    <link href="${ctx}/css/bootstrap/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="${ctx}/css/bootstrap/css/bootstrap-theme.min.css" rel="stylesheet"/>

    <link href="${ctx}/css/zui/css/zui.min.css" rel="stylesheet"/>
    <link href="${ctx}/css/zui/css/zui-theme.min.css" rel="stylesheet"/>

    <link rel="stylesheet" href="${ctx}/css/reply/css/style.css">
    <link rel="stylesheet" href="${ctx}/css/reply/css/comment.css">

    <style>
        body, html {
            background-color: #EBEBEB;
            padding: 0;
            margin: 0;
            height: 100%;
        }

        .stats-buttons a {
            text-decoration: none;
        }

        .commentAll a {
            text-decoration: none;
        }

        .comment-show a {
            text-decoration: none;
        }

        a {
            color: inherit;
            outline: 0;
        }

        a:-webkit-any-link {
            cursor: pointer;

        }

        .container {
            min-height: 100%;
            position: relative;

        }

        #content {
            min-height: 100%;
            position: relative;
        }

        .col-md-9 {
            padding-bottom: 80px;
        }

        .content-text {
            padding: 20px;

        }

        .single-share {
            float: right;
        }

        .stats-buttons {
            float: left;
        }

        .foot-nav-col li {
            list-style: none;
            margin-left: 100px;
        }

        .foot-nav-col h3 {
            margin-left: 120px;
        }

        .foot-nav-col a {
            text-decoration: none;
            color: grey;

        }

        .foot-nav-col a:link, a:visited {
            color: grey;
        }

        .foot-nav-col a:hover, a:active {
            color: #6318ff;
        }

        .foot-nav-col {
            margin-top: 20px;
            float: left;
        }

        .author img {
            width: 35px;
            height: 35px;
            border-radius: 35px;
            padding: 0;
            margin-right: 10px;
        }

        fieldset, img {
            border: 0;
        }

        .author a, .author span {
            float: left;
            font-size: 14px;
            font-weight: 700;
            line-height: 35px;
            color: #9b8878;
            text-decoration: none;
        }

        .author-h2 {
            display: block;
            font-size: 1.5em;
            -webkit-margin-before: 0.83em;
            -webkit-margin-after: 0.83em;
            -webkit-margin-start: 0px;
            -webkit-margin-end: 0px;
            font-weight: bold;
            font-size: 100%;
            font-weight: 400;
        }

        .commentAll {
            margin-left: 5px;
        }

    </style>
</head>
<body>
<div class="container">
    <div>
        <h1>Dreamland-梦境网</h1>
    </div>
    <div style="position: absolute;margin-left: 980px;margin-top: -40px;">
        <c:if test="${empty user}">
            <a name="tj_login" class="lb" href="login?error=login" style="color: black">[登录]</a>
            &nbsp;&nbsp;
            <a name="tj_login" class="lb" href="register.jsp" style="color: black">[注册]</a>
        </c:if>
        <c:if test="${not empty user}">
            <a name="tj_loginp" href="javascript:void(0);" class="lb" onclick="personal('${user.id}');"
               style="color: black"><font color="#9370db">${user.nickName}, 欢迎您！</font></a>
            &nbsp;&nbsp;
            <a name="tj_login" class="lb" href="${ctx}/loginout" style="color: black">[退出]</a>
        </c:if>

    </div>


    <nav class="navbar navbar-inverse">
        <!-- Brand and toggle get grouped for better mobile display -->
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar-menu"
                    aria-expanded="false">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="javascript:void(0);">首页</a>
        </div>
        <div id="navbar-menu" class="collapse navbar-collapse">
            <ul class="nav navbar-nav">
                <li class="active"><a href="#">最新梦</a></li>
                <li><a href="#">最热梦</a></li>
                <li><a href="#">梦诗词</a></li>
                <li><a href="#">梦问答</a></li>
                <li><a href="#">我的梦</a></li>
                <li><a href="${ctx}/list?id=${user.id}">个人空间</a></li>
            </ul>
        </div>

        <form class="navbar-form navbar-right" role="search" style="margin-top: -35px;margin-right: 10px">
            <div class="form-group">
                <input type="text" class="form-control" placeholder="Search">
            </div>
            <!--<button type="submit" class="btn btn-default">Submit</button>-->
            &nbsp; &nbsp;<i class="icon icon-search" style="color: white"></i>
        </form>

    </nav>

    <div id="content" class="row-fluid">
        <div class="col-md-9" style="background-color: white;">
            <div id="content_col" class="content-main">

                <c:forEach var="cont" items="${page.result}" varStatus="i">
                    <!-- 正文开始 -->

                    <div class="content-text">

                        <div class="author clearfix">
                            <div>
                                <a href="#" target="_blank" rel="nofollow" style="height: 35px">
                                     <img src="${cont.imgUrl}">
                                </a>
                            </div>
                            <a href="#" target="_blank">
                                <h2 class="author-h2">
                                        ${cont.nickName}
                                </h2>
                            </a>
                        </div>

                        <h2>${cont.title}</h2>
                            ${cont.content}
                        <div style="height: 5px"></div>
                        <div class="stats">
                            <!-- 笑脸、评论数等 -->
                            <span class="stats-vote"><i id="${cont.id}" class="number">${cont.upvote}</i> 赞</span>
                            <span class="stats-comments">
                    <span class="dash"> · </span>
                         <a onclick="reply(${cont.id},${cont.uId});">
                              <i class="number" id="comment_num_${cont.id}">${cont.commentNum}</i> 评论
                          </a>
                    </span>
                        </div>
                        <div style="height: 5px"></div>
                        <div class="stats-buttons bar clearfix">
                                <%--点赞--%>
                            <a style="cursor: pointer;" onclick="upvote_click(${cont.id},1);">
                                <i class="icon icon-thumbs-o-up icon-2x"></i>
                                <span class="number hidden" id="up_${cont.id}">${cont.upvote}</span>
                            </a>
                            &nbsp;
                                <%--踩--%>
                            <a style="cursor: pointer;" onclick="upvote_click(${cont.id},-1);">
                                <i class="icon icon-thumbs-o-down icon-2x"></i>
                                <span class="number hidden" id="down_${cont.id}">${cont.downvote}</span>
                            </a>
                            &nbsp;
                            <a style="cursor: pointer;" onclick="reply(${cont.id},${cont.uId});" title="点击打开或关闭">
                                <i class="icon icon-comment-alt icon-2x"></i>
                            </a>
                        </div>
                        <div class="single-share">
                            <a class="share-wechat" data-type="wechat" title="分享到微信" rel="nofollow"
                               style="margin-left:18px;color: grey;cursor: pointer; text-decoration:none;">
                                <i class="icon icon-wechat icon-2x"></i>
                            </a>
                            <a class="share-qq" data-type="qq" title="分享到QQ" rel="nofollow"
                               style="margin-left:18px;color: grey;cursor: pointer; text-decoration:none;">
                                <i class="icon icon-qq icon-2x"></i>
                            </a>
                            <a class="share-weibo" data-type="weibo" title="分享到微博" rel="nofollow"
                               style="margin-left:18px;color: grey;cursor: pointer; text-decoration:none;">
                                <i class="icon icon-weibo icon-2x"></i>
                            </a>
                        </div>
                        <br/>
                        &nbsp;
                        <div class="commentAll" style="display:none" id="comment_reply_${cont.id}">
                            <!--评论区域 begin-->
                            <div class="reviewArea clearfix">
                                <textarea class="content comment-input" placeholder="Please enter a comment&hellip;"
                                          onkeyup="keyUP(this)"></textarea>
                                <a class="plBtn" id="comment_${cont.id}"
                                   onclick="_comment(${cont.id},${user.id==null?0:user.id},${cont.uId})"
                                   style="color: white;cursor: pointer;">评论</a>
                            </div>
                            <!--评论区域 end-->
                            <!--添加评论内容的空div-->
                            <div class="comment-show-first" id="comment-show-${cont.id}">

                            </div>

                        </div>

                        <div class="single-clear">

                        </div>
                    </div>
                    <!-- 正文结束 -->
                    <div style="position: absolute;width:900px;background-color: #EBEBEB;height: 10px;left: 0px">
                    </div>
                </c:forEach>

            </div>


            <div id="page-info"
                 style="position: absolute;width:900px;background-color: #EBEBEB;height: 80px;left: 0px;">
                <ul class="pager pager-loose">
                    <c:if test="${page.pageNum <= 1}">
                        <li><a href="javascript:void(0);">« 上一页</a></li>
                    </c:if>
                    <c:if test="${page.pageNum > 1}">
                        <li class="previous"><a href="${ctx}/index_list?pageNum=${page.pageNum-1}&&id=${user.id}">«
                            上一页</a></li>
                    </c:if>
                    <c:forEach begin="1" end="${page.pages}" var="pn">
                        <c:if test="${page.pageNum==pn}">
                            <li class="active"><a href="javascript:void(0);">${pn}</a></li>
                        </c:if>
                        <c:if test="${page.pageNum!=pn}">
                            <li><a href="${ctx}/index_list?pageNum=${pn}&&id=${user.id}">${pn}</a></li>
                        </c:if>
                    </c:forEach>

                    <c:if test="${page.pageNum>=page.pages}">
                        <li><a href="javascript:void(0);">下一页 »</a></li>
                    </c:if>
                    <c:if test="${page.pageNum<page.pages}">
                        <li><a href="${ctx}/index_list?pageNum=${page.pageNum+1}&&id=${user.id}">下一页 »</a></li>
                    </c:if>

                </ul>
            </div>


            <div class="foot" style="position: absolute;left: 0px;float: left;margin-top: 60px;">
                <div class="foot-nav clearfix">
                    <div class="foot-nav-col">
                        <h3>
                            关于
                        </h3>
                        <ul>
                            <li>
                                <a href="#" target="_blank" rel="nofollow">
                                    关于梦境
                                </a>
                            </li>
                            <li>
                                <a href="#" target="_blank" rel="nofollow">
                                    加入我们
                                </a>
                            </li>
                            <li>
                                <a href="#" target="_blank" rel="nofollow">
                                    联系方式
                                </a>
                            </li>
                        </ul>
                    </div>
                    <div class="foot-nav-col">
                        <h3>
                            帮助
                        </h3>
                        <ul>
                            <li>
                                <a href="#" target="_blank" rel="nofollow">
                                    在线反馈
                                </a>
                            </li>
                            <li>
                                <a href="#" target="_blank" rel="nofollow">
                                    用户协议
                                </a>
                            </li>
                            <li>
                                <a href="#" target="_blank" rel="nofollow">
                                    隐私政策
                                </a>
                            </li>
                        </ul>
                    </div>
                    <div class="foot-nav-col">
                        <h3>
                            下载
                        </h3>
                        <ul>
                            <li>
                                <a href="#"
                                   target="_blank" rel="external nofollow">
                                    Android 客户端
                                </a>
                            </li>
                            <li>
                                <a href="#" target="_blank" rel="external nofollow">
                                    iPhone 客户端
                                </a>
                            </li>
                        </ul>
                    </div>
                    <div class="foot-nav-col">
                        <h3>
                            关注
                        </h3>
                        <ul>
                            <li>
                                <a href="http://www.dreamland.wang" onMouseOut="hideImg()" onmouseover="showImg()">
                                    微信
                                    <div id="wxImg"
                                         style="display:none;height:50px;back-ground:#f00;position:absolute;">
                                        <img src="images/dreamland.png"/><br/>
                                        手机扫描二维码关注
                                    </div>
                                    <!-- <div class="foot-wechat-tips">
                                        &lt;!&ndash; <span class="foot-wechat-icon"></span>&ndash;&gt;
                                         <span class=" icon icon-wechat icon-2x"></span>
                                         手机扫描二维码关注
                                     </div>-->
                                </a>
                            </li>
                            <li>
                                <a href="#" target="_blank" rel="external nofollow">
                                    新浪微博
                                </a>
                            </li>
                            <li>
                                <a href="#" target="_blank" rel="external nofollow">
                                    QQ空间
                                </a>
                            </li>
                        </ul>
                    </div>
                </div>
                <!-- rgba(60,63,65,0.31)-->
                <hr style="position: absolute;background-color: rgba(161,171,175,0.31);width: 1000px;height: 1px;left: 0px"/>
                <hr style="position: absolute;background-color: rgba(161,171,175,0.31);width: 1000px;height: 1px;left: 0px"/>
                <div class="foot-nav clearfix" style="position: absolute;left: 0px;margin-top: 40px;text-align: center">
                    <div class="foot-copyrights" style="margin-left: 200px">
                        <p>
                            互联网ICP备案：京ICP备xxxxxx号-1
                        </p>
                        <p>
                            <span>违法和不良信息举报电话：010-xxxxxxx</span>
                            <span>邮箱：xxx@dreamland.wang</span>
                        </p>
                        <p style="margin-top: 8px">&copy;www.dreamland.wang 梦境网版权所有</p>
                    </div>
                </div>
            </div>
            <!--col-md-9结束 -->
        </div>


        <div class="col-md-3" style="position:absolute;top:0px;left: 880px;width: 268px;">
            <div style="background-color: white;width: 250px;height: 440px">
                <iframe name="weather_inc" src="http://i.tianqi.com/index.php?c=code&id=82" width="250" height="440"
                        frameborder="0" marginwidth="0" marginheight="0" scrolling="no"></iframe>
            </div>
        </div>


    </div>


</div>
<script type="text/javascript" src="${ctx}/js/jquery-3.2.1.min.js"></script>
<script type="text/javascript" src="${ctx}/css/bootstrap/js/bootstrap.min.js"></script>

<script type="text/javascript" src="${ctx}/css/zui/js/zui.min.js"></script>


<script type="text/javascript" src="${ctx}/css/reply/js/jquery.flexText.js"></script>

</body>
<script language=javascript>
    function showImg() {
        document.getElementById("wxImg").style.display = 'block';
    }

    function hideImg() {
        document.getElementById("wxImg").style.display = 'none';
    }

    function personal(uId) {
        this.location = "${ctx}/list?id=" + uId;
    }


    //点赞，踩
    function upvote_click(id, cont) {
        $.ajax({
            type: 'post',
            url: '/upvote',
            date: {"id": id, "uid": '${user.id}', "upvote": cont},
            dataType: 'json',
            success: function (data) {
                var up = data["data"];
                //alter(up);
                if (up == "success") {
                    if (cont == -1) {
                        var down = document.getElementById("down_" + id);
                        var num = down.innerHTML;
                        var value = parseInt(num) + cont;
                        down.innerHTML = value;
                    } else {
                        var num = document.getElementById(id).innerHTML;
                        var value = parseInt(num) + cont;
                        document.getElementById(id).innerHTML = value;
                        document.getElementById("up_" + id).innerHTML = value;
                    }
                } else if (up == "done") {
                    alert("已点赞！")

                } else if (up == "down") {
                    alert("已踩！")
                } else {
                    window.location.href = "/login.jsp";
                }
            }


        });
    }


    //日期格式化
    function FormatDate(strTime) {
        var date = new Date(strTime);
        var hours = date.getHours();
        var min = date.getMinutes();
        if (min < 10) min = "0" + min;
        var second = date.getSeconds();
        if (second < 10) second = "0" + second;
        return date.getFullYear() + "-" + date.getMonth() + "-" + date.getDay() + "-" + hours + "-" + min + "-" + second;
    }

    //点击评论或回复图标
    function reply(id, uid) {

        $("div").remove("#comment_reply_" + id + " .comment-show");
        $("div").remove("#comment_reply_" + id + " .comment-show-con");
        if (showdiv_display = document.getElementById('comment_reply_' + id).style.display == 'none') {

            document.getElementById('comment_reply_' + id).style.display = 'block';
            $.ajax({
                type: 'post',
                url: '/reply',
                data: {"content_id": id},
                dataType: 'json',
                success: function (data) {
                    var list = data["list"];
                    var okHtml;
                    if (list != null && list != "") {
                        $(list).each(function () {
                            var chtml = "<div class = 'comment-show'>" +
                                "<div class='comment-show-con clearfix'>" +
                                "<div class='comment-show-con-img pull-left'><img src=" + this.user.imgUrl + "' alt = ''></div>" +
                                "<div class = 'comment-show-con-list pull-left clearfix'>" +
                                "<div class='pl-text clearfix'>" +
                                "<a class='comment-size-name'>" + this.user.nickName + " :</a>" +
                                "<span class = 'my-pl-con'>$nbsp;" + this.comContent + "</span>" +
                                "</div> <div class='date-dz'><span class='date-dz-left pull-left comment-time'>" + FormatDate(this.commTime) + "</span>" +
                                "<div class='date-dz-right pull-right comment-pl-block'>" +
                                "<a onclick='deleteComment(" + id + "," + uid + "," + this.id + ", null)' id='comment_dl_" + this.id + "' style='cursor: pointer' class='removeBlock'>删除</a>" +
                                "<a style='cursor: pointer' onclick='comment_hf_(" + id + "," + this.id + "," + null + "," + this.user.id + "," + uid + ")' id='comment_hf_" + this.id + "' class='date-dz-pl pl-hf hf-con-block pull-left'>回复</a>" +
                                "<span class='pull-left date-dz-line'>|</span>" +
                                "<a onclick='reply_up(" + this.id + ")' style='cursor: pointer' class='date-dz-z pull-left' id='change_color_" + this.id + "'><i class='date-dz-z-click-red'></i>赞 (<i class='z-num' id='comment_upvote_" + this.id + "'>" + this.upvote + "</i>)</a>" +
                                "</div> </div> <div class='hf-list-con' id='hf-list-con-" + this.id + "'>";

                            var ehtml = "</div> </div> </div></div>";
                            var parentComm_id = this.id;

                            okHtml = chtml;
                            //alter(this.children)
                            if (this.children != null && this.children != '') {
                                var commentList = this.comList;
                                $(commentList).each(function () {
                                    // alert(this.id);
                                    var oHtml = "<div class='all-pl-con'><div class='pl-text hfpl-text clearfix'>" +
                                        "<a class='comment-size-name'>" + this.user.nickName + "<a class='atName'>@" + this.byUser.nickName + " :</a> </a>" +
                                        "<span class='my-pl-con'>" + this.comContent + "</span>" +
                                        "</div><div class='date-dz'> <span class='date-dz-left pull-left comment-time'>" + FormatDate(this.commTime) + "</span>" +
                                        "<div class='date-dz-right pull-right comment-pl-block'>" +
                                        "<a style='cursor:pointer' onclick='deleteComment(" + id + "," + uid + "," + this.id + "," + parentComm_id + ")' id='comment_dl_" + this.id + "' class='removeBlock'>删除</a>" +
                                        "<a onclick='comment_hf(" + id + "," + this.id + "," + parentComm_id + "," + this.user.id + "," + uid + ")' id='comment_hf_" + this.id + "' style='cursor:pointer' class='date-dz-pl pl-hf hf-con-block pull-left'>回复</a> <span class='pull-left date-dz-line'>|</span>" +
                                        "<a onclick='reply_up(" + this.id + ")' id='change_color_" + this.id + "' style='cursor:pointer' class='date-dz-z pull-left'><i class='date-dz-z-click-red'></i>赞 (<i class='z-num' id='comment_upvote_" + this.id + "'>" + this.upvote + "</i>)</a>" +
                                        "</div></div> </div>";

                                    okHtml = okHtml + oHtml;
                                });
                            }
                            okHtml = okHtml + ehtml;
                            $("#comment-show-" + id).append(okHtml);


                        });
                    }
                }
            });


        } else {
            document.getElementById('comment_reply_' + id).style.display = 'none';//show的display属性设置为none（隐藏）
        }


    }

    function keyUP(t) {
        var len = $(t).val().length;
        if (len > 139) {
            $(t).val($(t).val().substring(0, 140));
        }
    }


    //点击评论按钮
    function _comment(content_id, uid, cuid) {
        var myDate = new Date();
        //获取当前年
        var year = myDate.getFullYear();
        //获取当前月
        var month = myDate.getMonth() + 1;
        //获取当前日
        var date = myDate.getDate();
        var h = myDate.getHours();
        var m = myDate.getMinutes();
        if (m < 10) m = '0' + m;
        var s = myDate.getSeconds();
        if (s < 10) s = '0' + s;
        var now = year + '-' + month + "-" + date + " " + h + ':' + m + ":" + s;
        //获取输入内容
        var oSize = $("#comment_input_" + content_id).val();
        console.log(oSize);
        //动态创建评论模块
        if (oSize.replace(/(^\s*)|(\s*$)/g, "") != '') {

            $.ajax({
                type: 'post',
                url: '/comment',
                data: {"content_id": content_id, "uid": uid, "oSize": oSize, "comment_time": now}
                dataType: 'json',
                success: function (data) {
                    var comm_data = data["data"];
                    if (comm_data == "fail") {
                        window.location.href = "/login.jsp"
                    } else {
                        var id = comm_data.id;
                        oHtml = '\'<div class="comment-show-con clearfix"><div class="comment-show-con-img pull-left"><img src="${user.imgUrl}" alt=""></div> <div class="comment-show-con-list pull-left clearfix"><div class="pl-text clearfix"> <a  class="comment-size-name">${user.nickName} : </a> <span class="my-pl-con">&nbsp;\'+ oSize +\'</span> </div> <div class="date-dz"> <span class="date-dz-left pull-left comment-time">\'+now+\'</span> <div class="date-dz-right pull-right comment-pl-block"><a style="cursor:pointer"  onclick="deleteComment(\'+content_id+\',\'+cuid+\',\'+id+\',\'+null+\')" id="comment_dl_\'+id+\'"  class="removeBlock">删除</a> <a style="cursor:pointer" onclick="comment_hf(\'+content_id+\',\'+id+\',\'+null+\',\'+comm_data.user.id+\',\'+cuid+\')" id="comment_hf_\'+id+\'" class="date-dz-pl pl-hf hf-con-block pull-left">回复</a> <span class="pull-left date-dz-line">|</span> <a onclick="reply_up(\'+id+\')" id="change_color_\'+id+\'" style="cursor:pointer"  class="date-dz-z pull-left" ><i class="date-dz-z-click-red"></i>赞 (<i class="z-num" id="comment_upvote_\'+id+\'">0</i>)</a> </div> </div><div class="hf-list-con"></div></div> </div>\';'
                        $("#comment_" + content_id).parents('.reviewArea').siblings('.comment-show-first').prepend(oHtml);
                        $("#comment_" + content_id).siblings('.flex-text-wrap').find('.comment-input').prop('value', '').siblings('pre').find('span').text('');

                        $("#comment_input_" + content_id.val(''));

                        var num = document.getElementById("comment_num_" + content_id).innerHTML;
                        document.getElementById("comment_num_" + content_id).innerHTML = (parseInt(num) + 1) + "";

                    }
                }
            });


        }
    }

</script>


</html>