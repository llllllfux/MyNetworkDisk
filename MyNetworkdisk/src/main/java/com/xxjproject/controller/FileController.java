package com.xxjproject.controller;

import com.xxjproject.domain.*;
import com.xxjproject.service.UserFileDeleteService;
import com.xxjproject.service.UserFileService;
import com.xxjproject.service.UserService;
import com.xxjproject.util.FileUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.util.ArrayList;
import java.util.List;

/**
 * @author xuxingjun
 * @data 2020/12/15  -  20:57
 */

@Controller
public class FileController {
    @Autowired
    private UserService userService;
    @Autowired
    private UserFileService userFileService;
    @Autowired
    private UserFileDeleteService userFileDeleteService;

    @ResponseBody
    @RequestMapping("/getUserFile.do")
    public Msg getUserFile(String username, Integer fileType) {
        int userID = userService.getUserByUsername(username).getUserID();
        if (fileType == 0) {
            List<UserFile> userFile = userFileService.getUserFile(userID);
            return Msg.success().add("userFile", userFile);
        } else if (fileType == 1) {
            List<UserFile> userImgFile = userFileService.getUserImgFile(userID);
            return Msg.success().add("userFile", userImgFile);
        } else if (fileType == 2) {
            List<UserFile> userDocumentFile = userFileService.getUserDocumentFile(userID);
            return Msg.success().add("userFile", userDocumentFile);
        } else if (fileType == 3) {
            List<UserFile> userVideoFile = userFileService.getUserVideoFile(userID);
            return Msg.success().add("userFile", userVideoFile);
        } else if (fileType == 4) {
            List<UserFile> userMusicFile = userFileService.getUserMusicFile(userID);
            return Msg.success().add("userFile", userMusicFile);
        } else if (fileType == 5) {
            List<UserFile> userCompressedFile = userFileService.getUserCompressedFile(userID);
            return Msg.success().add("userFile", userCompressedFile);
        } else {
            List<UserFile> userOtherFile = userFileService.getUserOtherFile(userID);
            return Msg.success().add("userFile", userOtherFile);
        }

    }





    @ResponseBody
    @RequestMapping("/fileDownload.do")
    public Msg fileDownload(int fileID, String username,HttpServletRequest request,HttpServletResponse response) throws IOException {
        UserFile userFile = userFileService.getUserFileByFileID(fileID);
        String serverFileName = userFile.getFileName();
        String serverFilePath = "F:\\server\\userFile\\" + username + "\\" + serverFileName;
        File file = new File(serverFilePath);
        User user = userService.getUserByUsername(username);
        int role = user.getRole();
        if (file.exists()) {
            System.out.println("文件存在！！");
            response.setContentType("application/x-msdownload");
            String str = "attachment;filename="+ java.net.URLEncoder.encode(serverFileName, "utf-8");
            response.setHeader("Content-Disposition", str);
            FileInputStream in = new FileInputStream(file);
            OutputStream out = response.getOutputStream();
            byte[] buff = new byte[1024];
            int len = 0;

            if (role == 1) {
                while ((len = in.read(buff)) > 0) {
                    out.write(buff, 0, len);
                }
            }else{
                //对非会员限速
                while ((len = in.read(buff)) > 0) {
                    out.write(buff, 0, len);
                    try {
                        Thread.sleep(17);
                    } catch (InterruptedException e) {
                        e.printStackTrace();
                    }
                }
            }
            System.out.println("下载完成！！");
            in.close();
            out.close();
            return null;
        } else {
            return null;
        }
    }


