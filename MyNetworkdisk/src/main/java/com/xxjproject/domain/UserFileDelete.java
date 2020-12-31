package com.xxjproject.domain;

/**
 * @author xuxingjun
 * @data 2020/12/20  -  14:15
 */
public class UserFileDelete {

    private int fileID;
    private int userID;
    private String filename;
    private String viewFileSize;
    private String deleteTime;
    private String postfix;
    private int fileSize;

    public UserFileDelete() {
    }

    public UserFileDelete(int fileID, int userID, String filename, String viewFileSize, String deleteTime, String postfix, int fileSize) {
        this.fileID = fileID;
        this.userID = userID;
        this.filename = filename;
        this.viewFileSize = viewFileSize;
        this.deleteTime = deleteTime;
        this.postfix = postfix;
        this.fileSize = fileSize;
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

    public String getFilename() {
        return filename;
    }

    public void setFilename(String filename) {
        this.filename = filename;
    }

    public String getViewFileSize() {
        return viewFileSize;
    }

    public void setViewFileSize(String viewFileSize) {
        this.viewFileSize = viewFileSize;
    }

    public String getDeleteTime() {
        return deleteTime;
    }

    public void setDeleteTime(String deleteTime) {
        this.deleteTime = deleteTime;
    }

    public String getPostfix() {
        return postfix;
    }

    public void setPostfix(String postfix) {
        this.postfix = postfix;
    }

    public int getFileSize() {
        return fileSize;
    }

    public void setFileSize(int fileSize) {
        this.fileSize = fileSize;
    }
}
