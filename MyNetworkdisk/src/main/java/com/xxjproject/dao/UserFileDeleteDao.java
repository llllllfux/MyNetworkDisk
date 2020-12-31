package com.xxjproject.dao;

import com.xxjproject.domain.UserFileDelete;

import java.util.List;

/**
 * @author xuxingjun
 * @data 2020/12/20  -  14:14
 */
public interface UserFileDeleteDao {
    int insertUserDeleteFile(UserFileDelete userFileDelete);

    List<UserFileDelete> selectUserDeleteFileByUserID(Integer userID);

    UserFileDelete selectUserDeleteFileByFileID(int fileID);

    int deleteUserFileByFileID(int fileID);

    int deleteAllFileByUserID(Integer userID);

//    List<String> selectFilenameByUserID(Integer userID);
}
