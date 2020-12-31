package com.xxjproject.domain;

/**
 * @author xuxingjun
 * @data 2020/12/16  -  21:35
 */
public class UserFile {
    private int fileID;
    private int userID;
    private String fileName;
    private int fileSize;
    private String uploadTime;
    private String postfix;
    private String viewFileSize;

    public UserFile() {
    }

    public UserFile(int fileID, int userID, String fileName, int fileSize, String uploadTime, String postfix, String viewFileSize) {
        this.fileID = fileID;
        this.userID = userID;
        this.fileName = fileName;
        this.fileSize = fileSize;
        this.uploadTime = uploadTime;
        this.postfix = postfix;
        this.viewFileSize = viewFileSize;
    }

    public int getFileID() {
        return fileID;
    }

    public void setFileID(int fileID) {
        this.fileID = fileID;
    }

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public int getFileSize() {
        return fileSize;
    }

    public void setFileSize(int fileSize) {
        this.fileSize = fileSize;
    }

    public String getUploadTime() {
        return uploadTime;
    }

    public void setUploadTime(String uploadTime) {
        this.uploadTime = uploadTime;
    }

    public String getPostfix() {
        return postfix;
    }

    public void setPostfix(String postfix) {
        this.postfix = postfix;
    }

    public String getViewFileSize() {
        return viewFileSize;
    }

    public void setViewFileSize(String viewFileSize) {
        this.viewFileSize = viewFileSize;
    }

    @Override
    public String toString() {
        return "UserFile{" +
                "fileID=" + fileID +
                ", userID=" + userID +
                ", fileName='" + fileName + '\'' +
                ", fileSize=" + fileSize +
                ", uploadTime='" + uploadTime + '\'' +
                ", postfix='" + postfix + '\'' +
                ", viewFileSize='" + viewFileSize + '\'' +
                '}';
    }
}
