package com.xxjproject.controller;


import com.xxjproject.domain.Msg;
import com.xxjproject.domain.UserFile;
import com.xxjproject.service.UserFileService;
import com.xxjproject.util.FileToPdfUtil;
import com.xxjproject.util.FileUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletResponse;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;

/**
 * @author xuxingjun
 * @data 2021/1/22  -  14:48
 */
@Controller
public class FilePreviewController {
    private Logger log = LoggerFactory.getLogger(this.getClass());
//    private static final String separator = File.separator;

    @Autowired
    private UserFileService userFileService;


    /**
     * 文件预览
     * 后端根据原始路径再转换返回
     *
     * @param
     * @return
     */

    @ResponseBody
    @RequestMapping("/filePreview.do")
    public Msg filePreview(String username, int fileID, HttpServletResponse response) throws IOException {
        System.out.println("------------开始处理预览！！！！！");
        System.out.println("fileID = " + fileID);
        UserFile sourceFile = userFileService.getUserFileByFileID(fileID);
        System.out.println("sourceFile = " + sourceFile);
        String sourceFilename = sourceFile.getFileName();


        String[] fileTypeArr = {"doc", "docx", "wps", "wpt", "xls", "xlsx", "et", "ppt", "pptx", "pdf","xlsm"};
        //判断是否可以转换或预览
        int i = sourceFilename.lastIndexOf(".");
        String fileType = sourceFilename.substring(i + 1);
        boolean flag = false;
        for (String type : fileTypeArr) {
            if (type.equals(fileType)) {
                flag = true;
                break;
            }
        }

        if (flag) {
            String sourceFilePath = "F:\\server\\userFile\\" + username + "\\" + sourceFilename;
            FileToPdfUtil.officeToPdf(sourceFilePath,sourceFilename);
//            //获取文件和pdf绝对路径
//            Map<String, String> map = FileToPdfUtil.filepathToPdfPath(filePath);
//            String pdfPath = map.get("pdfPath");
//
//            //如果文件不存在则生成pdf
//            File file = new File(pdfPath);
//            if (!file.exists()) {
//                FileToPdfUtil.officeToPdf(filePath);
//            }
//            try {
//                FileCopyUtils.copy(new FileInputStream(pdfPath), response.getOutputStream());
//            } catch (IOException e) {
//                log.error("filePreview："+e);
//            }
            String tempFilePath = "F:\\sysPdf\\" + FileUtil.modifyPostfix(sourceFilename,".pdf");

            FileInputStream inStream = new FileInputStream(tempFilePath);
            response.setContentType( "application/pdf");
            OutputStream outputStream= response.getOutputStream();
            int count = 0;
            byte[] buffer = new byte[1024 * 1024];
            while ((count =inStream.read(buffer)) != -1){
                outputStream.write(buffer, 0,count);
            }
            outputStream.flush();
            outputStream.close();

            return Msg.success();
        }else{
//            log.error("filePreview："+fileType+"文件不支持预览！");
            return Msg.fail().add("error","该文件类型不支持预览！");
        }
    }

//    @RequestMapping("/filePreviewTest.do")
//    public void filePreviewTest(HttpServletResponse response) throws IOException {
//        String tempFilePath = "D:\\Spring5框架课堂笔记.pdf";
//        FileInputStream inStream = new FileInputStream(tempFilePath);
//        response.setContentType( "application/pdf");
//        OutputStream outputStream= response.getOutputStream();
//        int count = 0;
//        byte[] buffer = new byte[1024 * 1024];
//        while ((count =inStream.read(buffer)) != -1){
//            outputStream.write(buffer, 0,count);
//        }
//        outputStream.flush();
//    }
}
