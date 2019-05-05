<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="ctx" value="${pageContext.request.contextPath }"/>
<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>注册页面</title>
    <meta name="keywords" content="梦境网">
    <meta name="content" content="梦境网">
    <meta name="viewport"
          content="width=device-width,initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge, chrome=1">
    <link type="text/css" rel="stylesheet" href="${ctx}/css/dreamland.css">
    <script type="text/javascript" src="${ctx}/js/jquery.min.js"></script>
</head>

<body class="login_bj" style="background-color: grey">

<div class="zhuce_body">
    <div class="zhuce_kong" id="dre_div">
        <div class="zc">
            <div class="bj_bai" style="height: 478px">
                <h3>欢迎注册</h3>
                <form action="${ctx}/doRegister" method="post" id="registerForm">
                    <span id="reg_span"></span>
                    <input id="phone" name="phone" type="text" class="kuang_txt phone" placeholder="手机号"
                           onblur="checkPhone();">
                    <br/>
                    <span id="phone_span" style="color: red"></span>
                    <input id="email" name="email" type="text" class="kuang_txt email" placeholder="邮箱"
                           onblur="checkEmail();">
                    <br/>
                    <span id="email_span" style="color: red"></span>
                    <input id="password" name="password" type="password" class="kuang_txt possword" placeholder="密码"
                           onKeyUp="CheckIntensity(this.value)" onblur="checkPassword();">
                    <br/>
                    <span id="password_span"></span>
                    <input id="nickName" name="nickName" type="text" class="kuang_txt possword" placeholder="昵称"
                           onblur="checkNickName();">
                    <br/>
                    <span id="nickName_span" style="color: red"></span>
                    <input id="code" name="code" type="text" class="kuang_txt yanzm" placeholder="验证码"
                           onblur="checkCode()">
                    <div>
                        <img id="captchaImg" style="CURSOR: pointer;" onclick="changeCaptcha()" title="看不清楚?请点击刷新验证码!"
                             align="absmiddle" src="{ctx}/captchaServlet" height="18" width="55">
                        <a href="javascript:;" onclick="changeCaptcha()" style="color: #666;">看不清楚</a><span
                            id="code_span" style="color: red;"></span>

                    </div>
                    <div>
                        <input id="protocol" type="checkbox" onclick="checkProtocol();"><span>已阅读并同意<a href="#"
                                                                                                       target="_blank"><span
                            class="lan">《梦境网用户协议》</span></a></span>
                        <br/>
                        <span id="protocol_span"></span>
                    </div>
                    <input name="注册" type="button" class="btn_zhuce" id="to_register" value="注册">
                    <br/>
                    <span style="color: red">${error}</span>

                </form>
            </div>
            <div class="bj_right" style="height: 478px">
                <p>使用以下账号直接登录</p>
                <a href="#" class="zhuce_qq">QQ注册</a>
                <a href="#" class="zhuce_wb">微博注册</a>
                <a href="#" class="zhuce_wx">微信注册</a>
                <p>已有账号？<a href="login.html">立即登录</a></p>

            </div>
        </div>
    </div>
</div>

<div style="text-align:center;">
</div>
</body>

