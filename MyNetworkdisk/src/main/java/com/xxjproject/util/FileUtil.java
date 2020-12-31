package com.xxjproject.util;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

/**
 * @author xuxingjun
 * @data 2020/12/19  -  21:11
 */
public class FileUtil {

    /**
     * 递归调用，自动更正重复的用户名
     * @param filename 要判断的文件名
     * @param list 已存在的文件名集合
     * @param i 填写 1
     * @param j 文件名filename去后缀名长度
     * @return
     */
    public static String getFileName(String filename, List list, int i , int j){
        if (list.contains(filename)){
            filename = filename.substring(0,j) + "(" + i + ")" + filename.substring(filename.lastIndexOf("."));
            i++;
            return getFileName(filename,list,i,j);
        }
        return filename;
    }

    /**
     * 获取不包含后缀名的文件名的长度与getFileName(String filename, List list, int i , int j)方法配合使用
     * @param filename
     * @return
     */
    public static int getFilenameLengthWithoutPostfix(String filename){
        return filename.substring(0,filename.lastIndexOf(".")).length();
    }

    public static String getFilenamePostfix(String filename){
        return filename.substring(filename.lastIndexOf("."));
    }

    /**
     * 修改文件后缀名
     * @param filename 原文件名
     * @param newPostfix 要修改成的后缀
     */
    public static String modifyPostfix(String filename,String newPostfix){
        return filename.substring(0,filename.lastIndexOf(".")) + newPostfix;

    }

    /**
     * 获取供用户查询文件大小
     * @param length
     * @return
     */

    public static String getViewFileSize(long length){
        String fileSize = "";
        if (length <= 1024) {
            fileSize = length + "B";
        } else if (length <= 1024 * 1024) {
            fileSize = Math.round(length / 1024.0) + "KB";
        } else if (length <= 1024 * 1024 * 1024) {
            fileSize = Math.round(length / (1024.0 * 1024.0)) + "M";
        }else{
            fileSize = "文件过大";
        }
        return fileSize;
    }

    /**
     * 获取用户操作的时间
     * @return
     */
    public static String getTime(){
        LocalDateTime now = LocalDateTime.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");
        String uploadTime = now.format(formatter);
        return uploadTime;
    }
}
