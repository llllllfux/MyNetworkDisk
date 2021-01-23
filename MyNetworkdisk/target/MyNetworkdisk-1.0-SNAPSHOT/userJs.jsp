<%--
  Created by IntelliJ IDEA.
  User: DELL
  Date: 2020/12/13
  Time: 14:14
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page deferredSyntaxAllowedAsLiteral="true"%>
<html>
<head>
    <title>我的网盘-全部文件</title>
    <%--        &lt;%&ndash;%>
    <%--            pageContext.setAttribute("PATH", request.getContextPath());--%>
    <%--        %>--%>
</head>
<body>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>

    <script src=""></script>
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
    String username = (String) request.getSession().getAttribute("username");
    int role = (int) request.getSession().getAttribute("role");
    String viewTotalFileSize = (String) request.getSession().getAttribute("viewTotalFileSize");
%>

<div class="lyear-layout-web">
    <div class="lyear-layout-container">
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
                        <td><b>>我的文件</b></td>
                    </tr>
                    <tr id="img">
                        <td><i>图片</i></td>
                    </tr>
                    <tr id="document">
                        <td><i>文档</i></td>
                    </tr>
                    <tr id="video">
                        <td><i>视频</i></td>
                    </tr>
                    <tr id="music">
                        <td><i>音频</i></td>
                    </tr>
                    <tr id="compressedFile">
                        <td><i>压缩文件</i></td>
                    </tr>
                    <tr id="other">
                        <td><i>其他</i></td>
                    </tr>
                    <tr id="myBin">
                        <td><b>> 回收站</b></td>
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

                        <span class="navbar-page-title"> 我的文件 </span>
                    </div>

                    <%--                    <ul class="topbar-right">--%>

                    <!-- Single button -->

                    <div class="col-lg-offset-7 ">
                        <a><b><font size="3" id="welcome"></font></b>
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
                            <li><a href="${PATH}/passwordModify.jsp">密码重置</a></li>
                            <li><a href="${PATH}/getVIP.jsp">成为会员</a></li>
                            <li role="separator" class="divider"></li>
                            <li><a href="${PATH}/quit.do">退出登录</a></li>
                        </ul>
                    </div>
                    <!-- 个人信息 -->
                    <%--                        <li class="dropdown dropdown-profile">--%>
                    <%--                        <a>--%>
                    <%--                            <!--<img id="showImage" class="img-avatar img-avatar-48 m-r-10" src="" />-->--%>
                    <%--                            欢迎您，用户：--%>
                    <%--                            <span id="showName"><span class="caret"></span></span>--%>
                    <%--                        </a>--%>
                    <%--                            <ul class="dropdown-menu dropdown-menu-right">--%>
                    <%--                                <li><i class="mdi mdi-account"></i> 个人信息</li>--%>
                    <%--                                <li><i class="mdi mdi-lock-outline"> 修改密码</i>--%>
                    <%--                                <li><i class="mdi mdi-account"></i> 我的好友</li>--%>
                    <%--                                <li class="divider"></li>--%>
                    <%--                                <li>欢迎您！用户：<span id="usernameLabel"></span></li>--%>
                    <%--                            </ul>--%>
                    <%--                        </li>--%>
                    <%--                    </ul>--%>

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
                                <button type="button" class="btn btn-primary" data-toggle="modal"
                                        data-target="#gridSystemModal">上传

                                </button>
                                <button type="button" class="btn btn-info">下载

                                </button>
                                <button type="button" class="btn btn-danger">删除
                                </button>
<%--                                <a href="${PATH}//filePreviewTest.do"></a>--%>

                                <form class="pull-right search-bar">
                                    <div class="col-md-12 col-md-offset-0">
                                        <a><b><font size="3" id="totalSize"></font></b></a>
                                        <%--                                    <input type="text" class="form-control" value="" id="keys" name="keyword"--%>
                                        <%--                                           placeholder="请输入搜索内容">--%>
                                    </div>

                                </form>

                                <%--                            <div class="toolbar-btn-action">--%>
                                <%--                                <a class="btn btn-primary m-r-5" data-toggle="modal" data-target="#gridSystemModal"><i--%>
                                <%--                                        class="mdi mdi-arrow-collapse-up"></i> 上传</a>--%>
                                <%--                                <a class="btn btn-success m-r-5"><i class="mdi mdi-arrow-collapse-down"></i> 下载</a>--%>
                                <%--                                <a class="btn btn-dark m-r-5"><i class="mdi mdi-window-close"></i> 删除</a>--%>
                                <%--                             </div>--%>


                                <!-- 上传文件弹出层-->
                                <div class="modal fade" tabindex="-1" role="dialog"
                                     aria-labelledby="gridSystemModalLabel" id="gridSystemModal">
                                    <div class="modal-dialog" role="document">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <button type="button" class="close" data-dismiss="modal"
                                                        aria-label="Close"><span aria-hidden="true">&times;</span>
                                                </button>
                                                <h4 class="modal-title" id="gridSystemModalLabel">文件上传</h4>
                                            </div>
                                            <div class="modal-body">
                                                <%--                                                <div class="">--%>
                                                <form class="btn btn-default" id="uploadFile"
                                                      enctype="multipart/form-data" method="POST">
                                                    <input type="file" id="file" name="file" multiple>
                                                    <%--                                                        <button type="submit" value="上传文件"></button>--%>
                                                </form>

                                                <%--                                                </div>--%>
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-default" data-dismiss="modal">关闭
                                                </button>
                                                <button type="button" class="btn btn-primary" data-dismiss=""
                                                        id="submitFileUpload">上传
                                                </button>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <!-- End 上传文件弹出层-->

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
        <!--End 页面主要内容-->
    </div>
