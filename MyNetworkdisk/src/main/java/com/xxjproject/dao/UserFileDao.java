package com.xxjproject.dao;

import com.xxjproject.domain.UserFile;

import java.util.List;

/**
 * @author xuxingjun
 * @data 2020/12/16  -  21:38
 */
public interface UserFileDao {
    int insertUserFile(UserFile userFile);
    List<UserFile> selectUserFileByUserID(int UserID);
    List<UserFile> selectUserImgFileByUserID(int UserID);
    UserFile selectUserFileByFileID(int fileID);

    List<UserFile> selectUserDocumentFileByUserID(int userID);

    List<UserFile> selectUserVideoFileByUserID(int userID);

    List<UserFile> selectUserMusicFileByUserID(int userID);

    List<UserFile> selectUserCompressedFileByUserID(int userID);

    List<UserFile> selectUserOtherFileByUserID(int userID);

    int updateFilenameByFileID(String newFilename,int fileID);

    int deleteUserFileByFileID(int fileID);
}
