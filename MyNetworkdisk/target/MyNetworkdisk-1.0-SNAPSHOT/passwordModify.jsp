<%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 2020/12/29
  Time: 18:47
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page isELIgnored ="false" %>
<html>
<head>
    <title>密码重置</title>
    <%
        pageContext.setAttribute("PATH", request.getContextPath());
    %>
    <%
        String username = (String) request.getSession().getAttribute("username");
    %>
    <script src="static/js/jquery-3.1.1.js"></script>
    <link href="static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>

<div class="col-md-offset-2"><h1>密码重置 <small>passwordModify</small></h1></div>
<div class="col-md-3 col-md-offset-7">
    <form method="post" action="${PATH}/passwordModify.do">

        <div class="form-group" id="divUsername">
            <label for="exampleInputUsername1" class="control-label">username</label>
            <input type="text" class="form-control" id="exampleInputUsername1" placeholder="请输入用户名"
                   name="username">
            <span class="help-block"></span>
        </div>

        <div class="form-group" id="divOldPassword">
            <label for="exampleInputPassword1" class="control-label">oldPassword</label>
            <input type="password" class="form-control" id="exampleInputPassword1" placeholder="请输入原密码"
                   name="oldPassword">
            <span class="help-block"></span>
        </div>

        <div class="form-group" id="divNewPassword">
            <label for="exampleInputPassword2" class="control-label">newPassword</label>
            <input type="password" class="form-control" id="exampleInputPassword2" placeholder="请输入新密码"
                   name="newPassword">
            <span class="help-block"></span>
        </div>

        <div class="form-group" id="divConfirmPassword">
            <label for="exampleInputPassword3" class="control-label">confirmPassword</label>

            <input type="password" class="form-control" id="exampleInputPassword3" placeholder="请确认新密码"
                   name="confirmPassword">
            <span class="help-block"></span>
        </div>

        <div class="form-group has-error" >
            <span class="help-block" id="loginTip"></span>
        </div>

        <button type="button" class="btn btn-default" id="user_modify_btn">修改</button>

    </form>
</div>

<script>
    var username = "<%= username%>";

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

    function validateUsername() {
        var username = $("#exampleInputUsername1").val();
        var regName = /^[a-zA-Z0-9_-]{6,16}$/;
        if (!regName.test(username)) {
            showValidateMsg("#exampleInputUsername1", "error", "用户名必须是6-16位数字，字母或者_-")
        } else {
            checkUsernameIsExist()
            // showValidateMsg("#exampleInputUsername1", "success", "");
        }
    }

    function checkUsernameIsExist() {
        var usernameCheck = $("#exampleInputUsername1").val();
        $.ajax({
            url: "${PATH}/checkRegisterUsernameIsExist.do",
            type: "POST",
            data: {usernameCheck: usernameCheck},
            success: function (res) {
                if (res.code == 200) {
                    showValidateMsg("#exampleInputUsername1", "success", "");
                } else {
                    showValidateMsg("#exampleInputUsername1", "error", "该用户未注册")

                }
            }
        })
    }

    function validateRegisterPassword1() {
        var password = $("#exampleInputPassword1").val();
        var regPassword = /^[a-zA-Z0-9_-]{6,16}$/;
        if (!regPassword.test(password)) {
            showValidateMsg("#exampleInputPassword1", "error", "密码不符合规范，至少包含8到18位数字字母")
        } else {
            showValidateMsg("#exampleInputPassword1", "success", "");
        }
    }

    function validateRegisterPassword2() {
        var password = $("#exampleInputPassword2").val();
        var regPassword = /^[a-zA-Z0-9_-]{6,16}$/;
        if (!regPassword.test(password)) {
            showValidateMsg("#exampleInputPassword2", "error", "密码不符合规范，至少包含8到18位数字字母")
        } else {
            showValidateMsg("#exampleInputPassword2", "success", "");
        }
    }

    function validateRegisterPassword3() {
        var password = $("#exampleInputPassword3").val();
        var regPassword = /^[a-zA-Z0-9_-]{6,16}$/;
        if (!regPassword.test(password)) {
            showValidateMsg("#exampleInputPassword3", "error", "密码不符合规范，至少包含8到18位数字字母")
        } else if ( $("#exampleInputPassword2").val() != password){
            showValidateMsg("#exampleInputPassword3", "error", "两次密码输入不一致");
        }else{
            showValidateMsg("#exampleInputPassword3", "success", "");
        }
    }

    $("#exampleInputUsername1").change(function () {
        validateUsername();
    })
    $("#exampleInputPassword1").change(function () {
        validateRegisterPassword1();
    })
    $("#exampleInputPassword2").change(function () {
        validateRegisterPassword2();
    })
    $("#exampleInputPassword3").change(function () {
        validateRegisterPassword3();
    })

    $("#user_modify_btn").click(function () {

        $("#user_register_btn").attr("type", "button");
        var loginTip = $("#loginTip")
        var divUsername = $("#divUsername")
        var divOldPassword = $("#divOldPassword")
        var divONewPassword = $("#divNewPassword")
        var divOConfirmPassword = $("#divConfirmPassword")

        if (divUsername.attr("class").indexOf("has-success") != -1
            && divOldPassword.attr("class").indexOf("has-success") != -1
            && divONewPassword.attr("class").indexOf("has-success") != -1
            && divOConfirmPassword.attr("class").indexOf("has-success") != -1) {

            $.ajax({
                url:"${PATH}/passwordModifyCheck.do",
                data:{
                    username:$("#exampleInputUsername1").val(),
                    oldPassword:$("#exampleInputPassword1").val(),
                    newPassword:$("#exampleInputPassword2").val(),
                    confirmPassword:$("#exampleInputPassword3").val()
                },
                type:"POST",
                success:function (res){
                    if (res.code == "200") {
                        // divUsername.attr("class","form-group has-error")
                        // divOldPassword.attr("class","form-group has-error")
                        // divONewPassword.attr("class","form-group has-error")
                        // divOConfirmPassword.attr("class","form-group has-error")

                        // alert("请按照规范输入数据！！")
                        loginTip.text(res.extend.error)
                        // window.location.href = "/MyNetworkdisk/passwordModify.jsp";
                    }else{
                        loginTip.text("")
                        $("#user_modify_btn").attr("type", "submit");
                        // $("#user_modify_btn").attr("type", "botton");
                        // window.location.href = "/MyNetworkdisk/login.jsp";
                    }
                }

            })
            // $("#user_modify_btn").attr("type", "submit");
        }
    })



</script>

</body>
</html>