</div>

</body>
</html>
<script>
    var username = "<%= username%>"



    function refreshInfo() {
        $.ajax({
            url: "${PATH}/getUserInfo.do",
            type: "GET",
            data: {username, username},
            success: function (res) {
                var role = res.extend.user.role;

                if (role == 1) {
                    $("#welcome").text("欢迎您，尊贵的会员用户：")
                } else {
                    $("#welcome").text("欢迎您，尊贵的用户：")
                }
                var maxSize;
                if (role == 1) {
                    maxSize = "5G";
                } else {
                    maxSize = "1G"
                }
                $("#totalSize").text(" 网盘容量 : " + res.extend.viewFileSize + "  /  " + maxSize)


            }
        })
    }
    if (username == "null") {
        username = "未登录";
    } else {
        $("#showName").html(username + "<span class=\"caret\"></span>")
        refreshInfo();
    }

    function createTable(userFile) {
        $("#showDocuments").empty();
        $.each(userFile, function (i, val) {
            var checkBoxTd = $("<td><input type='checkbox' class='check_item'/></td>");
            var fileName = $("<td></td>").append(userFile[i].fileName);
            var fileSize = $("<td></td>").append(userFile[i].viewFileSize);
            var uploadTime = $("<td></td>").append(userFile[i].uploadTime);

            var downloadBtn = $("<button></button>&nbsp").addClass("btn downloadBtn")
                .append($("<span></span>").addClass("glyphicon glyphicon-download-alt").append(""));
            //为下载按钮添加一个自定义的属性，来表示当前文件id
            downloadBtn.attr("download-id", userFile[i].fileID);

            var modifyFilenameBtn = $("<button></button>&nbsp").addClass("btn modifyFilenameBtn")
                .append($("<span></span>").addClass("glyphicon glyphicon-pencil").append(""));
            modifyFilenameBtn.attr("modifyFilename-id", userFile[i].fileID).attr("modifyFilename-name", userFile[i].fileName);

            var previewBtn = $("<button></button>&nbsp").addClass("btn previewBtn")
                .append($("<a></a>").attr("href","${PATH}/filePreview.do?username=" + username + "&fileID=" + userFile[i].fileID).attr("target","_blank")
                    .append($("<span></span>").addClass("glyphicon glyphicon glyphicon-eye-open").append("")));
            previewBtn.attr("preview-id",userFile[i].fileID);

            var deleteBtn = $("<button></button>").addClass("btn btn btn-danger deleteBtn")
                .append($("<span></span>").addClass("glyphicon glyphicon-trash").append(""));
            //为下载按钮添加一个自定义的属性，来表示当前文件id
            deleteBtn.attr("delete-id", userFile[i].fileID);


            var BtnTd = $("<td></td>").append(downloadBtn).append(modifyFilenameBtn).append(previewBtn).append(deleteBtn);

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

    var fileLise;

    function showTable() {
        $.ajax({
            url: "${PATH}/getUserFile.do",
            data: {username: username, fileType: 0},
            type: "GET",
            success: function (res) {
                fileLise = res.extend.userFile;
                createTable(res.extend.userFile)
                refreshInfo();
            }
        })
    }

    showTable();

    $(document).on("click", ".downloadBtn", function () {
        window.location.href = "${PATH}/fileDownload.do"
            + "?fileID=" + $(this).attr("download-id")
            + "&username=" + username;
    })

    $(document).on("click", ".modifyFilenameBtn", function () {
        var thisElement = $(this)
        var filename = $(this).attr("modifyFilename-name")
        var newFilename = prompt("请输入新文件名", filename)
        var fileID = $(this).attr("modifyFilename-id");
        if (newFilename != null && newFilename != filename) {
            $.ajax({
                url: "${PATH}/checkUserFilename.do",
                type: "GET",
                data: {username: username, newFilename: newFilename},
                success: function (res) {
                    if (res.code == 200) {
                        var isModify = confirm("已存在同名文件确认要修改文件名吗？")
                        if (isModify == true) {
                            $.ajax({
                                url: "${PATH}/modifyFilename.do",
                                type: "GET",
                                data: {
                                    fileID: fileID,
                                    newFilename: newFilename,
                                    oldFilename: filename,
                                    username: username
                                },
                                success: function (res) {
                                    if (res.code != 200) {
                                        thisElement.attr("modifyFilename-name", res.extend.newFilename);
                                        $($("#" + fileID).children("td").get(1)).text(res.extend.newFilename);
                                        // $("#" + fileID).empty()
                                    }
                                }
                            })
                        }
                    } else {
                        $.ajax({
                            url: "${PATH}/modifyFilename.do",
                            type: "GET",
                            data: {fileID: fileID, newFilename: newFilename, oldFilename: filename, username: username},
                            success: function (res) {
                                if (res.code != 200) {
                                    thisElement.attr("modifyFilename-name", res.extend.newFilename);
                                    $($("#" + fileID).children("td").get(1)).text(res.extend.newFilename);
                                    // $("#" + fileID).empty()
                                }
                            }
                        })
                    }
                }
            })

            <%--$.ajax({--%>
            <%--    url:"${PATH}/modifyFilename.do",--%>
            <%--    type:"GET",--%>
            <%--    data:{fileID:fileID,newFilename:newFilename,oldFilename:filename,username:username},--%>
            <%--    success:function (res){--%>
            <%--        if (res.code != 200){--%>
            <%--            $($("#" + fileID).children("td").get(1)).text(newFilename);--%>
            <%--            // $("#" + fileID).empty()--%>
            <%--        }--%>
            <%--    }--%>
            <%--})--%>
        }
    })

    $(document).on("click", ".deleteBtn", function () {
        var isDelete = confirm("确定要删除文件吗？删除的文件将会放在回收站中！")
        if (isDelete == true) {
            var fileID = $(this).attr("delete-id");
            // alert("已经删除！！")
            $.ajax({
                url: "${PATH}/fileDelete.do",
                data: {fileID: fileID},
                type: "GET",
                success: function () {
                    $("#" + fileID).empty()
                    refreshInfo();
                }
            })
        }
    })


    $("#submitFileUpload").click(function () {
        if ($("#file").val() == "") {
            $("#submitFileUpload").attr("data-dismiss", "")
            alert("请选择上传文件！")
        } else {
            $("#submitFileUpload").attr("data-dismiss", "modal")
            $.ajax({
                url: "${PATH}/fileUpload.do",
                type: "POST",
                data: (new FormData($('#uploadFile')[0])),
                processData: false,
                // contentType必须要有
                contentType: false,
                success: function (res) {
                    if (res.code != 200) {
                        showTable();
                        alert("上传成功！！")

                    }
                }
            })
        }
    })

    $("#myFile").click(function () {
        showTable();
    })

    $("#img").click(function () {
        $.ajax({
            url: "${PATH}/getUserFile.do",
            data: {username: username, fileType: 1},
            type: "GET",
            success: function (res) {
                createTable(res.extend.userFile)
            }

        })
    })

    $("#document").click(function () {
        $.ajax({
            url: "${PATH}/getUserFile.do",
            data: {username: username, fileType: 2},
            type: "GET",
            success: function (res) {
                createTable(res.extend.userFile)
            }

        })
    })
    $("#video").click(function () {
        $.ajax({
            url: "${PATH}/getUserFile.do",
            data: {username: username, fileType: 3},
            type: "GET",
            success: function (res) {
                createTable(res.extend.userFile)
            }
        })
    })
    $("#music").click(function () {
        $.ajax({
            url: "${PATH}/getUserFile.do",
            data: {username: username, fileType: 4},
            type: "GET",
            success: function (res) {
                createTable(res.extend.userFile)
            }

        })
    })

    $("#compressedFile").click(function () {
        $.ajax({
            url: "${PATH}/getUserFile.do",
            data: {username: username, fileType: 5},
            type: "GET",
            success: function (res) {
                createTable(res.extend.userFile)
            }

        })
    })

    $("#other").click(function () {
        $.ajax({
            url: "${PATH}/getUserFile.do",
            data: {username: username, fileType: 6},
            type: "GET",
            success: function (res) {
                createTable(res.extend.userFile)
            }

        })
    })

    $("#myBin").click(function () {
        window.location.href = "/MyNetworkdisk/recycleBin.jsp";
    })

    <%--$("#reviewPrice").click(function(){--%>

    <%--    window.open("${PATH}/filePreview.do?filePath=F:\\myTxt.txt");--%>
    <%--});--%>

    <%--$("#")--%>


</script>
</body>
</html>
