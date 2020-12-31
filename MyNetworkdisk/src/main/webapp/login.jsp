<%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 2020/12/12
  Time: 9:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <%
        pageContext.setAttribute("PATH", request.getContextPath());
    %>
    <title>我的网盘登陆</title>

    <script src="static/js/jquery-3.1.1.js"></script>
    <link rel="shortcut icon" href="#" />
    <link href="static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>

<%--登陆表单--%>
<div class="col-md-offset-2"><h1>我的网盘 登陆<small>MyNetworkDisk</small></h1></div>
<div class="col-md-3 col-md-offset-7">
    <form action="${PATH}/login.do" method="post">

        <div class="form-group" id="divAccount">
            <label for="exampleInputUsername1" class="control-label">Account</label>
            <input type="text" class="form-control" id="exampleInputUsername1" placeholder="用户名/邮箱登陆"
                   name="loginAccount">
            <span class="help-block"></span>

        </div>
        <div class="form-group" id="divPassword">
            <label for="exampleInputPassword1" class="control-label">Password</label>
            <input type="password" class="form-control" id="exampleInputPassword1" placeholder="密码"
                   name="loginPassword">
            <span class="help-block"></span>
        </div>

        <div class="form-group has-error" >
        <span class="help-block" id="loginTip"></span>
        </div>
        <button type="button" class="btn btn-default" id="login_btn">登陆</button>
    </form>
    <button type="button" class="btn btn-default" id="go_user_register_btn"><a href="register.jsp">注册</a></button>



</div>

<script type="text/javascript">

    // $("#login_btn").click(function (){
    //     if ($("#exampleInputPassword1").val() == ""){
    //         showValidateMsg("#exampleInputUsername1", "error", "密码不可以为空");
    //         return false;
    //     }
    //     var classValue = $("#divAccount").attr("class");
    //     if(classValue.indexOf("has-success") != -1){
    //         $("#login_btn").attr("type","submit");
    //     }
    // })



    function showValidateMsg(ele, status, msg) {

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

    $("#login_btn").click(function () {
        // $("#login_btn").attr("type", "submit");
        // var classDivAccount = $("#divAccount");
        // var classDivPassword = $("#divPassword");
        // classDivAccount.removeClass("has-error has-success")
        // classDivPassword.removeClass("has-error has-success")
        $("#login_btn").attr("type", "button");
        var loginTip = $("#loginTip")
        // loginTip.text("")

            if ($("#exampleInputPassword1").val() == "") {
                    showValidateMsg("#exampleInputPassword1", "error", "密码不可以为空");
                }
                // if($("#exampleInputUsername1"))

                var classDivAccount = $("#divAccount");
                var classDivPassword = $("#divPassword");
                if (classDivAccount.attr("class").indexOf("has-success") != -1 &&
                    classDivPassword.attr("class").indexOf("has-success") != -1) {
                    $.ajax({
                        url:"${PATH}/login.do",
                        data:{
                            loginAccount:$("#exampleInputUsername1").val(),
                            loginPassword:$("#exampleInputPassword1").val()
                        },
                        type:"POST",
                        success:function (res){
                            if (res. code == "200") {
                                // classDivAccount.attr("class","form-group has-error")
                                classDivPassword.attr("class","form-group has-error")
                                loginTip.text("账号或密码错误")
                            }else{
                                loginTip.text("")
                                $("#login_btn").attr("type", "submit");
                                window.location.href = "/MyNetworkdisk/userJs.jsp";
                            }
                        }

                    })
                }
        }
    )

    function validateLoginUsername() {
        var username = $("#exampleInputUsername1").val();
        var regName = /^[a-zA-Z0-9_-]{6,16}$/;
        if (!regName.test(username)) {
            showValidateMsg("#exampleInputUsername1", "error", "请输入正确的用户名")
        } else {
            checkUsernameIsExist()
        }
    }

    function validateLoginPassword() {
        var password = $("#exampleInputPassword1").val();

        if (password == "") {
            showValidateMsg("#exampleInputPassword1", "error", "密码不可以为空");
        } else {
            showValidateMsg("#exampleInputPassword1", "success", "");
        }
    }


    function checkUsernameIsExist() {
        var usernameCheck = $("#exampleInputUsername1").val();
        $.ajax({
            url: "${PATH}/checkLoginUsernameIsExist.do",
            type: "POST",
            data: {usernameCheck: usernameCheck},
            success: function (res) {
                if (res.code == 200) {
                    showValidateMsg("#exampleInputUsername1", "error", res.extend.usernameIsNotExist);
                    $("#login_tn").attr("ajaxUsername", "error")
                } else {
                    showValidateMsg("#exampleInputUsername1", "success", "");
                    $("#login_tn").attr("ajaxUsername", "success")

                }
            }
        })
    }

    $("#exampleInputUsername1").change(function () {
        validateLoginUsername();
    })
    $("#exampleInputPassword1").change(function () {
        validateLoginPassword();
    })
</script>

</body>
</html>