    @ResponseBody
    @RequestMapping("/fileUpload.do")
    public Msg fileUpload(MultipartFile file, HttpServletRequest request) {

        System.out.println("文件上传");
        String username = (String) request.getSession().getAttribute("username");
        System.out.println("username = " + username);
        User user = userService.getUserByUsername(username);
        Integer userID = user.getUserID();
        int role = user.getRole();
        System.out.println("userID = " + userID);
        int size = (int)file.getSize();
        int oldSize = userService.getUserByUsername(username).getTotalFileSize();
        int newSize = oldSize + size;
        userService.modifyFileTotalSizeByUserID(userID,newSize);
        String fileName = file.getOriginalFilename();
        String postfix = fileName.substring(fileName.lastIndexOf(".") + 1);


        //判断文件是否重名
        List<UserFile> userFile = userFileService.getUserFile(userID);
        ArrayList<String> filename = new ArrayList<>();
        for (UserFile fileItem :
                userFile) {
            filename.add(fileItem.getFileName());
        }
        if (filename.contains(fileName)) {
            int num = FileUtil.getFilenameLengthWithoutPostfix(fileName);
            fileName = FileUtil.getFileName(fileName, filename, 1, num);
        }

        File uploadFile = new File("F:\\server\\userFile\\" + username + "\\" + fileName);


        if (!uploadFile.getParentFile().exists()) {
            uploadFile.getParentFile().mkdirs();
        }
        try {

            if (role == 1)
            file.transferTo(uploadFile);
            else {
//                //对非会员限速,限制在60kb左右
                InputStream is = file.getInputStream();
                FileOutputStream os = new FileOutputStream(uploadFile);
                byte[] buff = new byte[1024];
                int len = 0;
                while ((len = is.read(buff)) > 0) {
                    os.write(buff, 0, len);
                    try {
                        Thread.sleep(17);
                    } catch (InterruptedException e) {
                        e.printStackTrace();
                    }
                    is.close();
                    os.close();
                }
            }
//

//            FileUploadThread fileUploadThread = new FileUploadThread(is, os, role);
//            Thread thread = new Thread(fileUploadThread);
//            thread.start();
//            fileUploadThread.pauseThread();


            System.out.println("上传完成！！！！");
            int length = (int) uploadFile.length();
            String viewFileSize = FileUtil.getViewFileSize(length);
            String uploadTime = FileUtil.getTime();
            userFileService.insertUserFile(new UserFile(0, userID, fileName, length, uploadTime, postfix, viewFileSize));
            System.out.println("文件上传成功");


        } catch (IOException e) {
            return Msg.fail().add("fail", "uploadFail");
        }
        return Msg.success().add("success", "uploadSuccess");
    }


    @ResponseBody
    @RequestMapping("/modifyFilename.do")
    public Msg getUserImgFile(int fileID, String newFilename, String oldFilename, String username) {
        System.out.println("fileID = " + fileID);
        System.out.println("newFilename = " + newFilename);
        System.out.println("oldFilename = " + oldFilename);
        System.out.println("username = " + username);


        int userID = userService.getUserByUsername(username).getUserID();
        List<UserFile> userFile = userFileService.getUserFile(userID);
        ArrayList<String> filename = new ArrayList<>();
        for (UserFile file :
                userFile) {
            filename.add(file.getFileName());
        }
        if (filename.contains(newFilename)) {
            int num = FileUtil.getFilenameLengthWithoutPostfix(newFilename);
            newFilename = FileUtil.getFileName(newFilename, filename, 1, num);
        }

        int i = userFileService.modifyFilenameByFileID(newFilename, fileID);

        System.out.println(i);
        System.out.println("newFilename = " + newFilename);

        if (i == 1) {
            System.out.println("成功修改！！");
            String oldFilePath = "F:\\server\\userFile\\" + username + "\\" + oldFilename;
            String newFilePath = "F:\\server\\userFile\\" + username + "\\" + newFilename;
            File oldFile = new File(oldFilePath);
            System.out.println(oldFile.exists());
            File newFile = new File(newFilePath);
            System.out.println(oldFile.renameTo(newFile));
            return Msg.success().add("newFilename", newFilename);
        } else {
            return Msg.fail().add("newFilename", newFilename);
        }
    }

    @ResponseBody
    @RequestMapping("/checkUserFilename.do")
    public Msg checkUserFilename(String username, String newFilename) {
        int userID = userService.getUserByUsername(username).getUserID();
        List<UserFile> userFile = userFileService.getUserFile(userID);
        ArrayList<String> filename = new ArrayList<>();
        for (UserFile file :
                userFile) {
            filename.add(file.getFileName());
        }
        if (filename.contains(newFilename)) {
            return Msg.fail().add("newFilename", newFilename);
        } else {
            return Msg.success().add("newFilename", newFilename);
        }
    }

    @ResponseBody
    @RequestMapping("/fileDelete")
    public Msg fileDelete(int fileID) {
        UserFile userFileByFileID = userFileService.getUserFileByFileID(fileID);

        int userID = userFileService.getUserFileByFileID(fileID).getUserID();
        System.out.println("userID = " + userID);
        User user = userService.getUserByUserID(userID);

        int totalFileSize = user.getTotalFileSize();
        System.out.println("totalFileSize = " + totalFileSize);
        int newSize = totalFileSize -userFileByFileID.getFileSize();
        System.out.println("newSize = " + newSize);
        userService.modifyFileTotalSizeByUserID(userID,newSize);
        System.out.println("修改完成！");

        userFileService.deleteUserFileToRecycleBinByFileID(fileID);
        String deleteTime = FileUtil.getTime();
        userFileDeleteService.addDeleteFile(new UserFileDelete
                (0, userFileByFileID.getUserID(),
                        userFileByFileID.getFileName(),
                        userFileByFileID.getViewFileSize(),
                        deleteTime,
                        userFileByFileID.getPostfix(),
                        userFileByFileID.getFileSize()));
        return null;
    }
}
