<%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 2020/12/12
  Time: 10:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page isELIgnored ="false" %>
<html>
<head>
    <title>用户注册</title>
    <%
        pageContext.setAttribute("PATH", request.getContextPath());
    %>

    <script src="static/js/jquery-3.1.1.js"></script>
    <link href="static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>
<div class="col-md-offset-2"><h1>欢迎注册 <small>Welcome</small></h1></div>
<div class="col-md-3 col-md-offset-7">
    <form method="post" action="${PATH}/register.do">

        <div class="form-group" id="divUsername">
            <label for="exampleInputUsername1" class="control-label">username</label>
            <input type="text" class="form-control" id="exampleInputUsername1" placeholder="请输入用户名"
                   name="registerUsername">
            <span class="help-block"></span>
        </div>

        <div class="form-group" id="divPassword">
            <label for="exampleInputPassword1" class="control-label">Password</label>
                <input type="password" class="form-control" id="exampleInputPassword1" placeholder="请输入密码"
                       name="registerPassword">
                <span class="help-block"></span>
        </div>

        <div class="form-group" id="divEmail">
            <label for="exampleInputEmail1" class="control-label">email</label>

            <input type="text" class="form-control" id="exampleInputEmail1" placeholder="请输入邮箱"
                   name="registerEmail">
            <span class="help-block"></span>
        </div>

        <div class="form-group has-error" >
            <span class="help-block" id="loginTip"></span>
        </div>

        <button type="button" class="btn btn-default" id="user_register_btn">注册</button>

    </form>
</div>

<script type="text/javascript">



    function showValidateMsg(ele, status, msg) {
        // 当一开始输入不正确的用户名之后，会变红。
        // 但是之后输入了正确的用户名却不会变绿，
        // 因为has-error和has-success状态叠加了。
        // 所以每次校验的时候都要清除当前元素的校验状态。
        $(ele).parent().removeClass("has-success has-error");
        //提示信息默认为空
        $(ele).next("span").text("");

        if ("success" == status) {
            //如果校验成功
            $(ele).parent().addClass("has-success");
            $(ele).next("span").text(msg);
        } else if ("error" == status) {
            //如果校验失败
            $(ele).parent().addClass("has-error");
            $(ele).next("span").text(msg);
        }
    }

    $("#user_register_btn").click(function () {

        $("#user_register_btn").attr("type", "button");
        var loginTip = $("#loginTip")
        var divUsername = $("#divUsername")
        var divPassword = $("#divPassword")
        var divEmail = $("#divEmail")

        if (divUsername.attr("class").indexOf("has-success") != -1
            && divPassword.attr("class").indexOf("has-success") != -1
            && divEmail.attr("class").indexOf("has-success") != -1) {

            $.ajax({
                url:"${PATH}/registerCheck.do",
                data:{
                    registerUsername:$("#exampleInputUsername1").val(),
                    registerPassword:$("#exampleInputPassword1").val(),
                    registerEmail:$("#exampleInputEmail1").val()
                },
                type:"POST",
                success:function (res){
                    if (res.code == "200") {
                        divUsername.attr("class","form-group has-error")
                        divPassword.attr("class","form-group has-error")
                        divEmail.attr("class","form-group has-error")
                        alert("请按照规范输入数据！！")
                        window.location.href = "/MyNetworkdisk/register.jsp";
                    }else{
                        loginTip.text("")
                        $("#user_register_btn").attr("type", "submit");
                        window.location.href = "/MyNetworkdisk/login.jsp";
                    }
                }

            })
            $("#user_register_btn").attr("type", "submit");
        }
    })

    function validateRegisterUsername() {
        var username = $("#exampleInputUsername1").val();
        var regName = /^[a-zA-Z0-9_-]{6,16}$/;
        if (!regName.test(username)) {
            showValidateMsg("#exampleInputUsername1", "error", "用户名必须是6-16位数字，字母或者_-")
        } else {
            checkUsernameIsExist()
            // showValidateMsg("#exampleInputUsername1", "success", "");
        }
    }

    function validateRegisterPassword() {
        var password = $("#exampleInputPassword1").val();
        var regPassword = /^[a-zA-Z0-9_-]{6,16}$/;
        if (!regPassword.test(password)) {
            showValidateMsg("#exampleInputPassword1", "error", "密码不符合规范，至少包含8到18位数字字母")
        } else {
            showValidateMsg("#exampleInputPassword1", "success", "");
        }
    }

    function validateRegisterEmail() {
        var email = $("#exampleInputEmail1").val();
        var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if (!regEmail.test(email)) {
            showValidateMsg("#exampleInputEmail1", "error", "邮箱不符合规范")
        } else {
            checkEmailIsExist();
            // showValidateMsg("#exampleInputEmail1", "success", "");
        }
    }

    function checkEmailIsExist() {
        var emailCheck = $("#exampleInputEmail1").val();
        $.ajax({
            url: "${PATH}/checkRegisterEmailIsExist.do",
            type: "POST",
            data: {emailCheck: emailCheck},
            success: function (res) {
                if (res.code == 200) {
                    showValidateMsg("#exampleInputEmail1", "error", res.extend.emailIsExist);
                } else {
                    showValidateMsg("#exampleInputEmail1", "success", "")

                }
            }
        })
    }

    function checkUsernameIsExist() {
        var usernameCheck = $("#exampleInputUsername1").val();
        $.ajax({
            url: "${PATH}/checkRegisterUsernameIsExist.do",
            type: "POST",
            data: {usernameCheck: usernameCheck},
            success: function (res) {
                if (res.code == 200) {
                    showValidateMsg("#exampleInputUsername1", "error", res.extend.usernameIsExist);
                } else {
                    showValidateMsg("#exampleInputUsername1", "success", "")

                }
            }
        })
    }

    $("#exampleInputUsername1").change(function () {
        validateRegisterUsername();
    })
    $("#exampleInputPassword1").change(function () {
        validateRegisterPassword();
    })
    $("#exampleInputEmail1").change(function () {
        validateRegisterEmail();
    })


</script>


</body>
</html>
