package com.xxjproject.controller;

import com.xxjproject.domain.Msg;
import com.xxjproject.domain.User;
import com.xxjproject.domain.UserFile;
import com.xxjproject.domain.UserFileDelete;
import com.xxjproject.service.UserFileDeleteService;
import com.xxjproject.service.UserFileService;
import com.xxjproject.service.UserService;
import com.xxjproject.service.impl.UserFileDeleteServiceImpl;
import com.xxjproject.service.impl.UserFileServiceImpl;
import com.xxjproject.service.impl.UserServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.io.File;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

/**
 * @author xuxingjun
 * @data 2020/12/20  -  15:41
 */
@Controller
public class FileDeleteController {
    @Autowired
    private UserFileDeleteService userFileDeleteService;
    @Autowired
    private UserService userService;

    @Autowired
    private UserFileService userFileService;

    @ResponseBody
    @RequestMapping("/getDeleteFile.do")
    public Msg getDeleteFile(String username){
        Integer userID = userService.getUserByUsername(username).getUserID();
        List<UserFileDelete> userDeleteFileByUserID = userFileDeleteService.getUserDeleteFileByUserID(userID);
        System.out.println("userDeleteFileByUserID = " + userDeleteFileByUserID);
        return Msg.success().add("userDeleteFile",userDeleteFileByUserID);
    }

    @ResponseBody
    @RequestMapping("/reductionFile.do")
    public Msg reductionFile(int fileID){
        System.out.println("fileID = " + fileID);
        UserFileDelete file = userFileDeleteService.getUserDeleteFileByFileID(fileID);
        LocalDateTime now = LocalDateTime.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
        String reductionTime = now.format(formatter);
        userFileService.insertUserFile(
                new UserFile(0,
                file.getUserID(),
                file.getFilename(),
                file.getFileSize(),
                reductionTime,
                file.getPostfix(),
                file.getViewFileSize()));
        int i = userFileDeleteService.deleteUserFileFromRecycleBin(fileID);
        if (i != -1){
//            System.out.println("开始修改容量！！！");
//            int userID = userFileService.getUserFileByFileID(fileID).getUserID();
//            User user = userService.getUserByUserID(userID);
//            int totalFileSize = user.getTotalFileSize();
//            System.out.println("totalFileSize = " + totalFileSize);
//            int newSize = totalFileSize -file.getFileSize();
//            System.out.println("newSize = " + newSize);
//            userService.modifyFileTotalSizeByUserID(userID,newSize);
//            System.out.println("修改完成！");
            return Msg.success();
        }else
            return Msg.fail();
    }

    @ResponseBody
    @RequestMapping("/deleteFileFromBin.do")
    public Msg deleteFileFromBin(int fileID,String username){

        UserFileDelete udf = userFileDeleteService.getUserDeleteFileByFileID(fileID);
        String filename = udf.getFilename();
        System.out.println("filename = " + filename);
        System.out.println("username = " + username);
        String path = "F:\\server\\userFile\\" + username + "\\" + filename;
        File file = new File(path);
        if (file.exists()){
            boolean delete = file.delete();
            int i = userFileDeleteService.deleteUserFileFromRecycleBin(fileID);
            if (delete && i ==1){
                return Msg.success();
            }
        }
        return Msg.fail();
    }

    @ResponseBody
    @RequestMapping("/clearAllBinFile.do")
    public Msg clearAllFile(String username) {
        Integer userID = userService.getUserByUsername(username).getUserID();
//        int i = userFileDeleteService.clearUserFileByUserID(userID);
        List<UserFileDelete> udf = userFileDeleteService.getUserDeleteFileByUserID(userID);
        String rootPath = "F:\\server\\userFile\\";
        String path = "";
        for (UserFileDelete userFileDelete : udf) {
            String filename = userFileDelete.getFilename();
            path = rootPath +  username + "\\" + filename;
            System.out.println("path = " + path);
            File file = new File(path);
            boolean delete = file.delete();
            System.out.println("delete = " + delete);
            userFileDeleteService.deleteUserFileFromRecycleBin(userFileDelete.getFileID());
        }
        return Msg.success();
    }

}