<script type="text/javascript">


    var phoneWidth = parseInt(window.screen.width);
    var phoneScale = phoneWidth / 640;
    var ua = navigator.userAgent;


    if (/Android (\d+\.\d+)/.test(ua)) {
        var version = parseFloat(RegExp.$1);
        if (version > 2.3) {
            document.write('<meta name="viewport" content="width=640, minimum-scale = ‘+phoneScale+‘, maximum-scale = ‘+phoneScale+‘, target-densitydpi=device-dpi">');
        } else {
            document.write('<meta name="viewport" content="width=640, target-densitydpi=device-dpi">');
        }
    } else {
        document.write('<meta name="viewport" content="width=640, user-scalable=no, target-densitydpi=device-dpi">');
    }

    function changeCaptcha() {
        $("#captchaImg").attr('src', '${ctx}/captchaServlet?t=' + (new Date().getTime()));
    }

    //效验手机号
    var v = 0;
    var flag2 = false;

    function checkPhone() {
        var phone = $("#phone").val();
        phone = phone.replace(/^\s+|\s+$/g, "");
        if (phone == "") {
            $("#phone_span").text("请输入手机号!");
            $("#phone_ok").text("");
            var hgt = $("#regist-left").height();
            if (v == 0) {
                $("#regist-left").height(hgt + 30);
                $("#regist-right").height(hgt + 30);
                v++;
            }
            flag2 = false;
        }
        if (!(/^1[3|4|5|8|7][0-9]\d{8}$/.test(phone))) {
            $("#phone_span").text("手机号非法,请重新输入!");
            $("#phone_ok").text("");
            var hgt = $("#regist-left").height();
            if (v == 0) {
                $("#regist-left").height(hgt + 30);
                $("#regist-right").height(hgt + 30);
                v++;
            }
            flag2 = false;
        } else {
            $.ajax({
                type: 'post',
                url: '/checkPhone',
                data: {"phone": phone},
                dataType: 'json',
                success: function (data) {
                    var val = data['message'];
                    if (val == "success") {
                        $("#phone_span").text("");
                        $("#reg_span").text("");
                        $("#phone_ok").text("√").css("color", "green");

                        var content = $("#phone_ok").text();
                        if (content == "√") {
                            var hgt = $("#regist-left").heigt();
                            if (v == 1) {
                                $("#regist-left").height(hgt - 30);
                                $("#regist-right").height(hgt - 30);
                            }
                            v = 0;
                        }
                        flag2 = true;
                    } else {
                        $("#phone_span").text("该手机号已经注册！");
                        $("#phone_ok").text("");
                        var hgt = $("#regist-left").height();
                        if (v == 0) {
                            $("#regist-left").height(hgt + 30);
                            $("#regist-right").height(hgt + 30);
                            v++;
                        }
                        flag2 = false;
                    }

                }
            });
        }
        return flag2;
    }

    //根据内容增加而增加高度
    function increaseHeight() {

        var hgt = $("#regist-left").height();
        $("#regist-left").height(hgt + 30);
        $("#regist-right").height(hgt + 30);

    }

    //根据内容减少而减少高度
    function reduceHeight() {
        var hgt = $("#regist-left").height();
        $("#regist-left").height(hgt - 30);
        $("#regist-right").height(hgt - 30);
    }

    //验证码校验
    var flag_c = false;

    function checkCode() {
        var code = $("#code").val();
        //去空格
        code = code.replace(/^\s+|\s+$/g, "");
        if (code == "") {
            $("#code_span").text("请输入验证码！").css("color", "red");
            flag_c = false;
        } else {
            $.ajax({
                type: 'post',
                url: '/checkCode',
                data: {"code": code},
                dataType: 'json',
                success: function (data) {
                    var val = data['message'];
                    if (val == "success") {
                        $("#code_span").text("√").css("color", "green");
                        $("#reg_span").text("");
                        flag_c = true;
                    } else {
                        $("#code_span").text("验证码错误！").css("color", "red");
                        flag_c = false;
                    }
                }
            });
        }
        return flag_c;
    }

    //勾选永和协议校验
    function checkProtocol() {
        if ($('#protocol').prop("checked")) {
            $("#reg_span").text("");
            return true;
        } else {
            return false;
        }

    }

    //提交注册信息
    $("#to_register").click(function () {
        if (!checkProtocol()) {
            $("#protocol_span").text("请勾选\"阅读并接受梦境网用户协议\"！").css("color", "red");
        } else {
            $("#protocol_span").text("");
        }

        if (checkPhone() && checkPassword() && checkEmail() && checkNickName() && checkCode() && checkProtocol()) {
            $("#registerForm").submit();
        } else {
            $("#reg_span").text("请将信息填写完整！").css("color", "red");
        }

    });

</script>
</html>