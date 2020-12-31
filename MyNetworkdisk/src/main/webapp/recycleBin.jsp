<%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 2020/12/20
  Time: 13:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>回收站</title>
    <script src="static/js/jquery-3.1.1.js"></script>
    <link href="static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="static/js/jconfirm/jquery-confirm.min.css">
    <script src="static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="static/js/JavaScript_util.js"></script>
    <link href="static/css/style.min.css" rel="stylesheet">
</head>
<body>
<%
    pageContext.setAttribute("PATH", request.getContextPath());
%>
<%
    String username = (String) request.getSession().getAttribute("username");
%>
<!--左侧导航-->
<aside class="lyear-layout-sidebar">

    <!-- logo -->
    <%--            <div id="logo" class="sidebar-header">--%>
    <%--            </div>--%>
    <img src="image/MyNetworkDiskLogo.jpg" width="230px" height="70px">
    <div class="lyear-layout-sidebar-scroll">
        <%--                <nav class="sidebar-main">--%>
        <table class="table table-bordered table-hover" style="text-align: center">
            <thead>
            <tr>
                <td></td>
            </tr>
            </thead>
            <tbody>
            <tr id="myFile">
                <td id="myAllFile"><b>>我的文件</b></td>
            </tr>
            <tr id="myBin">
                <td id="recycleBin"><b>> 回收站</b></td>
            </tr>

            </tbody>
        </table>
    </div>

</aside>
<!--End 左侧导航-->
<!--头部信息-->
<header class="lyear-layout-header">

    <nav class="navbar navbar-default">
        <div class="topbar">

            <div class="topbar-left">
                <div class="lyear-aside-toggler">
                    <span class="lyear-toggler-bar"></span>
                    <span class="lyear-toggler-bar"></span>
                    <span class="lyear-toggler-bar"></span>
                </div>
                <span class="navbar-page-title"> 回收站 </span>
            </div>

            <%--                    <ul class="topbar-right">--%>

            <!-- Single button -->

            <div class="col-lg-offset-7 ">
                <a><b><font size="3">欢迎您，用户：</font></b>
                    <%--                            <span id=""><span class="caret"></span>--%>
                    <%--                            </span>--%>
                </a>
            </div>

            <div class="btn-group col-md-2 ">
                <button type="button" class="btn btn-default  dropdown-toggle" data-toggle="dropdown"
                        aria-haspopup="true" aria-expanded="false" id="showName">
                    <span class="caret"></span>
                </button>
                <ul class="dropdown-menu">
                    <li><a href="#">密码重置</a></li>
                    <li><a href="#">成为会员</a></li>
                    <li role="separator" class="divider"></li>
                    <li><a href="${PATH}/quit.do">退出登录</a></li>
                </ul>
            </div>
        </div>
    </nav>

</header>
<!--End 头部信息-->
<!--页面主要内容-->
<main class="lyear-layout-content">

    <div class="container-fluid">

        <div class="row">
            <div class="col-lg-12">
                <div class="card">
                    <div class="card-toolbar clearfix">
                        <button type="button" class="btn btn-danger" id="clearAll">
                            清空回收站
                        </button>
                    </div>
                    <div class="card-body">

                        <div class="table-responsive">
                            <table class="table table-hover ">
                                <thead>
                                <tr>
                                    <th>
                                        <label class="lyear-checkbox checkbox-primary">
                                            <input type="checkbox" id="check-all"><span></span>
                                        </label>
                                    </th>
                                    <th>文件名</th>
                                    <th>文件大小</th>
                                    <th>修改日期</th>
                                    <th>操作</th>
                                </tr>
                                </thead>
                                <tbody id="showDocuments">
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</main>

<script>
    var username = "<%= username%>"
    if (username == "null") username = "未登录";
    $("#showName").html(username + "<span class=\"caret\"></span>")

    $("#myAllFile").click(function () {
        window.location.href = "/MyNetworkdisk/userJs.jsp"
    })

    $("#recycleBin").click(function () {
        window.location.href = "/MyNetworkdisk/recycleBin.jsp"
    })


    function createTable(userFile) {

        $("#showDocuments").empty();
        $.each(userFile, function (i, val) {
            var checkBoxTd = $("<td><input type='checkbox' class='check_item'/></td>");
            var fileName = $("<td></td>").append(userFile[i].filename);
            var fileSize = $("<td></td>").append(userFile[i].viewFileSize);
            var uploadTime = $("<td></td>").append(userFile[i].deleteTime);

            var reductionBtn = $("<button></button>&nbsp").addClass("btn reductionBtn")
                .append($("<span></span>").addClass("glyphicon glyphicon-repeat").append(""));
            //为下载按钮添加一个自定义的属性，来表示当前文件id
            reductionBtn.attr("reduction-id", userFile[i].fileID);

            var deleteBtn = $("<button></button>&nbsp").addClass("btn btn-danger deleteBtn")
                .append($("<span></span>").addClass("glyphicon glyphicon-remove-sign").append(""));
            deleteBtn.attr("delete-id", userFile[i].fileID).attr("delete-name", userFile[i].filename);

            var BtnTd = $("<td></td>").append(reductionBtn).append(deleteBtn);

            $("<tr></tr>")
                .attr("id", userFile[i].fileID)
                .append(checkBoxTd)
                .append(fileName)
                .append(fileSize)
                .append(uploadTime)
                .append(BtnTd)
                .appendTo("#showDocuments")
        })

    }

    function showTable() {
        $.ajax({
            url: "${PATH}/getDeleteFile.do",
            type: "GET",
            data: {username: username},
            success: function (res) {
                createTable(res.extend.userDeleteFile)
            }
        })
    }

    showTable();

    $(document).on("click", ".reductionBtn", function () {
        var thisElm = $(this)
        // alert(thisElm.attr("reduction-id"))
        $.ajax({
            url: "${PATH}/reductionFile.do",
            data: {fileID: thisElm.attr("reduction-id")},
            type: "GET",
            success: function (res) {
                if (res.code == 100) {
                    $("#" + thisElm.attr("reduction-id")).empty();
                }
            }
        })

    })

    $(document).on("click", ".deleteBtn", function () {
        var thisElm = $(this)
        var isDelete = confirm("确认要永久删除此文件吗？（删除后不可恢复！）");
        if (isDelete == true){
            $.ajax({
                url:"${PATH}/deleteFileFromBin.do",
                type:"GET",
                data:{fileID: thisElm.attr("delete-id"),username:username},
                success:function (res){
                    if (res.code == 100) {
                        $("#" + thisElm.attr("delete-id")).empty();
                    }
                }
            })
        }
    })

    $("#clearAll").click(function (){
        var isClear = confirm("确定要永久删除所有的文件吗？（删除后不可恢复！）");
        if (isClear == true){
            $.ajax({
                url:"${PATH}/clearAllBinFile.do",
                type:"GET",
                data:{username:username},
                success:function (res){
                    if (res.code == 100) {
                        $("#showDocuments").empty();
                    }
                }
            })
        }
    })

</script>

</body>
</html>
