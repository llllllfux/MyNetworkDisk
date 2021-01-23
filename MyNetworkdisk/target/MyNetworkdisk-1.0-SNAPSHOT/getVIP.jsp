<%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 2020/12/14
  Time: 22:34
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Title</title>
    <script src="static/js/jquery-3.1.1.js"></script>
    <link rel="shortcut icon" href="#"/>
    <link href="static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>

    <%
        pageContext.setAttribute("PATH", request.getContextPath());
        String username = (String) request.getSession().getAttribute("username");
    %>
</head>
<body>
<div class="col-md-offset-2"><h1>我的网盘 会员激活<small>GetVIP</small></h1></div>
<div class="col-md-3 col-md-offset-5">
    <form action="${PATH}/login.do" method="post">
        <div class="form-group has-success" id="divUsername">
            <label for="exampleInputUsername1" class="control-label">username</label>
            <input type="text" class="form-control" id="exampleInputUsername1" placeholder="用户名"
                   name="username">
            <span class="help-block"></span>

        </div>
        <div class="form-group" id="divActivationCode">
            <label for="exampleInputActivationCode" class="control-label">activationCode</label>
            <input type="password" class="form-control" id="exampleInputActivationCode" placeholder="激活码"
                   name="activationCode">
            <span class="help-block"></span>
        </div>

        <div class="form-group has-error">
            <span class="help-block" id="loginTip"></span>
        </div>
        <button type="button" class="btn btn-default" id="activation_btn">激活</button>
    </form>
</div>

<script>
    var username = "<%= username%>"
    $("#exampleInputUsername1").attr("value",username)


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

    function validateUsername() {
        var username = $("#exampleInputUsername1").val();
        var regName = /^[a-zA-Z0-9_-]{6,16}$/;
        if (!regName.test(username)) {
            showValidateMsg("#exampleInputUsername1", "error", "请输入正确的用户名")
        } else {
            checkUsernameIsExist()
        }
    }

    function validateActivationCode() {
        var username = $("#exampleInputActivationCode").val();
        var regName = /^[a-zA-Z0-9_-]{6,16}$/;
        if (!regName.test(username)) {
            showValidateMsg("#exampleInputActivationCode", "error", "激活码格式错误")
        }else {
            showValidateMsg("#exampleInputActivationCode", "success")
        }
    }

    $("#activation_btn").click(function () {
            $("#activation_btn").attr("type", "button");
            var loginTip = $("#loginTip")

            var classDivUsername = $("#divUsername");
            var classDivActivationCode = $("#divActivationCode");

            if (classDivUsername.attr("class").indexOf("has-success") != -1 &&
                classDivActivationCode.attr("class").indexOf("has-success") != -1) {
                $.ajax({
                    url:"${PATH}/GetVIP.do",
                    data:{
                        username:$("#exampleInputUsername1").val(),
                        activationCode:$("#exampleInputActivationCode").val()
                    },
                    type:"POST",
                    success:function (res){
                        if (res. code == "200") {
                            classDivActivationCode.attr("class","form-group has-error")
                            loginTip.text("激活码错误！")
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




    $("#exampleInputUsername1").change(function () {
        validateUsername();
    })

    $("#exampleInputActivationCode").change(function () {
        validateActivationCode();
    })

</script>
</body>
</html>
