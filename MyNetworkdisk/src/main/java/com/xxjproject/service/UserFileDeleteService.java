package com.xxjproject.service;

import com.xxjproject.domain.UserFileDelete;

import java.util.List;

/**
 * @author xuxingjun
 * @data 2020/12/20  -  14:28
 */
public interface UserFileDeleteService {
    int addDeleteFile(UserFileDelete userFileDelete);

    List<UserFileDelete> getUserDeleteFileByUserID(Integer userID);

    UserFileDelete getUserDeleteFileByFileID(int fileID);

    int deleteUserFileFromRecycleBin(int fileID);

    int clearUserFileByUserID(Integer userID);

//    List<String> getFilenameByUserID(Integer userID);
}
